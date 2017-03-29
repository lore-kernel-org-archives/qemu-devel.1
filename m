Received: from eggs.gnu.org ([2001:4830:134:3::10]:53133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE2v-0006LJ-CI
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE2s-00016I-4H
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:53:57 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:51618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ctE2r-00015q-Tp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:53:54 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5C25C78B6A
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 15:53:51 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 29 Mar 2017 15:53:22 +0200
Message-Id: <1490795611-4762-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/9] ppc/pnv: interrupt controller (POWER8)
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
IRQ 'server' number mapping under the machine handlers.

A new PnvICPState object based on MMIOs, which is specific to PowerNV,
is introduced in XICS. These ICP objects are created for each thread
of a core and linked to the associated PowerPCCPU object.

Finally, to make use of the XICS layer, the PowerNV machine is
extended with a QOM XICSFabric interface and with a global memory
region acting as the Interrupt Management area.


To test, grab a kernel and a rootfs image here :

  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/zImage.epapr
  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/rootfs.cpio.xz

The full patchset is available here :

   https://github.com/legoater/qemu/commits/powernv-ipmi-2.9

Thanks,

C.

Changes since v3:
 - renamed 'icp' backlink to a more generic name 'intc'
 - removed the array of ICP objects from under the PowerNV machine and
   handled the allocation of the PnvICPState object for each thread
   when the PowerPCCPU object is realized.

Changes since v2:

 - removed the ICS list from the PowerNV machine
 - changed the 'icp' backlink type to be an 'Object'

Changes since v1:

 - introduced PnvICPState to hold the ICP memory region
 - handled pir-to-cpu_index mapping under the machine icp_get handler
 - added multichip support
 - removed ics_eoi handler (came from a bug in PHB3_MSI)
 - kept PSI and OCC model for later, when this part is done.

C=C3=A9dric Le Goater (9):
  ppc/xics: introduce an 'intc' backlink under PowerPCCPU
  spapr: move the IRQ server number mapping under the machine
  ppc/xics: add a realize() handler to ICPStateClass
  ppc/pnv: add a PnvICPState object
  ppc/pnv: create the ICP object under PnvCore
  ppc/pnv: add a helper to calculate MMIO addresses registers
  ppc/pnv: extend the machine with a XICSFabric interface
  ppc/pnv: extend the machine with a InterruptStatsProvider interface
  ppc/pnv: add memory regions for the ICP registers

 hw/intc/Makefile.objs   |   1 +
 hw/intc/xics.c          |  11 ++-
 hw/intc/xics_pnv.c      | 180 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xics_spapr.c    |  25 ++-----
 hw/ppc/pnv.c            | 142 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c       |  30 ++++++--
 hw/ppc/spapr.c          |   3 +-
 hw/ppc/spapr_cpu_core.c |   4 +-
 include/hw/ppc/pnv.h    |  31 ++++++++-
 include/hw/ppc/xics.h   |  15 +++-
 target/ppc/cpu.h        |   1 +
 11 files changed, 414 insertions(+), 29 deletions(-)
 create mode 100644 hw/intc/xics_pnv.c

--=20
2.7.4
