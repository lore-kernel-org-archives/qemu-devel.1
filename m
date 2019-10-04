Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6815DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5F3207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5F3207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGPtv-0005Mc-1U
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 11:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGPni-00037F-GU
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGPnh-0005e2-2u
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:47:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:36332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iGPnR-0005Eb-Hf; Fri, 04 Oct 2019 11:47:21 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iGPnK-00019e-VT; Fri, 04 Oct 2019 18:47:03 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/5] migretion/block-dirty-bitmap: refactor
 init_dirty_bitmap_migration
Date: Fri,  4 Oct 2019 18:46:58 +0300
Message-Id: <20191004154701.3202-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004154701.3202-1-vsementsov@virtuozzo.com>
References: <20191004154701.3202-1-vsementsov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split out handling one bs, it is needed for the following commit, which
will handle BlockBackends in separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 93 +++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 5121f86d73..46641b7861 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -268,59 +268,68 @@ static void dirty_bitmap_mig_cleanup(void)
 }
 
 /* Called with iothread lock taken. */
-static int init_dirty_bitmap_migration(void)
+static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
 {
-    BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
     Error *local_err = NULL;
 
-    dirty_bitmap_mig_state.bulk_completed = false;
-    dirty_bitmap_mig_state.prev_bs = NULL;
-    dirty_bitmap_mig_state.prev_bitmap = NULL;
-    dirty_bitmap_mig_state.no_bitmaps = false;
+    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
+         bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
+    {
+        if (!bdrv_dirty_bitmap_name(bitmap)) {
+            continue;
+        }
 
-    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
-        const char *name = bdrv_get_device_or_node_name(bs);
+        if (!bs_name || strcmp(bs_name, "") == 0) {
+            error_report("Found bitmap '%s' in unnamed node %p. It can't "
+                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
+            return -1;
+        }
 
-        for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
-             bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
-        {
-            if (!bdrv_dirty_bitmap_name(bitmap)) {
-                continue;
-            }
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
 
-            if (!name || strcmp(name, "") == 0) {
-                error_report("Found bitmap '%s' in unnamed node %p. It can't "
-                             "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
-                goto fail;
-            }
+        bdrv_ref(bs);
+        bdrv_dirty_bitmap_set_busy(bitmap, true);
+
+        dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+        dbms->bs = bs;
+        dbms->node_name = bs_name;
+        dbms->bitmap = bitmap;
+        dbms->total_sectors = bdrv_nb_sectors(bs);
+        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
+            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+        if (bdrv_dirty_bitmap_enabled(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
+        }
+        if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
+        }
 
-            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT,
-                                        &local_err)) {
-                error_report_err(local_err);
-                goto fail;
-            }
+        QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
+                             dbms, entry);
+    }
 
-            bdrv_ref(bs);
-            bdrv_dirty_bitmap_set_busy(bitmap, true);
-
-            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
-            dbms->bs = bs;
-            dbms->node_name = name;
-            dbms->bitmap = bitmap;
-            dbms->total_sectors = bdrv_nb_sectors(bs);
-            dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
-                bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
-            if (bdrv_dirty_bitmap_enabled(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
-            }
-            if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
-            }
+    return 0;
+}
+
+/* Called with iothread lock taken. */
+static int init_dirty_bitmap_migration(void)
+{
+    BlockDriverState *bs;
+    DirtyBitmapMigBitmapState *dbms;
+
+    dirty_bitmap_mig_state.bulk_completed = false;
+    dirty_bitmap_mig_state.prev_bs = NULL;
+    dirty_bitmap_mig_state.prev_bitmap = NULL;
+    dirty_bitmap_mig_state.no_bitmaps = false;
 
-            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
-                                 dbms, entry);
+    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
+        if (add_bitmaps_to_list(bs, bdrv_get_device_or_node_name(bs))) {
+            goto fail;
         }
     }
 
-- 
2.21.0


