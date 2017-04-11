Received: from eggs.gnu.org ([2001:4830:134:3::10]:38026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxkS-0006Uz-51
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxkP-0003VT-1F
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:28 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:56016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxxkO-0003UE-Ry
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:24 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id C163331236
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 17:30:21 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Apr 2017 17:29:58 +0200
Message-Id: <1491924606-20026-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8] pnv: improvement of LPC support and
 IPMI support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

The first patches improve the LPC support for the POWER8NVL (nvlink)
systems and for multichip systems. Next, we add IPMI support to the
machine which is required to power off and reboot a PowerNV system. To
make use of it, a BT device and an BMC simulator need to be defined on
the command line:

    -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D1=
0

To improve the sensor and FRU support, one can use the following
options for the simulator:

    sdrfile=3D./palmetto-SDR.bin,fruareasize=3D256,frudatafile=3D./palmet=
to-FRU.bin


To test, grab a kernel and a rootfs image here :

  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/zImage.epapr
  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/rootfs.cpio.xz

The full patchset is available here :

   https://github.com/legoater/qemu/commits/powernv-ipmi-2.9

Thanks,

C.

Changes since v2:

 - used PNV_LPC() macro to cast the 'opaque' parameter
 - introduced a pnv_chip_lpc_offset() routine to locate the LPC node
   of a chip  =20
 - set the "primary" property on the LPC bus of chip 0 from the machine
 - used the pnv_chip_lpc_offset() routine to scan the default LPC bus
 - removed the initializer of io_base

Changes since v1:

 - moved the IRQ handler in pnv_lpc.c and introduced pnv_lpc_isa_irq_crea=
te()
 - only add the "primary" property on the LPC bus of chip 0
 - reworked the assignement of the ISA IO base in the 'reg' array
   property
 - changed the type of the 'bmc' attribute of the machine

Benjamin Herrenschmidt (1):
  ppc/pnv: Add support for POWER8+ LPC Controller

C=C3=A9dric Le Goater (7):
  ppc/pnv: enable only one LPC bus
  ppc/pnv: scan ISA bus to populate device tree
  ppc/pnv: populate device tree for RTC devices
  ppc/pnv: populate device tree for serial devices
  ppc/pnv: populate device tree for IPMI BT devices
  ppc/pnv: add initial IPMI sensors for the BMC simulator
  ppc/pnv: generate an OEM SEL event on shutdown

 hw/ppc/Makefile.objs     |   2 +-
 hw/ppc/pnv.c             | 228 ++++++++++++++++++++++++++++++++++++++---=
------
 hw/ppc/pnv_bmc.c         | 122 +++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c         | 106 +++++++++++++++++++---
 include/hw/ppc/pnv.h     |  11 +++
 include/hw/ppc/pnv_lpc.h |   8 ++
 6 files changed, 425 insertions(+), 52 deletions(-)
 create mode 100644 hw/ppc/pnv_bmc.c

--=20
2.7.4
