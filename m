Received: from eggs.gnu.org ([2001:4830:134:3::10]:56331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWa6s-0001Az-5T
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWa6r-00072u-65
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWa6q-00072q-Tm
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:25 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 26 Jan 2017 10:48:14 +0800
Message-Id: <20170126024815.22841-2-famz@redhat.com>
In-Reply-To: <20170126024815.22841-1-famz@redhat.com>
References: <20170126024815.22841-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] hbitmap: Add hbitmap_is_serializable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Max Reitz <mreitz@redhat.com>

Bitmaps with a granularity of 58 or above can be neither serialized nor
deserialized (see the comment in the function added in this series for
an explanation). This patch adds a function so that we can check whether
a bitmap actually can be (de-)serialized at all, thus avoiding failing
the necessary assertion in hbitmap_serialization_granularity().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20161115225746.3590-2-mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/hbitmap.h | 13 +++++++++++++
 util/hbitmap.c         | 22 +++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index eb46475..9239fe5 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -146,6 +146,19 @@ void hbitmap_reset_all(HBitmap *hb);
 bool hbitmap_get(const HBitmap *hb, uint64_t item);
 
 /**
+ * hbitmap_is_serializable:
+ * @hb: HBitmap which should be (de-)serialized.
+ *
+ * Returns whether the bitmap can actually be (de-)serialized. Other
+ * (de-)serialization functions may only be invoked if this function returns
+ * true.
+ *
+ * Calling (de-)serialization functions does not affect a bitmap's
+ * (de-)serializability.
+ */
+bool hbitmap_is_serializable(const HBitmap *hb);
+
+/**
  * hbitmap_serialization_granularity:
  * @hb: HBitmap to operate on.
  *
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 9f691b7..35088e1 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -387,6 +387,24 @@ void hbitmap_reset_all(HBitmap *hb)
     hb->count = 0;
 }
 
+bool hbitmap_is_serializable(const HBitmap *hb)
+{
+    /* Every serialized chunk must be aligned to 64 bits so that endianness
+     * requirements can be fulfilled on both 64 bit and 32 bit hosts.
+     * We have hbitmap_serialization_granularity() which converts this
+     * alignment requirement from bitmap bits to items covered (e.g. sectors).
+     * That value is:
+     *    64 << hb->granularity
+     * Since this value must not exceed UINT64_MAX, hb->granularity must be
+     * less than 58 (== 64 - 6, where 6 is ld(64), i.e. 1 << 6 == 64).
+     *
+     * In order for hbitmap_serialization_granularity() to always return a
+     * meaningful value, bitmaps that are to be serialized must have a
+     * granularity of less than 58. */
+
+    return hb->granularity < 58;
+}
+
 bool hbitmap_get(const HBitmap *hb, uint64_t item)
 {
     /* Compute position and bit in the last layer.  */
@@ -399,9 +417,7 @@ bool hbitmap_get(const HBitmap *hb, uint64_t item)
 
 uint64_t hbitmap_serialization_granularity(const HBitmap *hb)
 {
-    /* Must hold true so that the shift below is defined
-     * (ld(64) == 6, i.e. 1 << 6 == 64) */
-    assert(hb->granularity < 64 - 6);
+    assert(hbitmap_is_serializable(hb));
 
     /* Require at least 64 bit granularity to be safe on both 64 bit and 32 bit
      * hosts. */
-- 
2.9.3
