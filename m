Received: from eggs.gnu.org ([2001:4830:134:3::10]:33521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA3-0007Pj-Sz
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA1-0005b3-BD
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:55 -0500
Received: from mail.kernel.org ([198.145.29.136]:47874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA1-0005a5-57
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:53 -0500
Date: Tue, 10 Jan 2017 07:39:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-12-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/41] memory: handle alias for iommu notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

From: Jason Wang <jasowang@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
MST
