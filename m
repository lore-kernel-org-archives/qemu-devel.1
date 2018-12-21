Received: from eggs.gnu.org ([2001:4830:134:3::10]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8mH-0004O3-2W
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8mD-0003Qp-Se
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:34:57 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:33196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8mD-0003El-M7
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:34:53 -0500
Received: from player796.ha.ovh.net (unknown [10.109.146.168])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A1B66177010
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:34:43 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:34:25 +0100
Message-ID: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 00/15] spapr: Add support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

Previous work on PHB hotplug was last posted more than one year ago:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07906.html

Quite a few significant changes happened since then:
- fixed PHB indexes
- fixed IRQ numbers for LSIs
- SLOF capable of updating the FDT in QEMU
- XIVE

First step in this new series is to teach QEMU how to get the FDT from
SLOF thanks to the recent patch from Alexey, rebased against David's
ppc-for-4.0 branch (SHA1: 11ce774130e7).

Most of the other patches come from the previous version with minor
modifications, but I guess even the ones with Reviewed-by tags deserve
to be reviewed again in case I've missed something.

Finally, the XIVE and XICS backends are changed to expose the name of
the interrupt controller node in the device tree. The machine code can
then exploit this to reach out to its phandle property, in case it got
changed by SLOF. This is needed to wire up interrupts during hotplug.

This was only lightly tested at the moment. I'll post about that later.

Please comment.

Cheers,

--
Greg

---

Alexey Kardashevskiy (1):
      ppc/spapr: Receive and store device tree blob from SLOF

Greg Kurz (4):
      spapr: move spapr_create_phb() to core machine code
      spapr_pci: add proper rollback on PHB realize error path
      spapr_pci: Define SPAPR_MAX_PHBS in hw/pci-host/spapr.h
      spapr: Expose the name of the interrupt controller node

Michael Roth (9):
      pci: allow cleanup/unregistration of PCI buses
      spapr_pci: add PHB unrealize
      spapr: enable PHB hotplug for default pseries machine type
      spapr: create DR connectors for PHBs
      spapr_events: add support for phb hotplug events
      qdev: pass an Object * to qbus_set_hotplug_handler()
      spapr_pci: provide node start offset via spapr_populate_pci_dt()
      spapr_pci: add ibm, my-drc-index property for PHB hotplug
      spapr: add hotplug hooks for PHB hotplug

Nathan Fontenot (1):
      spapr: populate PHB DRC entries for root DT node


 configure                     |    2 
 hw/acpi/piix4.c               |    2 
 hw/char/virtio-serial-bus.c   |    2 
 hw/core/bus.c                 |   11 --
 hw/intc/spapr_xive.c          |    9 +-
 hw/intc/xics_spapr.c          |    9 +-
 hw/pci/pci.c                  |   33 ++++++
 hw/pci/pcie.c                 |    2 
 hw/pci/shpc.c                 |    2 
 hw/ppc/spapr.c                |  230 ++++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_drc.c            |   18 +++
 hw/ppc/spapr_events.c         |    3 +
 hw/ppc/spapr_hcall.c          |   42 +++++++
 hw/ppc/spapr_irq.c            |    3 +
 hw/ppc/spapr_pci.c            |  139 +++++++++++++++++++------
 hw/ppc/trace-events           |    3 +
 hw/s390x/css-bridge.c         |    2 
 hw/s390x/s390-pci-bus.c       |    6 +
 hw/scsi/virtio-scsi.c         |    2 
 hw/scsi/vmw_pvscsi.c          |    2 
 hw/usb/dev-smartcard-reader.c |    2 
 include/hw/pci-host/spapr.h   |   14 ++
 include/hw/pci/pci.h          |    3 +
 include/hw/ppc/spapr.h        |    9 +-
 include/hw/ppc/spapr_drc.h    |    8 +
 include/hw/ppc/spapr_irq.h    |    1 
 include/hw/ppc/spapr_xive.h   |    1 
 include/hw/ppc/xics.h         |    1 
 include/hw/qdev-core.h        |    3 -
 29 files changed, 491 insertions(+), 73 deletions(-)
