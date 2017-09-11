Received: from eggs.gnu.org ([2001:4830:134:3::10]:34524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGW-0008Tc-Bz
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGR-0003gp-CN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:12:56 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:54859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSGR-0003gV-5U
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:12:51 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B0098AA007
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:12:49 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:14 +0200
Message-Id: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 00/21] Guest exploitation of the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with an
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode, the newer POWER9 interrupt model. This
patchset is a proposal to add XIVE support in POWER9 sPAPR machine.

Follows a model for the XIVE interrupt controller and support for the
Hypervisor's calls which are used to configure the interrupt sources
and the event/notification queues of the guest. The last patch
integrates XIVE in the sPAPR machine.

Code is here:

  https://github.com/legoater/qemu/commits/xive

Caveats :

 - IRQ allocator : making progress

   The sPAPR machine make uses of the interrupt controller very early
   in the initialization sequence to allocate IRQ numbers and populate
   the device tree. CAS requires XIVE to be able to switch interrupt
   model and consequently have the models share a common IRQ allocator.  =
=20

   I have chosen to link the sPAPR XICS interrupt source into XIVE to
   share the ICSIRQState array which acts as an IRQ allocator. This
   can be improved.

 - Interrupt presenter :

   The register data is directly stored under the ICPState structure
   which is shared with all other sPAPR interrupt controller models.

 - KVM support : not addressed yet

   The guest needs to be run with kernel_irqchip=3Doff on a POWER9 system=
.

 - LSI : lightly tested.
  =20
Thanks,

C.

Changes since RFC v1:

 - removed initial complexity due to a tentative try to support
   PowerNV. This will come later.
 - removed specific XIVE interrupt source and presenter models
 - renamed files and typedefs
 - removed print_info() handler
 - introduced a CAS reset to rebuild the device tree
 - linked the XIVE model with the sPAPR XICS interrupt source to share
   the IRQ allocator  =20
 - improved hcall support (still some missing but they are not used
   under Linux)
 - improved device tree
 - should have addressed comments in first RFC
 - and much more ... Next version should have a better changelog.
=20

C=C3=A9dric Le Goater (21):
  ppc/xive: introduce a skeleton for the sPAPR XIVE interrupt controller
  migration: add VMSTATE_STRUCT_VARRAY_UINT32_ALLOC
  ppc/xive: define the XIVE internal tables
  ppc/xive: provide a link to the sPAPR ICS object under XIVE
  ppc/xive: allocate IRQ numbers for the IPIs
  ppc/xive: introduce handlers for interrupt sources
  ppc/xive: add MMIO handlers for the XIVE interrupt sources
  ppc/xive: describe the XIVE interrupt source flags
  ppc/xive: extend the interrupt presenter model for XIVE
  ppc/xive: add MMIO handlers for the XIVE TIMA
  ppc/xive: push the EQ data in OS event queue
  ppc/xive: notify the CPU when interrupt priority is more privileged
  ppc/xive: handle interrupt acknowledgment by the O/S
  ppc/xive: add support for the SET_OS_PENDING command
  spapr: modify spapr_populate_pci_dt() to use a 'nr_irqs' argument
  spapr: add a XIVE object to the sPAPR machine
  ppc/xive: add hcalls support
  ppc/xive: add device tree support
  ppc/xive: introduce a helper to map the XIVE memory regions
  ppc/xics: introduce a qirq_get() helper in the XICSFabric
  spapr: activate XIVE exploitation mode

 default-configs/ppc64-softmmu.mak |   1 +
 hw/intc/Makefile.objs             |   1 +
 hw/intc/spapr_xive.c              | 821 ++++++++++++++++++++++++++++++++=
+
 hw/intc/spapr_xive_hcall.c        | 930 ++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xics.c                    |  11 +-
 hw/intc/xive-internal.h           | 189 ++++++++
 hw/ppc/spapr.c                    | 110 ++++-
 hw/ppc/spapr_hcall.c              |   6 +
 hw/ppc/spapr_pci.c                |   4 +-
 include/hw/pci-host/spapr.h       |   2 +-
 include/hw/ppc/spapr.h            |  17 +-
 include/hw/ppc/spapr_xive.h       |  75 +++
 include/hw/ppc/xics.h             |   7 +
 include/migration/vmstate.h       |  10 +
 14 files changed, 2169 insertions(+), 15 deletions(-)
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/spapr_xive_hcall.c
 create mode 100644 hw/intc/xive-internal.h
 create mode 100644 include/hw/ppc/spapr_xive.h

--=20
2.13.5
