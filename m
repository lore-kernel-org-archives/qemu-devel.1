Received: from eggs.gnu.org ([209.51.188.92]:55747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUTq-00052I-Gc
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUIn-0006eq-US
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:23:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjUIl-0006ct-5e
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:23:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so4320624qtt.4
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-10-marcandre.lureau@redhat.com>
	<56d6d5ae-cc33-be46-1880-def10db32f41@redhat.com>
In-Reply-To: <56d6d5ae-cc33-be46-1880-def10db32f41@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 23:22:53 +0400
Message-ID: <CAMxuvayXt3Eev8ZCKLL7HEjnr7XkFwXA9RHrKZEyVL8Y66Ct-Q@mail.gmail.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Richard Jones <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, renzo@cs.unibo.it

Hi

On Thu, Nov 15, 2018 at 5:04 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
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

done

thanks

>
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
