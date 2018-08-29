Received: from eggs.gnu.org ([2001:4830:134:3::10]:34878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2WP-0004Oi-3q
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2WK-0001w3-HF
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2WI-0001uW-HR
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:04 +0200
Message-Id: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/20] memory-device: complete refactoring +
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

This series completes refactoring of pre_plug, plug and unplug logic of
memory devices. With this as a basis, one can easily have e.g. virtio
based memory devices (virtio-mem, virtio-pmem, virtio-fs?) with minor
modifications on e.g. x86.

Patch 1-14 are the "real" patches of this series. Patch 15-20 are a
modified version of the virtio-pmem prototype that makes use of the new
memory-device hotplug model.

I modified Pankajs work to work with this series. virtio-pmem is included
as it was requested during the review to showcase a real user, so we can
discuss if this is good enough for us or if we have to do further changes.

More details about virtio-pmem can be found at:
    https://lkml.org/lkml/2018/7/13/102

Of special interest regarding virtio devices being memory-devices are:
- "virtio-pmem: hotplug support functions"
- "pc: support for virtio-pmem"


Example: defining a simple virtio-pmem device (on /dev/zero for simplicity):

    qemu-system-x86_64 \
     -machine pc \
     -m 8G,maxmem=20G \
     -object memory-backend-file,id=mem1,share,mem-path=/dev/zero,size=4G \
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


v1 -> v2:
- Include virtio-pmem prototype
- Add "memory-device: fix error message when hinted address is too small"
- Add "memory-device: use memory device terminology in error messages"
- Add "hw/acpi-build: only indicate nvdimm and pc-dimm"
- Add "memory-device: ids of virtio based devices are special"
- Add "memory-device: ids of virtio based devices are special"
- Minor changes/fixes for other patches


David Hildenbrand (18):
  memory-device: fix error message when hinted address is too small
  memory-device: use memory device terminology in error messages
  memory-device: introduce separate config option
  memory-device: get_region_size()/get_plugged_size() might fail
  memory-device: convert get_region_size() to get_memory_region()
  memory-device: document MemoryDeviceClass
  memory-device: add device class function set_addr()
  pc-dimm: implement memory device class function set_addr()
  memory-device: complete factoring out pre_plug handling
  memory-device: complete factoring out plug handling
  memory-device: complete factoring out unplug handling
  memory-device: trace when pre_assigning/assigning/unassigning
    addresses
  hw/acpi-build: only indicate nvdimm and pc-dimm
  memory-device: ids of virtio based devices are special
  hmp: handle virtio-pmem when printing memory device infos
  numa: handle virtio-pmem in NUMA stats
  virtio-pmem: hotplug support functions
  pc: support for virtio-pmem

Pankaj Gupta (2):
  virtio-pmem: prototype
  virtio-pci: proxy for virtio-pmem

 default-configs/i386-softmmu.mak            |   4 +-
 default-configs/ppc64-softmmu.mak           |   3 +-
 hmp.c                                       |  29 ++-
 hw/Makefile.objs                            |   2 +-
 hw/i386/acpi-build.c                        |  15 +-
 hw/i386/pc.c                                |  10 +-
 hw/mem/Makefile.objs                        |   4 +-
 hw/mem/memory-device.c                      |  98 ++++++--
 hw/mem/pc-dimm.c                            |  59 ++---
 hw/mem/trace-events                         |   5 +-
 hw/virtio/Makefile.objs                     |   1 +
 hw/virtio/virtio-pci.c                      |  41 ++++
 hw/virtio/virtio-pci.h                      |  14 ++
 hw/virtio/virtio-pmem.c                     | 256 ++++++++++++++++++++
 include/hw/mem/memory-device.h              |  30 ++-
 include/hw/pci/pci.h                        |   1 +
 include/hw/virtio/virtio-pmem.h             |  51 ++++
 include/standard-headers/linux/virtio_ids.h |   1 +
 numa.c                                      |  25 +-
 qapi/misc.json                              |  28 ++-
 20 files changed, 582 insertions(+), 95 deletions(-)
 create mode 100644 hw/virtio/virtio-pmem.c
 create mode 100644 include/hw/virtio/virtio-pmem.h

-- 
2.17.1
