Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBA-0001Qf-K9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxB5-00038W-Ha
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:24 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:52079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxB3-00035t-W6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:18 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.2])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2277DA9521
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:50:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:35 +0200
Message-Id: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/28] ppc: support for the XIVE interrupt
 controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is the version 4 of the QEMU models adding support for XIVE to
the sPAPR machine, under TCG and KVM, and to the PowerNV machine. The
common framework is stabilizing and the routing is significantly
improved. The next interesting step would be to add escalation events
and model VP dispatching.

Thanks,

C.


Changes in v4 :

Common XIVE models :

 - minor changes in the XiveSource model. Remove unnecessary 'offset',
   full IRQ number space is populated.

 - reduced XiveFabric. The interface was embedding the Router which
   was wrong.

 - renamed XiveNVT to XiveTCTX for the Thread interrupt context.=20

 - removed the CPU EQDs from under the Thread interrupt context
   model. That was pratical but slightly ugly.

 - unified the TIMA load/store accessors for sPAPR and PowerNV. It
   supports all the TIMA privilege pages now.

 - introduced a XiveRouter abstract class combining the IVRE and the
   IVPE in one model. Storage for the routing tables should be
   provisioned by the inheriting classes : sPAPRXive, PnvXive

 - extended the routing algorithm. Covers all models and defines a
   clear sequence of each steps.  =20

 - introduced a VP matching algorithm using the CAM lines as in real HW.

 - introduced a new XiveEQSource model to expose the EQ ESBs. Not used
   on the field, only to sync the EQ cache in OPAL.

On the sPAPR side :

 - moved the EQDT under sPAPRXive, requires EQ indexing.
=20
 - new sPAPR IRQ backend for XIVE=20

 - new pseries-2.13-xive machine supporting only XIVE.=20

 - removed the capacity to switch the interrupt mode after CAS.  Will
   come in time when the models have stabilized.  This is not a large
   rework, the main problem being KVM reset.

 - improved migration algo. Still misses OPAL calls to sync XIVE.

On the PowerNV side :

 - A massive rework of PnvXive to adapt to the changes

 - unified VST accessors

 - multichip support


=3D XIVE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


The POWER9 processor comes with a new interrupt controller, called
XIVE as "eXternal Interrupt Virtualization Engine".

* Overall architecture
   =20

              XIVE Interrupt Controller
              +-------------------------------------+       IPIs
              | +---------+ +---------+ +---------+ |    +--------+
              | |VC       | |CQ       | |PC       |----> | CORES  |
              | |     esb | |         | |         |----> |        |
              | |     ive | |  Bridge | |         |----> |        |
              | |SC   eqd | |         | |     vpd | |    |        |
+------+      | +---------+ +----+----+ +---------+ |    +--+-+-+-+
| RAM  |      +------------------|------------------+       | | |
|      |                         |                          | | |
|      |                         |                          | | |
|      |   +---------------------v--------------------------v-v-v---+    =
  other
|      <---+                       Power Bus                        +----=
> chips
|  esb |   +-----------+-----------------------+--------------------+
|  ive |               |                       |
|  eqd |               |                       |
|  vpd |           +---+----+              +---+----+
+------+           |SC      |              |SC      |
                   |        |              |        |
                   | 2-bits |              | 2-bits |
                   | local  |              |   VC   |
                   +--------+              +--------+
                     PCIe                  NX,NPU,CAPI


     =20
                  SC: Source Controller (aka. IVSE)
                  VC: Virtualization Controller (aka. IVRE)
                  CQ: Common Queue (Bridge)
                  PC: Presentation Controller (aka. IVPE)
                =20
              2-bits: source state machine=20
                 esb: Event State Buffer (Array of PQ bits in an IVSE)
                 ive: Interrupt Virtualization Entry=20
                 eqd: Event Queue Descriptor
                 vpd: Virtual Processor Descriptor


It is composed of three sub-engines :

  - Interrupt Virtualization Source Engine (IVSE), or Source
    Controller (SC). These are found in PCI PHBs, in the PSI host
    bridge controller, but also inside the main controller for the
    core IPIs and other sub-chips (NX, CAP, NPU) of the
    chip/processor. They are configured to feed the IVRE with events.

  - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
    Controller (VC). Its job is to match an event source with an Event
    Queue (EQ).

  - Interrupt Virtualization Presentation Engine (IVPE) or Presentation
    Controller (PC). It maintains the interrupt context state of each
    thread and handles the delivery of the external exception to the
    thread.


* XIVE internal tables

Each of the sub-engines uses a set of tables to redirect exceptions
from event sources to CPU threads.

   =20
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
     Memory          | ESB  |    | IVT  |    | EQDT |   | VPDT |
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
           =20
       =20


The IVSE have a 2-bits, P for pending and Q for queued, state machine
for each source that allows events to be triggered. They are stored in
an array, the Event State Buffer (ESB) and controlled by MMIOs.

If the event is let through, the IVRE looks up in the Interrupt
Virtualization Entry (IVE) table for an Event Queue Descriptor (EQD)
configured for the source. Each Event Queue Descriptor defines a
notification path to a CPU and an in-memory Event Queue, in which will
be pushed an EQ data for the OS to pull.

The IVPE determines if a Virtual Processor (VP) can handle the event
by scanning the thread contexts of the VPs dispatched on the processor
HW threads. It maintains the interrupt context state of each thread in
a Virtual Processor Descriptor (VPD) table.


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
EQD tables. The VPD table does not need a backend in sPAPR. It owns a
XiveSource object for the IPIs and the virtual device interrupts, a
memory region for the TIMA and a XiveEQSource to manage the EQ ESBs.
(not used by Linux).

These choices were made to have a sPAPR interrupt controller
consistent with the one found on baremetal and to facilitate KVM
support, the main difficulty being the host memory regions exposed to
the guest.

The VP and EQ indexing needs some care and a set of helpers are
defined to ease the conversion between the CPU id as seen by the guest
and the identifiers manipulated by the models.


* Integration in the sPAPR machine

A new sPAPR IRQ backend is defined for XIVE. It introduces a couple of
new operations to handle the differences in the creation of the device
tree and in the allocation of the CPU interrupt controller. A new
XIVE-only machine is defined with the XIVE backend.

Changing interrupt mode as negotiated through CAS, to switch between
the XICS legacy model and XIVE, is obviously not supported. The sPAPR
IRQ backend framework should make the changes easier in the future.


* KVM support

Support for KVM introduces a set of specific XIVE models, very much
like XICS does, which self-connect to their KVM counterparts in the
Linux kernel. Two host memory regions are exposed to the guest and
need special care at initialization :

 - ESB mmios
 - Thread Interrupt Management Area (TIMA)

The models uses KVM accessors to synchronize the QEMU state with KVM.

Hybrid guest using KVM and an emulated irqchip (kernel_irqchip=3Doff) is
supported.

Migration is also supported but some synchronisation points are
possibly needed to turn off/on XIVE and make sure all HW states are
captured correctly. Stress tests will say.


* PowerNV models

The PnvXIVE model now uses the XiveRouter abstract model just like
sPAPRXive does. It provides accessors to the IVE, EQD and VPD tables
which are stored in the QEMU powernv machine and not in QEMU anymore.
It owns a set of memory regions for the IC registers, the ESBs, the EQ
ESBs, the TIMA, the notification MMIO.

Multichip is supported and the available IVSEs are the internal one
for the IPIS and the PSI host bridge controller.


* GitHub trees
=20
QEMU:

  https://github.com/legoater/qemu/commits/xive-3.0

Linux/KVM (to be sent later on):

  https://github.com/legoater/linux/commits/xive-4.17


C=C3=A9dric Le Goater (28):
  sparp_pci: simplify how the PCI LSIs are allocated
  spapr: introduce a generic IRQ frontend to the machine
  spapr: introduce a new IRQ backend using fixed IRQ number ranges
  ppc/xive: introduce a XIVE interrupt source model
  ppc/xive: add support for the LSI interrupt sources
  ppc/xive: introduce the XiveFabric interface
  ppc/xive: introduce the XiveRouter model
  ppc/xive: introduce the XIVE Event Queues
  ppc/xive: add support for the EQ Event State buffers
  ppc/xive: introduce the XIVE interrupt thread context
  ppc/xive: introduce a simplified XIVE presenter
  ppc/xive: notify the CPU when the interrupt priority is more
    privileged
  spapr/xive: introduce a XIVE interrupt controller
  spapr/xive: use the VCPU id as a VP identifier in the OS CAM.
  spapr: initialize VSMT before initializing the IRQ backend
  spapr: introdude a new machine IRQ backend for XIVE
  spapr: add hcalls support for the XIVE exploitation interrupt mode
  spapr: add device tree support for the XIVE exploitation mode
  spapr: allocate the interrupt thread context under the CPU core
  spapr: introduce a 'pseries-3.0-xive' QEMU machine
  spapr: add classes for the XIVE models
  target/ppc/kvm: add Linux KVM definitions for XIVE
  spapr/xive: add common realize routine for KVM
  spapr/xive: add KVM support
  spapr: fix XICS migration
  pnv: add a physical mapping array describing MMIO ranges in each chip
  ppc: externalize ppc_get_vcpu_by_pir()
  ppc/pnv: add XIVE support

 default-configs/ppc64-softmmu.mak |    3 +
 hw/intc/pnv_xive_regs.h           |  314 +++++++
 include/hw/ppc/pnv.h              |   71 +-
 include/hw/ppc/pnv_xive.h         |   92 ++
 include/hw/ppc/pnv_xscom.h        |    3 +
 include/hw/ppc/ppc.h              |    1 +
 include/hw/ppc/spapr.h            |   31 +-
 include/hw/ppc/spapr_irq.h        |   69 ++
 include/hw/ppc/spapr_xive.h       |  102 +++
 include/hw/ppc/xive.h             |  323 +++++++
 include/hw/ppc/xive_regs.h        |  182 ++++
 include/migration/vmstate.h       |    1 +
 linux-headers/asm-powerpc/kvm.h   |   23 +
 linux-headers/linux/kvm.h         |    3 +
 target/ppc/kvm_ppc.h              |    6 +
 hw/intc/pnv_xive.c                | 1485 ++++++++++++++++++++++++++++++
 hw/intc/spapr_xive.c              |  432 +++++++++
 hw/intc/spapr_xive_hcall.c        |  949 +++++++++++++++++++
 hw/intc/spapr_xive_kvm.c          |  809 +++++++++++++++++
 hw/intc/xive.c                    | 1801 +++++++++++++++++++++++++++++++=
++++++
 hw/ppc/pnv.c                      |  111 ++-
 hw/ppc/pnv_core.c                 |   28 +-
 hw/ppc/pnv_psi.c                  |   15 +-
 hw/ppc/pnv_xscom.c                |    8 +-
 hw/ppc/ppc.c                      |   16 +
 hw/ppc/spapr.c                    |  276 ++----
 hw/ppc/spapr_cpu_core.c           |    4 +-
 hw/ppc/spapr_events.c             |    8 +-
 hw/ppc/spapr_irq.c                |  834 +++++++++++++++++
 hw/ppc/spapr_pci.c                |   40 +-
 hw/ppc/spapr_vio.c                |   17 +-
 target/ppc/kvm.c                  |    7 +
 hw/intc/Makefile.objs             |    5 +-
 hw/ppc/Makefile.objs              |    2 +-
 34 files changed, 7768 insertions(+), 303 deletions(-)
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 include/hw/ppc/spapr_xive.h
 create mode 100644 include/hw/ppc/xive.h
 create mode 100644 include/hw/ppc/xive_regs.h
 create mode 100644 hw/intc/pnv_xive.c
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/spapr_xive_hcall.c
 create mode 100644 hw/intc/spapr_xive_kvm.c
 create mode 100644 hw/intc/xive.c
 create mode 100644 hw/ppc/spapr_irq.c

--=20
2.13.6
