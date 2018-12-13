Received: from eggs.gnu.org ([2001:4830:134:3::10]:33316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXNLe-0000Gc-Hz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXNLc-0006fp-4h
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:32:02 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXNLZ-0006Zm-Jh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:31:59 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so1262035otr.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 01:31:53 -0800 (PST)
MIME-Version: 1.0
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<154468427058.9757.15261216341451632615@02a1dbf831e2>
In-Reply-To: <154468427058.9757.15261216341451632615@02a1dbf831e2>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 09:31:40 +0000
Message-ID: <CAFEAcA_=Xn3KBhKwXG0_=iGtEZ56dK3TyLMcSnPafPZ8nL1zZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Li Qiang <liq3ea@gmail.com>, fam@euphon.net, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 13 Dec 2018 at 06:58, <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/1544666977-4816-1-git-send-email-liq3ea@gmail.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-quick@centos7 SHOW_ENV=1 J=8
> === TEST SCRIPT END ===
>
> libpmem support   no
> libudev           no
>
> WARNING: Use of SDL 1.2 is deprecated and will be removed in
> WARNING: future releases. Please switch to using SDL 2.0
>
> NOTE: cross-compilers enabled:  'cc'
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>
>
> The full log is available at
> http://patchew.org/logs/1544666977-4816-1-git-send-email-liq3ea@gmail.com/testing.docker-quick@centos7/?type=message.

Patchew's attempt to limit the log to only the section with
the errors/warnings seems to have misfired here -- it looks
like it's picked the first bit of the log with a warning/error
rather than extracting all of them, which in this case happens
to be the harmless complaint that this build setup doesn't
have SDL2 installed.

The actual cause of the failure is much lower down:

  GTESTER check-qtest-aarch64
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f != -1' failed.
Broken pipe
GTester: last random seed: R02S61a1e35369394d7efb0a0e96d8af615d
  GTESTER tests/test-qht-par
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f != -1' failed.
Broken pipe
GTester: last random seed: R02Sbf8c21ef5f216840e073ff3e487dedbc
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f != -1' failed.
Broken pipe
GTester: last random seed: R02Sfe8cd276fddf3a92891cf274bf88e888
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f != -1' failed.
Broken pipe
GTester: last random seed: R02S7487fc065e22541ba4c78c0db6c61d3c
Could not access KVM kernel module: No such file or directory

thanks
-- PMM
