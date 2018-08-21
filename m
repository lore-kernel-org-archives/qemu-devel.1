Received: from eggs.gnu.org ([2001:4830:134:3::10]:35350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs2b3-0006QM-Dd
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs2Ud-0004WD-J1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:58:28 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:44543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs2Ub-0004MH-Re
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:58:26 -0400
Received: by mail-oi0-x233.google.com with SMTP id s198-v6so30746191oih.11
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 01:58:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGmj6qsWJq3cXheRpftnK2c9yCFCGDwN=Y9Y=m=QLBq+dTokAA@mail.gmail.com>
References: <CAGmj6qti3t3dBp6OT1H_UrkUi5OvXrb1nhEyozonz6uZm2P95A@mail.gmail.com>
	<CAFEAcA8wZ7ga0kJ3WQ-A=fYNeJrxxCV+b2n7_Ni4Hg7jBS+L0w@mail.gmail.com>
	<CAGmj6qtJuootGneBjcz8aCRsBXBU+GN2nhERc+76un_CiBcDZQ@mail.gmail.com>
	<CAFEAcA8wp=_MzzrT0G70n1eHbbt8FXf2upZB0cyBmhK3Pv+Y9w@mail.gmail.com>
	<CAGmj6qsWJq3cXheRpftnK2c9yCFCGDwN=Y9Y=m=QLBq+dTokAA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 09:57:55 +0100
Message-ID: <CAFEAcA-9Q1Lr0PV48SNYG8hHTShcur_i-d+9u7P2ds3VTgxvfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Simulating a composite machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schroeder <mkschreder.uk@googlemail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 August 2018 at 19:29, Martin Schroeder
<mkschreder.uk@googlemail.com> wrote:
> Ok so FPU support is not there. What would it take for me to add it? I
> would very much like to add it if I get some guidance as to what needs
> to be done and where I can find information on how to do it. I see
> there is some code in fpu/softfloat.c but I guess it is not enough?

As I say, it's mostly the exception handling parts (and also some
things like M profile having memory mapped registers for the FPU
ID registers). The instructions themselves are the same as the
A-profile FPU.

My summary breakdown of this task looks like:
 * check which instructions we need to enable and which parts
   of the current FP implementation are A/R specific and need
   "not if M" conditionals
   (this is going to involve some comparison-of-specifications
   between the M-profile architecture spec manual and the A-profile
   one. The answer is probably going to wind up being "the
   A-profile-style FPU status and control register accesses
   need to be disabled", but there might be more. You can assume
   that the actual behaviour of each instruction is the same, though.)
 * implement the status and ID registers that M profile wants
   (mostly wiring up register accessors in hw/intc/armv7m_nvic.c
   to existing CPU state fields, I think)
 * exception model changes for FP (new exception frame layout, etc)
   -- this is all code in target/arm/helper.c which now needs to
   handle the possibility of an FPU. The pseudocode in the ARMv7M
   and v8M manuals will help in identifying where changes need
   to be made.
 * make sure co-processor enable/disable is wired up right
   (the coprocessor access is handled via a memory-mapped register)
 * implement lazy saving of FP registers (complicated; when the
   CPU status registers indicate that lazy-state-preservation is
   in effect, we need to arrange that attempting to execute an
   FP insn causes us to first stop and save the FPU state to the
   stack, and then do the instruction. The best way to do this is
   going to be to add a TB flag for "lazy state preservation required",
   and if that flag is set then when we encounter an FP insn we
   generate code for "raise a lazy-stacking exception". We can
   then deal with the exception by "do the lazy-stacking, then
   resume execution".
 * turn this on for Cortex-M4, Cortex-M33 and test

thanks
-- PMM
