Received: from eggs.gnu.org ([2001:4830:134:3::10]:49574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAegv-0007Uo-4E
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAegr-0007ne-2B
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:51:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 23 Apr 2018 18:51:15 +0200
Message-Id: <20180423165126.15441-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/11] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Right now we can only map PCDIMM/NVDIMM into guest address space. In the
future, we might want to do the same for virtio devices - e.g.
virtio-pmem or virtio-mem. Especially, they should be able to live side
by side to each other.

E.g. the virto based memory devices regions will not be exposed via ACPI
and friends. They will be detected just like other virtio devices and
indicate the applicable memory region. This makes it possible to also use
them on architectures without memory device detection support (e.g. s390x).

Let's factor out the memory device code into a MemoryDevice interface.

Please note that the "slots" assignment code is not relevant for memory
devices that will not be exposed via ACPI or similar. That's why that
part won't be exposed. KVM/vhost "slots" for memory regions are still
necessary but don't have to be manually specified (e.g. the slot number
doesn't mather).

So we are basically converting the hotplug memory region to a memory device
region. I have patches that also set up such a region for s390x.

v3 -> v4:
- "pc-dimm: factor out MemoryDevice interface"
-- dropped the "errp" parameter from the interface functions
-- made as many pointers const as I could :)
-- s/built/build/
- machine: make MemoryHotplugState accessible via the machine
-- State now kept via a pointer, not queried.
-- Added patches that rename the type and cleanup the terminology for
   spapr and pc
- Split up the big "pc-dimm: factor out address space logic into MemoryDevice
  code" into sub patches
--  We now pass the machine to the pc-dimm and MemoryDevice plug/unplug
    functions, so we can avoid qdev_get_machine()
-- Moved some checks around as requested by Igor
- Added a patch to make maxmem not depend on slots

v2 -> v3:
- "pc-dimm: factor out MemoryDevice interface"
--> Lookup both classes when comparing (David Gibson)

v1 -> v2:
- Fix compile issues on ppc (still untested  )


David Hildenbrand (11):
  pc-dimm: factor out MemoryDevice interface
  machine: make MemoryHotplugState accessible via the machine
  pc-dimm: no need to pass the memory region
  pc-dimm: pass in the machine and to the MemoryHotplugState
  pc-dimm: factor out address search into MemoryDevice code
  pc-dimm: factor out capacity and slot checks into MemoryDevice
  pc-dimm: move actual plug/unplug of a memory region to MemoryDevice
  machine: rename MemoryHotplugState to DeviceMemoryState
  pc: rename "hotplug memory" terminology to "device memory"
  spapr: rename "hotplug memory" terminology to "device memory"
  vl: allow 'maxmem' without 'slot'

 hw/i386/acpi-build.c                         |   7 +-
 hw/i386/pc.c                                 |  65 +++---
 hw/mem/Makefile.objs                         |   1 +
 hw/mem/memory-device.c                       | 275 ++++++++++++++++++++++++
 hw/mem/pc-dimm.c                             | 304 +++++++--------------------
 hw/ppc/spapr.c                               |  65 +++---
 hw/ppc/spapr_hcall.c                         |   7 +-
 hw/ppc/spapr_rtas_ddw.c                      |   5 +-
 include/hw/boards.h                          |  12 ++
 include/hw/i386/pc.h                         |   3 +-
 include/hw/mem/memory-device.h               |  51 +++++
 include/hw/mem/pc-dimm.h                     |  27 +--
 include/hw/ppc/spapr.h                       |   5 +-
 numa.c                                       |   3 +-
 qmp.c                                        |   4 +-
 stubs/Makefile.objs                          |   2 +-
 stubs/{qmp_pc_dimm.c => qmp_memory_device.c} |   4 +-
 vl.c                                         |  19 +-
 18 files changed, 506 insertions(+), 353 deletions(-)
 create mode 100644 hw/mem/memory-device.c
 create mode 100644 include/hw/mem/memory-device.h
 rename stubs/{qmp_pc_dimm.c => qmp_memory_device.c} (61%)

-- 
2.14.3
