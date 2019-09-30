Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2BC35280
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD7221855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD7221855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExYP-0002DS-CZ
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iExOL-0004bp-Jv
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iExOJ-0005wS-OG
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:15:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:46676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iExOF-0005or-9A; Mon, 30 Sep 2019 11:15:07 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iExOB-0005tD-Mp; Mon, 30 Sep 2019 18:15:03 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 04/10] hbitmap: drop meta bitmaps as they are unused
Date: Mon, 30 Sep 2019 18:14:56 +0300
Message-Id: <20190930151502.7829-5-vsementsov@virtuozzo.com>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/hbitmap.h |  21 --------
 tests/test-hbitmap.c   | 115 -----------------------------------------
 util/hbitmap.c         |  16 ------
 3 files changed, 152 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index ba2cdaeaa0..cf3dbf8b39 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -332,27 +332,6 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count);
 bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *start,
                              uint64_t *count);
 
-/* hbitmap_create_meta:
- * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
- * The caller owns the created bitmap and must call hbitmap_free_meta(hb) to
- * free it.
- *
- * Currently, we only guarantee that if a bit in the hbitmap is changed it
- * will be reflected in the meta bitmap, but we do not yet guarantee the
- * opposite.
- *
- * @hb: The HBitmap to operate on.
- * @chunk_size: How many bits in @hb does one bit in the meta track.
- */
-HBitmap *hbitmap_create_meta(HBitmap *hb, int chunk_size);
-
-/* hbitmap_free_meta:
- * Free the meta bitmap of @hb.
- *
- * @hb: The HBitmap whose meta bitmap should be freed.
- */
-void hbitmap_free_meta(HBitmap *hb);
-
 /**
  * hbitmap_iter_next:
  * @hbi: HBitmapIter to operate on.
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index e1f867085f..aeaa0b3f22 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -22,7 +22,6 @@
 
 typedef struct TestHBitmapData {
     HBitmap       *hb;
-    HBitmap       *meta;
     unsigned long *bits;
     size_t         size;
     size_t         old_size;
@@ -94,14 +93,6 @@ static void hbitmap_test_init(TestHBitmapData *data,
     }
 }
 
-static void hbitmap_test_init_meta(TestHBitmapData *data,
-                                   uint64_t size, int granularity,
-                                   int meta_chunk)
-{
-    hbitmap_test_init(data, size, granularity);
-    data->meta = hbitmap_create_meta(data->hb, meta_chunk);
-}
-
 static inline size_t hbitmap_test_array_size(size_t bits)
 {
     size_t n = DIV_ROUND_UP(bits, BITS_PER_LONG);
@@ -144,9 +135,6 @@ static void hbitmap_test_teardown(TestHBitmapData *data,
                                   const void *unused)
 {
     if (data->hb) {
-        if (data->meta) {
-            hbitmap_free_meta(data->hb);
-        }
         hbitmap_free(data->hb);
         data->hb = NULL;
     }
@@ -648,96 +636,6 @@ static void test_hbitmap_truncate_shrink_large(TestHBitmapData *data,
     hbitmap_test_truncate(data, size, -diff, 0);
 }
 
-static void hbitmap_check_meta(TestHBitmapData *data,
-                               int64_t start, int count)
-{
-    int64_t i;
-
-    for (i = 0; i < data->size; i++) {
-        if (i >= start && i < start + count) {
-            g_assert(hbitmap_get(data->meta, i));
-        } else {
-            g_assert(!hbitmap_get(data->meta, i));
-        }
-    }
-}
-
-static void hbitmap_test_meta(TestHBitmapData *data,
-                              int64_t start, int count,
-                              int64_t check_start, int check_count)
-{
-    hbitmap_reset_all(data->hb);
-    hbitmap_reset_all(data->meta);
-
-    /* Test "unset" -> "unset" will not update meta. */
-    hbitmap_reset(data->hb, start, count);
-    hbitmap_check_meta(data, 0, 0);
-
-    /* Test "unset" -> "set" will update meta */
-    hbitmap_set(data->hb, start, count);
-    hbitmap_check_meta(data, check_start, check_count);
-
-    /* Test "set" -> "set" will not update meta */
-    hbitmap_reset_all(data->meta);
-    hbitmap_set(data->hb, start, count);
-    hbitmap_check_meta(data, 0, 0);
-
-    /* Test "set" -> "unset" will update meta */
-    hbitmap_reset_all(data->meta);
-    hbitmap_reset(data->hb, start, count);
-    hbitmap_check_meta(data, check_start, check_count);
-}
-
-static void hbitmap_test_meta_do(TestHBitmapData *data, int chunk_size)
-{
-    uint64_t size = chunk_size * 100;
-    hbitmap_test_init_meta(data, size, 0, chunk_size);
-
-    hbitmap_test_meta(data, 0, 1, 0, chunk_size);
-    hbitmap_test_meta(data, 0, chunk_size, 0, chunk_size);
-    hbitmap_test_meta(data, chunk_size - 1, 1, 0, chunk_size);
-    hbitmap_test_meta(data, chunk_size - 1, 2, 0, chunk_size * 2);
-    hbitmap_test_meta(data, chunk_size - 1, chunk_size + 1, 0, chunk_size * 2);
-    hbitmap_test_meta(data, chunk_size - 1, chunk_size + 2, 0, chunk_size * 3);
-    hbitmap_test_meta(data, 7 * chunk_size - 1, chunk_size + 2,
-                      6 * chunk_size, chunk_size * 3);
-    hbitmap_test_meta(data, size - 1, 1, size - chunk_size, chunk_size);
-    hbitmap_test_meta(data, 0, size, 0, size);
-}
-
-static void test_hbitmap_meta_byte(TestHBitmapData *data, const void *unused)
-{
-    hbitmap_test_meta_do(data, BITS_PER_BYTE);
-}
-
-static void test_hbitmap_meta_word(TestHBitmapData *data, const void *unused)
-{
-    hbitmap_test_meta_do(data, BITS_PER_LONG);
-}
-
-static void test_hbitmap_meta_sector(TestHBitmapData *data, const void *unused)
-{
-    hbitmap_test_meta_do(data, BDRV_SECTOR_SIZE * BITS_PER_BYTE);
-}
-
-/**
- * Create an HBitmap and test set/unset.
- */
-static void test_hbitmap_meta_one(TestHBitmapData *data, const void *unused)
-{
-    int i;
-    int64_t offsets[] = {
-        0, 1, L1 - 1, L1, L1 + 1, L2 - 1, L2, L2 + 1, L3 - 1, L3, L3 + 1
-    };
-
-    hbitmap_test_init_meta(data, L3 * 2, 0, 1);
-    for (i = 0; i < ARRAY_SIZE(offsets); i++) {
-        hbitmap_test_meta(data, offsets[i], 1, offsets[i], 1);
-        hbitmap_test_meta(data, offsets[i], L1, offsets[i], L1);
-        hbitmap_test_meta(data, offsets[i], L2, offsets[i], L2);
-    }
-}
-
 static void test_hbitmap_serialize_align(TestHBitmapData *data,
                                          const void *unused)
 {
@@ -750,13 +648,6 @@ static void test_hbitmap_serialize_align(TestHBitmapData *data,
     g_assert_cmpint(r, ==, 64 << 3);
 }
 
-static void test_hbitmap_meta_zero(TestHBitmapData *data, const void *unused)
-{
-    hbitmap_test_init_meta(data, 0, 0, 1);
-
-    hbitmap_check_meta(data, 0, 0);
-}
-
 static void hbitmap_test_serialize_range(TestHBitmapData *data,
                                          uint8_t *buf, size_t buf_size,
                                          uint64_t pos, uint64_t count)
@@ -1165,12 +1056,6 @@ int main(int argc, char **argv)
     hbitmap_test_add("/hbitmap/truncate/shrink/large",
                      test_hbitmap_truncate_shrink_large);
 
-    hbitmap_test_add("/hbitmap/meta/zero", test_hbitmap_meta_zero);
-    hbitmap_test_add("/hbitmap/meta/one", test_hbitmap_meta_one);
-    hbitmap_test_add("/hbitmap/meta/byte", test_hbitmap_meta_byte);
-    hbitmap_test_add("/hbitmap/meta/word", test_hbitmap_meta_word);
-    hbitmap_test_add("/hbitmap/meta/sector", test_hbitmap_meta_sector);
-
     hbitmap_test_add("/hbitmap/serialize/align",
                      test_hbitmap_serialize_align);
     hbitmap_test_add("/hbitmap/serialize/basic",
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 574eb13ed8..75d72d7203 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -897,22 +897,6 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result)
     return true;
 }
 
-HBitmap *hbitmap_create_meta(HBitmap *hb, int chunk_size)
-{
-    assert(!(chunk_size & (chunk_size - 1)));
-    assert(!hb->meta);
-    hb->meta = hbitmap_alloc(hb->size << hb->granularity,
-                             hb->granularity + ctz32(chunk_size));
-    return hb->meta;
-}
-
-void hbitmap_free_meta(HBitmap *hb)
-{
-    assert(hb->meta);
-    hbitmap_free(hb->meta);
-    hb->meta = NULL;
-}
-
 char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
 {
     size_t size = bitmap->sizes[HBITMAP_LEVELS - 1] * sizeof(unsigned long);
-- 
2.21.0


