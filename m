Received: from eggs.gnu.org ([209.51.188.92]:40273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvfvF-0002Y3-3I
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvfvE-0005L0-9p
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:13:13 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 11:12:51 +0100
Message-Id: <20190218101254.8007-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/3] qdev: Hotplug handler chaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, David Hildenbrand <david@redhat.com>

This series implements support for hotplug handler chaining (proposed
by Igor), something that is necessary to turn selected virtio devices into
memory devices. Planned devices inlude virtio-mem and virtio-pmem.

The machine hotplug handler can intercept hotplug handler calls
to properly prepare/teardown the memory device part of a device. Control
is then passed on to the actual bus hotplug handler. So the default hotplug
handler is effectively overwritten to make interception possible.

This series was tested against
  [PATCH v3 0/6] tests: Add device unplug tests

RFCv2 -> v1:
- "qdev: Let the hotplug_handler_unplug() caller delete the device"
-- Fixed two spapr delete_device() calls I missed. Covered by tests now :)
-- Handle + add a comment for host pci bridge unplug, for which we have
   code but no user yet.
- virtio-pmem prototype will be handled from this point by Pankaj again,
  so no longer included

David Hildenbrand (2):
  qdev: Let the hotplug_handler_unplug() caller delete the device
  qdev: Provide qdev_get_bus_hotplug_handler()

Igor Mammedov (1):
  qdev: Let machine hotplug handler to override bus hotplug handler

 hw/acpi/cpu.c            |  1 +
 hw/acpi/memory_hotplug.c |  1 +
 hw/acpi/pcihp.c          |  3 ++-
 hw/core/qdev.c           | 19 ++++++++++++-------
 hw/i386/pc.c             |  5 ++---
 hw/pci/pci.c             |  3 ++-
 hw/pci/pcie.c            |  3 ++-
 hw/pci/shpc.c            |  3 ++-
 hw/ppc/spapr.c           |  6 ++++--
 hw/ppc/spapr_pci.c       |  3 ++-
 hw/s390x/css-bridge.c    |  2 +-
 hw/s390x/s390-pci-bus.c  | 13 ++++++++-----
 include/hw/qdev-core.h   | 12 ++++++++++++
 qdev-monitor.c           |  9 +++++++--
 14 files changed, 58 insertions(+), 25 deletions(-)

-- 
2.17.2
