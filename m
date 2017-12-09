Received: from eggs.gnu.org ([2001:4830:134:3::10]:45136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNajq-0000gm-Nv
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNajm-0006lu-Qq
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:02 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:40658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNajm-0006kz-Gj
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:43:58 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 70776125C3F
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:43:56 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:19 +0100
Message-Id: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/19] spapr: Guest exploitation of the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with an
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode, the newer POWER9 interrupt model. XIVE
is a complex interrupt controller introducing a large number of new
features, for virtualization in particular.

It is composed of three sub-engines :

  - Interrupt Virtualization Source Engine (IVSE). These are in PHBs,
    in the main controller for the IPIS and in the PSI host
    bridge. They are configured to feed the IVRE with events.

  - Interrupt Virtualization Routing Engine (IVRE). Their job is to
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

The high level ideas of the current design are :

 - introduce a persistent XIVE object under the sPAPR machine for
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

The patchset first introduces new models for XIVE :

 - sPAPRXive holding the internal tables and the MMIO regions used by
   the XIVE controller.
  =20
 - sPAPRXiveNVT object storing the interrupt state of the CPU and
   acting as the XIVE interrupt presenter

then, describes the notification process and the interrupt delivery to
the CPU.

It finishes with the integration of sPAPRXive object under the sPAPR
machine, the introducion of the new XIVE hcalls, the device tree
layout, and the necessary adjustments to support the CAS negotiation.

Migration is addressed, CPU hotplug, and support for older machines
and QEMU versions also. KVM support is not addressed yet and the guest
needs to be run with kernel_irqchip=3Doff on a POWER9 system.

Code is here:

  https://github.com/legoater/qemu/commits/xive
  =20
Thanks,

C.

 Changes since v1 :

 - used g_new0 instead of g_malloc0
 - removed VMSTATE_STRUCT_VARRAY_UINT32_ALLOC=20
 - introduced a device reset handler. the object needs to be parented
   to sysbus when created.
 - renamed spapr_xive_irq_set() to spapr_xive_irq_enable()
 - renamed spapr_xive_irq_unset() to spapr_xive_irq_disable()
 - moved the PPC_BIT macros under target/ppc/cpu.h
 - shrinked file copyright header
 - reworked the event notification logic of the qemu_irq handlers. =20
 - introduced XIVE_ESB_STORE_EOI support
 - removed 'esb_shift' field=20
 - removed a useless check on the validity of the IVE in the memory
   region handlers.
 - removed the overall ESB memory region. We now have only one region
   for the provisioned sources.
 - improved 'info pic' output
 - improved LSI support
 - renamed 'sPAPRXiveICP' to 'sPAPRXiveNVT'
 - renamed 'tima' field to 'regs'=20
 - renamed 'tima_os' fiels to 'ring_os'
 - removed 'tm_shift' field
 - introduced a memory region to model the User TIMA and another one
   for the OS TIMA. One page size for each.
 - removed useless checks in the memory region handlers
 - removed support for 970 ...
 - removed spapr_xive_eq_for_server() which did the EQ indexing.
 - changed spapr_xive_get_eq() to use a server and a priority parameter
 - introduced a couple of macro for the EQ indexing.=20
 - replaced dma_memory_write() by stl_be_dma()
 - set initial TM_PIPR to 0xFF in sPAPRXiveNVT
 - conditioned the creation of the sPAPRXive object to the
   xive_exploitation bool which false on older pseries machine.
 - parented the sPAPRXive object to sysbus.
 - simplified priority_is_valid() routine (to its minimum)
 - used PPC_BIT() macros to define the hcall flags
 - removed useless casts
 - defined the default characteristic of the single XIVE interrupt
   source to be : *XIVE_SRC_TRIGGER | XIVE_SRC_STORE_EOI*
 - removed EQ_W0_UCOND_NOTIFY when the EQ is reseted
 - fixed XIVE_EQ_DEBUG support. Offset for the generation bit was wrong
 - added a unit id to the nodename
 - added properties for the LSIs
 - simplified the array for the "ibm,plat-res-int-priorities"  property
 - renamed spapr_xive_populate() to spapr_dt_xive()
 - moved the mapping of the XIVE memory region and the setting
   of the ICP under the machine reset handler.
 - introduced a spapr_xive_qirq() helper
 - introduced a spapr_xive_nvt_create() helper
 - handled more errors in spapr_post_load() to return EINVAL


C=C3=A9dric Le Goater (19):
  dma-helpers: add a return value to store helpers
  spapr: introduce a skeleton for the XIVE interrupt controller
  spapr: introduce the XIVE interrupt sources
  spapr: add support for the LSI interrupt sources
  spapr: introduce a XIVE interrupt presenter model
  spapr: introduce the XIVE Event Queues
  spapr: push the XIVE EQ data in OS event queue
  spapr: notify the CPU when the XIVE interrupt priority is more
    privileged
  spapr: add support for the SET_OS_PENDING command (XIVE)
  spapr: introduce a 'xive_exploitation' boolean to enable XIVE
  spapr: add a sPAPRXive object to the machine
  spapr: add hcalls support for the XIVE exploitation interrupt mode
  spapr: add device tree support for the XIVE interrupt mode
  spapr: introduce a helper to map the XIVE memory regions
  spapr: add XIVE support to spapr_qirq()
  spapr: introduce a spapr_icp_create() helper
  spapr: toggle the ICP depending on the selected interrupt mode
  spapr: add support to dump XIVE information
  spapr: advertise XIVE exploitation mode in CAS

 default-configs/ppc64-softmmu.mak |    1 +
 hw/intc/Makefile.objs             |    1 +
 hw/intc/spapr_xive.c              | 1013 +++++++++++++++++++++++++++++++=
++++++
 hw/intc/spapr_xive_hcall.c        |  923 +++++++++++++++++++++++++++++++=
++
 hw/intc/xive-internal.h           |  196 +++++++
 hw/ppc/spapr.c                    |  188 ++++++-
 hw/ppc/spapr_cpu_core.c           |   37 +-
 hw/ppc/spapr_hcall.c              |    6 +
 include/hw/ppc/spapr.h            |   20 +-
 include/hw/ppc/spapr_cpu_core.h   |    1 +
 include/hw/ppc/spapr_xive.h       |   72 +++
 include/sysemu/dma.h              |    4 +-
 12 files changed, 2449 insertions(+), 13 deletions(-)
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/spapr_xive_hcall.c
 create mode 100644 hw/intc/xive-internal.h
 create mode 100644 include/hw/ppc/spapr_xive.h

--=20
2.13.6
