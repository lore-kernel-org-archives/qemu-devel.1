Received: from eggs.gnu.org ([2001:4830:134:3::10]:39655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuwgz-0001ql-5D
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuwgu-0008PI-1p
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:25 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:39064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cuwgt-0008Ov-RU
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:19 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 02A857AFF5
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 09:46:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  3 Apr 2017 09:45:56 +0200
Message-Id: <1491205565-12831-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/9] ppc/pnv: interrupt controller (POWER8)
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

Changes since v4:
 - reworked a bit the order of the patches for make check-qtest-ppc64
   to pass. The machine needs to be a XICSFabric before the PnvCore
   use it.
 - allocated the ICPState object from under sPAPRCPUCore and removed
   xics_get_cpu_index_by_dt_id()
 - moved the creation of PnvICPState object before the PowerPCCPU
   object is realized to handle correctly errors.
 - removed the empty ics_get() and ics_resend() handlers. They will be
   added by the PSI HB model

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
  spapr: move the IRQ server number mapping under the machine
  spapr: allocate the ICPState object from under sPAPRCPUCore
  ppc/xics: add a realize() handler to ICPStateClass
  ppc/pnv: add a PnvICPState object
  ppc/pnv: extend the machine with a XICSFabric interface
  ppc/pnv: extend the machine with a InterruptStatsProvider interface
  ppc/pnv: create the ICP object under PnvCore
  ppc/pnv: add a helper to calculate MMIO addresses registers
  ppc/pnv: add memory regions for the ICP registers

 hw/intc/Makefile.objs   |   1 +
 hw/intc/xics.c          |  16 ++--
 hw/intc/xics_pnv.c      | 192 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xics_spapr.c    |   5 +-
 hw/ppc/pnv.c            | 130 ++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c       |  27 ++++++-
 hw/ppc/spapr.c          |  48 ++++--------
 hw/ppc/spapr_cpu_core.c |  18 ++++-
 include/hw/ppc/pnv.h    |  31 +++++++-
 include/hw/ppc/spapr.h  |   2 +-
 include/hw/ppc/xics.h   |  15 +++-
 11 files changed, 428 insertions(+), 57 deletions(-)
 create mode 100644 hw/intc/xics_pnv.c

--=20
2.7.4
