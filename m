Received: from eggs.gnu.org ([2001:4830:134:3::10]:54513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z4E-0005mx-1p
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z45-0002jF-5F
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1g9z44-0002iq-Sl
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:13 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue,  9 Oct 2018 22:56:49 +0200
Message-Id: <20181009205652.10605-5-david@redhat.com>
In-Reply-To: <20181009205652.10605-1-david@redhat.com>
References: <20181009205652.10605-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/7] range: add some more functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Add some more functions that will be used in memory-device context.

range_init(): Init using lower bound and size
range_valid(): Check if there would be an overflow when initializin
range_size(): Extract the size of a range
range_overlaps_range(): Check for overlaps of two ranges
range_contains_range(): Check if one range is contained in the other
range_starts_before_range(): Check if one range starts before another
range_ends_after_range(): Check if one range ends after another

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/range.h | 80 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 7e75f4e655..18e8acf22f 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -112,6 +112,86 @@ static inline uint64_t range_upb(Range *range)
     return range->upb;
 }
 
+/*
+ * Initialize @range to span the interval [@lob,@lob + @size - 1].
+ * @size may be 0.
+ */
+static inline void range_init(Range *range, uint64_t lob, uint64_t size)
+{
+    range->lob = lob;
+    range->upb = lob + size - 1;
+    range_invariant(range);
+}
+
+/*
+ * Check if the interval [@lob,@lob + @size - 1] would be valid or not
+ * (result in an overflow).
+ */
+static inline bool range_valid(uint64_t lob, uint64_t size)
+{
+    return lob + size >= lob;
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
+/*
+ * Check if @range1 starts before @range2. If one of the ranges is empty,
+ * the result is alsways "false".
+ */
+static inline bool range_starts_before_range(const Range *range1,
+                                             const Range *range2)
+{
+    if (range_is_empty(range1) || range_is_empty(range2)) {
+        return false;
+    }
+    return range1->lob < range2->lob;
+}
+
+/*
+ * Check if @range1 ends after @range2. If one of the ranges is empty,
+ * the result is alsways "false".
+ */
+static inline bool range_ends_after_range(const Range *range1,
+                                          const Range *range2)
+{
+    if (range_is_empty(range1) || range_is_empty(range2)) {
+        return false;
+    }
+    return range1->upb > range2->upb;
+}
+
 /*
  * Extend @range to the smallest interval that includes @extend_by, too.
  */
-- 
2.17.1
