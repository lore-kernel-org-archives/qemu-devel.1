Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYWF-00007D-Te
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYW5-0000I7-VS
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:32:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEYW5-0000HC-ML
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:32:29 -0500
Date: Tue, 14 Nov 2017 10:32:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171114103219.GC13015@stefanha-x1.localdomain>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-2-peterx@redhat.com>
	<20171113165211.GG27765@stefanha-x1.localdomain>
	<20171114060939.GC6821@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <20171114060939.GC6821@xz-mi>
Subject: Re: [Qemu-devel] [RFC v3 01/27] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2017 at 02:09:39PM +0800, Peter Xu wrote:
> On Mon, Nov 13, 2017 at 04:52:11PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Nov 06, 2017 at 05:46:17PM +0800, Peter Xu wrote:
> > > This is not a problem if we are only having one single loop thread li=
ke
> > > before.  However, after per-monitor thread is introduced, this is not
> > > true any more, and the race can happen.
> > >=20
> > > The race can be triggered with "make check -j8" sometimes:
> >=20
> > Please mention a specific test case that fails.
>=20
> It was any of the check-qtest-$(TARGET)s that failed.  I'll mention
> that in next post.
>=20
> >=20
> > >=20
> > >   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
> > >   io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.
> > >=20
> > > This patch keeps the reference for the watch object when creating in
> > > io_add_watch_poll(), so that the object will never be released in the
> > > context main loop, especially when the context loop is running in
> > > another standalone thread.  Meanwhile, when we want to remove the wat=
ch
> > > object, we always first detach the watch object from its owner contex=
t,
> > > then we continue with the cleanup.
> > >=20
> > > Without this patch, calling io_remove_watch_poll() in main loop thread
> > > is not thread-safe, since the other per-monitor thread may be modifyi=
ng
> > > the watch object at the same time.
> > >=20
> > > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  chardev/char-io.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/chardev/char-io.c b/chardev/char-io.c
> > > index f81052481a..50b5bac704 100644
> > > --- a/chardev/char-io.c
> > > +++ b/chardev/char-io.c
> > > @@ -122,7 +122,6 @@ GSource *io_add_watch_poll(Chardev *chr,
> > >      g_free(name);
> > > =20
> > >      g_source_attach(&iwp->parent, context);
> > > -    g_source_unref(&iwp->parent);
> > >      return (GSource *)iwp;
> > >  }
> > > =20
> > > @@ -131,12 +130,25 @@ static void io_remove_watch_poll(GSource *sourc=
e)
> > >      IOWatchPoll *iwp;
> > > =20
> > >      iwp =3D io_watch_poll_from_source(source);
> > > +
> > > +    /*
> > > +     * Here the order of destruction really matters.  We need to fir=
st
> > > +     * detach the IOWatchPoll object from the context (which may sti=
ll
> > > +     * be running in another loop thread), only after that could we
> > > +     * continue to operate on iwp->src, or there may be race conditi=
on
> > > +     * between current thread and the context loop thread.
> > > +     *
> > > +     * Let's blame the glib bug mentioned in commit 2b316774f6
> > > +     * ("qemu-char: do not operate on sources from finalize
> > > +     * callbacks") for this extra complexity.
> >=20
> > I don't understand how this bug is to blame.  Isn't the problem here a
> > race condition between two QEMU threads?
>=20
> Yes, it is.
>=20
> The problem is, we won't have the race condition if glib does not have
> that bug mentioned.  Then the thread running GMainContext will have
> full control of iwp->src destruction, and destruction of it would be
> fairly straightforward (unref iwp->src in IOWatchPoll destructor).
> Now IIUC we are doing this in a hacky way, say, we destroy iwp->src
> explicitly from main thread before quitting (see [1] below, the whole
> if clause).
>=20
> >=20
> > Why are two threads accessing the watch at the same time?
>=20
> Here is how I understand:
>=20
> Firstly we need to tackle with that bug, by an explicit destruction of
> iwp->src below; meanwhile when we are destroying it, the GMainContext
> can still be running somewhere (it's not happening in current series
> since I stopped iothread earlier than this point, however it can still
> happen if in the future we don't do that), then we possibly want this
> patch.
>=20
> Again, without this patch, current series should work; however I do
> hope this patch can be in, in case someday we want to provide complete
> thread safety for Chardevs (now it is not really thread-safe).

You said qtests fail with "Assertion `iwp->src =3D=3D NULL' failed" but then
you said "without this patch, current series should work".  How do you
reproduce the failure if it doesn't occur?

It looks like remove_fd_in_watch() -> io_remove_watch_poll() callers
fall into two categories: called from within the event loop and called
when a chardev is destroyed.  Do the thread-safety issues occur when the
chardev is destroyed by the QEMU main loop thread?  Or did I miss cases
where remove_fd_in_watch() is called from other threads?

>=20
> >=20
> > > +     */
> > > +    g_source_destroy(&iwp->parent);
> > >      if (iwp->src) {
> > >          g_source_destroy(iwp->src);
> > >          g_source_unref(iwp->src);
> > >          iwp->src =3D NULL;
> > >      }
>=20
> [1]
>=20
> > > -    g_source_destroy(&iwp->parent);
> > > +    g_source_unref(&iwp->parent);
> > >  }
> > > =20
> > >  void remove_fd_in_watch(Chardev *chr)
> > > --=20
> > > 2.13.5
> > >=20
>=20
> Thanks,
>=20
> --=20
> Peter Xu

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaCsYzAAoJEJykq7OBq3PIEuwH/iT9H8MrJ660fO/Z5Pg4psjN
Tx6/Ks5PC/jJ9dL5UmBkt3yFtMrC8bJzVMwAsIr6jzj4hTvoEe4yPdaloUwYkJzU
EebB7LxXqpwr6Bw49qd9U4zZFSIvwEXuicOkJt+nF3Y3LCc8jbGp50FMO1yfarno
GtTzwTLIsRLm+njN/F8Fduox1OP+SAt6tAcKm5320kchM98cHo4z1vLKEdVtsajp
+HEc7NdtZWkhP+0TIOknp1UOcy+9vnsWZDru2PtdfXCOv/dtmwZs0/DNyTsaLIb+
j1SumcXfgtxiu3mHLuesY2Of5m+bz++2h3iUkqu1KsbeAlic0RfAUkFIJYhOvro=
=t0aZ
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
