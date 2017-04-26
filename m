Received: from eggs.gnu.org ([2001:4830:134:3::10]:50494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7G-0002kW-DJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7B-0002NQ-HH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:30501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7B-0002MA-7h
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:05 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:38 +0800
Message-Id: <1493201210-14357-9-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 08/20] Memory: add notifier flag check in
 memory_replay()
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

memory_region_iommu_replay is used to do replay with MAP/UNMAP notifier.
However, other notifiers may be passed in, so add a check against notifier
flag to avoid potential error. e.g. memory_region_iommu_replay_all loops
all registered notifiers, may just pass in wrong notifier.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/memory.c b/memory.c
index 9c253cc..0728e62 100644
--- a/memory.c
+++ b/memory.c
@@ -1630,6 +1630,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
 
+    if (!(n->notifier_flags & IOMMU_NOTIFIER_MAP_UNMAP)) {
+        /* If notifier flag is not IOMMU_NOTIFIER_UNMAP or
+         * IOMMU_NOTIFIER_MAP, return. This check is necessary
+         * as there is notifier other than MAP/UNMAP
+         */
+        return;
+    }
+
     /* If the IOMMU has its own replay callback, override */
     if (mr->iommu_ops->replay) {
         mr->iommu_ops->replay(mr, n);
-- 
1.9.1
