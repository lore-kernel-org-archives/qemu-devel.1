Received: from eggs.gnu.org ([209.51.188.92]:44579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjTz-0004uL-Sp
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjTx-00069D-C4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:35:43 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 16 Jan 2019 12:35:13 +0100
Message-Id: <20190116113523.9213-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 00/10] qdev: Hotplug handler chaining +
 virtio-pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

This series implements supprt for hotplug handler chaining (proposed
by Igor), something that is necessary to turn selected virtio devices into
memory devices. Planned devices inlude virtio-mem and virtio-pmem. The
current prototype of virtio-pmem is included.

The machine hotplug handler can intercept hotplug handler calls
to properly prepare/teardown the memory device part of a device. Control
is then passed on to the actual bus hotplug handler. So the default hotplug
handler is effectively overwritten to make interception possible.

It is based on the following patches/series
- [PULL v2 01/49] pci/pcie: stop plug/unplug if the slot is locked
-- Soon upstream
- [PATCH v1] pc: Use hotplug_handler_(plug|unplug|unplug_request)
-- Queued by Paolo
- [PATCH v2 0/6] s390x/pci: hotplug handler fixes and reworks
-- Partially queued

Patch 1-3 are the preparations for hotplug handler chaining. The remaining
patches are a modified prototype of virtio-pmem.

I modified Pankajs work to work with this series. virtio-pmem is included
as it was requested during review of previous preparations to showcase a
real user, so we can discuss if this is good enough for us or if we have
to do further changes.

More details about virtio-pmem (including the Linux guest driver side)
can be found at:
    https://lkml.org/lkml/2018/7/13/102
    https://lkml.org/lkml/2019/1/9/756

Example: defining a simple virtio-pmem device (on /dev/zero for simplicity):

    qemu-system-x86_64 \
     -machine pc \
     -monitor stdio \
     -m 8G,maxmem=20G \
     -object memory-backend-file,id=mem1,mem-path=/dev/zero,size=4G \
     -device virtio-pmem-pci,id=vp1,memdev=mem1

QEMU 3.0.50 monitor - type 'help' for more information
(qemu) info memory-devices
Memory device [virtio-pmem]: "vp1"
  memaddr: 0x240000000
  size: 4294967296
  memdev: /objects/mem1

(qemu) info memory_size_summary
base memory: 8589934592
plugged memory: 4294967296


David Hildenbrand (7):
  qdev: Let the hotplug_handler_unplug() caller delete the device
  qdev: Provide qdev_get_bus_hotplug_handler()
  virtio-pci: Allow to specify additional interfaces for the base type
  hmp: Handle virtio-pmem when printing memory device infos
  numa: Handle virtio-pmem in NUMA stats
  pc: Support for PCI based memory devices
  pc: Enable support for virtio-pmem

Igor Mammedov (1):
  qdev: Let machine hotplug handler to override bus hotplug handler

Pankaj Gupta (2):
  virtio-pmem: Prototype
  virtio-pci: Proxy for virtio-pmem

 default-configs/i386-softmmu.mak            |   1 +
 hmp.c                                       |  27 +--
 hw/acpi/cpu.c                               |   1 +
 hw/acpi/memory_hotplug.c                    |   1 +
 hw/acpi/pcihp.c                             |   3 +-
 hw/core/qdev.c                              |  19 +-
 hw/i386/pc.c                                |  95 +++++++++-
 hw/pci/pcie.c                               |   3 +-
 hw/pci/shpc.c                               |   3 +-
 hw/ppc/spapr.c                              |   4 +-
 hw/ppc/spapr_pci.c                          |   3 +-
 hw/s390x/css-bridge.c                       |   2 +-
 hw/s390x/s390-pci-bus.c                     |  13 +-
 hw/virtio/Makefile.objs                     |   3 +
 hw/virtio/virtio-pci.c                      |   1 +
 hw/virtio/virtio-pci.h                      |  15 ++
 hw/virtio/virtio-pmem-pci.c                 | 129 +++++++++++++
 hw/virtio/virtio-pmem.c                     | 189 ++++++++++++++++++++
 include/hw/qdev-core.h                      |  12 ++
 include/hw/virtio/virtio-pmem.h             |  54 ++++++
 include/standard-headers/linux/virtio_ids.h |   1 +
 numa.c                                      |  24 +--
 qapi/misc.json                              |  26 ++-
 qdev-monitor.c                              |   9 +-
 24 files changed, 588 insertions(+), 50 deletions(-)
 create mode 100644 hw/virtio/virtio-pmem-pci.c
 create mode 100644 hw/virtio/virtio-pmem.c
 create mode 100644 include/hw/virtio/virtio-pmem.h

-- 
2.17.2
