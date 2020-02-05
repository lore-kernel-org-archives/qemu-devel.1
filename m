Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A8AC352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06FC2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06FC2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIpY-0006eP-RZ
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIk5-0005Z5-74
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIk3-0001i4-7P
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:13 -0500
Received: from relay.sw.ru ([185.231.240.75]:41374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjs-00015Q-Ku; Wed, 05 Feb 2020 06:21:00 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjk-0006Jd-VZ; Wed, 05 Feb 2020 14:20:53 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 07/10] block/dirty-bitmap: improve _next_dirty_area API
Date: Wed,  5 Feb 2020 14:20:38 +0300
Message-Id: <20200205112041.6003-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205112041.6003-1-vsementsov@virtuozzo.com>
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Firstly, _next_dirty_area is for scenarios when we may contiguously
search for next dirty area inside some limited region, so it is more
comfortable to specify "end" which should not be recalculated on each
iteration.

Secondly, let's add a possibility to limit resulting area size, not
limiting searching area. This will be used in NBD code in further
commit. (Note that now bdrv_dirty_bitmap_next_dirty_area is unused)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/dirty-bitmap.h |  3 ++-
 include/qemu/hbitmap.h       | 25 +++++++++++---------
 block/dirty-bitmap.c         |  6 +++--
 tests/test-hbitmap.c         | 43 +++++++++++++++++++++++------------
 util/hbitmap.c               | 44 ++++++++++++++++++++++--------------
 5 files changed, 75 insertions(+), 46 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index b1f0de12db..8a10029418 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -110,7 +110,8 @@ int64_t bdrv_dirty_bitmap_next_dirty(BdrvDirtyBitmap *bitmap, int64_t offset,
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
                                     int64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
-                                       int64_t *offset, int64_t *bytes);
+        int64_t start, int64_t end, int64_t max_dirty_count,
+        int64_t *dirty_start, int64_t *dirty_count);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
 
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 6e9ae51ed3..5e71b6d6f7 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -324,18 +324,21 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count);
 
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
index 1b14c8eb26..063793e316 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -873,9 +873,11 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
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
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 8905b8a351..b6726cf76b 100644
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
index 883ca48fa6..305b894a63 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -270,22 +270,33 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count)
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
+    end = MIN(end, hb->orig_size);
+    if (start >= end) {
         return false;
     }
 
-    area_end = hbitmap_next_zero(hb, area_start, *start + *count - area_start);
-    if (area_end < 0) {
-        area_end = MIN(hb->orig_size, *start + *count);
+    start = hbitmap_next_dirty(hb, start, end - start);
+    if (start < 0) {
+        return false;
     }
 
-    *start = area_start;
-    *count = area_end - area_start;
+    end = start + MIN(end - start, max_dirty_count);
+
+    next_zero = hbitmap_next_zero(hb, start, end - start);
+    if (next_zero >= 0) {
+        end = next_zero;
+    }
+
+    *dirty_start = start;
+    *dirty_count = end - start;
 
     return true;
 }
@@ -841,16 +852,15 @@ bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
  */
 static void hbitmap_sparse_merge(HBitmap *dst, const HBitmap *src)
 {
-    int64_t offset = 0;
-    int64_t count = src->orig_size;
+    int64_t offset;
+    int64_t count;
 
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


