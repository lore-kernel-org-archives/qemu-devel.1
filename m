Received: from eggs.gnu.org ([2001:4830:134:3::10]:50008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etKTw-0004Nh-W9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etKTt-00028c-PN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:50:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:55536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1etKTt-00025V-Iy
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:50:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1etKTs-0007rM-F4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 21:50:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 705392E80C7
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 21:50:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Mar 2018 21:44:55 -0000
From: Bill Paul <wpaul@windriver.com>
Reply-To: Bug 1753309 <1753309@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152019341691.7537.9997390122339723494.malonedeb@gac.canonical.com>
Message-Id: <152037269578.7728.4875822417510253413.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1753309] Re: Ethernet interrupt vectors for
 sabrelite machine are defined backwards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

"4.14+: Both versions of qemu (as-is and interrupts reverted) work fine"

Hm. I really wonder how it can be possible that Linux works with the
interrupt vectors reversed, though to be fair I have not looked at the
Linux i.MX6 ENET driver code. I suppose it's possible that the driver is
binding the same interrupt service routine to both interrupt vectors. If
so, then it works by accident. :)

I think U-Boot uses polling so it wouldn't care if the interrupt vectors
are wrong.

We have several SabreLite boards in house. We also have NXP Sabre SD
reference boards which use the same i.MX6Q SoC and the exact same
ethernet driver with the same interrupt configuration. I have always
used VxWorks with them rather than Linux, and I can say for a fact that
the VxWorks ENET driver only binds an ISR to vector 150 (118) (VxWorks
doesn't currently support the IEEE 1588 feature with this interface so
it never uses vector 151) and it works as expected -- network interrupt
events are indeed received via vector 150.

The same VxWorks image that works with real hardware does not work with
QEMU unless I fix the vectors in fsl-imx6.h.

In short, both the hardware and the manual seem to agree. QEMU is doing
it wrong. :)

Also, the errata sheet for the i.MX6 is here:

https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Apparently erratum 6687 is related to power management and wakeup
events. I'm not sure how that factors in to how Linux behaves.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753309

Title:
  Ethernet interrupt vectors for sabrelite machine are defined backwards

Status in QEMU:
  New

Bug description:
  The sabrelite machine model used by qemu-system-arm is based on the
  Freescale/NXP i.MX6Q processor. This SoC has an on-board ethernet
  controller which is supported in QEMU using the imx_fec.c module
  (actually called imx.enet for this model.)

  The include/hw/arm/fsm-imx6.h file defines the interrupt vectors for
  the imx.enet device like this:

  #define FSL_IMX6_ENET_MAC_1588_IRQ 118
  #define FSL_IMX6_ENET_MAC_IRQ 119

  However, this is backwards. The reference manual for the i.MX6D/Q
  devices can be found here:

  https://www.nxp.com/docs/en/reference-manual/IMX6DQRM.pdf

  On page 225, in Table 3-1. ARM Cortex A9 domain interrupt summary, it
  shows the following:

  150 ENET
  MAC 0 IRQ, Logical OR of:
  MAC 0 Periodic Timer Overflow
  MAC 0 Time Stamp Available
  MAC 0 Time Stamp Available
  MAC 0 Time Stamp Available
  MAC 0 Payload Receive Error
  MAC 0 Transmit FIFO Underrun
  MAC 0 Collision Retry Limit
  MAC 0 Late Collision
  MAC 0 Ethernet Bus Error
  MAC 0 MII Data Transfer Done
  MAC 0 Receive Buffer Done
  MAC 0 Receive Frame Done
  MAC 0 Transmit Buffer Done
  MAC 0 Transmit Frame Done
  MAC 0 Graceful Stop
  MAC 0 Babbling Transmit Error
  MAC 0 Babbling Receive Error
  MAC 0 Wakeup Request [synchronous]

  151 ENET
  MAC 0 1588 Timer interrupt [synchronous] request

  Note:
  150 - 32 =3D=3D 118
  151 - 32 =3D=3D 119

  In other words, the vector definitions in the fsl-imx6.h file are
  reversed. The correct definition is:

  #define FSL_IMX6_ENET_MAC_IRQ 118
  #define FSL_IMX6_ENET_MAC_1588_IRQ 119

  I tested the sabrelite simulation using VxWorks 7 (which supports the
  SabreLite board) and found that while I was able to send and receive
  packet data via the simulated ethernet interface, the VxWorks i.MX6
  ethernet driver failed to receive any interrupts. When I corrected the
  interrupt vector definitions as shown above and recompiled QEMU,
  everything worked as expected. I was able to exchange ICMP packets
  with the simulated target and telnet to/from the VxWorks instance
  running in the virtual machine. I used the tap interface for this.

  As a workaround I was also able to make the ethernet work by modifying
  the VxWorks imx6q-sabrelite.dts file to change the ethernet interrupt
  property from 150 to 151.

  This problem was observed with the following environment:

  Host: FreeBSD/amd64 11.1-RELEASE
  QEMU version: 2.11.0 and 2.11.1 built from source code

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1753309/+subscriptions
