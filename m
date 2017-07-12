Received: from eggs.gnu.org ([2001:4830:134:3::10]:41388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3K-0005lv-5t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3J-0003S4-31
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:42654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVH3I-0003Lp-Ob
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:36 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:17 +0800
Message-Id: <1499863221-16206-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v12 4/8] xbitmap: add xb_find_next_bit() and
 xb_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

xb_find_next_bit() is added to support find the next "1" or "0" bit
in the given range. xb_zero() is added to support zero the given range
of bits.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 include/linux/xbitmap.h |  4 ++++
 lib/radix-tree.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/xbitmap.h b/include/linux/xbitmap.h
index 0b93a46..88c2045 100644
--- a/include/linux/xbitmap.h
+++ b/include/linux/xbitmap.h
@@ -36,6 +36,10 @@ int xb_set_bit(struct xb *xb, unsigned long bit);
 bool xb_test_bit(const struct xb *xb, unsigned long bit);
 int xb_clear_bit(struct xb *xb, unsigned long bit);
 
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end);
+unsigned long xb_find_next_bit(struct xb *xb, unsigned long start,
+			       unsigned long end, bool set);
+
 static inline bool xb_empty(const struct xb *xb)
 {
 	return radix_tree_empty(&xb->xbrt);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index d624914..c45b910 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2271,6 +2271,32 @@ bool xb_test_bit(const struct xb *xb, unsigned long bit)
 	return test_bit(bit, bitmap->bitmap);
 }
 
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+
+	for (i = start; i <= end; i++)
+		xb_clear_bit(xb, i);
+}
+
+/*
+ * Find the next one (@set = 1) or zero (@set = 0) bit within the bit range
+ * from @start to @end in @xb. If no such bit is found in the given range,
+ * bit end + 1 will be returned.
+ */
+unsigned long xb_find_next_bit(struct xb *xb, unsigned long start,
+			       unsigned long end, bool set)
+{
+	unsigned long i;
+
+	for (i = start; i <= end; i++) {
+		if (xb_test_bit(xb, i) == set)
+			break;
+	}
+
+	return i;
+}
+
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			struct radix_tree_iter *iter, gfp_t gfp, int end)
 {
-- 
2.7.4
