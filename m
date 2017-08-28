Received: from eggs.gnu.org ([2001:4830:134:3::10]:57813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dmH9k-0001xb-MW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dmH9j-0005zu-L9
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:20:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:17236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dmH9j-0005ys-CR
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:20:31 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 28 Aug 2017 18:08:30 +0800
Message-Id: <1503914913-28893-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v15 2/5] lib/xbitmap: add xb_find_next_bit()
 and xb_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

xb_find_next_bit() is used to find the next "1" or "0" bit in the
given range. xb_zero() is used to zero the given range of bits.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/xbitmap.h |  3 +++
 lib/xbitmap.c           | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/xbitmap.h b/include/linux/xbitmap.h
index 25b05ff..0061f7a 100644
--- a/include/linux/xbitmap.h
+++ b/include/linux/xbitmap.h
@@ -38,6 +38,9 @@ static inline void xb_init(struct xb *xb)
 int xb_set_bit(struct xb *xb, unsigned long bit);
 bool xb_test_bit(struct xb *xb, unsigned long bit);
 void xb_clear_bit(struct xb *xb, unsigned long bit);
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end);
+unsigned long xb_find_next_bit(struct xb *xb, unsigned long start,
+			       unsigned long end, bool set);
 
 /* Check if the xb tree is empty */
 static inline bool xb_is_empty(const struct xb *xb)
diff --git a/lib/xbitmap.c b/lib/xbitmap.c
index 8c55296..b9e2a0c 100644
--- a/lib/xbitmap.c
+++ b/lib/xbitmap.c
@@ -174,3 +174,42 @@ void xb_preload(gfp_t gfp)
 	}
 }
 EXPORT_SYMBOL(xb_preload);
+
+/**
+ *  xb_zero - zero a range of bits in the xbitmap
+ *  @xb: the xbitmap that the bits reside in
+ *  @start: the start of the range, inclusive
+ *  @end: the end of the range, inclusive
+ */
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+
+	for (i = start; i <= end; i++)
+		xb_clear_bit(xb, i);
+}
+EXPORT_SYMBOL(xb_zero);
+
+/**
+ * xb_find_next_bit - find next 1 or 0 in the give range of bits
+ * @xb: the xbitmap that the bits reside in
+ * @start: the start of the range, inclusive
+ * @end: the end of the range, inclusive
+ * @set: the polarity (1 or 0) of the next bit to find
+ *
+ * Return the index of the found bit in the xbitmap. If the returned index
+ * exceeds @end, it indicates that no such bit is found in the given range.
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
+EXPORT_SYMBOL(xb_find_next_bit);
-- 
2.7.4
