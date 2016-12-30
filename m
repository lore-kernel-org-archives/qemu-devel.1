Received: from eggs.gnu.org ([2001:4830:134:3::10]:51049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8l-0001SN-DU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8j-0005ls-Iu
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cMu8j-0005lM-Cd
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:21 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2016 18:09:17 +0800
Message-Id: <1483092559-24488-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 08/10] memory: handle alias for iommu
 notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, Jason Wang <jasowang@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
