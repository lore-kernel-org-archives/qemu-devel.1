Received: from eggs.gnu.org ([2001:4830:134:3::10]:41870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eyKdy-0007Sf-Ra
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eyKdu-0007J2-Ig
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:01:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eyKdu-0007IO-Cc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:01:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eyKds-0000X5-QQ
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 17:01:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C53542E84C2
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 17:01:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Mar 2018 16:47:56 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1753309 <1753309@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152019341691.7537.9997390122339723494.malonedeb@gac.canonical.com>
Message-Id: <152156447632.22543.16561391842865095203.malone@soybean.canonical.com>
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

This is now fixed in git master by commit 6461d7e2678fe4, which updates
the defines and also has a workaround for older guest kernels (which we
can remove if/when we model the IOMUX).

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753309

Title:
  Ethernet interrupt vectors for sabrelite machine are defined backwards

Status in QEMU:
  Fix Committed

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
