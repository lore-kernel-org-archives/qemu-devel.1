Received: from eggs.gnu.org ([209.51.188.92]:38180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcj6-0000XC-P4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcj4-0002z8-II
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtcj1-0002ta-4G
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CIJR7w090012
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm2u19g6m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:04 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 12 Feb 2019 18:24:01 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Feb 2019 19:23:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v4 00/15] spapr: Add support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

This allows to hotplug/unplug PHBs. I could successfully test:
- using in-kernel XICS, emulated XICS and XIVE
- hotplug/unplug with e1000 device to validate LSIs
- hotplug/unplug with virtio-net device to validate MSIs
- some simple migration scenarios

Please comment.

Changes in v4:

- added a LSI bitmap to XICS
- no longer need compat property in XICS
- simplified the patches to access the name and the phandle of the
  interrupt controller
- delay the creation of the PHB drc->fdt to RTAS ibm,configure-connector

Change in v3:
- reworked phandle related code some more
- disintricate allocation/"type setting" of interrupts
- identify LSIs at machine init

Changes in v2:
- rebased on current ppc-for-4.0
- added some preliminary cleanup
- call unrealize from realize error path
- advertise PHB hotplug in last patch
- reworked phandle related code
- sync LSIs to KVM

--
Greg

---

Greg Kurz (8):
      spapr_irq: Add an @xics_offset field to sPAPRIrq
      xive: Only set source type for LSIs
      spapr_irq: Set LSIs at interrupt controller init
      spapr: Expose the name of the interrupt controller node
      spapr_irq: Expose the phandle of the interrupt controller
      spapr_pci: add PHB unrealize
      spapr_drc: Allow FDT fragment to be added later
      spapr: add hotplug hooks for PHB hotplug

Michael Roth (6):
      spapr: create DR connectors for PHBs
      spapr_events: add support for phb hotplug events
      qdev: pass an Object * to qbus_set_hotplug_handler()
      spapr_pci: provide node start offset via spapr_populate_pci_dt()
      spapr_pci: add ibm, my-drc-index property for PHB hotplug
      spapr: enable PHB hotplug for default pseries machine type

Nathan Fontenot (1):
      spapr: populate PHB DRC entries for root DT node


 hw/acpi/pcihp.c               |    2 -
 hw/acpi/piix4.c               |    2 -
 hw/char/virtio-serial-bus.c   |    2 -
 hw/core/bus.c                 |   11 +--
 hw/intc/spapr_xive.c          |   17 +----
 hw/intc/xics.c                |   18 ++---
 hw/intc/xics_kvm.c            |    2 -
 hw/intc/xics_spapr.c          |    2 -
 hw/pci/pcie.c                 |    2 -
 hw/pci/shpc.c                 |    2 -
 hw/ppc/pnv_psi.c              |    3 +
 hw/ppc/spapr.c                |  146 ++++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_drc.c            |   53 +++++++++++++--
 hw/ppc/spapr_events.c         |    7 +-
 hw/ppc/spapr_irq.c            |  122 ++++++++++++++++++++++++++++------
 hw/ppc/spapr_pci.c            |  113 +++++++++++++++++++++++++-------
 hw/ppc/spapr_vio.c            |    2 -
 hw/s390x/css-bridge.c         |    2 -
 hw/s390x/s390-pci-bus.c       |    6 +-
 hw/scsi/virtio-scsi.c         |    2 -
 hw/scsi/vmw_pvscsi.c          |    2 -
 hw/usb/dev-smartcard-reader.c |    2 -
 include/hw/pci-host/spapr.h   |    7 ++
 include/hw/ppc/spapr.h        |    6 +-
 include/hw/ppc/spapr_drc.h    |   14 ++++
 include/hw/ppc/spapr_irq.h    |    9 ++-
 include/hw/ppc/spapr_xive.h   |    5 +
 include/hw/ppc/xics.h         |    4 +
 include/hw/ppc/xics_spapr.h   |    2 +
 include/hw/ppc/xive.h         |    7 +-
 include/hw/qdev-core.h        |    3 -
 31 files changed, 461 insertions(+), 116 deletions(-)
