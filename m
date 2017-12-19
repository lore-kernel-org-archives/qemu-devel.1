Received: from eggs.gnu.org ([2001:4830:134:3::10]:49444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRH6g-0003Zk-GC
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRH6f-0000Fa-9A
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:34:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eRH6e-0000Bf-UO
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:34:49 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 19 Dec 2017 20:17:54 +0800
Message-Id: <1513685879-21823-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v20 2/7] xbitmap: potential improvement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

This patch made some changes to the original xbitmap implementation from
the linux-dax tree:

- xb_set_bit: delete the new inserted radix_tree_node when failing to
  get the per cpu ida bitmap, this avoids the kind of memory leak of the
  unused radix tree node left in the tree.

- xb_preload: with the original implementation, the CPU that successfully
  do __radix_tree_preload() may get into sleep by kmalloc(), which has a
  risk of getting the caller of xb_preload() scheduled to another CPU
  after waken up, and the new CPU may not have radix_tree_node
  pre-allocated there, this will be a problem when inserting a node to
  the tree later. This patch moves __radix_tree_preload() after kmalloc()
  and returns a boolean to indicate the success or failure. Also, add the
  __must_check annotation to xb_preload for prudence purpose.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/xbitmap.h |  2 +-
 lib/radix-tree.c        | 21 ++++++++++++++++++---
 lib/xbitmap.c           |  4 +++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/xbitmap.h b/include/linux/xbitmap.h
index 4ac2b8d..108f929 100644
--- a/include/linux/xbitmap.h
+++ b/include/linux/xbitmap.h
@@ -41,7 +41,7 @@ static inline bool xb_empty(const struct xb *xb)
 	return radix_tree_empty(&xb->xbrt);
 }
 
-void xb_preload(gfp_t);
+int xb_preload(gfp_t);
 
 static inline void xb_preload_end(void)
 {
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 2650e9e..f30347a 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2142,17 +2142,32 @@ int ida_pre_get(struct ida *ida, gfp_t gfp)
 }
 EXPORT_SYMBOL(ida_pre_get);
 
-void xb_preload(gfp_t gfp)
+/**
+ *  xb_preload - preload for xb_set_bit()
+ *  @gfp_mask: allocation mask to use for preloading
+ *
+ * Preallocate memory to use for the next call to xb_set_bit(). On success,
+ * return zero, with preemption disabled. On error, return -ENOMEM with
+ * preemption not disabled.
+ */
+__must_check int xb_preload(gfp_t gfp)
 {
-	__radix_tree_preload(gfp, XB_PRELOAD_SIZE);
 	if (!this_cpu_read(ida_bitmap)) {
 		struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);
 
 		if (!bitmap)
-			return;
+			return -ENOMEM;
+		/*
+		 * The per-CPU variable is updated with preemption enabled.
+		 * If the calling task is unlucky to be scheduled to another
+		 * CPU which has no ida_bitmap allocation, it will be detected
+		 * when setting a bit (i.e. xb_set_bit()).
+		 */
 		bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
 		kfree(bitmap);
 	}
+
+	return __radix_tree_preload(gfp, XB_PRELOAD_SIZE);
 }
 EXPORT_SYMBOL(xb_preload);
 
diff --git a/lib/xbitmap.c b/lib/xbitmap.c
index 236afa9..2dcfad5 100644
--- a/lib/xbitmap.c
+++ b/lib/xbitmap.c
@@ -29,8 +29,10 @@ int xb_set_bit(struct xb *xb, unsigned long bit)
 	bitmap = rcu_dereference_raw(*slot);
 	if (!bitmap) {
 		bitmap = this_cpu_xchg(ida_bitmap, NULL);
-		if (!bitmap)
+		if (!bitmap) {
+			__radix_tree_delete(root, node, slot);
 			return -EAGAIN;
+		}
 		memset(bitmap, 0, sizeof(*bitmap));
 		__radix_tree_replace(root, node, slot, bitmap, NULL);
 	}
-- 
2.7.4
