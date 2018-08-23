Received: from eggs.gnu.org ([2001:4830:134:3::10]:47768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsuDh-0001Cw-45
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsuDg-0006sX-Av
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:20:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsuDg-0006s3-1H
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:20:32 -0400
Received: by mail-oi0-x241.google.com with SMTP id l82-v6so5312972oih.11
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 11:20:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAF4BF-R8iAkeHXFPHazY2Tmr+Yh=WrG4yKx=LVm7rRLBnxKseA@mail.gmail.com>
References: <CAF4BF-R8iAkeHXFPHazY2Tmr+Yh=WrG4yKx=LVm7rRLBnxKseA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 19:20:10 +0100
Message-ID: <CAFEAcA_y2-N_aaG4W4rQABsTe=B++pSMp53_kKay0_MjGT4WpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix ARM v7m gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Friedt <chrisfriedt@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 August 2018 at 17:36, Christopher Friedt <chrisfriedt@gmail.com> wrote:
> I hope this message finds you well, as I'm currently on a lake in the
> middle of nowhere relying on my flaky cellular connection. Roaming
> sucks. In any case, I found a bug while trying to execute the "svc 0"
> instruction for cortex-m3.
>
> A UsageFault (EXCP_INVSTATE) is injected at
> target/arm/translate.c:disas_arm_insn() without the patch. I noticed
> because I added a log statement to the effect, so my pre-patch output
> was:
>
> $ qemu-system-arm -d int  -M netduino2 -cpu cortex-m3  -S -s
> -semihosting -nographic -kernel hello.bin
> Taking exception 2 [SVC]
> ... as 11
> M variants do not implement ARM mode.
> Taking exception 18 [v7M INVSTATE UsageFault]
> ... as 3
> M variants do not implement ARM mode.
> Taking exception 18 [v7M INVSTATE UsageFault]
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> R00=2000079c R01=0000008c R02=00000000 R03=000f0005
> R04=2000071c R05=20000808 R06=00000000 R07=000f0005
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=200018e0 R14=fffffff1 R15=00000000
> XPSR=00000003 ---- A handler
> FPSCR: 00000000
> Abort trap: 6

Hi; thanks for your patch, but I don't think it is correct.
What it does is to make QEMU ignore the T bit in the xPSR.
The architecture says that what should happen is that attempts
to execute with the T bit clear should cause an INVSTATE
UsageFault, which is exactly what we do. The reason we end up
aborting is because the CPU should really be going into
Lockup mode (where it basically hangs indefinitely),
and QEMU doesn't implement that.

Your guest code almost certainly has a bug where it is
not setting the low bit in the words in its exception
vector table. See the v7M ARM ARM section B1.5.3 if you
happen to have a copy on your lake, but the short answer
is that bit 1 must be set, exactly because this is what
defines whether EPSR.T is set on exception entry. If
you tried this on real hardware it would fail in the
same way (except that the hardware would lock up and sit
there like a lemon rather than calling abort()).

thanks
-- PMM
