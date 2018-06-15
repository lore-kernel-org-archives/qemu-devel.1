Received: from eggs.gnu.org ([2001:4830:134:3::10]:45478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmqu-0007pB-Lh
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmqr-0000f9-Hs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 15 Jun 2018 13:24:48 +0200
Message-Id: <20180615112500.19854-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/12] pc-dimm: next bunch of cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

This is another set of cleanups as the result from
    [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
And is based on
    [PATCH v1 0/2] memory: fix alignment checks/asserts

These cleanup are the last step before
- 1. moving pc-dimm address and slot assignment into pc_dimm_pre_plug
- 2. factoring out pre_plug, plug and unplug logic of memory devices
     completely

v1 -> v2:
- deferring "pc-dimm: assign and verify the "slot" property during pre_plug"
- deferring "pc-dimm: introduce and use pc_dimm_memory_pre_plug()"
- dropped "pc-dimm: get_memory_region() will never return a NULL pointer"
- dropped "pc-dimm: don't allow to access "size" before the device was realized"
- dropped "spapr: move memory hotplug size check into plug code"
- dropped "pc-dimm: get_memory_region() can never fail"
-- replaces by "pc-dimm: get_memory_region() will not fail after realize"
- added "pc: rename pc_dimm_(plug|unplug|...)* into ..."
- added "pc-dimm: rename pc_dimm_memory_* to pc_dimm_*"
- added "pc-dimm: remove pc_dimm_get_free_slot() from header"
- added "pc-dimm: merge get_(vmstate_)memory_region()"
- added "nvdimm: convert "unarmed" into a static property"
- added "nvdimm: convert "label-size" into a static property"
- added "nvdimm: make get_memory_region() perform checks and initialization"


David Hildenbrand (12):
  pc-dimm: remove leftover "struct pc_dimms_capacity"
  pc: rename pc_dimm_(plug|unplug|...)* into
    pc_memory_(plug|unplug|...)*
  pc-dimm: rename pc_dimm_memory_* to pc_dimm_*
  pc-dimm: remove pc_dimm_get_free_slot() from header
  pc: factor out pc specific dimm checks into pc_memory_pre_plug()
  hostmem: drop error variable from host_memory_backend_get_memory()
  pc-dimm: merge get_(vmstate_)memory_region()
  nvdimm: no need to overwrite get_vmstate_memory_region()
  nvdimm: convert "unarmed" into a static property
  nvdimm: convert "label-size" into a static property
  nvdimm: make get_memory_region() perform checks and initialization
  pc-dimm: get_memory_region() will not fail after realize

 backends/hostmem.c       |   3 +-
 hw/i386/pc.c             |  73 +++++++++++-----------
 hw/mem/nvdimm.c          | 130 +++++++++++++++------------------------
 hw/mem/pc-dimm.c         |  35 ++++-------
 hw/misc/ivshmem.c        |   3 +-
 hw/ppc/spapr.c           |  18 ++----
 include/hw/mem/pc-dimm.h |  17 ++---
 include/sysemu/hostmem.h |   3 +-
 numa.c                   |   3 +-
 9 files changed, 116 insertions(+), 169 deletions(-)

-- 
2.17.1
