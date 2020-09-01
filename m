Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96430206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1Hvxd7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96430206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7kp-0008B5-PT
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7Nx-0001CG-AJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7Nv-0007Lg-Eo
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1DR62ssBCDaf7djhnYqLT+6jN9+fFKOLTU8lTzjHdk=;
 b=H1Hvxd7ZBrzP/QPDquCbh2Op+fDcT+A7xhc2/U9ECTXCUTSF1vFL96ceLV2v61mFzKnuot
 79RdFcwfEBf25ZeWCWASynN2+4V8qkf/twR2BBF5xOHDY1iyyqSKzx7cd5yJ2yeklydKEF
 KCCxQ6hIot11d8kalk72l6pI/fbcOeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-bBdOTpA4PRCr5MzPd00rMg-1; Tue, 01 Sep 2020 10:35:40 -0400
X-MC-Unique: bBdOTpA4PRCr5MzPd00rMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB93318B9F49;
 Tue,  1 Sep 2020 14:35:39 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F3967DA51;
 Tue,  1 Sep 2020 14:35:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 30/43] backup: Deal with filters
Date: Tue,  1 Sep 2020 16:34:11 +0200
Message-Id: <20200901143424.884735-31-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup-top.c |  2 +-
 block/backup.c     |  9 +++++----
 blockdev.c         | 19 +++++++++++++++----
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index af2f20f346..430d1be068 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -281,7 +281,7 @@ void bdrv_backup_top_drop(BlockDriverState *bs)
 
     s->active = false;
     bdrv_child_refresh_perms(bs, bs->backing, &error_abort);
-    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
+    bdrv_replace_node(bs, bs->backing->bs, &error_abort);
     bdrv_set_backing_hd(bs, NULL, &error_abort);
 
     bdrv_drained_end(bs);
diff --git a/block/backup.c b/block/backup.c
index 4f13bb20a5..9afa0bf3b4 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -297,6 +297,7 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
 {
     int ret;
     BlockDriverInfo bdi;
+    bool target_does_cow = bdrv_backing_chain_next(target);
 
     /*
      * If there is no backing file on the target, we cannot rely on COW if our
@@ -304,7 +305,7 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
      * targets with a backing file, try to avoid COW if possible.
      */
     ret = bdrv_get_info(target, &bdi);
-    if (ret == -ENOTSUP && !target->backing) {
+    if (ret == -ENOTSUP && !target_does_cow) {
         /* Cluster size is not defined */
         warn_report("The target block device doesn't provide "
                     "information about the block size and it doesn't have a "
@@ -313,14 +314,14 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
                     "this default, the backup may be unusable",
                     BACKUP_CLUSTER_SIZE_DEFAULT);
         return BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else if (ret < 0 && !target->backing) {
+    } else if (ret < 0 && !target_does_cow) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
             "which has no backing file");
         error_append_hint(errp,
             "Aborting, since this may create an unusable destination image\n");
         return ret;
-    } else if (ret < 0 && target->backing) {
+    } else if (ret < 0 && target_does_cow) {
         /* Not fatal; just trudge on ahead. */
         return BACKUP_CLUSTER_SIZE_DEFAULT;
     }
@@ -371,7 +372,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
-    if (compress && !block_driver_can_compress(target->drv)) {
+    if (compress && !bdrv_supports_compressed_writes(target)) {
         error_setg(errp, "Compression is not supported for this drive %s",
                    bdrv_get_device_name(target));
         return NULL;
diff --git a/blockdev.c b/blockdev.c
index 73d96ce21c..d53e39c303 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1741,7 +1741,13 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
      * on top of.
      */
     if (backup->sync == MIRROR_SYNC_MODE_TOP) {
-        source = backing_bs(bs);
+        /*
+         * Backup will not replace the source by the target, so none
+         * of the filters skipped here will be removed (in contrast to
+         * mirror).  Therefore, we can skip all of them when looking
+         * for the first COW relationship.
+         */
+        source = bdrv_cow_bs(bdrv_skip_filters(bs));
         if (!source) {
             backup->sync = MIRROR_SYNC_MODE_FULL;
         }
@@ -1761,9 +1767,14 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     if (backup->mode != NEW_IMAGE_MODE_EXISTING) {
         assert(backup->format);
         if (source) {
-            bdrv_refresh_filename(source);
-            bdrv_img_create(backup->target, backup->format, source->filename,
-                            source->drv->format_name, NULL,
+            /* Implicit filters should not appear in the filename */
+            BlockDriverState *explicit_backing =
+                bdrv_skip_implicit_filters(source);
+
+            bdrv_refresh_filename(explicit_backing);
+            bdrv_img_create(backup->target, backup->format,
+                            explicit_backing->filename,
+                            explicit_backing->drv->format_name, NULL,
                             size, flags, false, &local_err);
         } else {
             bdrv_img_create(backup->target, backup->format, NULL, NULL, NULL,
-- 
2.26.2


