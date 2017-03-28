Received: from eggs.gnu.org ([2001:4830:134:3::10]:59170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cslck-00037y-49
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cslcg-0007Cn-Vy
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:33:02 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:40055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cslcg-0007BW-Qg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:32:58 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 259F77883D
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 09:32:47 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 28 Mar 2017 09:32:24 +0200
Message-Id: <1490686352-24017-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8] ppc/pnv: interrupt controller (POWER8)
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

The initial patches are more cleanups of the XICS layer which move the
IRQ 'server' number mapping under the machine handlers. The PowerNV
machine is then extended with the Interrupt Source Control (ICS), the
Interrupt Control Presenter (ICP) objects and the Interrupt Management
area.

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

 - removed the ICS list from the PowerNV machine
 - changed the 'icp' backlink type to be an 'Object'

Changes since v1:

 - introduced PnvICPState to hold the ICP memory region
 - handled pir-to-cpu_index mapping under the machine icp_get handler
 - added multichip support
 - removed ics_eoi handler (came from a bug in PHB3_MSI)
 - kept PSI and OCC model for later, when this part is done.

C=C3=A9dric Le Goater (8):
  ppc/xics: introduce an 'icp' backlink under PowerPCCPU
  spapr: move the IRQ server number mapping under the machine
  ppc/xics: add a realize() handler to ICPStateClass
  ppc/pnv: add a PnvICPState object
  ppc/pnv: create the ICP and ICS objects under the machine
  ppc/pnv: add a helper to calculate MMIO addresses registers
  ppc/pnv: link the CPUs to the machine XICSFabric
  ppc/pnv: add memory regions for the ICP registers

 hw/intc/Makefile.objs   |   1 +
 hw/intc/xics.c          |   9 ++-
 hw/intc/xics_pnv.c      | 180 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xics_spapr.c    |  25 ++-----
 hw/ppc/pnv.c            | 179 ++++++++++++++++++++++++++++++++++++++++++=
+++++
 hw/ppc/pnv_core.c       |  20 ++++--
 hw/ppc/spapr.c          |   3 +-
 hw/ppc/spapr_cpu_core.c |   5 +-
 include/hw/ppc/pnv.h    |  34 ++++++++-
 include/hw/ppc/xics.h   |  13 ++++
 target/ppc/cpu.h        |   1 +
 11 files changed, 443 insertions(+), 27 deletions(-)
 create mode 100644 hw/intc/xics_pnv.c

--=20
2.7.4
