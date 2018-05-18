Received: from eggs.gnu.org ([2001:4830:134:3::10]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJZlY-0006lt-Pt
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJZlT-0005bp-3U
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:25:25 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 18 May 2018 15:25:08 +0800
Message-Id: <20180518072517.20901-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/9] intel-iommu: nested vIOMMU, cleanups,
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
Cc: Tian Kevin <kevin.tian@intel.com>, QEMU Stable <qemu-stable@nongnu.org>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

Upstream repo: https://github.com/xzpeter/qemu/tree/fix-vtd-dma

This version contains little functional changes, mostly comment-wise
and patch squashings.  I squashed the last 4 patches since they are
solving the same problem, meanwhile the old patch 9 itself might
brought some problem if without patch 12 so I just squashed them all.
I re-wrote the commit message for that patch (and it simplifies me to
write the SECURITY part since all those four patches are solving the
single problem).  Reviewers can go to previous version 3 and have a
look at patches 9-12 since the contents are totally the same (and I
suppose that one might be easier for reviewers).

V3: http://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04009.html

I made bold to have Jintack's Reported-by and Tested-by for the last
big patch already, after I did some smoke test for this new version.

v4:
- rename: notifiers_list to vtd_as_with_notifiers,
  vtd_as_notify_mappings to vtd_as_has_map_notifier [Eric]
- tune the comments in misc patches [Eric]
- add missing places to take iommu lock [Eric]
- for each patch: cc stable, add "SECURITY IMPLICATION" at the
  beginning of commit where necessary
- merge patch 9-12

Please review.  Thanks.

Peter Xu (9):
  intel-iommu: send PSI always even if across PDEs
  intel-iommu: remove IntelIOMMUNotifierNode
  intel-iommu: add iommu lock
  intel-iommu: only do page walk for MAP notifiers
  intel-iommu: introduce vtd_page_walk_info
  intel-iommu: pass in address space when page walk
  intel-iommu: trace domain id during page walk
  util: implement simple iova tree
  intel-iommu: rework the page walk logic

 include/hw/i386/intel_iommu.h |  19 +-
 include/qemu/iova-tree.h      | 134 ++++++++++++
 hw/i386/intel_iommu.c         | 396 +++++++++++++++++++++++++---------
 util/iova-tree.c              | 114 ++++++++++
 MAINTAINERS                   |   6 +
 hw/i386/trace-events          |   5 +-
 util/Makefile.objs            |   1 +
 7 files changed, 566 insertions(+), 109 deletions(-)
 create mode 100644 include/qemu/iova-tree.h
 create mode 100644 util/iova-tree.c

-- 
2.17.0
