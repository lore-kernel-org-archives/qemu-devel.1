Received: from eggs.gnu.org ([2001:4830:134:3::10]:44422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdevC-00077B-R3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdevB-0007D6-Ek
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:21:38 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdevB-0007Cg-76
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:21:37 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v77so19748174wmv.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:21:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <tencent_44FCF9336341E20C3F2A5EB7@qq.com>
References: <tencent_44FCF9336341E20C3F2A5EB7@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 15:21:15 +0000
Message-ID: <CAFEAcA_2hK+cYTnBeR-GX1jqkCtUr6JEzaduP9VAu-vLGWTefQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fw: qemu integrator RAM size can't reach 128M when
 emulate the arm926
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: heavybird <4345099@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 14 February 2017 at 13:45, heavybird <4345099@qq.com> wrote:
> i tried use the integrator.c to emulate the arm926 which has 128M message but found the RAM size can use is less than 32M. steps below. the qemu usding is 2.8.
>
> 1  define the RAM from 0-128M in ld file.
> 2 write the test program to verify i can write/read the memory from 32M to 64M continuously with address directly.
> 3 always failed when the size is close to 32M even though i changed start address.
> 4 error message:
>
> qemu: hardware error: integratorcm_write3: Unimplemented offset 0x0
>
> CPU #0:
> R00=00000028 R01=00019000 R02=00000055 R03=10000000
> R04=0000ea9c R05=00000505 R06=00000606 R07=00000707
> R08=00000808 R09=00000909 R10=00001010 R11=0000feb4
> R12=00000000 R13=0000fea8 R14=00000338 R15=00000300

You don't give your test program, but I'm guessing
from this register dump that the address it is
trying to read is in r3 which is 0x10000000.
That is off the end of the RAM (which starts at 0
and goes up to just under 0x10000000 in the case when
you have the maximum possible 256MB RAM in this board).
In particular 0x10000000 is where the board's system
registers start, and the error above indicates that you
have attempted to write to one of them, not to RAM.

I suspect you have a bug in your test code.

thanks
-- PMM
