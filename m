Received: from eggs.gnu.org ([2001:4830:134:3::10]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOsyA-0007KU-55
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOsy5-0007Et-6T
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:19:38 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:53461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cOsy4-0007Eg-Uj
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:19:33 -0500
Date: Wed, 4 Jan 2017 16:19:31 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <119554983.4442989.1483564771761.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170104205936.27279-1-marcandre.lureau@redhat.com>
References: <20170104205936.27279-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] win32: fix main-loop busy loop on
 socket/fd event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org


> Paolo suggested to me on irc to call event_notifier_test_and_clear()
> after select() >0 from aio-win32.c's aio_prepare. Unfortunately, not all
> fds associated with ctx->notifiers are in AIO fd handlers set.
> (qemu_set_nonblock() in util/oslib-win32.c calls qemu_fd_register()).

That makes sense.  Out of curiosity, what is a practical case of a socket
that is nonblocking but doesn't have an attached handler?

Another possibility (this one requires much more attention to avoid missing
some edge case; however, it should be easy to verify if it fixes the busy
loop) could be to move aio_notify_accept to just before setting ctx->notify=
_me.
This would work for both aio-posix and aio-win32.

Paolo

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/block/aio.h | 2 ++
>  async.c             | 6 ++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/include/block/aio.h b/include/block/aio.h
> index ca551e346f..a6da135bf3 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -100,6 +100,7 @@ struct AioContext {
>       */
>      int walking_bh;
> =20
> +#ifndef _WIN32
>      /* Used by aio_notify.
>       *
>       * "notified" is used to avoid expensive event_notifier_test_and_cle=
ar
> @@ -113,6 +114,7 @@ struct AioContext {
>       * in the docs/aio_notify_accept.promela formal model.
>       */
>      bool notified;
> +#endif
>      EventNotifier notifier;
> =20
>      /* Thread pool for performing work and receiving completion callback=
s */
> diff --git a/async.c b/async.c
> index b2de360c23..8c2a68b6cc 100644
> --- a/async.c
> +++ b/async.c
> @@ -329,15 +329,21 @@ void aio_notify(AioContext *ctx)
>      smp_mb();
>      if (ctx->notify_me) {
>          event_notifier_set(&ctx->notifier);
> +#ifndef _WIN32
>          atomic_mb_set(&ctx->notified, true);
> +#endif
>      }
>  }
> =20
>  void aio_notify_accept(AioContext *ctx)
>  {
> +#ifndef _WIN32
>      if (atomic_xchg(&ctx->notified, false)) {
> +#endif
>          event_notifier_test_and_clear(&ctx->notifier);
> +#ifndef _WIN32
>      }
> +#endif
>  }
> =20
>  static void aio_timerlist_notify(void *opaque)
> --
> 2.11.0
>=20
>=20
