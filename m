Received: from eggs.gnu.org ([2001:4830:134:3::10]:41360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3G-0005jY-V3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3F-0003R0-NF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:42654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVH3F-0003Lp-CV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:33 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:16 +0800
Message-Id: <1499863221-16206-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v12 3/8] Introduce xbitmap
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

From: Matthew Wilcox <mawilcox@microsoft.com>

The eXtensible Bitmap is a sparse bitmap representation which is
efficient for set bits which tend to cluster.  It supports up to
'unsigned long' worth of bits, and this commit adds the bare bones --
xb_set_bit(), xb_clear_bit() and xb_test_bit().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 include/linux/radix-tree.h |   2 +
 include/linux/xbitmap.h    |  49 ++++++++++++++++
 lib/radix-tree.c           | 138 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/xbitmap.h

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 3e57350..428ccc9 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -317,6 +317,8 @@ void radix_tree_iter_delete(struct radix_tree_root *,
 			struct radix_tree_iter *iter, void __rcu **slot);
 void *radix_tree_delete_item(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
+bool __radix_tree_delete(struct radix_tree_root *root,
+			 struct radix_tree_node *node, void __rcu **slot);
 void radix_tree_clear_tags(struct radix_tree_root *, struct radix_tree_node *,
 			   void __rcu **slot);
 unsigned int radix_tree_gang_lookup(const struct radix_tree_root *,
diff --git a/include/linux/xbitmap.h b/include/linux/xbitmap.h
new file mode 100644
index 0000000..0b93a46
--- /dev/null
+++ b/include/linux/xbitmap.h
@@ -0,0 +1,49 @@
+/*
+ * eXtensible Bitmaps
+ * Copyright (c) 2017 Microsoft Corporation <mawilcox@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * eXtensible Bitmaps provide an unlimited-size sparse bitmap facility.
+ * All bits are initially zero.
+ */
+
+#include <linux/idr.h>
+
+struct xb {
+	struct radix_tree_root xbrt;
+};
+
+#define XB_INIT {							\
+	.xbrt = RADIX_TREE_INIT(IDR_RT_MARKER | GFP_NOWAIT),		\
+}
+#define DEFINE_XB(name)		struct xb name = XB_INIT
+
+static inline void xb_init(struct xb *xb)
+{
+	INIT_RADIX_TREE(&xb->xbrt, IDR_RT_MARKER | GFP_NOWAIT);
+}
+
+int xb_set_bit(struct xb *xb, unsigned long bit);
+bool xb_test_bit(const struct xb *xb, unsigned long bit);
+int xb_clear_bit(struct xb *xb, unsigned long bit);
+
+static inline bool xb_empty(const struct xb *xb)
+{
+	return radix_tree_empty(&xb->xbrt);
+}
+
+void xb_preload(gfp_t gfp);
+
+static inline void xb_preload_end(void)
+{
+	preempt_enable();
+}
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 898e879..d624914 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/xbitmap.h>
 
 
 /* Number of nodes in fully populated tree of given height */
@@ -78,6 +79,14 @@ static struct kmem_cache *radix_tree_node_cachep;
 #define IDA_PRELOAD_SIZE	(IDA_MAX_PATH * 2 - 1)
 
 /*
+ * The XB can go up to unsigned long, but also uses a bitmap.
+ */
+#define XB_INDEX_BITS		(BITS_PER_LONG - ilog2(IDA_BITMAP_BITS))
+#define XB_MAX_PATH		(DIV_ROUND_UP(XB_INDEX_BITS, \
+					      RADIX_TREE_MAP_SHIFT))
+#define XB_PRELOAD_SIZE		(XB_MAX_PATH * 2 - 1)
+
+/*
  * Per-cpu pool of preloaded nodes
  */
 struct radix_tree_preload {
@@ -840,6 +849,8 @@ int __radix_tree_create(struct radix_tree_root *root, unsigned long index,
 							offset, 0, 0);
 			if (!child)
 				return -ENOMEM;
+			if (is_idr(root))
+				all_tag_set(child, IDR_FREE);
 			rcu_assign_pointer(*slot, node_to_entry(child));
 			if (node)
 				node->count++;
@@ -1986,8 +1997,8 @@ void __radix_tree_delete_node(struct radix_tree_root *root,
 	delete_node(root, node, update_node, private);
 }
 
-static bool __radix_tree_delete(struct radix_tree_root *root,
-				struct radix_tree_node *node, void __rcu **slot)
+bool __radix_tree_delete(struct radix_tree_root *root,
+			 struct radix_tree_node *node, void __rcu **slot)
 {
 	void *old = rcu_dereference_raw(*slot);
 	int exceptional = radix_tree_exceptional_entry(old) ? -1 : 0;
@@ -2137,6 +2148,129 @@ int ida_pre_get(struct ida *ida, gfp_t gfp)
 }
 EXPORT_SYMBOL(ida_pre_get);
 
+void xb_preload(gfp_t gfp)
+{
+	__radix_tree_preload(gfp, XB_PRELOAD_SIZE);
+	if (!this_cpu_read(ida_bitmap)) {
+		struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);
+
+		if (!bitmap)
+			return;
+		bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
+		kfree(bitmap);
+	}
+}
+EXPORT_SYMBOL(xb_preload);
+
+int xb_set_bit(struct xb *xb, unsigned long bit)
+{
+	int err;
+	unsigned long index = bit / IDA_BITMAP_BITS;
+	struct radix_tree_root *root = &xb->xbrt;
+	struct radix_tree_node *node;
+	void **slot;
+	struct ida_bitmap *bitmap;
+	unsigned long ebit;
+
+	bit %= IDA_BITMAP_BITS;
+	ebit = bit + 2;
+
+	err = __radix_tree_create(root, index, 0, &node, &slot);
+	if (err)
+		return err;
+	bitmap = rcu_dereference_raw(*slot);
+	if (radix_tree_exception(bitmap)) {
+		unsigned long tmp = (unsigned long)bitmap;
+
+		if (ebit < BITS_PER_LONG) {
+			tmp |= 1UL << ebit;
+			rcu_assign_pointer(*slot, (void *)tmp);
+			return 0;
+		}
+		bitmap = this_cpu_xchg(ida_bitmap, NULL);
+		if (!bitmap)
+			return -EAGAIN;
+		memset(bitmap, 0, sizeof(*bitmap));
+		bitmap->bitmap[0] = tmp >> RADIX_TREE_EXCEPTIONAL_SHIFT;
+		rcu_assign_pointer(*slot, bitmap);
+	}
+
+	if (!bitmap) {
+		if (ebit < BITS_PER_LONG) {
+			bitmap = (void *)((1UL << ebit) |
+					RADIX_TREE_EXCEPTIONAL_ENTRY);
+			__radix_tree_replace(root, node, slot, bitmap, NULL,
+						NULL);
+			return 0;
+		}
+		bitmap = this_cpu_xchg(ida_bitmap, NULL);
+		if (!bitmap)
+			return -EAGAIN;
+		memset(bitmap, 0, sizeof(*bitmap));
+		__radix_tree_replace(root, node, slot, bitmap, NULL, NULL);
+	}
+
+	__set_bit(bit, bitmap->bitmap);
+	return 0;
+}
+
+int xb_clear_bit(struct xb *xb, unsigned long bit)
+{
+	unsigned long index = bit / IDA_BITMAP_BITS;
+	struct radix_tree_root *root = &xb->xbrt;
+	struct radix_tree_node *node;
+	void **slot;
+	struct ida_bitmap *bitmap;
+	unsigned long ebit;
+
+	bit %= IDA_BITMAP_BITS;
+	ebit = bit + 2;
+
+	bitmap = __radix_tree_lookup(root, index, &node, &slot);
+	if (radix_tree_exception(bitmap)) {
+		unsigned long tmp = (unsigned long)bitmap;
+
+		if (ebit >= BITS_PER_LONG)
+			return 0;
+		tmp &= ~(1UL << ebit);
+		if (tmp == RADIX_TREE_EXCEPTIONAL_ENTRY)
+			__radix_tree_delete(root, node, slot);
+		else
+			rcu_assign_pointer(*slot, (void *)tmp);
+		return 0;
+	}
+
+	if (!bitmap)
+		return 0;
+
+	__clear_bit(bit, bitmap->bitmap);
+	if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
+		kfree(bitmap);
+		__radix_tree_delete(root, node, slot);
+	}
+
+	return 0;
+}
+
+bool xb_test_bit(const struct xb *xb, unsigned long bit)
+{
+	unsigned long index = bit / IDA_BITMAP_BITS;
+	const struct radix_tree_root *root = &xb->xbrt;
+	struct ida_bitmap *bitmap = radix_tree_lookup(root, index);
+
+	bit %= IDA_BITMAP_BITS;
+
+	if (!bitmap)
+		return false;
+	if (radix_tree_exception(bitmap)) {
+		bit += RADIX_TREE_EXCEPTIONAL_SHIFT;
+		if (bit > BITS_PER_LONG)
+			return false;
+		return (unsigned long)bitmap & (1UL << bit);
+	}
+	return test_bit(bit, bitmap->bitmap);
+}
+
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			struct radix_tree_iter *iter, gfp_t gfp, int end)
 {
-- 
2.7.4
