Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRr-0001nM-O5
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MHy-0005ah-0N
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:20:53 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:08 +0200
Message-Id: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/16] memory-device: complete refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

This series completes refactoring of pre_plug, plug and unplug logic of
memory devices. With this as a basis, we can built e.g. virtio
based memory devices or internal "RAM chip" devices.

I dropped the virtio-pmem prototype for now, I will look into plugging
it differently next. But this part in this series here is independent of
hotplug handler changes required to make it work for virtio devices.

v4 -> v5:
- Added a bunch of RB's
- Minor spelling fixed
- Dropped "memory-device: add class function get_device_id()"
- Added   "memory-device: improve "range conflicts" error message
- Dropped "memory-device: handle integer overflows properly"
-- Will require more changes. But I am able to reproduce some overflows.
- "memory-device: document MemoryDeviceClass"
-- Changed documentation format as requested by Auger
- "memory-device: trace when pre_plugging/plugging/unplugging"
-- Include device ID and rename tracepoints.

v3 -> v4:
- Minor comment and subject fixes
- Added "memory-device: fix alignment error message"
- Added "pc-dimm: pass PCDIMMDevice to pc_dimm_.*plug"
- Dropped "hw/acpi-build: only indicate nvdimm and pc-dimm"
- "memory-device: document MemoryDeviceClass"
-- add more details about get_plugged_size
- "memory-device: add and use memory_device_get_region_size()"
-- fixed "local_err" usage
-- due to "pc-dimm: pass PCDIMMDevice to pc_dimm_.*plug", keep PC_DIMM cast
- "memory-device: add class function get_device_id()"
-- provide default handler
- "hmp: handle virtio-pmem when printing memory device infos"
-- avoid fall-through switch case
-- add g_assert_not_reached()
- "numa: handle virtio-pmem in NUMA stats"
-- avoid fall-through switch case
-- add g_assert_not_reached()
- Added "qdev: hotplug: provide do_unplug handler"
-- unplug/unplug_request are not called for devices inside a device hierarchy
   This new handler is always called when unrealizing and doesn't trigger
   the unrealize (in contrast to unplug/unplug_request)
- "pc: support for virtio-pmem" and "virtio-pmem: hotplug support functions"
-- use do_unplug handler
- Tested "device_del vp1". It works, and I can see in the traces the
  address getting unassigned. QEMU crashes when shutting down, that most
  most likely is a result of virtio-pmem not properly unrealizing and
  cleaning up virtqueues. (@Pankaj if you read this  )

v2 -> v3:
- Rephrased some patch subjects/descriptions
- Added "memory-device: handle integer overflows properly"
- "memory-device: forward errors in get_region_size()/get_plugged_size()"
-- drop superfluous error check
- "memory-device: document MemoryDeviceClass"
-- some rewording
- replaced "memory-device: convert get_region_size() to get_memory_region()"
        by "memory-device: add and use memory_device_get_region_size()"
       and "memory-device: factor out get_memory_region() from pc-dimm"
       and "memory-device: drop get_region_size()"
- squashed "memory-device: add device class function set_addr()"
       and "pc-dimm: implement memory device class function set_addr()"
- replaced "memory-device: ids of virtio based devices are special"
        by "memory-device: add optional function get_device_id()"
- fixed up the virtio-pmem prototype

v1 -> v2:
- Include virtio-pmem prototype
- Add "memory-device: fix error message when hinted address is too small"
- Add "memory-device: use memory device terminology in error messages"
- Add "hw/acpi-build: only indicate nvdimm and pc-dimm"
- Add "memory-device: ids of virtio based devices are special"
- Add "memory-device: ids of virtio based devices are special"
- Minor changes/fixes for other patches

David Hildenbrand (16):
  memory-device: fix alignment error message
  memory-device: fix error message when hinted address is too small
  memory-device: improve "range conflicts" error message
  pc-dimm: pass PCDIMMDevice to pc_dimm_.*plug
  memory-device: use memory device terminology in error messages
  memory-device: introduce separate config option
  memory-device: forward errors in get_region_size()/get_plugged_size()
  memory-device: document MemoryDeviceClass
  memory-device: add and use memory_device_get_region_size()
  memory-device: factor out get_memory_region() from pc-dimm
  memory-device: drop get_region_size()
  memory-device: add device class function set_addr()
  memory-device: complete factoring out pre_plug handling
  memory-device: complete factoring out plug handling
  memory-device: complete factoring out unplug handling
  memory-device: trace when pre_plugging/plugging/unplugging

 default-configs/i386-softmmu.mak  |   3 +-
 default-configs/ppc64-softmmu.mak |   3 +-
 hw/Makefile.objs                  |   2 +-
 hw/i386/pc.c                      |   6 +-
 hw/mem/Makefile.objs              |   4 +-
 hw/mem/memory-device.c            | 103 ++++++++++++++++++++++++------
 hw/mem/nvdimm.c                   |   9 ++-
 hw/mem/pc-dimm.c                  |  84 ++++++++----------------
 hw/mem/trace-events               |   5 +-
 hw/ppc/spapr.c                    |  29 ++++-----
 include/hw/mem/memory-device.h    |  74 ++++++++++++++++++---
 include/hw/mem/pc-dimm.h          |  10 +--
 qapi/misc.json                    |   2 +-
 13 files changed, 210 insertions(+), 124 deletions(-)

-- 
2.17.1
