Received: from eggs.gnu.org ([2001:4830:134:3::10]:43479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOtHi-00084G-Nk
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOtHh-00077c-PZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:39:50 -0500
Received: from mail-yw0-x229.google.com ([2607:f8b0:4002:c05::229]:34642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cOtHh-00077V-L2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:39:49 -0500
Received: by mail-yw0-x229.google.com with SMTP id t125so326205048ywc.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 13:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20170104205936.27279-1-marcandre.lureau@redhat.com>
	<119554983.4442989.1483564771761.JavaMail.zimbra@redhat.com>
In-Reply-To: <119554983.4442989.1483564771761.JavaMail.zimbra@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 04 Jan 2017 21:39:38 +0000
Message-ID: <CAJ+F1CL=r4jf0DYoaqxUWEZhkR1gWCy03u_KMsQ5Puy7SzNdgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Wed, Jan 4, 2017 at 10:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
> > Paolo suggested to me on irc to call event_notifier_test_and_clear()
> > after select() >0 from aio-win32.c's aio_prepare. Unfortunately, not al=
l
> > fds associated with ctx->notifiers are in AIO fd handlers set.
> > (qemu_set_nonblock() in util/oslib-win32.c calls qemu_fd_register()).
>
> That makes sense.  Out of curiosity, what is a practical case of a socket
> that is nonblocking but doesn't have an attached handler?
>
>
Good question, qio_channel_socket_set_blocking() calls qemu_set_nonblock().
But it seems to also use its own source handler
qio_channel_create_socket_watch(), so the AIO notifier is probably needless
here.

Another possibility (this one requires much more attention to avoid missing
> some edge case; however, it should be easy to verify if it fixes the busy
> loop) could be to move aio_notify_accept to just before setting
> ctx->notify_me.
> This would work for both aio-posix and aio-win32.
>
>
 --- a/async.c
+++ b/async.c
@@ -232,8 +232,8 @@ aio_ctx_check(GSource *source)
     AioContext *ctx =3D (AioContext *) source;
     QEMUBH *bh;

-    atomic_and(&ctx->notify_me, ~1);
     aio_notify_accept(ctx);
+    atomic_and(&ctx->notify_me, ~1);

That? doesn't work here.

thanks
--=20
Marc-Andr=C3=A9 Lureau
