Received: from eggs.gnu.org ([2001:4830:134:3::10]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDT-0007aA-Li
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDP-00035l-N3
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:11 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:51815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1clZDP-00034D-Gf
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:07 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 59F953BD6A
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:52:57 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  8 Mar 2017 11:52:43 +0100
Message-Id: <1488970371-8865-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 0/8] ppc/pnv: interrupt controller
 (POWER8)
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

Here is a series adding support for the interrupt controller as found
on a POWER8 system. POWER9 uses a different interrupt controller
called XIVE, still to be worked on.

The initial patches are small extensions to the recently added
XICSFabric framework. The PowerNV machine is then extended to hold the
Interrupt Source Control (ICS) and the Interrupt Control Presenter
objects of the system. After that, we use a memory region to model the
Interrupt Management area which contains the ICPs registers of a
POWER8 PowerNV system.

Last is a PSI (Processor Service Interface) bridge model to handle the
external interrupt, a minimal model for the OCC (on-chip Controller)
and support for the LPC controller on POWER8+ cpus.

To test, grab a kernel and a rootfs image here :

  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/zImage.epapr
  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/rootfs.cpio.xz

The full patchset is available here :

   https://github.com/legoater/qemu/commits/powernv-ipmi-2.9

Thanks,

C.

Benjamin Herrenschmidt (3):
  ppc/pnv: Add cut down PSI bridge model and hookup external interrupt
  ppc/pnv: Add OCC model stub with interrupt support
  ppc/pnv: Add support for POWER8+ LPC Controller

C=C3=A9dric Le Goater (5):
  ppc/xics: add a xics_get_cpu_index_by_pir() helper
  ppc/xics: add an ics_eoi() handler to XICSFabric
  ppc/pnv: create the ICP and ICS objects under the machine
  ppc/pnv: add memory regions for the ICP registers
  ppc/pnv: map the ICP memory regions

 hw/intc/xics.c             |  20 +-
 hw/ppc/Makefile.objs       |   2 +-
 hw/ppc/pnv.c               | 224 ++++++++++++++++-
 hw/ppc/pnv_core.c          | 158 +++++++++++-
 hw/ppc/pnv_lpc.c           |  47 +++-
 hw/ppc/pnv_occ.c           | 136 +++++++++++
 hw/ppc/pnv_psi.c           | 583 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/ppc.c               |  16 ++
 hw/ppc/spapr.c             |  11 +
 include/hw/ppc/pnv.h       |  34 +++
 include/hw/ppc/pnv_core.h  |   1 +
 include/hw/ppc/pnv_lpc.h   |   9 +
 include/hw/ppc/pnv_occ.h   |  38 +++
 include/hw/ppc/pnv_psi.h   |  61 +++++
 include/hw/ppc/pnv_xscom.h |   6 +
 include/hw/ppc/xics.h      |   7 +
 target/ppc/cpu.h           |  10 +
 17 files changed, 1343 insertions(+), 20 deletions(-)
 create mode 100644 hw/ppc/pnv_occ.c
 create mode 100644 hw/ppc/pnv_psi.c
 create mode 100644 include/hw/ppc/pnv_occ.h
 create mode 100644 include/hw/ppc/pnv_psi.h

--=20
2.7.4
