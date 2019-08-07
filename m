Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF73C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3D421E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3D421E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMiE-0004ko-Gx
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg8-0007mi-Gb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg7-0003KS-5e
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:40658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg4-0003Cx-1h; Wed, 07 Aug 2019 10:12:32 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg0-0005oH-BO; Wed, 07 Aug 2019 17:12:28 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 17:12:26 +0300
Message-Id: <20190807141226.193501-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807141226.193501-1-vsementsov@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 10/10] qcow2-bitmap: move bitmap reopen-rw
 code to qcow2_reopen_commit
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

The only reason I can imagine for this strange code at the very-end of
bdrv_reopen_commit is the fact that bs->read_only updated after
calling drv->bdrv_reopen_commit in bdrv_reopen_commit. And in the same
time, prior to previous commit, qcow2_reopen_bitmaps_rw did a wrong
check for being writable, when actually it only need writable file
child not self.

So, as it's fixed, let's move things to correct place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  6 ------
 block.c                   | 19 -------------------
 block/qcow2.c             | 15 ++++++++++++++-
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..18a1e81194 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -531,12 +531,6 @@ struct BlockDriver {
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
 
-    /**
-     * Bitmaps should be marked as 'IN_USE' in the image on reopening image
-     * as rw. This handler should realize it. It also should unset readonly
-     * field of BlockDirtyBitmap's in case of success.
-     */
-    int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
     bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
                                             const char *name,
                                             uint32_t granularity,
diff --git a/block.c b/block.c
index d59f9f97cb..395bc88045 100644
--- a/block.c
+++ b/block.c
@@ -3925,16 +3925,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     BlockDriver *drv;
     BlockDriverState *bs;
     BdrvChild *child;
-    bool old_can_write, new_can_write;
 
     assert(reopen_state != NULL);
     bs = reopen_state->bs;
     drv = bs->drv;
     assert(drv != NULL);
 
-    old_can_write =
-        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
-
     /* If there are any driver level actions to take */
     if (drv->bdrv_reopen_commit) {
         drv->bdrv_reopen_commit(reopen_state);
@@ -3978,21 +3974,6 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     }
 
     bdrv_refresh_limits(bs, NULL);
-
-    new_can_write =
-        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
-    if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw) {
-        Error *local_err = NULL;
-        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
-            /* This is not fatal, bitmaps just left read-only, so all following
-             * writes will fail. User can remove read-only bitmaps to unblock
-             * writes.
-             */
-            error_reportf_err(local_err,
-                              "%s: Failed to make dirty bitmaps writable: ",
-                              bdrv_get_node_name(bs));
-        }
-    }
 }
 
 /*
diff --git a/block/qcow2.c b/block/qcow2.c
index 5c1187e2f9..9e6210c282 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1828,6 +1828,20 @@ fail:
 static void qcow2_reopen_commit(BDRVReopenState *state)
 {
     qcow2_update_options_commit(state->bs, state->opaque);
+    if (state->flags & BDRV_O_RDWR) {
+        Error *local_err = NULL;
+
+        if (qcow2_reopen_bitmaps_rw(state->bs, &local_err) < 0) {
+            /*
+             * This is not fatal, bitmaps just left read-only, so all following
+             * writes will fail. User can remove read-only bitmaps to unblock
+             * writes or retry reopen.
+             */
+            error_reportf_err(local_err,
+                              "%s: Failed to make dirty bitmaps writable: ",
+                              bdrv_get_node_name(state->bs));
+        }
+    }
     g_free(state->opaque);
 }
 
@@ -5229,7 +5243,6 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
 
-    .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
     .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
     .bdrv_remove_persistent_dirty_bitmap = qcow2_remove_persistent_dirty_bitmap,
 };
-- 
2.18.0


