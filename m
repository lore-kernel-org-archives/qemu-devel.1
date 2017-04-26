Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6O-00025S-2Y
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6K-0001sb-9H
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:49299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K6J-0001rZ-T4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:12 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:30 +0800
Message-Id: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 00/20] Qemu: Extend intel_iommu emulator to
 support Shared Virtual Memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

Hi,

This patchset is proposing a solution to extend the current
Intel IOMMU emulator in QEMU to support Shared Virtual Memory
usage in guest. The whole SVM virtualization for intel_iommu
has two series which introduces changes in Qemu and VFIO/IOMMU.
This patchset mainly changes Qemu. For VFIO/IOMMU changes, it is
in another patchset.

"[RFC PATCH 0/8] Shared Virtual Memory virtualization for VT-d"

[Terms]:
SVM: Shared Virtual Memory
vSVM: virtual SVM, mean use SVM in guest
IOVA: I/O Virtual Address
gIOVA: I/O Virtual Address in guest
GVA: virtual memory address in guest
GPA: physical address in guest
HPA: physical address in host
PRQ: Page Request
vIOMMU: Virtual IOMMU emulated by QEMU
pIOMMU: physical IOMMU on HW
QI: Queued Invalidation, a mechanism used to invalidate cache in VT-d
PASID: Process Address Space ID
IGD: Intel Graphics Device
PT: Passthru Mode
ECS: Extended Context Support
Ex-Root Table: root table used in ECS mode
Ex-Context Table: context table use in ECS mode

[About Shared Virtual Memory]
Shared Virtual Memory (SVM) is a VT-d feature that allows sharing
application address space with the I/O device. The feature works
with the PCI sig Process Address Space ID (PASID). SVM has the
following benefits:

* Programmer gets a consistent view of memory across host application
  and device.
* Efficient access to data, avoiding pining or copying overheads.
* Memory over-commit via demand paging for both CPU and device access
  to memory.

IGD is a SVM capable device, applications like OpenCL wants SVM support
to achieve the benefits above. This patchset was tested with IGD and SVM
tools provided by IGD driver developer.


[vSVM]
SVM usage in guest would be mentioned as vSVM in this patch set. vSVM
enables sharing guest application address space with assigned devices.

The following diagram illustrates the relationship of the Ex-Root Table
, Ex-Context Table, PASID Table, First-Level Page Table, Second-Level
Page Table on VT-d.

                                              ------+
                                            ------+ |
                                         +------+ | |
                              PASID      |      | | |
                              Table      +------+ | |
                             +------+    |      | | |
                Ex-Context   |      |    +------+ | |
                   Table     +------+    |      | |
                 +------+    | pasid| -->+------+
      Ex-Root    |      |    +------+    First-Level
      Table      +------+    |      |    Page Table
     +------+    |devfn | -->+------+
     |      |    +------+ \
     +------+    |      |  \                ------+
     | bus  | -->+------+   \             ------+ |
     +------+                \         +------+ | |
     |      |                 \        |      | | |
     +------+                  \       +------+ | |
    /                           \      |      | | |
RTA                              \     +------+ | |
                                  \    |      | |
                                   --> +------+
                                       Second-Level
                                       Page Table

To achieve the virtual SVM usage, GVA->HPA mapping in physical VT-d
is needed. On VT-d, there is nested mode which is able to achieve
GVA->HPA mapping. With nested mode enabled for a device, any request-
with-PASID from this device would be translated with first-level page
table and second-level page table in a nested mode. The translation
process is getting GVA->GPA by first-level page table, and then getting
GPA->HPA by second-level page table.
                                       
The translation above could be achieve by linking the whole guest PASID
table to host. With guest PASID table linked, the Remapping Hardware in
VT-d could use the guest first-level page table to get GVA->GPA translation
and then use the host second-level page table to get GPA->HPA translation.

Besides nested mode and linking guest PASID table to host, caching-mode
is another key capability. Reporting the Caching Mode as Set for the
virtual hardware requires the guest software to explicitly issue
invalidation operations on the virtual hardware for any/all updates to the
guest remapping structures. The virtualizing software may trap these guest
invalidation operations to keep the shadow translation structures consistent
to guest translation structure modifications. With Caching Mode reported to
guest, intel_iommu emulator could trap the programming of context entry in
guest thus link the guest PASID table to host and set nested mode.

[vSVM Implementation]
To enable SVM usage to guest, the work includes the following items.

Initialization Phase:
(1) Report SVM required capabilities in intel_iommu emulator
(2) Trap the guest context cache invalidation, link the whole guest PASID
    table to host ex-context entry
(3) Set nested mode in host extended-context entry

Run-time:
(4) Forward guest cache invalidation requests for 1st level translation to
    pIOMMU
(5) Fault reporting, reports fault happen on host to intel_iommu emulator,
    then to guest
(6) Page Request and response

As fault reporting framework is in discussion in another thread which is
driven by Lan Tianyu, so vSVM enabling plan is to divide the work into two
phase. This patchset is for Phase 1.

Phase 1: include item (1), (2) and (3).
Phase 2: include item (4), (5) and (6).


[Overview of patch]
This patchset has a requirement of Passthru-Mode supporting for
intel_iommu. Peter Xu has sent a patch for it.
https://www.mail-archive.com/qemu-devel@nongnu.org/msg443627.html

* 1 ~ 2 enables Extend-Context Support in intel_iommu emulator.
* 3 exposes SVM related capability to guest with an option.
* 4 changes VFIO notifier parameter for the newly added notifier.
* 5 ~ 6 adds new VFIO notifier for pasid table bind request.
* 7 ~ 8 adds notifier flag check in memory_replay and region_del.
* 9 ~ 11 introduces a mechanism between VFIO and intel_iommu emulator
  to record assigned device info. e.g. the host SID of the assigned
  device.
* 12 adds fire function for pasid table bind notifier
* 13 adds generic definition for pasid table info in iommu.h
* 14 ~ 15 link the guest pasid table to host for intel_iommu
* 16 adds VFIO notifier for propagating guest IOMMU TLB invalidate
  to host.
* 17 adds fire function for IOMMU TLB invalidate notifier
* 18 ~ 20 propagate first-level page table related cache invalidate
  to host.

[Test Done]
The patchset is tested with IGD. Assign IGD to guest, the IGD could
write data to guest application address space.

i915 SVM capable driver could be found:
https://cgit.freedesktop.org/~miku/drm-intel/?h=svm

i915 svm test tool:
https://cgit.freedesktop.org/~miku/intel-gpu-tools/log/?h=svm


[Co-work with gIOVA enablement]
Currently Peter Xu is working on enabling gIOVA usage for Intel
IOMMU emulator, this patchset is based on Peter's work (V7).
https://github.com/xzpeter/qemu/tree/vtd-vfio-enablement-v7

[Limitation]
* Due to VT-d HW limitation, an assigned device cannot use gIOVA
and vSVM in the same time. Intel VT-d spec would introduce a new
capability bit indicating such limitation which guest IOMMU driver
can check to prevent both IOVA/SVM enabled, as a short-term solution.
In the long term it will be fixed by HW.

[Open]
* This patchset proposes passing raw data from guest to host when
propagating the guest IOMMU TLB invalidation.

In fact, we have two choice here.

a) as proposed in this patchset, passing raw data to host. Host pIOMMU
   driver submits invalidation request after replacing specific fields.
   Reject if the IOMMU model is not correct.
   * Pros: no need to do parse and re-assembling, better performance
   * Cons: unable to support the scenarios which emulates an Intel IOMMU
           on an ARM platform.
b) parse the invalidation info into specific data, e.g. gran, addr,
   size, invalidation type etc. then fill the data in a generic
   structure. In host, pIOMMU driver re-assemble the invalidation
   request and submit to pIOMMU.
   * Pros: may be able to support the scenario above. But it is still in
           question since different vendor may have vendor specific
           invalidation info. This would make it difficult to have vendor
           agnostic invalidation propagation API.

   * Cons: needs additional complexity to do parse and re-assembling.
           The generic structure would be a hyper-set of all possible
           invalidate info, this may be hard to maintain in future.

As the pros/cons show, I proposed a) as an initial version. But it is an
open. I would be glad to hear from you.

FYI. The following definition is a draft discussed with Jean in previous
discussion. It has both generic part and vendor specific part.

struct tlb_invalidate_info
{
        __u32   model;  /* Vendor number */
        __u8 granularity
#define DEVICE_SELECTVIE_INV    (1 << 0)
#define PAGE_SELECTIVE_INV      (1 << 0)
#define PASID_SELECTIVE_INV     (1 << 1)
        __u32 pasid;
        __u64 addr;
        __u64 size;

        /* Since IOMMU format has already been validated for this table,
           the IOMMU driver knows that the following structure is in a
           format it knows */
        __u8 opaque[];
};

struct tlb_invalidate_info_intel
{
        __u32 inv_type;
        ...
        __u64 flags;
        ...
        __u8 mip;
        __u16 pfsid;
};

Additionally, Jean is proposing a para-vIOMMU solution. There is opaque
data in the proposed invalidate request VIRTIO_IOMMU_T_INVALIDATE. So it
may be preferred to have opaque part when doing the iommu tlb invalidate
propagation in SVM virtualization.

http://www.spinics.net/lists/kvm/msg147993.html

Best Wishes,
Yi L


Liu, Yi L (20):
  intel_iommu: add "ecs" option
  intel_iommu: exposed extended-context mode to guest
  intel_iommu: add "svm" option
  Memory: modify parameter in IOMMUNotifier func
  VFIO: add new IOCTL for svm bind tasks
  VFIO: add new notifier for binding PASID table
  VFIO: check notifier flag in region_del()
  Memory: add notifier flag check in memory_replay()
  Memory: introduce iommu_ops->record_device
  VFIO: notify vIOMMU emulator when device is assigned
  intel_iommu: provide iommu_ops->record_device
  Memory: Add func to fire pasidt_bind notifier
  IOMMU: add pasid_table_info for guest pasid table
  intel_iommu: add FOR_EACH_ASSIGN_DEVICE macro
  intel_iommu: link whole guest pasid table to host
  VFIO: Add notifier for propagating IOMMU TLB invalidate
  Memory: Add func to fire TLB invalidate notifier
  intel_iommu: propagate Extended-IOTLB invalidate to host
  intel_iommu: propagate PASID-Cache invalidate to host
  intel_iommu: propagate Ext-Device-TLB invalidate to host

 hw/i386/intel_iommu.c          | 543 +++++++++++++++++++++++++++++++++++++----
 hw/i386/intel_iommu_internal.h |  87 +++++++
 hw/vfio/common.c               |  45 +++-
 hw/vfio/pci.c                  |  94 ++++++-
 hw/virtio/vhost.c              |   3 +-
 include/exec/memory.h          |  45 +++-
 include/hw/i386/intel_iommu.h  |   5 +-
 include/hw/vfio/vfio-common.h  |   5 +
 linux-headers/linux/iommu.h    |  35 +++
 linux-headers/linux/vfio.h     |  26 ++
 memory.c                       |  59 +++++
 11 files changed, 882 insertions(+), 65 deletions(-)
 create mode 100644 linux-headers/linux/iommu.h

-- 
1.9.1
