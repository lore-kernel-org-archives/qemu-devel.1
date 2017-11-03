Received: from eggs.gnu.org ([2001:4830:134:3::10]:57773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAf4D-0001QG-Bt
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAf48-0007lV-Ee
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:43:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:54380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAf48-0007kx-8X
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:43:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAf45-0008Gh-0n
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 16:43:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A5B132E8298
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 16:43:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 16:29:11 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1353346 <1353346@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140806083240.21378.88043.malonedeb@soybean.canonical.com>
Message-Id: <150972655168.4347.15326270964704541064.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1353346] Re: ARMv7-M software-triggered
 interrupts-- unexpected behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in QEMU 2.9 as part of the rewrite of M profile
exception handling.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1353346

Title:
  ARMv7-M software-triggered interrupts-- unexpected behaviour

Status in QEMU:
  Fix Released

Bug description:
  The handling of the NVIC "Software Triggered Interrupt Register" in
  qemu-2.1.0/hw/intc/armv7m_nvic.c:375 isn't quite right.  As things
  stand, writing a zero to the STIR ends up transferring control to
  vector table entry zero, which, on ARMv7-M, holds the reset value of
  the stack pointer.  That's what I see with lm3s811evb emulation, and
  that's not what happens on my STM NUCLEO-F103RB board (Cortex-M3).

  Seems like an oversight-- the handler probably wants
  armv7m_nvic_set_pending(), not gic_set_pending_private(), and the IRQ
  number needs 16 added onto it to get the exception number for the
  interrupt.

  ARM DUI 0552A (Cortex-M3 Devices: Generic User's Guide), p. 134:
    "Interrupt ID of the interrupt to trigger, in the range 0-239. For exam=
ple, a value of 0x03 specifies interrupt IRQ3."

  Cheers,
  Boris

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1353346/+subscriptions
