Received: from eggs.gnu.org ([209.51.188.92]:45560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzMZ6-0002ep-PQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzMYy-00073l-Gk
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:21:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:44775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1gzMYy-00070f-8M
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:21:28 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Thu, 28 Feb 2019 21:47:54 +0800
Message-Id: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [RFC v2 0/3] intel_iommu: support scalable mode
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
v1->v2

Patch 1:
    - remove unnecessary macros.
    - rename macros to capital.
    - make 're->hi' assignment be unconditional to simplify codes.
    - remove 'vtd_get_context_base' to embed its content into caller.
    - remove 'vtd_context_entry_format' to to embed its content into caller.
    - remove unnecessary memset for 'pe->val'.
    - use 'INTEL_IOMMU_DEVICE' to get 'IntelIOMMUState' to remove input
      'IntelIOMMUState *s' parameter.
    - call 'vtd_get_domain_id' to get domain_id.
    - check error code returned by 'vtd_ce_get_rid2pasid_entry' in
      'vtd_dev_pt_enabled'.
    - check '!is_fpd_set' of context entry before handing pasid entry.
    - move 's->root_scalable' assignment to patch 3.
    - add comment for 'VTD_FR_PASID_TABLE_INV'.
    - remove not used 'VTD_ROOT_ENTRY_SIZE'.
    - change 'VTD_CTX_ENTRY_LECY_SIZE' to 'VTD_CTX_ENTRY_LEGACY_SIZE'.
    - change 'VTD_CTX_ENTRY_SM_SIZE' to 'VTD_CTX_ENTRY_SCALABLE_SIZE'.
    - use union in 'struct VTDContextEntry' to reduce code changes.
Patch 2:
    - modify s-o-b position.
    - remove unnecessary macros.
    - change 'iq_dw' type to bool.
    - remove initialization to 'inv_desc->val[]'.
    - modify 'VTDInvDesc' to add a union 'val[4]' to be compatible
      with both legacy mode and scalable mode.
Patch 3:
    - rename "scalable-mode" to "x-scalable-mode".
    - remove caching_mode check when scalable_mode is set.
    - check dma_drain check when scalable_mode is set. This is requested
      by spec.
    - remove redundant macros.
---

Liu, Yi L (2):
  intel_iommu: scalable mode emulation
  intel_iommu: add 256 bits qi_desc support

Yi Sun (1):
  intel_iommu: add scalable-mode option to make scalable mode work

 hw/i386/intel_iommu.c          | 540 ++++++++++++++++++++++++++++++++++-------
 hw/i386/intel_iommu_internal.h |  54 ++++-
 hw/i386/trace-events           |   2 +-
 include/hw/i386/intel_iommu.h  |  28 ++-
 4 files changed, 534 insertions(+), 90 deletions(-)

-- 
1.9.1
