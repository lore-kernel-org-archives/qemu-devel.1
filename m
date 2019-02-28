Received: from eggs.gnu.org ([209.51.188.92]:51559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzKoG-0002AW-2m
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzKoF-0007wI-AA
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:29:08 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Feb 2019 13:28:46 +0100
Message-Id: <20190228122849.4296-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qdev: Hotplug handler chaining
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

Can somebody please pick this up in the near future? (@Eduardo, @MST,
@Paolo, @David - I have no idea who the right person is :) )

The longer we wait, the more likely it is that some stuff gets upstreamed
that conflicts with patch 1 and will break unnoticed. (e.g. spapr PHB
hotplug was just upstreamed and required a fixup, luckily I was CC'ed on
that one).

---

This series implements support for hotplug handler chaining (proposed
by Igor), something that is necessary to turn selected virtio devices into
memory devices. Planned devices inlude virtio-mem and virtio-pmem.

The machine hotplug handler can intercept hotplug handler calls
to properly prepare/teardown the memory device part of a device. Control
is then passed on to the actual bus hotplug handler. So the default hotplug
handler is effectively overwritten to make interception possible.

This series was tested against the - now upstream - device unplug tests
part of "tests/device-plug-test".

v1 -> v2:
- Fixed spapr PHB unplug which was just upstreamed

RFCv2 -> v1:
- "qdev: Let the hotplug_handler_unplug() caller delete the device"
-- Fixed two spapr delete_device() calls I missed. Covered by tests now
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
 hw/ppc/spapr.c           |  9 ++++++---
 hw/ppc/spapr_pci.c       |  3 ++-
 hw/s390x/css-bridge.c    |  2 +-
 hw/s390x/s390-pci-bus.c  | 13 ++++++++-----
 include/hw/qdev-core.h   | 12 ++++++++++++
 qdev-monitor.c           |  9 +++++++--
 14 files changed, 60 insertions(+), 26 deletions(-)

-- 
2.17.2
