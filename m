Received: from eggs.gnu.org ([2001:4830:134:3::10]:60286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj5-0006Q9-0w
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj1-00030G-Qo
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:42 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:27042 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj1-0002wn-FR
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:03 +0300
Message-Id: <20170628120530.31251-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 03/30] hbitmap: improve dirty iter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Make dirty iter resistant to resetting bits in corresponding HBitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/qemu/hbitmap.h | 26 ++++----------------------
 util/hbitmap.c         | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 9239fe515e..6b04391266 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -256,10 +256,9 @@ void hbitmap_free(HBitmap *hb);
  * the lowest-numbered bit that is set in @hb, starting at @first.
  *
  * Concurrent setting of bits is acceptable, and will at worst cause the
- * iteration to miss some of those bits.  Resetting bits before the current
- * position of the iterator is also okay.  However, concurrent resetting of
- * bits can lead to unexpected behavior if the iterator has not yet reached
- * those bits.
+ * iteration to miss some of those bits.
+ *
+ * The concurrent resetting of bits is OK.
  */
 void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first);
 
@@ -298,24 +297,7 @@ void hbitmap_free_meta(HBitmap *hb);
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
index 35088e19c4..0b38817505 100644
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
2.11.1
