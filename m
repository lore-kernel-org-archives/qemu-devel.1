Received: from eggs.gnu.org ([2001:4830:134:3::10]:60934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7iA1-0006Jj-9r
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7i9w-0006cg-Ev
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:25:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:45794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7i9w-0006bb-7c
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:25:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7i9u-00077l-SP
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 13:25:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D2E6A2E80CE
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 13:25:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 13:13:06 -0000
From: Thomas Huth <657006@bugs.launchpad.net>
Reply-To: Bug 657006 <657006@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101008180054.4876.62094.malonedeb@palladium.canonical.com>
Message-Id: <150902358626.17096.9892702318273302823.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 657006] Re: arm v7M - svc insn doesn't trigger
 PendSV handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/657006

Title:
  arm v7M - svc insn doesn't trigger PendSV handler

Status in QEMU:
  Incomplete

Bug description:
  The svc instruction doesn't work as expected.

  -> qemu 0.13.0 rc1 (git)

  Test : demo with freeRTOS (for example
  FreeRTOS-6.0.5/Demo/CORTEX_LM3S811_GCC) with the card lm3s811evb.

  If we start the scheduler, it will call that function (__attribute__
  (( naked ))) :

  void vPortStartFirstTask( void )

  {

          __asm volatile(

                                          " ldr r0, =3D0xE000ED08   \n" /*
  Use the NVIC offset register to locate the stack. */

                                          " ldr r0, [r0]
  \n"

                                          " ldr r0, [r0]
  \n"

                                          " msr msp, r0
  \n" /* Set the msp back to the start of the stack. */

                                          " svc 0
  \n" /* System call to start first task. */

                                  );

  }

  The 4 first lines in asm work fine. The scv 0 call will rise the right in=
terrupt in qemu (line 151, in arm_gic.c, best_irq =3D 15). However, it will=
 never call the PendSV Handler (xPortPendSVHandler here). This function is =
recorded in the nvic vector.
  Next, (after the svc), the processor will execute the line after in code =
(this is a naked function) so the next function written after vPortStartFir=
stTask in the code.

  =

  command line :
  console 1 : qemu-system-arm -M lm3s6965evb -kernel gcc/RTOSDemo.axf -s -S
  console 2 : arm-none-eabi-gdb -ex "target remote localhost:1234" gcc/RTOS=
Demo.axf

  arm-none-eabi from http://www.codesourcery.com/sgpp/lite/arm/portal/relea=
se1294
  Same error with another project with arm-elf

  processor : arm cortex m3

  host : gentoo (2.6.35-r9) (without kqemu)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/657006/+subscriptions
