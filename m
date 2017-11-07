Received: from eggs.gnu.org ([2001:4830:134:3::10]:56407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7iH-0007MU-TC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7iD-0007xV-2a
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:31:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC7iC-0007wf-T8
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:30:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC7iB-0008HB-7E
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 17:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 21F352E80D2
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 17:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:18:24 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1226531 <1226531@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130917104457.12235.50139.malonedeb@soybean.canonical.com>
Message-Id: <151007510465.4240.13978998865979409904.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1226531] Re: Incorrect logic in ARMv7M interrupt
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We finally fixed this longstanding ARMv7M emulation bug in the 2.10
release (by rewriting the NVIC handling entirely).


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1226531

Title:
  Incorrect logic in ARMv7M interrupt handler

Status in QEMU:
  Fix Released

Bug description:
  On ARMv7M interrupts handlers will be called even if emulated code
  executes "cpsid i" instruction.

  Underlying cause described below:

  In cpu-exec.c:cpu_exec there is a block of code that determines if an
  interrupt should be raised or not:

  =

                      /* ARMv7-M interrupt return works by loading a magic =
value
                         into the PC.  On real hardware the load causes the
                         return to occur.  The qemu implementation performs=
 the
                         jump normally, then does the exception return when=
 the
                         CPU tries to execute code at the magic address.
                         This will cause the magic PC value to be pushed to
                         the stack if an interrupt occurred at the wrong ti=
me.
                         We avoid this by disabling interrupts when
                         pc contains a magic address.  */
                      if (interrupt_request & CPU_INTERRUPT_HARD
                          && ((IS_M(env) && env->regs[15] < 0xfffffff0)
                              || !(env->uncached_cpsr & CPSR_I))) {
                          env->exception_index =3D EXCP_IRQ;
                          cc->do_interrupt(cpu);
                          next_tb =3D 0;
                      }

  I'm not convinced the logic is correct.
  The logic for ARMv7M should be:

  If an interrupt is pending (interrupt_request & CPU_INTERRUPT_HARD)
  AND
  Interrupts are not disabled ( !(env->uncached_cpsr & CPSR_I) )
  AND
  PC doesn't have a magic value (env->regs[15] < 0xfffffff0)

  The current logic seems fires the interrupt if interrupts are enabled
  OR the PC isn't magic, which is basically all the time.

  I'm not sure what the cleanest patch for this would be.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1226531/+subscriptions
