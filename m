Received: from eggs.gnu.org ([2001:4830:134:3::10]:43713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSJ9-0006qT-K2
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSJ7-0005YB-P9
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:02:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:48 +0300
Message-ID: <1482503344-6424-6-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 05/21] hbitmap: improve dirty iter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

Make dirty iter resistant to resetting bits in corresponding HBitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/hbitmap.h | 24 ++----------------------
 util/hbitmap.c         | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index eb46475..2873a46 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -243,10 +243,7 @@ void hbitmap_free(HBitmap *hb);
  * the lowest-numbered bit that is set in @hb, starting at @first.
  *
  * Concurrent setting of bits is acceptable, and will at worst cause the
- * iteration to miss some of those bits.  Resetting bits before the current
- * position of the iterator is also okay.  However, concurrent resetting of
- * bits can lead to unexpected behavior if the iterator has not yet reached
- * those bits.
+ * iteration to miss some of those bits.  Resetting bits is also okay.
  */
 void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first);
 
@@ -285,24 +282,7 @@ void hbitmap_free_meta(HBitmap *hb);
  * Return the next bit that is set in @hbi's associated HBitmap,
  * or -1 if all remaining bits are zero.
  */
-static inline int64_t hbitmap_iter_next(HBitmapIter *hbi)
-{
-    unsigned long cur = hbi->cur[HBITMAP_LEVELS - 1];
-    int64_t item;
-
-    if (cur == 0) {
-        cur = hbitmap_iter_skip_words(hbi);
-        if (cur == 0) {
-            return -1;
-        }
-    }
-
-    /* The next call will resume work from the next bit.  */
-    hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
-    item = ((uint64_t)hbi->pos << BITS_PER_LEVEL) + ctzl(cur);
-
-    return item << hbi->granularity;
-}
+int64_t hbitmap_iter_next(HBitmapIter *hbi);
 
 /**
  * hbitmap_iter_next_word:
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 5d1a21c..48d8b2d 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -106,8 +106,9 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi)
 
     unsigned long cur;
     do {
-        cur = hbi->cur[--i];
+        i--;
         pos >>= BITS_PER_LEVEL;
+        cur = hbi->cur[i] & hb->levels[i][pos];
     } while (cur == 0);
 
     /* Check for end of iteration.  We always use fewer than BITS_PER_LONG
@@ -139,6 +140,26 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi)
     return cur;
 }
 
+int64_t hbitmap_iter_next(HBitmapIter *hbi)
+{
+    unsigned long cur = hbi->cur[HBITMAP_LEVELS - 1] &
+            hbi->hb->levels[HBITMAP_LEVELS - 1][hbi->pos];
+    int64_t item;
+
+    if (cur == 0) {
+        cur = hbitmap_iter_skip_words(hbi);
+        if (cur == 0) {
+            return -1;
+        }
+    }
+
+    /* The next call will resume work from the next bit.  */
+    hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
+    item = ((uint64_t)hbi->pos << BITS_PER_LEVEL) + ctzl(cur);
+
+    return item << hbi->granularity;
+}
+
 void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
 {
     unsigned i, bit;
-- 
1.8.3.1
