Received: from eggs.gnu.org ([209.51.188.92]:59585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1h0zvI-0002FW-3x
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1h0zvH-0004eU-10
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:35:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1h0zvG-0004NE-Mj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:35:14 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Tue,  5 Mar 2019 10:34:52 +0800
Message-Id: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 0/3] intel_iommu: support scalable mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, Yi Sun <yi.y.sun@linux.intel.com>

Intel vt-d rev3.0 [1] introduces a new translation mode called
'scalable mode', which enables PASID-granular translations for
first level, second level, nested and pass-through modes. The
vt-d scalable mode is the key ingredient to enable Scalable I/O
Virtualization (Scalable IOV) [2] [3], which allows sharing a
device in minimal possible granularity (ADI - Assignable Device
Interface). As a result, previous Extended Context (ECS) mode
is deprecated (no production ever implements ECS).

This patch set emulates a minimal capability set of VT-d scalable
mode, equivalent to what is available in VT-d legacy mode today:
    1. Scalable mode root entry, context entry and PASID table
    2. Seconds level translation under scalable mode
    3. Queued invalidation (with 256 bits descriptor)
    4. Pass-through mode

Corresponding intel-iommu driver support will be included in
kernel 5.0:
    https://www.spinics.net/lists/kernel/msg2985279.html

We will add emulation of full scalable mode capability along with
guest iommu driver progress later, e.g.:
    1. First level translation
    2. Nested translation
    3. Per-PASID invalidation descriptors
    4. Page request services for handling recoverable faults

To verify the patches, below cases were tested according to Peter Xu's
suggestions.
    +---------+----------------------------------------------------------------+----------------------------------------------------------------+
    |         |                      w/ Device Passthr                         |                     w/o Device Passthr                         |
    |         +-------------------------------+--------------------------------+-------------------------------+--------------------------------+
    |         | virtio-net-pci, vhost=on      | virtio-net-pci, vhost=off      | virtio-net-pci, vhost=on      | virtio-net-pci, vhost=off      |
    |         +-------------------------------+--------------------------------+-------------------------------+--------------------------------+
    |         | netperf | kernel bld | data cp| netperf | kernel bld | data cp | netperf | kernel bld | data cp| netperf | kernel bld | data cp |
    +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
    | Legacy  | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    |
    +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
    | Scalable| Pass    | Pass       | Pass   | Pass    | Pass       | Pass    | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    |
    +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+

References:
[1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf

---
RFC v2->v1

Patch 1:
    - revert unnecessary rename in 'vtd_ce_present".
    - use 'ce_size' to judge if it is scalable mode in
      'vtd_get_context_entry_from_root'.
    - remove some 'inline' declarations.
    - remove unnecessary scalable mode check in 'vtd_ce_type_check' and
      make corresponding changes in 'vtd_dev_to_context_entry'.
    - add 'VTD_FR_PASID_TABLE_INV' case in 'vtd_qualified_faults[]'.
    - create a macro function to handle a repeated pattern about 'is_fpd_set'.
    - explicitly print 'legacy mode' when calling 'trace_vtd_replay_ce_valid'.
Patch 2:
    - do "(val & VTD_IQT_QT_256_RSV_BIT)" to be clear.
Patch 3:
    - move 's->dma_drain' check from 'vtd_init' to 'vtd_decide_config'.
---

Liu, Yi L (2):
  intel_iommu: scalable mode emulation
  intel_iommu: add 256 bits qi_desc support

Yi Sun (1):
  intel_iommu: add scalable-mode option to make scalable mode work

 hw/i386/intel_iommu.c          | 559 +++++++++++++++++++++++++++++++++--------
 hw/i386/intel_iommu_internal.h |  54 +++-
 hw/i386/trace-events           |   2 +-
 include/hw/i386/intel_iommu.h  |  28 ++-
 4 files changed, 533 insertions(+), 110 deletions(-)

-- 
1.9.1
