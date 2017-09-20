Received: from eggs.gnu.org ([2001:4830:134:3::10]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dufWP-0004si-99
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dufWL-0006qU-C4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dufWL-0006pw-1S
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:58:33 -0400
Date: Wed, 20 Sep 2017 17:09:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920090926.GA31306@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-2-git-send-email-peterx@redhat.com>
	<20170920075703.GA4053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170920075703.GA4053@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 01/15] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Sep 20, 2017 at 08:57:03AM +0100, Daniel P. Berrange wrote:
> On Thu, Sep 14, 2017 at 03:50:22PM +0800, Peter Xu wrote:
> > This is not a problem if we are only having one single loop thread li=
ke
> > before.  However, after per-monitor thread is introduced, this is not
> > true any more, and the race can happen.
> >=20
> > The race can be triggered with "make check -j8" sometimes:
> >=20
> >   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
> >   io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.
> >=20
> > This patch keeps the reference for the watch object when creating in
> > io_add_watch_poll(), so that the object will never be released in the
> > context main loop, especially when the context loop is running in
> > another standalone thread.  Meanwhile, when we want to remove the wat=
ch
> > object, we always first detach the watch object from its owner contex=
t,
> > then we continue with the cleanup.
> >=20
> > Without this patch, calling io_remove_watch_poll() in main loop threa=
d
> > is not thread-safe, since the other per-monitor thread may be modifyi=
ng
> > the watch object at the same time.
>=20
> This doesn't feel right to me. Why is the main loop thread doing anythi=
ng
> at all with the Chardev, if there is a per-monitor thread ? The Chardev
> code isn't thread safe so it isn't safe to have two separate threads
> accessing the same Chardev. IOW, if we want a per-monitor thread, then
> we must make sure the main thread never touches that monitor's chardev
> at all.  While your patch here might have avoided the assertion you
> mention above, I fear this is just papering over a fundamental problem
> that still exists, that can only be solved by not letting the mainloop
> touch the chardev at all.

The stack I encountered:

#0  0x00007f658234c765 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:54
#1  0x00007f658234e36a in __GI_abort () at abort.c:89
#2  0x00007f6582344f97 in __assert_fail_base (fmt=3D<optimized out>, asse=
rtion=3Dassertion@entry=3D0x55c76345fce1 "iwp->src =3D=3D NULL", file=3Df=
ile@entry=3D0x55c76345fcc0 "/root/git/qemu/chardev/char-io.c", line=3Dlin=
e@entry=3D91, function=3Dfunction@entry=3D0x55c76345fd10 <__PRETTY_FUNCTI=
ON__.21863> "io_watch_poll_finalize") at assert.c:92
#3  0x00007f6582345042 in __GI___assert_fail (assertion=3D0x55c76345fce1 =
"iwp->src =3D=3D NULL", file=3D0x55c76345fcc0 "/root/git/qemu/chardev/cha=
r-io.c", line=3D91, function=3D0x55c76345fd10 <__PRETTY_FUNCTION__.21863>=
 "io_watch_poll_finalize") at assert.c:101
#4  0x000055c7632c2be5 in io_watch_poll_finalize (source=3D0x55c7651cd450=
) at /root/git/qemu/chardev/char-io.c:91
#5  0x00007f65847bb859 in g_source_unref_internal () at /lib64/libglib-2.=
0.so.0
#6  0x00007f65847bca29 in g_source_destroy_internal () at /lib64/libglib-=
2.0.so.0
#7  0x000055c7632c2d30 in io_remove_watch_poll (source=3D0x55c7651cd450) =
at /root/git/qemu/chardev/char-io.c:139
#8  0x000055c7632c2d5c in remove_fd_in_watch (chr=3D0x55c7651ccdf0) at /r=
oot/git/qemu/chardev/char-io.c:145
#9  0x000055c7632c2368 in qemu_chr_fe_set_handlers (b=3D0x55c7651f6410, f=
d_can_read=3D0x0, fd_read=3D0x0, fd_event=3D0x0, be_change=3D0x0, opaque=3D=
0x0, context=3D0x0, set_open=3Dtrue)
    at /root/git/qemu/chardev/char-fe.c:267
#10 0x000055c7632c2221 in qemu_chr_fe_deinit (b=3D0x55c7651f6410, del=3Df=
alse) at /root/git/qemu/chardev/char-fe.c:231
#11 0x000055c762e2b15c in monitor_data_destroy (mon=3D0x55c7651f6410) at =
/root/git/qemu/monitor.c:600
#12 0x000055c762e340ec in monitor_cleanup () at /root/git/qemu/monitor.c:=
4346
#13 0x000055c762f9445d in main (argc=3D19, argv=3D0x7ffc6846d0e8, envp=3D=
0x7ffc6846d188) at /root/git/qemu/vl.c:4889

So it's destroying the CharBackend, but it'll then call
qemu_chr_fe_set_handlers() which finally tries to remove the watch poll.

If without current patch, I can still encounter the same crash when
doing "make check -j8".

>=20
> >=20
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-io.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/chardev/char-io.c b/chardev/char-io.c
> > index f810524..3828c20 100644
> > --- a/chardev/char-io.c
> > +++ b/chardev/char-io.c
> > @@ -122,7 +122,6 @@ GSource *io_add_watch_poll(Chardev *chr,
> >      g_free(name);
> > =20
> >      g_source_attach(&iwp->parent, context);
> > -    g_source_unref(&iwp->parent);
> >      return (GSource *)iwp;
> >  }
> > =20
> > @@ -131,12 +130,24 @@ static void io_remove_watch_poll(GSource *sourc=
e)
> >      IOWatchPoll *iwp;
> > =20
> >      iwp =3D io_watch_poll_from_source(source);
> > +
> > +    /*
> > +     * Here the order of destruction really matters.  We need to fir=
st
> > +     * detach the IOWatchPoll object from the context (which may sti=
ll
> > +     * be running in another loop thread), only after that could we
> > +     * continue to operate on iwp->src, or there may be race conditi=
on
> > +     * between current thread and the context loop thread.
> > +     *
> > +     * Let's blame the glib bug mentioned in commit 2b3167 (again) f=
or
> > +     * this extra complexity.
> > +     */
> > +    g_source_destroy(&iwp->parent);
> >      if (iwp->src) {
> >          g_source_destroy(iwp->src);
> >          g_source_unref(iwp->src);
> >          iwp->src =3D NULL;
> >      }
> > -    g_source_destroy(&iwp->parent);
> > +    g_source_unref(&iwp->parent);
> >  }
> > =20
> >  void remove_fd_in_watch(Chardev *chr)
> > --=20
> > 2.7.4
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|

--=20
Peter Xu
