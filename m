Received: from eggs.gnu.org ([2001:4830:134:3::10]:39526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fLFLo-00047b-O1
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fLFLn-00027t-Qv
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:01:48 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:42573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fLFLn-00027R-Lg
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:01:47 -0400
Received: by mail-io0-x236.google.com with SMTP id a10-v6so20371408ioc.9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 15:01:47 -0700 (PDT)
MIME-Version: 1.0
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date: Tue, 22 May 2018 15:01:46 -0700
Message-ID: <CAGtobs_PEYmSyPwbYG-6oNp9PxwQ52xHaFuXh59ELWcrAm6LSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] AIO error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi!

I'm tracking an error case in the native AIO path, and was wondering if
there was a latent (albeit possibly hard to hit) bug. Specifically
util/async.c::aio_get_linux_aio:

#ifdef CONFIG_LINUX_AIO
LinuxAioState *aio_get_linux_aio(AioContext *ctx)
{
    if (!ctx->linux_aio) {
        ctx->linux_aio = laio_init();
        laio_attach_aio_context(ctx->linux_aio, ctx);
    }
    return ctx->linux_aio;
}
#endif

laio_init() can in certain conditions return NULL, but that's not checked
here and then the NULL result is passed directly into
laio_attach_aio_context, which dereferences it without checking that the
pointer is valid.

I'm not sure what is appropriate if laio_init() returns NULL, returning
NULL back to the caller of aio_get_linux_aio() has its own issues, because
those callers don't seem to check its return value either.

Thanks in advance!
-Nish
