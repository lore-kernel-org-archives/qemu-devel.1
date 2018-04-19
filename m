Received: from eggs.gnu.org ([2001:4830:134:3::10]:56309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98us-0007PU-LP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98uo-0007bq-Iv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:43:58 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:41342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98uo-0007Vn-9k
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:43:54 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.37])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id BEFCB167CC8
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:43:44 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:42:56 +0200
Message-Id: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/35] ppc: support for the XIVE interrupt
 controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

The POWER9 processor comes with a new interrupt controller, called
XIVE, which introduces a large number of new features, for
virtualization in particular.

* XIVE interrupt controller

It is composed of three sub-engines :

  - Interrupt Virtualization Source Engine (IVSE). These are in PHBs,
    in the main controller for the IPIS and in the PSI host
    bridge. They are configured to feed the IVRE with events.

  - Interrupt Virtualization Routing Engine (IVRE). Its job is to
    match an event source with a Notification Virtualization Target
    (NVT), a priority and an Event Queue (EQ) to determine if a
    Virtual Processor can handle the event.

  - Interrupt Virtualization Presentation Engine (IVPE). It maintains
    the interrupt state of each hardware thread and present the
    notification as an external exception.

Each of the engines uses a set of internal tables to redirect
exceptions from event sources to CPU threads. Interrupt sources have a
2-bit state machine, the Event State Buffer (ESB), that allows events
to be triggered. If the event is let through, the IVRE looks up in the
Interrupt Virtualization Entry (IVE) table for the Event Queue
Descriptor configured for the source. Each Event Queue Descriptor
defines a notification path to a CPU and an in-memory queue in which
will be recorded an event identifier for the OS to pull.

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with a
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode. On a POWER9 PowerNV machine, the XIVE
interrupt controller is a must have.


* XIVE for sPAPR

Here are the high level ideas of the current design to add support for
XIVE :

 - introduce a persistent sPAPRXive object under the sPAPR machine for
   newer machines and let the CAS negotiation process decide whether
   it should be used or not. Use the 'ov5_cas' attribute for this
   purpose.

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


* sPAPR patchset layout=20

It first defines new models for XIVE, which will be shared between the
machines or with KVM for sPAPR :

 - XiveSource holding the PQ bits and the ESB MMIO region used to
   control them.

 - XiveNVT holding the CPU interrupt state and the EQ state. it models
   the XIVE interrupt presenter engine.

 - sPAPRXive modeling the XIVE interrupt controller for sPAPR
   machines, holding the internal routing table, a single XIVE source
   for the IPIs and other interrupts and the TIMA MMIO regions used by
   the XiveNVT to do interrupt management.=20

We do not model the IVRE, but this is not a problem to introduce it if
needed. Maybe for migration. To be discussed.
  =20
Then, the notification process and the interrupt delivery to the CPU
is described. Support for sPAPR is completed with the integration of
the sPAPRXive object in the machine, the definition of the new XIVE
hcalls, the device tree layout, and the necessary adjustments to
support the CAS negotiation.

Follows the support for KVM with a set of specific XIVE models, very
much like XICS does.  But, the interrupt mode is still chosen at the
init of the machine and the reset does change the KVM interrupt
device. A couple of patches try to fix this limitation with a proposal
to support resets of KVM devices. Some issues in the MMU migration
which still need to be addressed.


* PowerNV extension

It seemed interesting to include the models for PowerNV as a way to
validate that the concept are valid.

The patchset finishes with RFCs of models for the XIVE interrupt
controller and for the PSI bridge device for the POWER9 PowerNV. PSI
provides a good example of the usage of the notify() handler of the
XiveFabric interface, linking the PSI XiveSource to its owning device.


* Coverage

At this stage, XIVE support in QEMU covers :

 - TCG & KVM kernel_irqchip=3Doff/on
 - CPU hotplug
 - support for older machines
 - migration under TCG
 - migration under KVM, including kernel_irqchip=3Doff <-> kernel_irqchip=
=3Don


* Caveats

Migration still needs some care to make sure all HW states are
captured correctly. Extra quiescence points are possibly needed,
to turn off/on the XIVE configuration under KVM.

KVM device reset works well enough but has consequences on MMU
migration. Probably an ordering problem.


* Github
=20
QEMU:

  https://github.com/legoater/qemu/commits/xive

Linux/KVM (to be sent later on):

  https://github.com/legoater/linux/commits/xive

Thanks,

C.

 Changes since v2 :

 - added support for Store EOI
 - added support for two page ESB MMIO setting like on KVM
 - introduced the XiveFabric interface
 - introduced spapr_xive_mmio_unmap()
 - KVM support

C=C3=A9dric Le Goater (35):
  ppc/xive: introduce a XIVE interrupt source model
  ppc/xive: add support for the LSI interrupt sources
  ppc/xive: introduce the XiveFabric interface
  spapr/xive: introduce a XIVE interrupt controller for sPAPR
  spapr/xive: add a single source block to the sPAPR XIVE model
  spapr/xive: introduce a XIVE interrupt presenter model
  spapr/xive: introduce the XIVE Event Queues
  spapr: push the XIVE EQ data in OS event queue
  spapr: notify the CPU when the XIVE interrupt priority is more
    privileged
  spapr: add support for the SET_OS_PENDING command (XIVE)
  spapr: introduce a 'xive_exploitation' option to enable XIVE
  spapr: add a sPAPRXive object to the machine
  spapr: add hcalls support for the XIVE exploitation interrupt mode
  spapr: add device tree support for the XIVE exploitation mode
  sysbus: add a sysbus_mmio_unmap() helper
  spapr: introduce a helper to map the XIVE memory regions
  spapr: add XIVE support to spapr_qirq()
  spapr: introduce a spapr_icp_create() helper
  spapr: toggle the ICP depending on the selected interrupt mode
  spapr: add support to dump XIVE information
  spapr: advertise XIVE exploitation mode in CAS
  spapr: add classes for the XIVE models
  target/ppc/kvm: add Linux KVM definitions for XIVE
  spapr/xive: add common realize routine for KVM
  spapr/xive: add KVM support
  spapr/xive: add a XIVE KVM device to the machine
  migration: discard non-migratable RAMBlocks
  intc: introduce a CPUIntc interface
  spapr/xive,xics: use the CPU_INTC handlers to reset KVM
  spapr/xive,xics: reset KVM at machine reset
  spapr/xive: raise migration priority of the machine
  ppc/pnv: introduce a pnv_icp_create() helper
  ppc: externalize ppc_get_vcpu_by_pir()
  ppc/pnv: add XIVE support
  ppc/pnv: add a PSI bridge model for POWER9 processor

 default-configs/ppc64-softmmu.mak |    3 +
 exec.c                            |   10 +
 hw/core/sysbus.c                  |   10 +
 hw/intc/Makefile.objs             |    5 +-
 hw/intc/intc.c                    |   26 +
 hw/intc/pnv_xive.c                | 1234 +++++++++++++++++++++++++++++++=
++++++
 hw/intc/pnv_xive_regs.h           |  314 ++++++++++
 hw/intc/spapr_xive.c              |  324 ++++++++++
 hw/intc/spapr_xive_hcall.c        |  923 +++++++++++++++++++++++++++
 hw/intc/spapr_xive_kvm.c          |  655 ++++++++++++++++++++
 hw/intc/xics.c                    |    4 +
 hw/intc/xics_kvm.c                |  108 +++-
 hw/intc/xive.c                    | 1200 +++++++++++++++++++++++++++++++=
+++++
 hw/ppc/pnv.c                      |   93 +--
 hw/ppc/pnv_core.c                 |    2 +-
 hw/ppc/pnv_psi.c                  |  399 +++++++++++-
 hw/ppc/ppc.c                      |   16 +
 hw/ppc/spapr.c                    |  264 +++++++-
 hw/ppc/spapr_cpu_core.c           |   55 +-
 hw/ppc/spapr_hcall.c              |    6 +
 hw/ppc/spapr_rtas.c               |    2 -
 include/exec/cpu-common.h         |    1 +
 include/hw/intc/intc.h            |   21 +
 include/hw/ppc/pnv.h              |   37 +-
 include/hw/ppc/pnv_psi.h          |   50 +-
 include/hw/ppc/pnv_xive.h         |   89 +++
 include/hw/ppc/pnv_xscom.h        |    5 +
 include/hw/ppc/ppc.h              |    1 +
 include/hw/ppc/spapr.h            |   21 +-
 include/hw/ppc/spapr_cpu_core.h   |    2 +
 include/hw/ppc/spapr_xive.h       |   93 +++
 include/hw/ppc/xics.h             |    1 +
 include/hw/ppc/xive.h             |  269 ++++++++
 include/hw/ppc/xive_regs.h        |  187 ++++++
 include/hw/sysbus.h               |    1 +
 include/migration/vmstate.h       |    2 +
 linux-headers/asm-powerpc/kvm.h   |   18 +
 linux-headers/linux/kvm.h         |    5 +
 migration/ram.c                   |   42 +-
 target/ppc/kvm.c                  |    7 +
 target/ppc/kvm_ppc.h              |    6 +
 41 files changed, 6414 insertions(+), 97 deletions(-)
 create mode 100644 hw/intc/pnv_xive.c
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/spapr_xive_hcall.c
 create mode 100644 hw/intc/spapr_xive_kvm.c
 create mode 100644 hw/intc/xive.c
 create mode 100644 include/hw/ppc/pnv_xive.h
 create mode 100644 include/hw/ppc/spapr_xive.h
 create mode 100644 include/hw/ppc/xive.h
 create mode 100644 include/hw/ppc/xive_regs.h

--=20
2.13.6
