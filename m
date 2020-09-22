Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31152C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FCA2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FCA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKebJ-0001U2-F5
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kKeW0-0002Ck-9L; Tue, 22 Sep 2020 05:23:12 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:23413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kKeVx-0005cY-90; Tue, 22 Sep 2020 05:23:11 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3EA55454AE;
 Tue, 22 Sep 2020 11:14:33 +0200 (CEST)
From: =?UTF-8?q?Fabian=20Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu 2/4] drive-mirror: add support for conditional and always
 bitmap sync modes
Date: Tue, 22 Sep 2020 11:14:16 +0200
Message-Id: <20200922091418.53562-3-f.gruenbichler@proxmox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 05:14:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Teach mirror two new tricks for using bitmaps:

Always: no matter what, we synchronize the copy_bitmap back to the
sync_bitmap. In effect, this allows us resume a failed mirror at a later
date, since the target bdrv should be exactly in the state referenced by
the bitmap.

Conditional: On success only, we sync the bitmap. This is akin to
incremental backup modes; we can use this bitmap to later refresh a
successfully created mirror, or possibly re-try the whole failed mirror
if we are able to rollback the target to the state before starting the
mirror.

Based on original work by John Snow.

Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
---
 block/mirror.c | 28 ++++++++++++++++++++--------
 blockdev.c     |  3 +++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index d64c8203ef..bc4f4563d9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -654,8 +654,6 @@ static int mirror_exit_common(Job *job)
         bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
     }
 
-    bdrv_release_dirty_bitmap(s->dirty_bitmap);
-
     /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
      * before we can call bdrv_drained_end */
     bdrv_ref(src);
@@ -755,6 +753,18 @@ static int mirror_exit_common(Job *job)
     blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
     blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
 
+    if (s->sync_bitmap) {
+        if (s->bitmap_mode == BITMAP_SYNC_MODE_ALWAYS ||
+            (s->bitmap_mode == BITMAP_SYNC_MODE_ON_SUCCESS &&
+             job->ret == 0 && ret == 0)) {
+            /* Success; synchronize copy back to sync. */
+            bdrv_clear_dirty_bitmap(s->sync_bitmap, NULL);
+            bdrv_dirty_bitmap_merge_internal(s->sync_bitmap, s->dirty_bitmap,
+                                             NULL, true);
+        }
+    }
+    bdrv_release_dirty_bitmap(s->dirty_bitmap);
+
     bs_opaque->job = NULL;
 
     bdrv_drained_end(src);
@@ -1592,10 +1602,6 @@ static BlockJob *mirror_start_job(
                        " sync mode",
                        MirrorSyncMode_str(sync_mode));
             return NULL;
-        } else if (bitmap_mode != BITMAP_SYNC_MODE_NEVER) {
-            error_setg(errp,
-                       "Bitmap Sync Mode '%s' is not supported by Mirror",
-                       BitmapSyncMode_str(bitmap_mode));
         }
     } else if (bitmap) {
         error_setg(errp,
@@ -1612,6 +1618,12 @@ static BlockJob *mirror_start_job(
             return NULL;
         }
         granularity = bdrv_dirty_bitmap_granularity(bitmap);
+
+        if (bitmap_mode != BITMAP_SYNC_MODE_NEVER) {
+            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
+                return NULL;
+            }
+        }
     } else if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
@@ -1781,8 +1793,8 @@ static BlockJob *mirror_start_job(
     }
 
     if (s->sync_mode == MIRROR_SYNC_MODE_BITMAP) {
-        bdrv_merge_dirty_bitmap(s->dirty_bitmap, s->sync_bitmap,
-                                NULL, &local_err);
+        bdrv_dirty_bitmap_merge_internal(s->dirty_bitmap, s->sync_bitmap,
+                                         NULL, true);
         if (local_err) {
             goto fail;
         }
diff --git a/blockdev.c b/blockdev.c
index 6baa1a33f5..0fd30a392d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3019,6 +3019,9 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             return;
         }
+    } else if (has_bitmap_mode) {
+        error_setg(errp, "Cannot specify bitmap sync mode without a bitmap");
+        return;
     }
 
     if (!has_replaces) {
-- 
2.20.1



