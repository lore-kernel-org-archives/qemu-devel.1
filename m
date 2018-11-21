Received: from eggs.gnu.org ([2001:4830:134:3::10]:33141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPZdz-0004oK-Ie
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPZdx-0007pW-QX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:02:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gPZdx-0007nU-In
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:02:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id y1so3651472wmi.3
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-10-marcandre.lureau@redhat.com>
	<56d6d5ae-cc33-be46-1880-def10db32f41@redhat.com>
In-Reply-To: <56d6d5ae-cc33-be46-1880-def10db32f41@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Nov 2018 01:02:28 +0400
Message-ID: <CAJ+F1CKxYgVMUJ6Sw3YTvCr4Nr36ZSxkEN-4wxeJRirsCtSvQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 09/41] slirp: add a set_nonblock()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, samuel.thibault@ens-lyon.org, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, renzo@cs.unibo.it

Hi
On Thu, Nov 15, 2018 at 5:09 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/11/2018 13:36, Marc-Andr=C3=A9 Lureau wrote:
> > qemu_set_nonblock() does some event registration with the main loop on
> > win32, let's have a callback.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Perhaps a better interface would be register_poll_fd, which is called
> before a file descriptor can be returned to slirp_pollfds_fill?  And
> perhaps a dual unregister_poll_fd, which QEMU would leave empty, to be
> called before closing the file descriptor.

That sounds like a good idea, but I think it will bring more issues as
qemu_fd_register() doing WSAEventSelect will put the socket in
nonblocking mode anyway, and we don't have/need qemu_fd_unregister()
yet:

https://msdn.microsoft.com/de-de/library/windows/desktop/ms738573(v=3Dvs.85=
).aspx
"The WSAAsyncSelect and WSAEventSelect functions automatically set a
socket to nonblocking mode. If WSAAsyncSelect or WSAEventSelect has
been issued on a socket, then any attempt to use ioctlsocket to set
the socket back to blocking mode will fail with WSAEINVAL.
To set the socket back to blocking mode, an application must first
disable WSAAsyncSelect by calling WSAAsyncSelect with the lEvent
parameter equal to zero, or disable WSAEventSelect by calling
WSAEventSelect with the lNetworkEvents parameter equal to zero."

I will stick to the set_nonblock() callback for now.

thanks



> Paolo
>
> > ---
> >  slirp/libslirp.h | 1 +
> >  net/slirp.c      | 1 +
> >  slirp/misc.c     | 2 +-
> >  slirp/tcp_subr.c | 4 ++--
> >  4 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> > index 88185e6c33..f2e7f94ebb 100644
> > --- a/slirp/libslirp.h
> > +++ b/slirp/libslirp.h
> > @@ -20,6 +20,7 @@ typedef struct SlirpCb {
> >                        SlirpTimerCb cb, void *opaque);
> >      void (*timer_free)(void *timer);
> >      void (*timer_mod)(void *timer, int64_t expire_timer);
> > +    void (*set_nonblock)(int fd);
> >  } SlirpCb;
> >
> >
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 7b28886802..5ea8c255f6 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -190,6 +190,7 @@ static SlirpCb slirp_cb =3D {
> >      .timer_new =3D net_slirp_timer_new,
> >      .timer_free =3D net_slirp_timer_free,
> >      .timer_mod =3D net_slirp_timer_mod,
> > +    .set_nonblock =3D qemu_set_nonblock,
> >  };
> >
> >  static int net_slirp_init(NetClientState *peer, const char *model,
> > diff --git a/slirp/misc.c b/slirp/misc.c
> > index 7972b9b05b..dd2b3512a8 100644
> > --- a/slirp/misc.c
> > +++ b/slirp/misc.c
> > @@ -174,7 +174,7 @@ fork_exec(struct socket *so, const char *ex)
> >      socket_set_fast_reuse(so->s);
> >      opt =3D 1;
> >      qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int)=
);
> > -    qemu_set_nonblock(so->s);
> > +    so->slirp->cb->set_nonblock(so->s);
> >      return 1;
> >  }
> >  #endif
> > diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> > index 4b40850c7a..8d97f1f54e 100644
> > --- a/slirp/tcp_subr.c
> > +++ b/slirp/tcp_subr.c
> > @@ -412,7 +412,7 @@ int tcp_fconnect(struct socket *so, unsigned short =
af)
> >      int opt, s=3Dso->s;
> >      struct sockaddr_storage addr;
> >
> > -    qemu_set_nonblock(s);
> > +    so->slirp->cb->set_nonblock(s);
> >      socket_set_fast_reuse(s);
> >      opt =3D 1;
> >      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
> > @@ -484,7 +484,7 @@ void tcp_connect(struct socket *inso)
> >          tcp_close(sototcpcb(so)); /* This will sofree() as well */
> >          return;
> >      }
> > -    qemu_set_nonblock(s);
> > +    so->slirp->cb->set_nonblock(s);
> >      socket_set_fast_reuse(s);
> >      opt =3D 1;
> >      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau
