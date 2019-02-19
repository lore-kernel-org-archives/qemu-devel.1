Received: from eggs.gnu.org ([209.51.188.92]:33442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw925-0002II-Ui
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw922-0007Ib-5b
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw91y-0006pM-9C
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEGHV115975
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrmfgddsy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:42 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:17:39 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:17:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 00/17] spapr: Add support for PHB hotplug
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

Based on David's ppc-for-4.0 branch SHA1:

6f585625d0d1 target/ppc: Basic POWER9 bare-metal radix MMU support

Please comment.

Changes in v5:
- all DRC subtypes generate FDT fragment at configure connector time
- Drop all the LSI bitmap and allocation/typing disintricate stuff
- set IRQ type in KVM at claim time
- fix hotplug call chain
- added PHB unplug test to tests/device-plug-test

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

Greg Kurz (11):
      spapr_drc: Allow FDT fragment to be added later
      spapr: Generate FDT fragment for LMBs at configure connector time
      spapr: Generate FDT fragment for CPUs at configure connector time
      spapr/pci: Generate FDT fragment at configure connector time
      spapr/drc: Drop spapr_drc_attach() fdt argument
      xics: Write source state to KVM at claim time
      spapr: Expose the name of the interrupt controller node
      spapr_irq: Expose the phandle of the interrupt controller
      spapr_pci: add PHB unrealize
      spapr: add hotplug hooks for PHB hotplug
      tests/device-plug: Add PHB unplug request test for spapr

Michael Roth (5):
      spapr: create DR connectors for PHBs
      spapr_events: add support for phb hotplug events
      spapr_pci: provide node start offset via spapr_populate_pci_dt()
      spapr_pci: add ibm, my-drc-index property for PHB hotplug
      spapr: enable PHB hotplug for default pseries machine type

Nathan Fontenot (1):
      spapr: populate PHB DRC entries for root DT node


 hw/intc/spapr_xive.c        |    9 +-
 hw/intc/xics.c              |    4 +
 hw/intc/xics_kvm.c          |   74 ++++++++-----
 hw/intc/xics_spapr.c        |    2 
 hw/ppc/spapr.c              |  238 +++++++++++++++++++++++++++++++++++--------
 hw/ppc/spapr_drc.c          |   51 ++++++++-
 hw/ppc/spapr_events.c       |    3 +
 hw/ppc/spapr_irq.c          |   42 +++++++-
 hw/ppc/spapr_pci.c          |  135 ++++++++++++++++++++----
 include/hw/pci-host/spapr.h |   11 ++
 include/hw/ppc/spapr.h      |   10 ++
 include/hw/ppc/spapr_drc.h  |   17 +++
 include/hw/ppc/spapr_irq.h  |    2 
 include/hw/ppc/spapr_xive.h |    3 +
 include/hw/ppc/xics.h       |    1 
 include/hw/ppc/xics_spapr.h |    2 
 tests/device-plug-test.c    |   16 +++
 17 files changed, 497 insertions(+), 123 deletions(-)
