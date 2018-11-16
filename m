Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbp4-0006Lq-28
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbp0-0007Gj-Sa
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:02 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:48392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbp0-00076g-IA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:57:58 -0500
Received: from player734.ha.ovh.net (unknown [10.109.159.20])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 07AEE107D7E
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:57:40 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:56:53 +0100
Message-Id: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/36] ppc: support for the XIVE interrupt
 controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is the version 5 of the QEMU models adding support for the XIVE
interrupt controller to the sPAPR machine, under TCG and KVM, and to
the PowerNV POWER9 machine.

The most important changes for sPAPR are the introduction of a new
'dual' pseries machine supporting both interrupt mode: XICS and XIVE,
under TCG and KVM, and fixes for the virtual LSIs.

The QEMU PowerNV POWER9 machine now has support for PHB4 bringing it
to the level of a "real" machine. It validates the model of the
barematel XIVE IC controller proposed in this patchset. The other
PowerNV models will be part of another patchset.

Thanks,

C.


Changes in v5 :

 Common XIVE models :

 - renamed the XIVE structures to fit the changes of the XIVE
   architecture documents: IVE, EQD, VPD -> EAS, END, NVT  =20
 - reworked the monitor ouput to print the EQ contents

 sPAPR models :

 - introduced a XIVE Router 'reset' method for the Xive Thread Context
   to set the OS CAM line of the VCPU
 - introduced a spapr_irq_init() routine to the sPAPR IRQ backend
   and reworked the XIVE-only machine to fit mainline QEMU
 - introduced a reset() method to the sPAPR IRQ backend to handle
   changes in the interrupt mode after machine reset
 - introduced a 'dual' machine supporting both interrupt mode

 KVM :

 - introduced some more sPAPR NVT and END indexing helpers for KVM suppor=
t
 - fixed the virtual LSIs in KVM by using the H_INT_ESB source flag
 - improved the KVM support with better common classes and cleaner
   QEMU<->KVM interfaces
 - improved KVM migration with a better control on the capture sequence.
   Still some issues with 'ceded' VCPUs=20
 - introduced KVM support for the 'dual' machine

 PowerNV:

 - introduced address spaces for the IPI and END set translation
   tables


Changes in v4 :

   See https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01672.htm=
l


=3D XIVE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


The POWER9 processor comes with a new interrupt controller, called
XIVE as "eXternal Interrupt Virtualization Engine".


* Overall architecture


              XIVE Interrupt Controller
              +-------------------------------------+       IPIs
              | +---------+ +---------+ +---------+ |    +--------+
              | |VC       | |CQ       | |PC       |----> | CORES  |
              | |     esb | |         | |         |----> |        |
              | |     eas | |  Bridge | |         |----> |        |
              | |SC   end | |         | |     nvt | |    |        |
+------+      | +---------+ +----+----+ +---------+ |    +--+-+-+-+
| RAM  |      +------------------|------------------+       | | |
|      |                         |                          | | |
|      |                         |                          | | |
|      |   +---------------------v--------------------------v-v-v---+    =
  other
|      <---+                       Power Bus                        +----=
> chips
|  esb |   +-----------+-----------------------+--------------------+
|  eas |               |                       |
|  end |               |                       |
|  nvt |           +---+----+              +---+----+
+------+           |SC      |              |SC      |
                   |        |              |        |
                   | 2-bits |              | 2-bits |
                   | local  |              |   VC   |
                   +--------+              +--------+
                     PCIe                  NX,NPU,CAPI

                  SC: Source Controller (aka. IVSE)
                  VC: Virtualization Controller (aka. IVRE)
                  CQ: Common Queue (Bridge)
                  PC: Presentation Controller (aka. IVPE)

              2-bits: source state machine (PQ bits)
                 esb: Event State Buffer (Array of PQ bits in an IVSE)
                 eas: Event Assignment Structure
                 end: Event Notification Descriptor
                 nvt: Notification Virtual Target

It is composed of three sub-engines :

  - Interrupt Virtualization Source Engine (IVSE), or Source
    Controller (SC). These are found in PCI PHBs, in the PSI host
    bridge controller, but also inside the main controller for the
    core IPIs and other sub-chips (NX, CAP, NPU) of the
    chip/processor. They are configured to feed the IVRE with events.

  - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
    Controller (VC). Its job is to match an event source with an Event
    Notification Descriptor (END).

  - Interrupt Virtualization Presentation Engine (IVPE) or Presentation
    Controller (PC). It maintains the interrupt context state of each
    thread and handles the delivery of the external exception to the
    thread.


* XIVE internal tables

Each of the sub-engines uses a set of tables to redirect exceptions
from event sources to CPU threads.

                                             +-------+
   User or OS                                |  EQ   |
       or                            +------>|entries|
   Hypervisor                        |       |  ..   |
     Memory                          |       +-------+
                                     |           ^
                                     |           |
               +--------------------------------------------------+
                                     |           |
   Hypervisor        +------+    +---+--+    +---+--+   +------+
     Memory          | ESB  |    | EAT  |    | ENDT |   | NVTT |
    (skiboot)        +----+-+    +----+-+    +----+-+   +------+
                       ^  |        ^  |        ^  |       ^
                       |  |        |  |        |  |       |
               +--------------------------------------------------+
                       |  |        |  |        |  |       |
                       |  |        |  |        |  |       |
                 +-----|--|--------|--|--------|--|-+   +-|-----+    +---=
---+
                 |     |  |        |  |        |  | |   | | tctx|    |Thr=
ead|
    IPI or   ----+     +  v        +  v        +  v |---| +  .. |----->  =
   |
   HW events     |                                  |   |       |    |   =
   |
                 |              IVRE                |   | IVPE  |    +---=
---+
                 +----------------------------------+   +-------+

The IVSE have a 2-bits, P for pending and Q for queued, state machine
for each source that allows events to be triggered. They are stored in
an array, the Event State Buffer (ESB) and controlled by MMIOs.

If the event is let through, the IVRE looks up in the Event Assignment
Structure (EAS) table for an Event Notification Descriptor (END)
configured for the source. Each Event Notification Descriptor defines
a notification path to a CPU and an in-memory Event Queue, in which
will be pushed an EQ data for the OS to pull.

The IVPE determines if a Notification Virtual Target (NVT) can handle
the event by scanning the thread contexts of the VPs dispatched on the
processor HW threads. It maintains the interrupt context state of each
thread in a NVT table.


* Overview of the QEMU models for the XIVE sub-engines

The XiveSource models the IVSE in general, internal and external. It
handles the source ESBs and the MMIO interface to control them.

The XiveFabric is a small helper interface interconnecting the
XiveSource to the XiveRouter.

The XiveRouter is an abstract model acting as a combined IVRE and
IVPE. It routes event notifications using the IVE and EQD tables to
the IVPE sub-engine which does a CAM scan to find a CPU to deliver the
exception. Storage should be provided by the inheriting classes.

XiveEQSource is a special source object. It exposes the EQ ESB MMIOs of
the Event Queues which are used for coalescing event notifications and
for escalation. Not used on the field, only to sync the EQ cache in
OPAL.

Finally, the XiveTCTX contains the interrupt state context of a thread,
four sets of registers, one for each exception that can be delivered
to a CPU. These contexts are scanned by the IVPE to find a matching VP
when a notification is triggered. It also models the Thread Interrupt
Management Area (TIMA), which exposes the thread context registers to
the CPU for interrupt management.


* XIVE for sPAPR

sPAPRXive models the XIVE interrupt controller of a sPAPR machine. It
inherits from the XiveRouter and provisions storage for the IVE and
END tables. The NVT table does not need a backend in sPAPR. It owns a
XiveSource object for the IPIs and the virtual device interrupts, a
memory region for the TIMA and a XiveENDSource to manage the END ESBs.
(not used by Linux).

These choices were made to have a sPAPR interrupt controller
consistent with the one found on baremetal and to facilitate KVM
support, the main difficulty being the host memory regions exposed to
the guest.

The NVT and tbe END indexing needs some care and a set of helpers are
defined to ease the conversion between the CPU id as seen by the guest
and the XIVE identifiers manipulated by the models.=20


* Integration in the sPAPR machine, xive only and dual

A new sPAPR IRQ backend is defined for XIVE. It introduces a couple of
new operations to handle the differences in the creation of the device
tree and in the allocation of the CPU interrupt controller. A new
'xive' only pseries machine is defined using this XIVE backend.

Being able to support both interrupt mode in the same machine requires
some more changes. As the machine chooses the interrupt mode at CAS
time, it is activated after a reconfiguration done in a reset. This is
handled by a new 'dual' sPAPR IRQ backend which is built on top of the
XICS and XIVE backend. A new 'dual' pseries machine is defined using
this backend.


* KVM support

Support for KVM introduces a set of specific XIVE models, very much
like XICS does, which self-connect to their KVM counterparts in the
Linux kernel. Two host memory regions are exposed to the guest and
need special care at initialization :

  - ESB mmios
  - Thread Interrupt Management Area (TIMA)

The models uses KVM accessors to synchronize the QEMU state with
KVM. The states are :

  - the source configuration (EAT)
  - the END configuration (ENDT)
  - the OS EQ state (toggle bit and index)
  - the thread interrupt context registers.

Hybrid guest using KVM and an emulated irqchip (kernel_irqchip=3Doff) is
supported.

Migration under KVM is supported but still has some issues with the
pages of the OS event notification queues when the VCPUs are
'ceded'. They are mapped to the ZERO_PAGE on the receiving side. Work
in progress.

KVM support for the 'dual' machine required some more changes. Both
interrupt mode need to be initialized at the QEMU level to keep the
IRQ number space in sync and to allow switching from one mode to
another. At the KVM level, the whole initialization of the KVM device,
sources and presenters, needs to be done in the reset handler when the
interrupt mode is chosen. This is a major change in the KVM models.

KVM being initialized at reset, we loose the possiblity to fallback to
the QEMU emulated mode in case of failure and failures become fatal to
the machine.


* PowerNV models

The PnvXIVE model uses the XiveRouter abstract model just like
sPAPRXive. It provides accessors to the EAS, END and NVT tables which
are stored in the QEMU PowerNV machine and not in QEMU anymore. It
owns a set of memory regions for the IC registers, the ESBs, the END
ESBs, the TIMA, the notification MMIO.

Multichip is supported and the available IVSEs are the internal one
for the IPIS, the PSI host bridge controller and PHB4.

The next interesting step would be to add escalation events and model
the VCPU dispatching to support emulated KVM guests.


* GitHub trees
=20
QEMU sPAPR:

  https://github.com/legoater/qemu/commits/xive-3.1
 =20
QEMU PowerNV:

  https://github.com/legoater/qemu/commits/powernv-3.1

Linux/KVM:

  https://github.com/legoater/linux/commits/xive-4.20

OPAL:

  https://github.com/legoater/skiboot/commits/xive



C=C3=A9dric Le Goater (36):
  ppc/xive: introduce a XIVE interrupt source model
  ppc/xive: add support for the LSI interrupt sources
  ppc/xive: introduce the XiveFabric interface
  ppc/xive: introduce the XiveRouter model
  ppc/xive: introduce the XIVE Event Notification Descriptors
  ppc/xive: add support for the END Event State buffers
  ppc/xive: introduce the XIVE interrupt thread context
  ppc/xive: introduce a simplified XIVE presenter
  ppc/xive: notify the CPU when the interrupt priority is more
    privileged
  spapr/xive: introduce a XIVE interrupt controller
  spapr/xive: use the VCPU id as a NVT identifier
  spapr: initialize VSMT before initializing the IRQ backend
  spapr: introduce a spapr_irq_init() routine
  spapr: modify the irq backend 'init' method
  spapr: introdude a new machine IRQ backend for XIVE
  spapr: add hcalls support for the XIVE exploitation interrupt mode
  spapr: add device tree support for the XIVE exploitation mode
  spapr: allocate the interrupt thread context under the CPU core
  spapr: add a 'pseries-3.1-xive' machine type
  spapr: add classes for the XIVE models
  spapr: extend the sPAPR IRQ backend for XICS migration
  spapr/xive: add models for KVM support
  spapr/xive: add migration support for KVM
  spapr: add a 'reset' method to the sPAPR IRQ backend
  spapr: set the interrupt presenter at reset
  spapr: add a 'pseries-3.1-dual' machine type
  sysbus: add a sysbus_mmio_unmap() helper
  ppc/xics: introduce a icp_kvm_init() routine
  ppc/xics: remove abort() in icp_kvm_init()
  spapr: check for KVM IRQ device activation
  spapr/xive: export the spapr_xive_kvm_init() routine
  spapr/rtas: modify spapr_rtas_register() to remove RTAS handlers
  spapr: introduce routines to delete the KVM IRQ device
  spapr: add KVM support to the 'dual' machine
  ppc: externalize ppc_get_vcpu_by_pir()
  ppc/pnv: add XIVE support

 default-configs/ppc64-softmmu.mak |    3 +
 hw/intc/pnv_xive_regs.h           |  314 +++++
 include/hw/ppc/pnv.h              |   22 +-
 include/hw/ppc/pnv_xive.h         |  100 ++
 include/hw/ppc/pnv_xscom.h        |    3 +
 include/hw/ppc/ppc.h              |    1 +
 include/hw/ppc/spapr.h            |   18 +-
 include/hw/ppc/spapr_cpu_core.h   |    2 +
 include/hw/ppc/spapr_irq.h        |   16 +-
 include/hw/ppc/spapr_xive.h       |  113 ++
 include/hw/ppc/xics.h             |    1 +
 include/hw/ppc/xive.h             |  332 ++++++
 include/hw/ppc/xive_regs.h        |  183 +++
 include/hw/sysbus.h               |    1 +
 include/migration/vmstate.h       |    1 +
 linux-headers/asm-powerpc/kvm.h   |   45 +
 linux-headers/linux/kvm.h         |    6 +
 target/ppc/kvm_ppc.h              |    6 +
 hw/core/sysbus.c                  |   10 +
 hw/intc/pnv_xive.c                | 1612 +++++++++++++++++++++++++
 hw/intc/spapr_xive.c              |  523 +++++++++
 hw/intc/spapr_xive_hcall.c        |  954 +++++++++++++++
 hw/intc/spapr_xive_kvm.c          |  983 ++++++++++++++++
 hw/intc/xics_kvm.c                |  113 +-
 hw/intc/xive.c                    | 1811 +++++++++++++++++++++++++++++
 hw/ppc/pnv.c                      |   74 +-
 hw/ppc/ppc.c                      |   16 +
 hw/ppc/spapr.c                    |   84 +-
 hw/ppc/spapr_cpu_core.c           |   31 +-
 hw/ppc/spapr_hcall.c              |   16 +
 hw/ppc/spapr_irq.c                |  455 +++++++-
 hw/ppc/spapr_rtas.c               |    2 +-
 target/ppc/kvm.c                  |    7 +
 hw/intc/Makefile.objs             |    5 +-
 34 files changed, 7780 insertions(+), 83 deletions(-)
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h
 create mode 100644 include/hw/ppc/spapr_xive.h
 create mode 100644 include/hw/ppc/xive.h
 create mode 100644 include/hw/ppc/xive_regs.h
 create mode 100644 hw/intc/pnv_xive.c
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/spapr_xive_hcall.c
 create mode 100644 hw/intc/spapr_xive_kvm.c
 create mode 100644 hw/intc/xive.c

--=20
2.17.2
