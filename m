Received: from eggs.gnu.org ([2001:4830:134:3::10]:33154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER5E-0001VF-5K
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER5A-0005HP-4g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:08:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fER59-0005Gq-Vl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:08:28 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri,  4 May 2018 11:08:01 +0800
Message-Id: <20180504030811.28111-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] intel-iommu: nested vIOMMU, cleanups,
 bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

v2:
- fix patchew code style warnings
- interval tree: postpone malloc when inserting; simplify node remove
  a bit where proper [Jason]
- fix up comment and commit message for iommu lock patch [Kevin]
- protect context cache too using the iommu lock [Kevin, Jason]
- add vast comment in patch 8 to explain the modify-PTE problem
  [Jason, Kevin]

Online repo:

  https://github.com/xzpeter/qemu/tree/fix-vtd-dma

This series fixes several major problems that current code has:

- Issue 1: when getting very big PSI UNMAP invalidations, the current
  code is buggy in that we might skip the notification while actually
  we should always send that notification.

- Issue 2: IOTLB is not thread safe, while block dataplane can be
  accessing and updating it in parallel.

- Issue 3: For devices that only registered with UNMAP-only notifiers,
  we don't really need to do page walking for PSIs, we can directly
  deliver the notification down.  For example, vhost.

- Issue 4: unsafe window for MAP notified devices like vfio-pci (and
  in the future, vDPA as well).  The problem is that, now for domain
  invalidations we do this to make sure the shadow page tables are
  correctly synced:

  1. unmap the whole address space
  2. replay the whole address space, map existing pages

  However during step 1 and 2 there will be a very tiny window (it can
  be as big as 3ms) that the shadow page table is either invalid or
  incomplete (since we're rebuilding it up).  That's fatal error since
  devices never know that happending and it's still possible to DMA to
  memories.

Patch 1 fixes issue 1.  I put it at the first since it's picked from
an old post.

Patch 2 is a cleanup to remove useless IntelIOMMUNotifierNode struct.

Patch 3 fixes issue 2.

Patch 4 fixes issue 3.

Patch 5-9 fix issue 4.  Here a very simple interval tree is
implemented based on Gtree.  It's different with general interval tree
in that it does not allow user to pass in private data (e.g.,
translated addresses).  However that benefits us that then we can
merge adjacent interval leaves so that hopefully we won't consume much
memory even if the mappings are a lot (that happens for nested virt -
when mapping the whole L2 guest RAM range, it can be at least in GBs).

Patch 10 is another big cleanup only can work after patch 9.

Tests:

- device assignments to L1, even L2 guests.  With this series applied
  (and the kernel IOMMU patches: https://lkml.org/lkml/2018/4/18/5),
  we can even nest vIOMMU now, e.g., we can specify vIOMMU in L2 guest
  with assigned devices and things will work.  We can't before.

- vhost smoke test for regression.

Please review.  Thanks,

Peter Xu (10):
  intel-iommu: send PSI always even if across PDEs
  intel-iommu: remove IntelIOMMUNotifierNode
  intel-iommu: add iommu lock
  intel-iommu: only do page walk for MAP notifiers
  intel-iommu: introduce vtd_page_walk_info
  intel-iommu: pass in address space when page walk
  util: implement simple interval tree logic
  intel-iommu: maintain per-device iova ranges
  intel-iommu: don't unmap all for shadow page table
  intel-iommu: remove notify_unmap for page walk

 include/hw/i386/intel_iommu.h |  19 ++-
 include/qemu/interval-tree.h  | 130 +++++++++++++++
 hw/i386/intel_iommu.c         | 306 +++++++++++++++++++++++++---------
 util/interval-tree.c          | 208 +++++++++++++++++++++++
 hw/i386/trace-events          |   3 +-
 util/Makefile.objs            |   1 +
 6 files changed, 579 insertions(+), 88 deletions(-)
 create mode 100644 include/qemu/interval-tree.h
 create mode 100644 util/interval-tree.c

-- 
2.17.0
