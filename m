Received: from eggs.gnu.org ([209.51.188.92]:36871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBFa-0001qM-C9
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBFZ-00079x-CH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55296
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBFW-00076y-OD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHEU4v078215
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:14:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2w939wt6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:14:37 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:14:34 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:14:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 00/19] spapr: Add support for PHB hotplug
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
- using experimental in-kernel XIVE from Cedric
- hotplug/unplug with e1000 device to validate LSIs
- hotplug/unplug with virtio-net device to validate MSIs
- some simple migration scenarios

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

Please comment.

--
Greg

---

Greg Kurz (11):
      spapr: Rename xics to intc in interrupt controller agnostic code
      xics: Disintricate allocation and type setting of interrupts
      spapr/xive: Don't set irq type in spapr_xive_irq_claim()
      spapr: Set irq type in a dedicated function
      spapr: Identify LSIs of all possible PHBs at machine init
      spapr_pci: add PHB unrealize
      spapr: Factor out setting of "phandle" DT property to sPAPR irq frontend
      spapr_xive: Cache device tree nodename in sPAPRXive
      spapr: Expose the name of the interrupt controller node
      spapr_irq: Expose the phandle of the interrupt controller
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

Thomas Huth (1):
      ppc: Move spapr-related prototypes from xics.h into a seperate header file


 hw/acpi/pcihp.c               |    2 -
 hw/acpi/piix4.c               |    2 -
 hw/char/virtio-serial-bus.c   |    2 -
 hw/core/bus.c                 |   11 +--
 hw/core/machine.c             |    4 +
 hw/intc/spapr_xive.c          |   35 ++++-----
 hw/intc/xics.c                |   28 ++++++-
 hw/intc/xics_kvm.c            |    1 
 hw/intc/xics_spapr.c          |   10 +--
 hw/pci/pcie.c                 |    2 -
 hw/pci/shpc.c                 |    2 -
 hw/ppc/pnv_psi.c              |    1 
 hw/ppc/spapr.c                |  163 +++++++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr_drc.c            |   18 +++++
 hw/ppc/spapr_events.c         |    9 ++
 hw/ppc/spapr_irq.c            |  129 +++++++++++++++++++++++++++-----
 hw/ppc/spapr_pci.c            |  124 ++++++++++++++++++++++++-------
 hw/ppc/spapr_vio.c            |    4 +
 hw/s390x/css-bridge.c         |    2 -
 hw/s390x/s390-pci-bus.c       |    6 +-
 hw/scsi/virtio-scsi.c         |    2 -
 hw/scsi/vmw_pvscsi.c          |    2 -
 hw/usb/dev-smartcard-reader.c |    2 -
 include/hw/pci-host/spapr.h   |   11 ++-
 include/hw/ppc/spapr.h        |    4 +
 include/hw/ppc/spapr_drc.h    |    8 ++
 include/hw/ppc/spapr_irq.h    |   16 +++-
 include/hw/ppc/spapr_xive.h   |   13 +++
 include/hw/ppc/xics.h         |   15 ++--
 include/hw/ppc/xics_spapr.h   |   43 +++++++++++
 include/hw/qdev-core.h        |    3 -
 31 files changed, 545 insertions(+), 129 deletions(-)
 create mode 100644 include/hw/ppc/xics_spapr.h
