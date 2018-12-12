Received: from eggs.gnu.org ([2001:4830:134:3::10]:35386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0ol-0004F9-Gu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0ok-0002J5-3h
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:28:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gX0og-0002Fo-8u
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:28:31 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:28:20 +0100
Message-Id: <20181212092821.18260-2-david@redhat.com>
In-Reply-To: <20181212092821.18260-1-david@redhat.com>
References: <20181212092821.18260-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/2] range: add some more functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Add some more functions that will be used in memory-device context.

range_init(): Init using lower bound and size, check for validity
range_init_nofail(): Init using lower bound and size, validity asserted
range_size(): Extract the size of a range
range_overlaps_range(): Check for overlaps of two ranges
range_contains_range(): Check if one range is contained in the other

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/range.h | 62 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 7e75f4e655..ba606c6bc0 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -112,6 +112,68 @@ static inline uint64_t range_upb(Range *range)
     return range->upb;
 }
 
+/*
+ * Initialize @range to span the interval [@lob,@lob + @size - 1].
+ * @size may be 0. If the range would overflow, returns -ERANGE, otherwise
+ * 0.
+ */
+static inline int QEMU_WARN_UNUSED_RESULT range_init(Range *range, uint64_t lob,
+                                                     uint64_t size)
+{
+    if (lob + size < lob) {
+        return -ERANGE;
+    }
+    range->lob = lob;
+    range->upb = lob + size - 1;
+    range_invariant(range);
+    return 0;
+}
+
+/*
+ * Initialize @range to span the interval [@lob,@lob + @size - 1].
+ * @size may be 0. Range must not overflow.
+ */
+static inline void range_init_nofail(Range *range, uint64_t lob, uint64_t size)
+{
+    range->lob = lob;
+    range->upb = lob + size - 1;
+    range_invariant(range);
+}
+
+/*
+ * Get the size of @range.
+ */
+static inline uint64_t range_size(const Range *range)
+{
+    return range->upb - range->lob + 1;
+}
+
+/*
+ * Check if @range1 overlaps with @range2. If one of the ranges is empty,
+ * the result is always "false".
+ */
+static inline bool range_overlaps_range(const Range *range1,
+                                        const Range *range2)
+{
+    if (range_is_empty(range1) || range_is_empty(range2)) {
+        return false;
+    }
+    return !(range2->upb < range1->lob || range1->upb < range2->lob);
+}
+
+/*
+ * Check if @range1 contains @range2. If one of the ranges is empty,
+ * the result is always "false".
+ */
+static inline bool range_contains_range(const Range *range1,
+                                        const Range *range2)
+{
+    if (range_is_empty(range1) || range_is_empty(range2)) {
+        return false;
+    }
+    return range1->lob <= range2->lob && range1->upb >= range2->upb;
+}
+
 /*
  * Extend @range to the smallest interval that includes @extend_by, too.
  */
-- 
2.17.2
