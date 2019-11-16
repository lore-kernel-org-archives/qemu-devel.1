Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A62EC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 16:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B8B208CE
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 16:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B8B208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iW13X-0007Os-F0
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 11:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iW11i-00052v-S8
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 11:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iW11h-0005TU-NG
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 11:34:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:37816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iW11f-0005RT-3q; Sat, 16 Nov 2019 11:34:19 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iW11Y-0005cn-96; Sat, 16 Nov 2019 19:34:12 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/4] block/io: bdrv_common_block_status_above: support
 include_base
Date: Sat, 16 Nov 2019 19:34:08 +0300
Message-Id: <20191116163410.12129-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191116163410.12129-1-vsementsov@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above, let's support include_base parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4d7fa99bd2..df3ecf2430 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2196,6 +2196,7 @@ int bdrv_flush_all(void)
 typedef struct BdrvCoBlockStatusData {
     BlockDriverState *bs;
     BlockDriverState *base;
+    bool include_base;
     bool want_zero;
     int64_t offset;
     int64_t bytes;
@@ -2418,6 +2419,7 @@ early_out:
 
 static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                                    BlockDriverState *base,
+                                                   bool include_base,
                                                    bool want_zero,
                                                    int64_t offset,
                                                    int64_t bytes,
@@ -2429,8 +2431,8 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     int ret = 0;
     bool first = true;
 
-    assert(bs != base);
-    for (p = bs; p != base; p = backing_bs(p)) {
+    assert(include_base || bs != base);
+    for (p = bs; include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
@@ -2466,6 +2468,10 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
             return ret;
         }
 
+        if (p == base) {
+            break;
+        }
+
         /* Proceed to backing */
         assert(*pnum <= bytes);
         bytes = *pnum;
@@ -2481,7 +2487,7 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
     BdrvCoBlockStatusData *data = opaque;
 
     data->ret = bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
+                                           data->include_base, data->want_zero,
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->file);
     data->done = true;
@@ -2495,6 +2501,7 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
  */
 static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           BlockDriverState *base,
+                                          bool include_base,
                                           bool want_zero, int64_t offset,
                                           int64_t bytes, int64_t *pnum,
                                           int64_t *map,
@@ -2504,6 +2511,7 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
+        .include_base = include_base,
         .want_zero = want_zero,
         .offset = offset,
         .bytes = bytes,
@@ -2528,7 +2536,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
                                           pnum, map, file);
 }
 
@@ -2545,7 +2553,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
                                          bytes, pnum ? pnum : &dummy, NULL,
                                          NULL);
     if (ret < 0) {
-- 
2.21.0


