Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9FEC388F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365A2215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365A2215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExb4-00052z-TF
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iExOM-0004eN-WC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iExOK-0005xM-FF
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:15:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:46682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iExOF-0005ox-86; Mon, 30 Sep 2019 11:15:07 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iExOC-0005tD-6x; Mon, 30 Sep 2019 18:15:04 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 07/10] block/dirty-bitmap: improve _next_dirty_area API
Date: Mon, 30 Sep 2019 18:14:59 +0300
Message-Id: <20190930151502.7829-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930151502.7829-1-vsementsov@virtuozzo.com>
References: <20190930151502.7829-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Firstly, _next_dirty_area is for scenarios when we may contiguously
search for next dirty area inside some limited region, so it is more
comfortable to specify "end" which should not be recalculated on each
iteration.

Secondly, mirror wants to limit resulting are, and for this thing it
limits @count. But actually mirror don't want to limit the whole region
to search, but only resulting sub-region. Add separate parameter
@max_dirty_count to satisfy such request.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  3 ++-
 include/qemu/hbitmap.h       | 25 ++++++++++++---------
 block/dirty-bitmap.c         |  6 +++--
 block/mirror.c               | 11 +++++----
 tests/test-hbitmap.c         | 43 +++++++++++++++++++++++-------------
 util/hbitmap.c               | 41 +++++++++++++++++++++-------------
 6 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 333e44e793..a010110709 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -108,7 +108,8 @@ int64_t bdrv_dirty_bitmap_next_dirty(BdrvDirtyBitmap *bitmap, int64_t offset,
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
                                     int64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
-                                       int64_t *offset, int64_t *bytes);
+        int64_t start, int64_t end, int64_t max_dirty_count,
+        int64_t *dirty_start, int64_t *dirty_count);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
 
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index eeecd33f01..99dfcbd9e5 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -331,18 +331,21 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count);
 
 /* hbitmap_next_dirty_area:
  * @hb: The HBitmap to operate on
- * @start: in-out parameter.
- *         in: the offset to start from
- *         out: (if area found) start of found area
- * @count: in-out parameter.
- *         in: length of requested region
- *         out: length of found area
- *
- * If dirty area found within [@start, @start + @count), returns true and sets
- * @offset and @bytes appropriately. Otherwise returns false and leaves @offset
- * and @bytes unchanged.
+ * @start: the offset to start from
+ * @end: end of requested area
+ * @max_dirty_count: limit for out parameter dirty_count
+ * @dirty_start: on success: start of found area
+ * @dirty_count: on success: length of found area
+ *
+ * If dirty area found within [@start, @end), returns true and sets
+ * @dirty_start and @dirty_count appropriately. @dirty_count will not exceed
+ * @max_dirty_count.
+ * If dirty area was not found, returns false and leaves @dirty_start and
+ * @dirty_count unchanged.
  */
-bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *count);
+bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t start, int64_t end,
+                             int64_t max_dirty_count,
+                             int64_t *dirty_start, int64_t *dirty_count);
 
 /**
  * hbitmap_iter_next:
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index fe2420b297..f1b552b7a2 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -867,9 +867,11 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
 }
 
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
-                                       int64_t *offset, int64_t *bytes)
+        int64_t start, int64_t end, int64_t max_dirty_count,
+        int64_t *dirty_start, int64_t *dirty_count)
 {
-    return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
+    return hbitmap_next_dirty_area(bitmap->bitmap, start, end, max_dirty_count,
+                                   dirty_start, dirty_count);
 }
 
 /**
diff --git a/block/mirror.c b/block/mirror.c
index d6b3a898ed..c8947a5726 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1190,15 +1190,14 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
     }
 
     while (true) {
-        bool valid_area;
+        bool found;
         int ret;
 
         bdrv_dirty_bitmap_lock(job->dirty_bitmap);
-        dirty_bytes = MIN(offset + bytes - dirty_offset, INT_MAX);
-        valid_area = bdrv_dirty_bitmap_next_dirty_area(job->dirty_bitmap,
-                                                       &dirty_offset,
-                                                       &dirty_bytes);
-        if (!valid_area) {
+        found = bdrv_dirty_bitmap_next_dirty_area(job->dirty_bitmap,
+                dirty_offset, offset + bytes, INT_MAX,
+                &dirty_offset, &dirty_bytes);
+        if (!found) {
             bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
             break;
         }
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index e3f1b3f361..d75e84a76a 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -920,18 +920,19 @@ static void test_hbitmap_next_x_after_truncate(TestHBitmapData *data,
     test_hbitmap_next_x_check(data, 0);
 }
 
-static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
-                                               int64_t offset,
-                                               int64_t count)
+static void test_hbitmap_next_dirty_area_check_limited(TestHBitmapData *data,
+                                                       int64_t offset,
+                                                       int64_t count,
+                                                       int64_t max_dirty)
 {
     int64_t off1, off2;
     int64_t len1 = 0, len2;
     bool ret1, ret2;
     int64_t end;
 
-    off1 = offset;
-    len1 = count;
-    ret1 = hbitmap_next_dirty_area(data->hb, &off1, &len1);
+    ret1 = hbitmap_next_dirty_area(data->hb,
+            offset, count == INT64_MAX ? INT64_MAX : offset + count, max_dirty,
+            &off1, &len1);
 
     end = offset > data->size || data->size - offset < count ? data->size :
                                                                offset + count;
@@ -940,21 +941,25 @@ static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
         ;
     }
 
-    for (len2 = 1; off2 + len2 < end && hbitmap_get(data->hb, off2 + len2);
-         len2++) {
+    for (len2 = 1; (off2 + len2 < end && len2 < max_dirty &&
+                    hbitmap_get(data->hb, off2 + len2)); len2++)
+    {
         ;
     }
 
     ret2 = off2 < end;
-    if (!ret2) {
-        /* leave unchanged */
-        off2 = offset;
-        len2 = count;
+    g_assert_cmpint(ret1, ==, ret2);
+
+    if (ret2) {
+        g_assert_cmpint(off1, ==, off2);
+        g_assert_cmpint(len1, ==, len2);
     }
+}
 
-    g_assert_cmpint(ret1, ==, ret2);
-    g_assert_cmpint(off1, ==, off2);
-    g_assert_cmpint(len1, ==, len2);
+static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
+                                               int64_t offset, int64_t count)
+{
+    test_hbitmap_next_dirty_area_check_limited(data, offset, count, INT64_MAX);
 }
 
 static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
@@ -964,6 +969,7 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, 0, 1);
     test_hbitmap_next_dirty_area_check(data, L3 - 1, 1);
+    test_hbitmap_next_dirty_area_check_limited(data, 0, INT64_MAX, 1);
 
     hbitmap_set(data->hb, L2, 1);
     test_hbitmap_next_dirty_area_check(data, 0, 1);
@@ -976,6 +982,8 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
     test_hbitmap_next_dirty_area_check(data, L2, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, L2, 1);
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 1);
+    test_hbitmap_next_dirty_area_check_limited(data, 0, INT64_MAX, 1);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 - 1, 2, 1);
 
     hbitmap_set(data->hb, L2 + 5, L1);
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
@@ -988,6 +996,8 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
     test_hbitmap_next_dirty_area_check(data, L2 + L1, L1);
     test_hbitmap_next_dirty_area_check(data, L2, 0);
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 0);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 + 3, INT64_MAX, 3);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 + 3, 7, 10);
 
     hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
@@ -997,6 +1007,9 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
     test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1, 5);
     test_hbitmap_next_dirty_area_check(data, L2 * 2 - L1, L1 + 1);
     test_hbitmap_next_dirty_area_check(data, L2 * 2, L2);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 * 2 + 1, INT64_MAX, 5);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 * 2 + 1, 10, 5);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 * 2 + 1, 2, 5);
 
     hbitmap_set(data->hb, 0, L3);
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
diff --git a/util/hbitmap.c b/util/hbitmap.c
index c089020ca3..77a2d48e7d 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -270,22 +270,34 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count)
     return res;
 }
 
-bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *count)
+bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t start, int64_t end,
+                             int64_t max_dirty_count,
+                             int64_t *dirty_start, int64_t *dirty_count)
 {
-    int64_t area_start, area_end;
+    int64_t next_zero;
 
-    area_start = hbitmap_next_dirty(hb, *start, *count);
-    if (area_start < 0) {
+    assert(start >= 0 && end >= 0 && max_dirty_count > 0);
+
+    if (start >= hb->orig_size || end <= start) {
+        return false;
+    }
+
+    end = MIN(end, hb->orig_size);
+
+    start = hbitmap_next_dirty(hb, start, end - start);
+    if (start < 0) {
         return false;
     }
 
-    area_end = hbitmap_next_zero(hb, area_start, *start + *count - area_start);
-    if (area_end < 0) {
-        area_end = MIN(hb->orig_size, *start + *count);
+    end = start + MIN(end - start, max_dirty_count);
+
+    next_zero = hbitmap_next_zero(hb, start, end - start);
+    if (next_zero >= 0) {
+        end = next_zero;
     }
 
-    *start = area_start;
-    *count = area_end - area_start;
+    *dirty_start = start;
+    *dirty_count = end - start;
 
     return true;
 }
@@ -836,13 +848,12 @@ static void hbitmap_sparse_merge(HBitmap *dst, const HBitmap *src)
     int64_t offset = 0;
     int64_t count = src->orig_size;
 
-    while (hbitmap_next_dirty_area(src, &offset, &count)) {
+    for (offset = 0;
+         hbitmap_next_dirty_area(src, offset, src->orig_size, INT64_MAX,
+                                 &offset, &count);
+         offset += count)
+    {
         hbitmap_set(dst, offset, count);
-        offset += count;
-        if (offset >= src->orig_size) {
-            break;
-        }
-        count = src->orig_size - offset;
     }
 }
 
-- 
2.21.0


