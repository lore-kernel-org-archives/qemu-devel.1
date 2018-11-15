Received: from eggs.gnu.org ([2001:4830:134:3::10]:36655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHJW-0000fz-BA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHJS-0004ZR-92
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:04:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNHJS-0004Yw-3E
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:04:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so18711395wmb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:04:02 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-10-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56d6d5ae-cc33-be46-1880-def10db32f41@redhat.com>
Date: Thu, 15 Nov 2018 14:03:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On 14/11/2018 13:36, Marc-André Lureau wrote:
> qemu_set_nonblock() does some event registration with the main loop on
> win32, let's have a callback.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Perhaps a better interface would be register_poll_fd, which is called
before a file descriptor can be returned to slirp_pollfds_fill?  And
perhaps a dual unregister_poll_fd, which QEMU would leave empty, to be
called before closing the file descriptor.

Paolo

> ---
>  slirp/libslirp.h | 1 +
>  net/slirp.c      | 1 +
>  slirp/misc.c     | 2 +-
>  slirp/tcp_subr.c | 4 ++--
>  4 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 88185e6c33..f2e7f94ebb 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -20,6 +20,7 @@ typedef struct SlirpCb {
>                        SlirpTimerCb cb, void *opaque);
>      void (*timer_free)(void *timer);
>      void (*timer_mod)(void *timer, int64_t expire_timer);
> +    void (*set_nonblock)(int fd);
>  } SlirpCb;
>  
>  
> diff --git a/net/slirp.c b/net/slirp.c
> index 7b28886802..5ea8c255f6 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -190,6 +190,7 @@ static SlirpCb slirp_cb = {
>      .timer_new = net_slirp_timer_new,
>      .timer_free = net_slirp_timer_free,
>      .timer_mod = net_slirp_timer_mod,
> +    .set_nonblock = qemu_set_nonblock,
>  };
>  
>  static int net_slirp_init(NetClientState *peer, const char *model,
> diff --git a/slirp/misc.c b/slirp/misc.c
> index 7972b9b05b..dd2b3512a8 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -174,7 +174,7 @@ fork_exec(struct socket *so, const char *ex)
>      socket_set_fast_reuse(so->s);
>      opt = 1;
>      qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
> -    qemu_set_nonblock(so->s);
> +    so->slirp->cb->set_nonblock(so->s);
>      return 1;
>  }
>  #endif
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index 4b40850c7a..8d97f1f54e 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -412,7 +412,7 @@ int tcp_fconnect(struct socket *so, unsigned short af)
>      int opt, s=so->s;
>      struct sockaddr_storage addr;
>  
> -    qemu_set_nonblock(s);
> +    so->slirp->cb->set_nonblock(s);
>      socket_set_fast_reuse(s);
>      opt = 1;
>      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
> @@ -484,7 +484,7 @@ void tcp_connect(struct socket *inso)
>          tcp_close(sototcpcb(so)); /* This will sofree() as well */
>          return;
>      }
> -    qemu_set_nonblock(s);
> +    so->slirp->cb->set_nonblock(s);
>      socket_set_fast_reuse(s);
>      opt = 1;
>      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
> 
