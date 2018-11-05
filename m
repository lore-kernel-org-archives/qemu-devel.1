Received: from eggs.gnu.org ([2001:4830:134:3::10]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJc4V-0007Wj-I2
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJc0Q-0008EQ-Ju
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:21:20 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  5 Nov 2018 11:20:34 +0100
Message-Id: <20181105102044.20547-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] pci: hotplug handler reworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>

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

>From my POV what needs to be done in the future:
1. Introduce pre_plug/plug/unplug_request/unplug handlers for all PCI
   buses
2. Move pci realize/unrealize parts to pre_plug/pkug/unplug functions like
   pci_pre_plug() ...
3. Call the pci pre_plug/plug/unplug handlers from the PCI bus hotplug
   handler at the right spots
4. Factor more checks from existing plug() handlers out into pre_plug()
   (e.g. after the call to pci_pre_plug())

v1 -> v2:
- Added "pci/pcie: rename hotplug handler callbacks"
- Added "pci/shpc: rename hotplug handler callbacks"
- Added "s390x/pci: rename hotplug handler callbacks"
- Dropped "pci/shpc: move hotplug checks to preplug handler"
-- We will have to factor out stuff into pre_plug() first as described
   above
- Renamed and added more details to the "perform unplug via the hotplug
  handler" patches
- "pci/pcihp: overwrite hotplug handler recursively from the start"
-- Perform the overwrite only for cold plugged bridges, to keep the
   existing behavior

David Hildenbrand (10):
  pci/pcie: rename hotplug handler callbacks
  pci/shpc: rename hotplug handler callbacks
  s390x/pci: rename hotplug handler callbacks
  pci/pcie: stop plug/unplug if the slot is locked
  pci/pcihp: perform check for bus capability in pre_plug handler
  pci/pcihp: overwrite hotplug handler recursively from the start
  pci/pcihp: perform unplug via the hotplug handler
  pci/pcie: perform unplug via the hotplug handler
  pci/shpc: perform unplug via the hotplug handler
  spapr_pci: perform unplug via the hotplug handler

 hw/acpi/pcihp.c                 | 47 ++++++++++++++++++++++++++++-----
 hw/acpi/piix4.c                 | 39 ++++++++++++++-------------
 hw/pci-bridge/pci_bridge_dev.c  | 31 +++++++++++++++-------
 hw/pci-bridge/pcie_pci_bridge.c | 29 ++++++++++++++------
 hw/pci/pcie.c                   | 46 +++++++++++++++++++++-----------
 hw/pci/pcie_port.c              |  6 +++--
 hw/pci/shpc.c                   | 25 ++++++++++++------
 hw/ppc/spapr_pci.c              | 33 ++++++++++++++---------
 hw/s390x/s390-pci-bus.c         | 12 ++++-----
 include/hw/acpi/pcihp.h         |  5 ++++
 include/hw/pci/pcie.h           | 12 ++++++---
 include/hw/pci/shpc.h           | 10 ++++---
 12 files changed, 201 insertions(+), 94 deletions(-)

-- 
2.17.2
