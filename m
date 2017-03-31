Received: from eggs.gnu.org ([2001:4830:134:3::10]:54889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8b-0008PR-Jx
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8W-00020Z-NN
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:24164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cts8W-0001yz-Ah
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:24 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 31 Mar 2017 16:41:43 +0800
Message-Id: <20170331084147.32716-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC PATCH 0/4] nvdimm: enable flush hint address
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dan.j.williams@intel.com, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

This patch series constructs the flush hint address structures for
nvdimm devices in QEMU.

It's of course not for 2.9. I send it out early in order to get
comments on one point I'm uncertain (see the detailed explanation
below). Thanks for any comments in advance!


Background
---------------
Flush hint address structure is a substructure of NFIT and specifies
one or more addresses, namely Flush Hint Addresses. Software can write
to any one of these flush hint addresses to cause any preceding writes
to the NVDIMM region to be flushed out of the intervening platform
buffers to the targeted NVDIMM. More details can be found in ACPI Spec
6.1, Section 5.2.25.8 "Flush Hint Address Structure".


Why is it RFC?
---------------
RFC is added because I'm not sure whether the way in this patch series
that allocates the guest flush hint addresses is right.

QEMU needs to trap guest accesses (at least for writes) to the flush
hint addresses in order to perform the necessary flush on the host
back store. Therefore, QEMU needs to create IO memory regions that
cover those flush hint addresses. In order to create those IO memory
regions, QEMU needs to know the flush hint addresses or their offsets
to other known memory regions in advance. So far looks good.

Flush hint addresses are in the guest address space. Looking at how
the current NVDIMM ACPI in QEMU allocates the DSM buffer, it's natural
to take the same way for flush hint addresses, i.e. let the guest
firmware allocate from free addresses and patch them in the flush hint
address structure. (*Please correct me If my following understand is wrong*)
However, the current allocation and pointer patching are transparent
to QEMU, so QEMU will be unaware of the flush hint addresses, and
consequently have no way to create corresponding IO memory regions in
order to trap guest accesses.

Alternatively, this patch series moves the allocation of flush hint
addresses to QEMU:

1. (Patch 1) We reserve an address range after the end address of each
   nvdimm device. Its size is specified by the user via a new pc-dimm
   option 'reserved-size'.

   For the following example,
        -object memory-backend-file,id=mem0,size=4G,...
        -device nvdimm,id=dimm0,memdev=mem0,reserved-size=4K,...
        -device pc-dimm,id=dimm1,...
   if dimm0 is allocated to address N ~ N+4G, the address of dimm1
   will start from N+4G+4K or higher. N+4G ~ N+4G+4K is reserved for
   dimm0.

2. (Patch 4) When NVDIMM ACPI code builds the flush hint address
   structure for each nvdimm device, it will allocate them from the
   above reserved area, e.g. the flush hint addresses of above dimm0
   are allocated in N+4G ~ N+4G+4K. The addresses are known to QEMU in
   this way, so QEMU can easily create IO memory regions for them.

   If the reserved area is not present or too small, QEMU will report
   errors.


How to test?
---------------
Add options 'flush-hint' and 'reserved-size' when creating a nvdimm
device, e.g.
    qemu-system-x86_64 -machine pc,nvdimm \
                       -m 4G,slots=4,maxmem=128G \
                       -object memory-backend-file,id=mem1,share,mem-path=/dev/pmem0 \
                       -device nvdimm,id=nv1,memdev=mem1,reserved-size=4K,flush-hint \
                       ...

The guest OS should be able to find a flush hint address structure in
NFIT. For guest Linux kernel v4.8 or later which supports flush hint,
if QEMU is built with NVDIMM_DEBUG = 1 in include/hw/mem/nvdimm.h, it
will print debug messages like
    nvdimm: Write Flush Hint: offset 0x0, data 0x1
    nvdimm: Write Flush Hint: offset 0x4, data 0x0
when linux performs flush via flush hint address.



Haozhong Zhang (4):
  pc-dimm: add 'reserved-size' to reserve address range after the ending address
  nvdimm: add functions to initialize and perform flush on back store
  nvdimm acpi: record the cache line size in AcpiNVDIMMState
  nvdimm acpi: build flush hint address structure if required

 hw/acpi/nvdimm.c         | 111 ++++++++++++++++++++++++++++++++++++++++++++---
 hw/i386/pc.c             |   5 ++-
 hw/i386/pc_piix.c        |   2 +-
 hw/i386/pc_q35.c         |   2 +-
 hw/mem/nvdimm.c          |  48 ++++++++++++++++++++
 hw/mem/pc-dimm.c         |  48 ++++++++++++++++++--
 include/hw/mem/nvdimm.h  |  20 ++++++++-
 include/hw/mem/pc-dimm.h |   2 +
 8 files changed, 224 insertions(+), 14 deletions(-)

-- 
2.10.1
