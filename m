Received: from eggs.gnu.org ([2001:4830:134:3::10]:37545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrap-0000cL-15
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHral-0008Ie-Na
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:03 -0500
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:45379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHral-0008EZ-Dc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:30:59 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0E58D171C45
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:30:58 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:30 +0100
Message-Id: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/25] spapr: Guest exploitation of the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with an
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode, the newer POWER9 interrupt model. XIVE
is a complex interrupt controller introducing a large number of new
features, for virtualization in particular. Here is a brief overview
for the sPAPR platform which only requires a small subset of these
functions.

XIVE uses a set of internal tables to redirect exceptions from
interrupt sources to the CPU. Each interrupt source has a 2-bit state
machine, the Event State Buffer (ESB), that allows events to be
triggered. If the event is let through, XIVE looks up in the Interrupt
Virtualization Entry (IVE) table for the Event Queue Descriptor
defined for the source. Each Event Queue Descriptor defines a
notification path to a CPU and an in-memory queue in which will be
recorded an event identifier for the OS to pull.


This patchset is the first non-RFC proposal to add XIVE support in a
POWER9 sPAPR machine. It should addressed the comments made on the
previous RFCs, the most important points being :

 - use a single IRQ allocator for the machine,
 - remove any relation with the XICS model,
 - get rid of 'nr_servers' under the XIVE object.=20

The high level ideas of the current design are :

 - move all IRQ allocation code under the machine to make sure that
   the allocated IRQ numbers are kept in sync between XICS and
   XIVE. This is necessary for the devices which allocate IRQs and
   populate the device tree before the machine is even started.

 - introduce a persistent XIVE object under the sPAPR machine and let
   the CAS negotiation process decide whether it should be used or
   not. Use the 'ov5_cas' attribute for this purpose.

 - introduce a persistent XIVE interrupt presenter under the sPAPR
   core and switch ICP after CAS. Each core has now two ICPs, one
   active through the 'intc' pointer and another one among its
   children ready to be used if the guest requires it.

 - move the XIVE EQs under the cores to simplify the XIVE model

 - allocate the CPU IPIs at the beginning of the IRQ number space to
   be compatible with XICS (which starts at 4096) and also to simplify
   the model. This means that the XIVE model covers the whole IRQ
   number space. There are no offset like in XICS splitting the IRQ
   number space.


The patchset first begins with cleanups and code movements in the XICS
model and in the sPAPR machine to prepare ground for the integration
of the XIVE model. Some could be merged directly.

It continues with patches introducing new models or XIVE :

 - sPAPRXive holding the internal tables and the MMIO regions used by
   the XIVE controller.
 - sPAPRXiveICP object acting the XIVE interrupt presenter

and describing the notification process and the interrupt delivery to
the CPU.

It finishes with the integration of sPAPRXive object under the sPAPR
machine, the introducion of the new XIVE hcalls, the new device tree
layout, and the necessary adjustments to support the CAS negotiation.

Migration is addressed, CPU hotplug, and support for older machines
and QEMU versions also.


Code is here:

  https://github.com/legoater/qemu/commits/xive

Caveats :

 - KVM support : not addressed yet
   The guest needs to be run with kernel_irqchip=3Doff on a POWER9 system=
.
 - LSI : hardly tested.
  =20
Thanks,

C.

Tests :

 - make check on each patch
 - migration :
     qemu-2.12 (pseries-2.12) <->  qemu-2.12 (pseries-2.12)
     qemu-2.12 (pseries-2.10) <->  qemu-2.12 (pseries-2.10)
     qemu-2.10 (pseries-2.10) <->  qemu-2.12 (pseries-2.10)

C=C3=A9dric Le Goater (25):
  ppc/xics: introduce an icp_create() helper
  ppc/xics: assign of the CPU 'intc' pointer under the core
  spapr: introduce a spapr_icp_create() helper
  spapr: move the IRQ allocation routines under the machine
  spapr: introduce a spapr_irq_set() helper
  spapr: introduce a spapr_irq_get_qirq() helper
  migration: add VMSTATE_STRUCT_VARRAY_UINT32_ALLOC
  spapr: introduce a skeleton for the XIVE interrupt controller
  spapr: introduce handlers for XIVE interrupt sources
  spapr: add MMIO handlers for the XIVE interrupt sources
  spapr: describe the XIVE interrupt source flags
  spapr: introduce a XIVE interrupt presenter model
  spapr: introduce the XIVE Event Queues
  spapr: push the XIVE EQ data in OS event queue
  spapr: notify the CPU when the XIVE interrupt priority is more
    privileged
  spapr: add support for the SET_OS_PENDING command (XIVE)
  spapr: add a sPAPRXive object to the machine
  spapr: allocate IRQ numbers for the XIVE interrupt mode
  spapr: add hcalls support for the XIVE interrupt mode
  spapr: add device tree support for the XIVE interrupt mode
  spapr: introduce a helper to map the XIVE memory regions
  spapr: add XIVE support to spapr_irq_get_qirq()
  spapr: toggle the ICP depending on the selected interrupt mode
  spapr: add support to dump XIVE information
  spapr: advertise XIVE exploitation mode in CAS

 default-configs/ppc64-softmmu.mak |   1 +
 hw/intc/Makefile.objs             |   1 +
 hw/intc/spapr_xive.c              | 964 ++++++++++++++++++++++++++++++++=
++++++
 hw/intc/spapr_xive_hcall.c        | 949 ++++++++++++++++++++++++++++++++=
+++++
 hw/intc/trace-events              |   4 -
 hw/intc/xics.c                    |  35 +-
 hw/intc/xics_spapr.c              | 114 -----
 hw/intc/xive-internal.h           | 189 ++++++++
 hw/ppc/pnv_core.c                 |  10 +-
 hw/ppc/spapr.c                    | 286 ++++++++++-
 hw/ppc/spapr_cpu_core.c           |  44 +-
 hw/ppc/spapr_events.c             |  16 +-
 hw/ppc/spapr_hcall.c              |   6 +
 hw/ppc/spapr_pci.c                |  10 +-
 hw/ppc/spapr_vio.c                |   2 +-
 hw/ppc/trace-events               |   4 +
 include/hw/pci-host/spapr.h       |   2 +-
 include/hw/ppc/spapr.h            |  27 +-
 include/hw/ppc/spapr_cpu_core.h   |   1 +
 include/hw/ppc/spapr_vio.h        |   2 +-
 include/hw/ppc/spapr_xive.h       |  89 ++++
 include/hw/ppc/xics.h             |   8 +-
 include/migration/vmstate.h       |  10 +
 23 files changed, 2592 insertions(+), 182 deletions(-)
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/spapr_xive_hcall.c
 create mode 100644 hw/intc/xive-internal.h
 create mode 100644 include/hw/ppc/spapr_xive.h

--=20
2.13.6
