Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A93DC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405172084F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405172084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxubI-0000aP-G4
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 10:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUq-00045D-1k
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUo-0002E1-B0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:49614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUi-0002AG-NH; Wed, 14 Aug 2019 10:43:20 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUe-0007hk-F4; Wed, 14 Aug 2019 17:43:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 14 Aug 2019 17:43:12 +0300
Message-Id: <20190814144315.89729-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190814144315.89729-1-vsementsov@virtuozzo.com>
References: <20190814144315.89729-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/4] block/dirty-bitmap: switch
 _next_dirty_area and _next_zero to int64_t
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's very uncomfortable that we can't use same variable as result of
bdrv_dirty_bitmap_next_zero and parameter of
bdrv_dirty_bitmap_next_dirty_area.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  6 +++---
 include/qemu/hbitmap.h       |  5 ++---
 block/dirty-bitmap.c         |  6 +++---
 block/mirror.c               |  4 ++--
 tests/test-hbitmap.c         | 32 ++++++++++++++++----------------
 util/hbitmap.c               | 15 ++++++++++-----
 6 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 4b4b731b46..493c4566d3 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -108,10 +108,10 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
-int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
-                                    uint64_t bytes);
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
+                                    int64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
-                                       uint64_t *offset, uint64_t *bytes);
+                                       int64_t *offset, int64_t *bytes);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 4afbe6292e..5149ac7721 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -309,7 +309,7 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
  * bitmap is looked through. You can use UINT64_MAX as @count to search up to
  * the bitmap end.
  */
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count);
+int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count);
 
 /* hbitmap_next_dirty_area:
  * @hb: The HBitmap to operate on
@@ -324,8 +324,7 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count);
  * @offset and @bytes appropriately. Otherwise returns false and leaves @offset
  * and @bytes unchanged.
  */
-bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *start,
-                             uint64_t *count);
+bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *count);
 
 /* hbitmap_create_meta:
  * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 134e0c9a0c..eeccdb48f5 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -802,14 +802,14 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
     return hbitmap_sha256(bitmap->bitmap, errp);
 }
 
-int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
-                                    uint64_t bytes)
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
+                                    int64_t bytes)
 {
     return hbitmap_next_zero(bitmap->bitmap, offset, bytes);
 }
 
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
-                                       uint64_t *offset, uint64_t *bytes)
+                                       int64_t *offset, int64_t *bytes)
 {
     return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
 }
diff --git a/block/mirror.c b/block/mirror.c
index 56937ebe92..0d3b078f44 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1198,8 +1198,8 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
                      QEMUIOVector *qiov, int flags)
 {
     QEMUIOVector target_qiov;
-    uint64_t dirty_offset = offset;
-    uint64_t dirty_bytes;
+    int64_t dirty_offset = offset;
+    int64_t dirty_bytes;
 
     if (qiov) {
         qemu_iovec_init(&target_qiov, qiov->niov);
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index eed5d288cb..462a6c3f74 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -946,7 +946,7 @@ static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
 
 static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
 {
-    test_hbitmap_next_zero_check_range(data, start, UINT64_MAX);
+    test_hbitmap_next_zero_check_range(data, start, INT64_MAX);
 }
 
 static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
@@ -1014,11 +1014,11 @@ static void test_hbitmap_next_zero_after_truncate(TestHBitmapData *data,
 }
 
 static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
-                                               uint64_t offset,
-                                               uint64_t count)
+                                               int64_t offset,
+                                               int64_t count)
 {
-    uint64_t off1, off2;
-    uint64_t len1 = 0, len2;
+    int64_t off1, off2;
+    int64_t len1 = 0, len2;
     bool ret1, ret2;
     int64_t end;
 
@@ -1054,24 +1054,24 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
                                             int granularity)
 {
     hbitmap_test_init(data, L3, granularity);
-    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, 0, 1);
     test_hbitmap_next_dirty_area_check(data, L3 - 1, 1);
 
     hbitmap_set(data->hb, L2, 1);
     test_hbitmap_next_dirty_area_check(data, 0, 1);
     test_hbitmap_next_dirty_area_check(data, 0, L2);
-    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
-    test_hbitmap_next_dirty_area_check(data, L2 - 1, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, L2 - 1, 1);
     test_hbitmap_next_dirty_area_check(data, L2 - 1, 2);
     test_hbitmap_next_dirty_area_check(data, L2 - 1, 3);
-    test_hbitmap_next_dirty_area_check(data, L2, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, L2, 1);
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 1);
 
     hbitmap_set(data->hb, L2 + 5, L1);
-    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, L2 - 2, 8);
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 5);
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 3);
@@ -1083,16 +1083,16 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 0);
 
     hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
-    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
-    test_hbitmap_next_dirty_area_check(data, L2, UINT64_MAX);
-    test_hbitmap_next_dirty_area_check(data, L2 + 1, UINT64_MAX);
-    test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1 - 1, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2, INT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, INT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1 - 1, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1, 5);
     test_hbitmap_next_dirty_area_check(data, L2 * 2 - L1, L1 + 1);
     test_hbitmap_next_dirty_area_check(data, L2 * 2, L2);
 
     hbitmap_set(data->hb, 0, L3);
-    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
 }
 
 static void test_hbitmap_next_dirty_area_0(TestHBitmapData *data,
@@ -1119,7 +1119,7 @@ static void test_hbitmap_next_dirty_area_after_truncate(TestHBitmapData *data,
     hbitmap_test_init(data, L1, 0);
     hbitmap_test_truncate_impl(data, L1 * 2);
     hbitmap_set(data->hb, L1 + 1, 1);
-    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
 }
 
 int main(int argc, char **argv)
diff --git a/util/hbitmap.c b/util/hbitmap.c
index fd44c897ab..c08751fb50 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -193,7 +193,7 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
     }
 }
 
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count)
+int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count)
 {
     size_t pos = (start >> hb->granularity) >> BITS_PER_LEVEL;
     unsigned long *last_lev = hb->levels[HBITMAP_LEVELS - 1];
@@ -202,6 +202,8 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count)
     uint64_t end_bit, sz;
     int64_t res;
 
+    assert(start >= 0 && count >= 0);
+
     if (start >= hb->orig_size || count == 0) {
         return -1;
     }
@@ -244,14 +246,15 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count)
     return res;
 }
 
-bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *start,
-                             uint64_t *count)
+bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *count)
 {
     HBitmapIter hbi;
     int64_t firt_dirty_off, area_end;
     uint32_t granularity = 1UL << hb->granularity;
     uint64_t end;
 
+    assert(*start >= 0 && *count >= 0);
+
     if (*start >= hb->orig_size || *count == 0) {
         return false;
     }
@@ -704,6 +707,7 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
     HBitmap *hb = g_new0(struct HBitmap, 1);
     unsigned i;
 
+    assert(size <= INT64_MAX);
     hb->orig_size = size;
 
     assert(granularity >= 0 && granularity < 64);
@@ -734,6 +738,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
     uint64_t num_elements = size;
     uint64_t old;
 
+    assert(size <= INT64_MAX);
     hb->orig_size = size;
 
     /* Size comes in as logical elements, adjust for granularity. */
@@ -791,8 +796,8 @@ bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
  */
 static void hbitmap_sparse_merge(HBitmap *dst, const HBitmap *src)
 {
-    uint64_t offset = 0;
-    uint64_t count = src->orig_size;
+    int64_t offset = 0;
+    int64_t count = src->orig_size;
 
     while (hbitmap_next_dirty_area(src, &offset, &count)) {
         hbitmap_set(dst, offset, count);
-- 
2.18.0


