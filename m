Received: from eggs.gnu.org ([2001:4830:134:3::10]:33578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQqyq-00059k-HN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQqyn-00053v-F8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:41:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQqyn-000530-5k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:40:57 -0500
Date: Mon, 18 Dec 2017 08:40:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218084047.GC18648@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-22-peterx@redhat.com>
	<20171214134359.GJ14433@stefanha-x1.localdomain>
	<20171218055217.GN22308@xz-mi> <20171218073229.GP22308@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <20171218073229.GP22308@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 21/26] qmp: isolate responses into io
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 03:32:29PM +0800, Peter Xu wrote:
> On Mon, Dec 18, 2017 at 01:52:17PM +0800, Peter Xu wrote:
> > On Thu, Dec 14, 2017 at 01:43:59PM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 01:51:55PM +0800, Peter Xu wrote:
> > > > @@ -4429,6 +4515,13 @@ void monitor_cleanup(void)
> > > >       */
> > > >      iothread_stop(mon_global.mon_iothread);
> > > > =20
> > > > +    /*
> > > > +     * After we have IOThread to send responses, it's possible that
> > > > +     * when we stop the IOThread there are still replies queued in=
 the
> > > > +     * responder queue.  Flush all of them.
> > > > +     */
> > > > +    monitor_qmp_bh_responder(NULL);
> > >=20
> > > This doesn't work because monitor_qmp_bh_responder() does not guarant=
ee
> > > that the full response has been written when it returns.
> > >=20
> > > When qemu_chr_fe_write() returns EAGAIN then qemu_chr_fe_add_watch() =
is
> > > used to register an event loop callback when the chardev becomes
> > > writable again.  But you stopped the event loop using iothread_stop()=
 so
> > > we will never complete the write.
> >=20
> > Good catch...
> >=20
> > Actually I just noticed that for char frontend I missed a place to use
> > the chardev context for polling.  So before the flushing I possibly
> > need this:
> >=20
> > diff --git a/chardev/char-fe.c b/chardev/char-fe.c                     =
       =20
> > index ee6d596100..462c529f19 100644   =20
> > --- a/chardev/char-fe.c               =20
> > +++ b/chardev/char-fe.c               =20
> > @@ -356,7 +356,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCon=
dition cond,                                                               =
           =20
> >      }                                =20
> >                                       =20
> >      g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);   =
       =20
> > -    tag =3D g_source_attach(src, NULL);=20
> > +    tag =3D g_source_attach(src, be->chr->gcontext);                  =
         =20
> >      g_source_unref(src);             =20
> >                                       =20
> >      return tag;                      =20
> >=20
> > Otherwise it'll be still be run in main thread always.
> >=20
> > (I guess I haven't yet encountered an EAGAIN for it so far)
> >=20
> > >=20
> > > I suggest draining the monitor while the IOThread is still running
> > > (that way the AioContext and GMainContext are still operational).  You
> > > can:
> > > 1. Suspend the monitor so new commands will not be read.
> > > 2. Wait until all responses and outbuf are empty.
> > >=20
> > > Another option is moving the chardev back to the main loop but I'm not
> > > sure if the chardev subsystem supports that.
> >=20
> > Your suggestion is good to me.  I'll do that in IOThread before it
> > stops.  Thanks!
>=20
> Hmm, after a second thought, I think maybe it would be nicer to just
> call monitor_flush() after the monitor iothread is stopped.
>=20
> Firstly, that is perfectly legal - since AFAICT commit 6cff3e8594
> ("monitor: protect outbuf and mux_out with mutex", 2014-06-23) is
> tailored for doing that, though that was for block iothread, not
> monitor.
>=20
> Then, it's still possible that the write buffer is full and we got
> EAGAIN during flushing.  Then we'll plug another task into the monitor
> gcontext which will never run since the iothread is stopped already.
> IMHO that's totally fine - I think it's already our best effort to
> flush the out buffer once at this point.  If the buffer is still full
> after one attemp of monitor_flush(), we should just give up the 2nd
> flushing instead of waiting here.  After all, we are quitting QEMU.
>=20
> As a summary, my planned change of this issue would be quite
> straightforward: call monitor_flush() when looping over monitors,
> before destroying them.  And when destroying, if there is dangling
> Monitor.out_watch, detach them.  Hope that works.  Thanks,

I think QEMU currently doesn't drain the monitor output buffer either.
Please make sure to write the code and commit description so it is clear
this is just a best-effort attempt.

Stefan

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN38PAAoJEJykq7OBq3PIypwH/RF8Tei53v/8LjvZulYNUZ4x
KJie3SnoFc7SzDGMkvdiswlNXIdkjh147mvr4w9zHliKbO7lAnfsaQl6Lk9TdDPn
xi5ajsdOzQ7wwtvprhbl39gFfRruTgpJf3ivn/cG2mBVUH+H+5v2RkKvLmYWNKnC
qN4nkgt2jTXdr9ASZCDnOz9mPLUxDq2YUUJSKusZZOEoOrxmo2aMfsoFCgX10wvX
86TQKyt+ARADni0m6B5wFUbIk9a93E4x3jQCu/phfJY2S1Y7AntVQdSndek6URXx
3UyPXNZ3qoMAeDTzZuYMIDiIeeybacXoH7Pj6e28AwcLUbkv/Czg4sPUx9SRFAk=
=1fFe
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
