Received: from eggs.gnu.org ([2001:4830:134:3::10]:35184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7y0-0000op-59
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7xw-0003gt-Va
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:36 +0200
Message-Id: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/17] MemoryDevice: use multi stage hotplug
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

This is an alternative implementation of "MemoryDevice: introduce and use
ResourceHandler". It is based on the proposal of Igor, to have multi stage
hotplug handlers. This seems to work just fine for DIMMs and virtio-mem.

This approach results in slightly more LOC (each machine has to
implement support for it), however the end result looks cleaner to me.

----

We can have devices that need certain other resources that are e.g.
system resources managed by the machine. We need a clean way to assign
these resources (without violating layers as brought up by Igor).

One example is virtio-mem/virtio-pmem. Both device types need to be
assigned some region in guest physical address space. This device memory
belongs to the machine and is managed by it. However, virito devices are
hotplugged using the hotplug handler their proxy device implements. So we
could trigger e.g. a PCI hotplug handler for virtio-pci or a CSS/CCW
hotplug handler for virtio-ccw. But definetly not the machine.

Now, we can route other devices through the machine hotplug handler, to
properly assign/unassign resources - like a portion in guest physical
address space.

Main changes to other approach:
- Use multi stage hotplug handler instead of resource handler
- MemoryDevices only compiled if necessary (CONFIG_MEM_HOTPLUG)
- Prepare PC/SPAPR machines properly for multi stage hotplug handlers
- Route SPAPR unplug code via the hotunplug handler
- Directly include s390x support :) But there are no usable memory devices
  yet :( (well, only my virtio-mem prototype)
- Included "memory-device: drop assert related to align and start of address
  space"


David Hildenbrand (16):
  memory-device: drop assert related to align and start of address space
  pc: prepare for multi stage hotplug handlers
  pc: route all memory devices through the machine hotplug handler
  spapr: prepare for multi stage hotplug handlers
  spapr: route all memory devices through the machine hotplug handler
  spapr: handle pc-dimm unplug via hotplug handler chain
  spapr: handle cpu core unplug via hotplug handler chain
  memory-device: new functions to handle plug/unplug
  pc-dimm: implement new memory device functions
  memory-device: factor out pre-plug into hotplug handler
  memory-device: factor out unplug into hotplug handler
  memory-device: factor out plug into hotplug handler
  s390x/sclp: make sure ram_size and maxram_size stay in sync
  s390x: prepare for multi stage hotplug handlers
  s390x: initialize memory region for memory devices
  s390x: support memory devices

Igor Mammedov (1):
  qdev: let machine hotplug handler to override bus hotplug handler

 default-configs/s390x-softmmu.mak |   1 +
 hw/core/qdev.c                    |   6 +-
 hw/i386/pc.c                      | 107 +++++++++++++++++++++++-------
 hw/mem/memory-device.c            | 129 ++++++++++++++++++++++--------------
 hw/mem/pc-dimm.c                  |  48 +++++---------
 hw/mem/trace-events               |   4 +-
 hw/ppc/spapr.c                    | 135 +++++++++++++++++++++++++++++++++-----
 hw/s390x/s390-virtio-ccw.c        | 102 +++++++++++++++++++++++++++-
 hw/s390x/sclp.c                   |  18 ++++-
 include/hw/mem/memory-device.h    |  21 ++++--
 include/hw/mem/pc-dimm.h          |   3 +-
 include/hw/qdev-core.h            |  11 ++++
 12 files changed, 446 insertions(+), 139 deletions(-)

-- 
2.14.3
