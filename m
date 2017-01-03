Received: from eggs.gnu.org ([2001:4830:134:3::10]:32801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOJXt-0002o6-AF
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOJXs-0008Gs-Cu
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOJXs-0008Fd-6t
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:08 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  3 Jan 2017 15:29:39 +0800
Message-Id: <1483428594-28880-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1483428594-28880-1-git-send-email-peterx@redhat.com>
References: <1483428594-28880-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 02/17] memory: handle alias for iommu
 notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

From: Jason Wang <jasowang@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/memory.c b/memory.c
index 33110e9..2bfc37f 100644
--- a/memory.c
+++ b/memory.c
@@ -1603,6 +1603,11 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
 void memory_region_register_iommu_notifier(MemoryRegion *mr,
                                            IOMMUNotifier *n)
 {
+    if (mr->alias) {
+        memory_region_register_iommu_notifier(mr->alias, n);
+        return;
+    }
+
     /* We need to register for at least one bitfield */
     assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
     QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
@@ -1643,6 +1648,10 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n)
 {
+    if (mr->alias) {
+        memory_region_unregister_iommu_notifier(mr->alias, n);
+        return;
+    }
     QLIST_REMOVE(n, node);
     memory_region_update_iommu_notify_flags(mr);
 }
-- 
2.7.4
