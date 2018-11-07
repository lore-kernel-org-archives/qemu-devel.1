Received: from eggs.gnu.org ([2001:4830:134:3::10]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKRyZ-0007dg-GF
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKRyY-0002v6-P1
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:50:47 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKRyY-0002jx-D3
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:50:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so5350202otk.3
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 09:50:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <154161094050.29232.7509981504999944905.malone@soybean.canonical.com>
References: <152204272199.688.3778854075369133494.malonedeb@wampee.canonical.com>
	<154161094050.29232.7509981504999944905.malone@soybean.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Nov 2018 17:50:11 +0000
Message-ID: <CAFEAcA9DZ1W682=zEnHsR6xj1vXDOs1wHXSsDE7C_K19OaorEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1758819] Re: HVF Illegal instruction: 4,
 High Sierra, v2.12-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_Del_Real?= <sergio.g.delreal@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 November 2018 at 17:15, Nathan Wallace <1758819@bugs.launchpad.net> wrote:
> I am also able to reproduce this bug. The problem is that when hvf is
> enabled, qemu will attempt to execute the xgetbv instruction, which
> isn't supported on my processor (Intel Xeon X5670).
>
> Here is a stack trace from lldb; the behavior is 100% reproducible for
> me.
>
> nathan@Nathans-Mac-Pro:~/src/qemu/qemu-3.0.0/x86_64-softmmu
> $ lldb -- qemu-system-x86_64 --accel hvf
> (lldb) target create "qemu-system-x86_64"
> runCurrent executable set to 'qemu-system-x86_64' (x86_64).
> (lldb) settings set -- target.run-args  "--accel" "hvf"
> (lldb) run
> Process 27479 launched: '/Users/nathan/src/qemu/qemu-3.0.0/x86_64-softmmu/qemu-system-x86_64' (x86_64)
> Process 27479 stopped
> * thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
>     frame #0: 0x00000001001bca3a qemu-system-x86_64`xgetbv(xcr=0) at x86_cpuid.c:34
>    31   {
>    32       uint32_t eax, edx;
>    33
> -> 34       __asm__ volatile ("xgetbv"
>    35                         : "=a" (eax), "=d" (edx)
>    36                         : "c" (xcr));
>    37
> Target 0: (qemu-system-x86_64) stopped.

Sergio -- looks like this is the result of your code
in hvf-utils/x86_cpuid.c, which assumes xgetbv is
present on the host CPU.

It looks like tcg/i386/tcg-target.inc.c has some code
which uses xgetbv but has some better guards on
it to avoid the undef -- looks like there's a bit
you need to check in another cpuid field...

thanks
-- PMM
