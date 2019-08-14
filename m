Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CBFC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795D92084F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795D92084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxuWP-0005JB-60
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 10:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUp-00043x-6r
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUn-0002Db-ML
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:49612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUi-0002AE-QL; Wed, 14 Aug 2019 10:43:20 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUe-0007hk-VF; Wed, 14 Aug 2019 17:43:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 14 Aug 2019 17:43:13 +0300
Message-Id: <20190814144315.89729-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190814144315.89729-1-vsementsov@virtuozzo.com>
References: <20190814144315.89729-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add _next_dirty API
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

We have bdrv_dirty_bitmap_next_zero, let's add corresponding
bdrv_dirty_bitmap_next_dirty, which is more comfortable to use than
bitmap iterators in some cases. It will be used in the following
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  2 ++
 include/qemu/hbitmap.h       | 13 ++++++++
 block/dirty-bitmap.c         |  6 ++++
 util/hbitmap.c               | 61 +++++++++++++++++++-----------------
 4 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 493c4566d3..d1310ee76e 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -108,6 +108,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
+int64_t bdrv_dirty_bitmap_next_dirty(BdrvDirtyBitmap *bitmap, int64_t offset,
+                                     int64_t bytes);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
                                     int64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 5149ac7721..80ecabe8e2 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -299,6 +299,19 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first);
  */
 unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
 
+/*
+ * hbitmap_next_dirty:
+ *
+ * Find next dirty bit within selected range. If not found, return -1.
+ *
+ * @hb: The HBitmap to operate on
+ * @start: The bit to start from.
+ * @count: Number of bits to proceed. If @start+@count > bitmap size, the whole
+ * bitmap is looked through. You can use UINT64_MAX as @count to search up to
+ * the bitmap end.
+ */
+int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t count);
+
 /* hbitmap_next_zero:
  *
  * Find next not dirty bit within selected range. If not found, return -1.
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index eeccdb48f5..efe3a39d49 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -802,6 +802,12 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
     return hbitmap_sha256(bitmap->bitmap, errp);
 }
 
+int64_t bdrv_dirty_bitmap_next_dirty(BdrvDirtyBitmap *bitmap, int64_t offset,
+                                     int64_t bytes)
+{
+    return hbitmap_next_zero(bitmap->bitmap, offset, bytes);
+}
+
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offset,
                                     int64_t bytes)
 {
diff --git a/util/hbitmap.c b/util/hbitmap.c
index c08751fb50..3f2d7451ce 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -193,6 +193,30 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
     }
 }
 
+int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t count)
+{
+    HBitmapIter hbi;
+    int64_t firt_dirty_off;
+    uint64_t end;
+
+    assert(start >= 0 && count >= 0);
+
+    if (start >= hb->orig_size || count == 0) {
+        return -1;
+    }
+
+    end = count > hb->orig_size - start ? hb->orig_size : start + count;
+
+    hbitmap_iter_init(&hbi, hb, start);
+    firt_dirty_off = hbitmap_iter_next(&hbi);
+
+    if (firt_dirty_off < 0 || firt_dirty_off >= end) {
+        return -1;
+    }
+
+    return MAX(start, firt_dirty_off);
+}
+
 int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count)
 {
     size_t pos = (start >> hb->granularity) >> BITS_PER_LEVEL;
@@ -248,40 +272,21 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count)
 
 bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *count)
 {
-    HBitmapIter hbi;
-    int64_t firt_dirty_off, area_end;
-    uint32_t granularity = 1UL << hb->granularity;
-    uint64_t end;
-
-    assert(*start >= 0 && *count >= 0);
-
-    if (*start >= hb->orig_size || *count == 0) {
-        return false;
-    }
-
-    end = *count > hb->orig_size - *start ? hb->orig_size : *start + *count;
-
-    hbitmap_iter_init(&hbi, hb, *start);
-    firt_dirty_off = hbitmap_iter_next(&hbi);
+    int64_t area_start, area_end;
 
-    if (firt_dirty_off < 0 || firt_dirty_off >= end) {
+    area_start = hbitmap_next_dirty(hb, *start, *count);
+    if (area_start < 0) {
         return false;
     }
 
-    if (firt_dirty_off + granularity >= end) {
-        area_end = end;
-    } else {
-        area_end = hbitmap_next_zero(hb, firt_dirty_off + granularity,
-                                     end - firt_dirty_off - granularity);
-        if (area_end < 0) {
-            area_end = end;
-        }
+    area_end = QEMU_ALIGN_UP(area_start + 1, 1UL << hb->granularity);
+    area_end = hbitmap_next_zero(hb, area_end, *start + *count - area_end);
+    if (area_end < 0) {
+        area_end = MIN(hb->orig_size, *start + *count);
     }
 
-    if (firt_dirty_off > *start) {
-        *start = firt_dirty_off;
-    }
-    *count = area_end - *start;
+    *start = area_start;
+    *count = area_end - area_start;
 
     return true;
 }
-- 
2.18.0


