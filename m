Received: from eggs.gnu.org ([2001:4830:134:3::10]:51170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGGM-0004Sb-OT
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGGL-0008Ms-TU
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:19:42 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 24 Oct 2018 12:19:23 +0200
Message-Id: <20181024101930.20674-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/7] pci: hotplug handler reworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

This series reworks some pci hotplug handlers (except for s390, that will
require more work but is not required for now).

1. Route all unplug calls via the hotplug handler when called from the
   unplug_request handler. This will be required to get multi-stage
   hotplug handlers running, but also makes sense on its own (just like we
   already did for some CPU/memory hotplug handlers).

2. Introduce some pre_plug handlers where it makes sense already.

3. Call the plug/pre_plug handler also for coldplugged devices. Especially
   pcihp is special as it overwrites hotplug handlers.

This series will not yet factor out pre_plug/plug/unplug from pci device
realize/unrealize functions, this will require more work but this
series is also required first to get it running.

David Hildenbrand (7):
  pcihp: perform check for bus capability in pre_plug handler
  pcihp: overwrite hotplug handler recursively from the start
  pcihp: route unplug via the hotplug handler
  pci/pcie: route unplug via the hotplug handler
  pci/shpc: move hotplug checks to preplug handler
  pci/shpc: route unplug via the hotplug handler
  spapr_pci: route unplug via the hotplug handler

 hw/acpi/pcihp.c                 | 40 +++++++++++++++++++++++-----
 hw/acpi/piix4.c                 | 39 ++++++++++++++-------------
 hw/pci-bridge/pci_bridge_dev.c  | 23 +++++++++++++++-
 hw/pci-bridge/pcie_pci_bridge.c | 23 +++++++++++++++-
 hw/pci/pcie.c                   | 10 ++++++-
 hw/pci/pcie_port.c              |  1 +
 hw/pci/shpc.c                   | 47 ++++++++++++++++++---------------
 hw/ppc/spapr_pci.c              | 33 ++++++++++++++---------
 include/hw/acpi/pcihp.h         |  5 ++++
 include/hw/pci/pcie.h           |  2 ++
 include/hw/pci/shpc.h           |  4 +++
 11 files changed, 165 insertions(+), 62 deletions(-)

-- 
2.17.2
