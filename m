Received: from eggs.gnu.org ([2001:4830:134:3::10]:36595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgt-0007Lr-Vs
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgq-0008Bo-1c
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:47 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:46526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqgm-0007vQ-91
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:42 -0500
Received: from player688.ha.ovh.net (unknown [10.109.160.244])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C55CC19DBA2
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:39:26 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:11 +0100
Message-Id: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 00/12] ppc: support for the XIVE interrupt
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

Here is the version 8 of the QEMU models adding support for the XIVE
interrupt controller to the sPAPR machine, under TCG only. KVM support
will be proposed in an other patchset, along with the KVM XIVE device
patchset, so will PowerNV.

The most important changes for sPAPR are the introduction of a 'ic-mode'
machine option to select the interrupt mode of the machine and the fix
for CPU hotplug.

Thanks,

C.

Changes in v8 (sPAPR only) :

 - reworked spapr_irq_init_xive() to use qdev_create()
 - changed the EQ sizes list property to contain 64K only
 - fixed OS CAM line of hotplugged CPUs (TCG)
 - introduced a check on CPU type when activating XIVE.
 - introduced an 'ic-mode' machine option
 - renamed spapr_xive_enable_mmio() to spapr_xive_mmio_set_enabled()
 - changed default CPU type to POWER9
=20
Changes in v7 :

 https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01760.html

Changes in v6 :

 https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00965.html

Changes in v5 :

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03218.html

Changes in v4 :

 https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01672.html


=3D XIVE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


The POWER9 processor comes with a new interrupt controller, called
XIVE as "eXternal Interrupt Virtualization Engine".


* Overall architecture


             XIVE Interrupt Controller
             +------------------------------------+      IPIs
             | +---------+ +---------+ +--------+ |    +-------+
             | |VC       | |CQ       | |PC      |----> | CORES |
             | |     esb | |         | |        |----> |       |
             | |     eas | |  Bridge | |   tctx |----> |       |
             | |SC   end | |         | |    nvt | |    |       |
 +------+    | +---------+ +----+----+ +--------+ |    +-+-+-+-+
 | RAM  |    +------------------|-----------------+      | | |
 |      |                       |                        | | |
 |      |                       |                        | | |
 |      |  +--------------------v------------------------v-v-v--+    othe=
r
 |      <--+                     Power Bus                      +--> chip=
s
 |  esb |  +---------+-----------------------+------------------+
 |  eas |            |                       |
 |  end |         +--|------+                |
 |  nvt |       +----+----+ |           +----+----+
 +------+       |SC       | |           |SC       |
                |         | |           |         |
                | PQ-bits | |           | PQ-bits |
                | local   |-+           |  in VC  |
                +---------+             +---------+
                   PCIe                 NX,NPU,CAPI

                  SC: Source Controller (aka. IVSE)
                  VC: Virtualization Controller (aka. IVRE)
                  PC: Presentation Controller (aka. IVPE)
                  CQ: Common Queue (Bridge)

             PQ-bits: 2 bits source state machine (P:pending Q:queued)
                 esb: Event State Buffer (Array of PQ bits in an IVSE)
                 eas: Event Assignment Structure
                 end: Event Notification Descriptor
                 nvt: Notification Virtual Target
                tctx: Thread interrupt Context


The XIVE IC is composed of three sub-engines :

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
  User or OS                              |  EQ   |
      or                          +------>|entries|
  Hypervisor                      |       |  ..   |
    Memory                        |       +-------+
                                  |           ^
                                  |           |
             +-------------------------------------------------+
                                  |           |
  Hypervisor      +------+    +---+--+    +---+--+   +------+
    Memory        | ESB  |    | EAT  |    | ENDT |   | NVTT |
   (skiboot)      +----+-+    +----+-+    +----+-+   +------+
                    ^  |        ^  |        ^  |       ^
                    |  |        |  |        |  |       |
             +-------------------------------------------------+
                    |  |        |  |        |  |       |
                    |  |        |  |        |  |       |
               +----|--|--------|--|--------|--|-+   +-|-----+    +------=
+
               |    |  |        |  |        |  | |   | | tctx|    |Thread=
|
   IPI or   ---+    +  v        +  v        +  v |---| +  .. |----->     =
|
  HW events    |                                 |   |       |    |      =
|
               |             IVRE                |   | IVPE  |    +------=
+
               +---------------------------------+   +-------+
           =20


The IVSE have a 2-bits state machine, P for pending and Q for queued,
for each source that allows events to be triggered. They are stored in
an Event State Buffer (ESB) array and can be controlled by MMIOs.

If the event is let through, the IVRE looks up in the Event Assignment
Structure (EAS) table for an Event Notification Descriptor (END)
configured for the source. Each Event Notification Descriptor defines
a notification path to a CPU and an in-memory Event Queue, in which
will be enqueued an EQ data for the OS to pull.

The IVPE determines if a Notification Virtual Target (NVT) can handle
the event by scanning the thread contexts of the VCPUs dispatched on
the processor HW threads. It maintains the interrupt context state of
each thread in a NVT table.


* Overview of the QEMU models for the XIVE sub-engines

The XiveSource models the IVSE in general, internal and external. It
handles the source ESBs and the MMIO interface to control them.

The XiveNotifier is a small helper interface interconnecting the
XiveSource to the XiveRouter.

The XiveRouter is an abstract model acting as a combined IVRE and
IVPE. It routes event notifications using the IVE and EQD tables to
the IVPE sub-engine which does a CAM scan to find a CPU to deliver the
exception. Storage should be provided by the inheriting classes.

XiveENDSource is a special source object. It exposes the EQ ESB MMIOs of
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
supported. Migration under KVM is supported.

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

  https://github.com/legoater/qemu/commits/xive-v8-4.0
 =20
QEMU PowerNV:

  https://github.com/legoater/qemu/commits/powernv-3.1

Linux/KVM:

  https://github.com/legoater/linux/commits/xive-4.20

OPAL:

  https://github.com/legoater/skiboot/commits/xive

C=C3=A9dric Le Goater (12):
  spapr: introduce a new machine IRQ backend for XIVE
  spapr: add hcalls support for the XIVE exploitation interrupt mode
  spapr: add device tree support for the XIVE exploitation mode
  spapr: allocate the interrupt thread context under the CPU core
  spapr: extend the sPAPR IRQ backend for XICS migration
  spapr: add a 'reset' method to the sPAPR IRQ backend
  spapr: add an extra OV5 field to the sPAPR IRQ backend
  spapr: introduce an 'ic-mode' machine option
  spapr: set the interrupt presenter at reset
  spapr: enable XIVE MMIOs at reset
  spapr: introduce a new sPAPR IRQ backend supporting XIVE and XICS
  spapr: change default CPU type to POWER9

 include/hw/ppc/spapr.h          |   24 +-
 include/hw/ppc/spapr_cpu_core.h |    2 +
 include/hw/ppc/spapr_irq.h      |   12 +
 include/hw/ppc/spapr_xive.h     |    8 +
 include/hw/ppc/xics.h           |    4 +-
 include/hw/ppc/xive.h           |    1 +
 hw/intc/spapr_xive.c            | 1053 +++++++++++++++++++++++++++++++
 hw/intc/xics_spapr.c            |    3 +-
 hw/intc/xive.c                  |   22 +
 hw/ppc/spapr.c                  |  105 ++-
 hw/ppc/spapr_cpu_core.c         |   30 +-
 hw/ppc/spapr_hcall.c            |   11 +
 hw/ppc/spapr_irq.c              |  349 +++++++++-
 13 files changed, 1584 insertions(+), 40 deletions(-)

--=20
2.17.2
