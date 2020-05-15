Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60243C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BED2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dntAXcbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BED2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZtR-0005nw-55
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj6-0002hJ-IQ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZiy-0002GS-SS
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psdhIKzz+o+i3IjFZobqM93vouvy1hiHnI9SQsiL3ws=;
 b=dntAXcbPHTfZh4wrw/+or+rvmfgHjFc2nhO2UpKhRpGmfXVOJniawIBf0S0ujG/2l1MLH1
 CRh9pvlwMHS4NDBO9t5Av5zFSxljhKcfGWG9MrpIbKLMoLANoCLfvjA+LCU18HpoRPBAt7
 MU7udAj5t2cZW37oAPJZ/TM4hyq1z8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-HhixXpIwM-G5Uy77WTVkgw-1; Fri, 15 May 2020 08:45:57 -0400
X-MC-Unique: HhixXpIwM-G5Uy77WTVkgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F28E3A0BDD;
 Fri, 15 May 2020 12:45:55 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64E0B2E165;
 Fri, 15 May 2020 12:45:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/51] block: Add BdrvChildRole to BdrvChild
Date: Fri, 15 May 2020 14:44:47 +0200
Message-Id: <20200515124521.335403-18-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

For now, it is always set to 0.  Later patches in this series will
ensure that all callers pass an appropriate combination of flags.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200513110544.176672-6-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h       |  2 ++
 include/block/block_int.h   |  2 ++
 block.c                     | 11 ++++++++---
 block/backup-top.c          |  3 ++-
 block/blkdebug.c            |  2 +-
 block/blklogwrites.c        |  6 +++---
 block/blkreplay.c           |  2 +-
 block/blkverify.c           |  4 ++--
 block/block-backend.c       |  4 ++--
 block/bochs.c               |  2 +-
 block/cloop.c               |  2 +-
 block/copy-on-read.c        |  2 +-
 block/crypto.c              |  2 +-
 block/dmg.c                 |  2 +-
 block/filter-compress.c     |  2 +-
 block/parallels.c           |  2 +-
 block/qcow.c                |  2 +-
 block/qcow2.c               |  6 +++---
 block/qed.c                 |  2 +-
 block/quorum.c              |  4 ++--
 block/raw-format.c          |  2 +-
 block/replication.c         |  2 +-
 block/throttle.c            |  2 +-
 block/vdi.c                 |  2 +-
 block/vhdx.c                |  2 +-
 block/vmdk.c                |  4 ++--
 block/vpc.c                 |  2 +-
 block/vvfat.c               |  2 +-
 blockjob.c                  |  5 +++--
 tests/test-bdrv-drain.c     | 20 +++++++++++---------
 tests/test-bdrv-graph-mod.c |  4 ++--
 31 files changed, 62 insertions(+), 49 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 35f1a1cecf..25e299605e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -353,6 +353,7 @@ BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
                            BlockDriverState* parent,
                            const BdrvChildClass *child_class,
+                           BdrvChildRole child_role,
                            bool allow_none, Error **errp);
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
@@ -598,6 +599,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
                              const BdrvChildClass *child_class,
+                             BdrvChildRole child_role,
                              Error **errp);
 
 bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 9a78b981e4..1c6641c17a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -746,6 +746,7 @@ struct BdrvChild {
     BlockDriverState *bs;
     char *name;
     const BdrvChildClass *klass;
+    BdrvChildRole role;
     void *opaque;
 
     /**
@@ -1233,6 +1234,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildClass *child_class,
+                                  BdrvChildRole child_role,
                                   AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp);
diff --git a/block.c b/block.c
index 0ce9b61c97..14810e0426 100644
--- a/block.c
+++ b/block.c
@@ -2571,6 +2571,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildClass *child_class,
+                                  BdrvChildRole child_role,
                                   AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp)
@@ -2592,6 +2593,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
         .bs             = NULL,
         .name           = g_strdup(child_name),
         .klass          = child_class,
+        .role           = child_role,
         .perm           = perm,
         .shared_perm    = shared_perm,
         .opaque         = opaque,
@@ -2644,6 +2646,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
                              const BdrvChildClass *child_class,
+                             BdrvChildRole child_role,
                              Error **errp)
 {
     BdrvChild *child;
@@ -2656,7 +2659,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                     perm, shared_perm, &perm, &shared_perm);
 
     child = bdrv_root_attach_child(child_bs, child_name, child_class,
-                                   bdrv_get_aio_context(parent_bs),
+                                   child_role, bdrv_get_aio_context(parent_bs),
                                    perm, shared_perm, parent_bs, errp);
     if (child == NULL) {
         return NULL;
@@ -2774,7 +2777,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     }
 
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing,
-                                    errp);
+                                    0, errp);
     /* If backing_hd was already part of bs's backing chain, and
      * inherits_from pointed recursively to bs then let's update it to
      * point directly to bs (else it will become NULL). */
@@ -2965,6 +2968,7 @@ BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
                            BlockDriverState *parent,
                            const BdrvChildClass *child_class,
+                           BdrvChildRole child_role,
                            bool allow_none, Error **errp)
 {
     BlockDriverState *bs;
@@ -2975,7 +2979,8 @@ BdrvChild *bdrv_open_child(const char *filename,
         return NULL;
     }
 
-    return bdrv_attach_child(parent, bs, bdref_key, child_class, errp);
+    return bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
+                             errp);
 }
 
 /*
diff --git a/block/backup-top.c b/block/backup-top.c
index 282845a410..f891dd7838 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -214,7 +214,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
              source->supported_zero_flags);
 
     bdrv_ref(target);
-    state->target = bdrv_attach_child(top, target, "target", &child_file, errp);
+    state->target = bdrv_attach_child(top, target, "target", &child_file, 0,
+                                      errp);
     if (!state->target) {
         bdrv_unref(target);
         bdrv_unref(top);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index f369d54ee4..c91e78d5c8 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -497,7 +497,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* Open the image file */
     bs->file = bdrv_open_child(qemu_opt_get(opts, "x-image"), options, "image",
-                               bs, &child_file, false, &local_err);
+                               bs, &child_file, 0, false, &local_err);
     if (local_err) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index f3b3259d8d..739db6dcf6 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -157,7 +157,7 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Open the file */
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0, false,
                                &local_err);
     if (local_err) {
         ret = -EINVAL;
@@ -166,8 +166,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Open the log file */
-    s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_file, false,
-                                  &local_err);
+    s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_file, 0,
+                                  false, &local_err);
     if (local_err) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 131c9e8477..9b2814fc58 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -28,7 +28,7 @@ static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* Open the image file */
     bs->file = bdrv_open_child(NULL, options, "image",
-                               bs, &child_file, false, &local_err);
+                               bs, &child_file, 0, false, &local_err);
     if (local_err) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/blkverify.c b/block/blkverify.c
index ba6b1853ae..ba4f6d7b7c 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -125,7 +125,7 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* Open the raw file */
     bs->file = bdrv_open_child(qemu_opt_get(opts, "x-raw"), options, "raw",
-                               bs, &child_file, false, &local_err);
+                               bs, &child_file, 0, false, &local_err);
     if (local_err) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
@@ -134,7 +134,7 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* Open the test file */
     s->test_file = bdrv_open_child(qemu_opt_get(opts, "x-image"), options,
-                                   "test", bs, &child_format, false,
+                                   "test", bs, &child_format, 0, false,
                                    &local_err);
     if (local_err) {
         ret = -EINVAL;
diff --git a/block/block-backend.c b/block/block-backend.c
index c0af79147a..efc7acb3d8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -423,7 +423,7 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
         return NULL;
     }
 
-    blk->root = bdrv_root_attach_child(bs, "root", &child_root, blk->ctx,
+    blk->root = bdrv_root_attach_child(bs, "root", &child_root, 0, blk->ctx,
                                        perm, BLK_PERM_ALL, blk, errp);
     if (!blk->root) {
         blk_unref(blk);
@@ -834,7 +834,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     bdrv_ref(bs);
-    blk->root = bdrv_root_attach_child(bs, "root", &child_root, blk->ctx,
+    blk->root = bdrv_root_attach_child(bs, "root", &child_root, 0, blk->ctx,
                                        blk->perm, blk->shared_perm, blk, errp);
     if (blk->root == NULL) {
         return -EPERM;
diff --git a/block/bochs.c b/block/bochs.c
index e7bbeaa1c4..b013e73063 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -110,7 +110,7 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/cloop.c b/block/cloop.c
index f90f1a4b4c..3ed9fa63cc 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -71,7 +71,7 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 7504ca6ffc..a2c4e6dc58 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -28,7 +28,7 @@
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0, false,
                                errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/crypto.c b/block/crypto.c
index bdb2b27475..8b516bfee2 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -218,7 +218,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     unsigned int cflags = 0;
     QDict *cryptoopts = NULL;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/dmg.c b/block/dmg.c
index ef3c6e771d..af8188638c 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -439,7 +439,7 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 82c315b298..4dc5f9fb8c 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -30,7 +30,7 @@
 static int compress_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0, false,
                                errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/parallels.c b/block/parallels.c
index bd5f6ffa09..9855ac1162 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -739,7 +739,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     char *buf;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/qcow.c b/block/qcow.c
index 6a72dea049..13583f0339 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -130,7 +130,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
     encryptfmt = qdict_get_try_str(encryptopts, "format");
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         ret = -EINVAL;
diff --git a/block/qcow2.c b/block/qcow2.c
index 76bec61ee9..86335d9403 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1591,7 +1591,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     /* Open external data file */
     s->data_file = bdrv_open_child(NULL, options, "data-file", bs, &child_file,
-                                   true, &local_err);
+                                   0, true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1601,7 +1601,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
         if (!s->data_file && s->image_data_file) {
             s->data_file = bdrv_open_child(s->image_data_file, options,
-                                           "data-file", bs, &child_file,
+                                           "data-file", bs, &child_file, 0,
                                            false, errp);
             if (!s->data_file) {
                 ret = -EINVAL;
@@ -1863,7 +1863,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
         .ret = -EINPROGRESS
     };
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/qed.c b/block/qed.c
index 337eb6dbb6..1ad2aba810 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -547,7 +547,7 @@ static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
         .ret = -EINPROGRESS
     };
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/quorum.c b/block/quorum.c
index a0824c300d..024de76e6f 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -977,7 +977,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
         assert(ret < 32);
 
         s->children[i] = bdrv_open_child(NULL, options, indexstr, bs,
-                                         &child_format, false, &local_err);
+                                         &child_format, 0, false, &local_err);
         if (local_err) {
             ret = -EINVAL;
             goto close_exit;
@@ -1053,7 +1053,7 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
-    child = bdrv_attach_child(bs, child_bs, indexstr, &child_format, errp);
+    child = bdrv_attach_child(bs, child_bs, indexstr, &child_format, 0, errp);
     if (child == NULL) {
         s->next_child_index--;
         goto out;
diff --git a/block/raw-format.c b/block/raw-format.c
index 00e13bb41e..4b8d4ce8be 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -428,7 +428,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRawState *s = bs->opaque;
     int ret;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/replication.c b/block/replication.c
index af428c5b66..052c7ef601 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -90,7 +90,7 @@ static int replication_open(BlockDriverState *bs, QDict *options,
     const char *mode;
     const char *top_id;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/throttle.c b/block/throttle.c
index 71f4bb0ad1..2dea913be7 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -82,7 +82,7 @@ static int throttle_open(BlockDriverState *bs, QDict *options,
     int ret;
 
     bs->file = bdrv_open_child(NULL, options, "file", bs,
-                               &child_file, false, errp);
+                               &child_file, 0, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/vdi.c b/block/vdi.c
index 0ef733ae19..653acb5fc1 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -378,7 +378,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     QemuUUID uuid_link, uuid_parent;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/vhdx.c b/block/vhdx.c
index e692cf80cc..dde156c97b 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -996,7 +996,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t signature;
     Error *local_err = NULL;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/vmdk.c b/block/vmdk.c
index 56e85689f3..c2cb741e2d 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1152,7 +1152,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
         assert(ret < 32);
 
         extent_file = bdrv_open_child(extent_path, options, extent_opt_prefix,
-                                      bs, &child_file, false, &local_err);
+                                      bs, &child_file, 0, false, &local_err);
         g_free(extent_path);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -1257,7 +1257,7 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     uint32_t magic;
     Error *local_err = NULL;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/vpc.c b/block/vpc.c
index 46a2d48659..b2a86074a5 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -228,7 +228,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     int64_t bs_size;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/vvfat.c b/block/vvfat.c
index f845d9b485..cd8ae50a2c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3183,7 +3183,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
     options = qdict_new();
     qdict_put_str(options, "write-target.driver", "qcow");
     s->qcow = bdrv_open_child(s->qcow_filename, options, "write-target", bs,
-                              &child_vvfat_qcow, false, errp);
+                              &child_vvfat_qcow, 0, false, errp);
     qobject_unref(options);
     if (!s->qcow) {
         ret = -EINVAL;
diff --git a/blockjob.c b/blockjob.c
index be38c8c550..470facfd47 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -217,8 +217,9 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
     if (job->job.aio_context != qemu_get_aio_context()) {
         aio_context_release(job->job.aio_context);
     }
-    c = bdrv_root_attach_child(bs, name, &child_job, job->job.aio_context,
-                               perm, shared_perm, job, errp);
+    c = bdrv_root_attach_child(bs, name, &child_job, 0,
+                               job->job.aio_context, perm, shared_perm, job,
+                               errp);
     if (job->job.aio_context != qemu_get_aio_context()) {
         aio_context_acquire(job->job.aio_context);
     }
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 9d683a6c11..c03705ea37 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1202,7 +1202,7 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
 
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_attach_child(bs, null_bs, "null-child", &child_file, &error_abort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_file, 0, &error_abort);
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1211,13 +1211,13 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
     child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
     tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child", &child_file,
-                                        &error_abort);
+                                        0, &error_abort);
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_attach_child(bs, null_bs, "null-child", &child_file, &error_abort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_file, 0, &error_abort);
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1314,7 +1314,7 @@ static void detach_indirect_bh(void *opaque)
 
     bdrv_ref(data->c);
     data->child_c = bdrv_attach_child(data->parent_b, data->c, "PB-C",
-                                      &child_file, &error_abort);
+                                      &child_file, 0, &error_abort);
 }
 
 static void detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1396,13 +1396,15 @@ static void test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
-    child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_file, &error_abort);
-    child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_backing, &error_abort);
+    child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_file, 0,
+                                &error_abort);
+    child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_backing, 0,
+                                &error_abort);
 
     bdrv_ref(a);
     bdrv_attach_child(parent_a, a, "PA-A",
                       by_parent_cb ? &child_file : &detach_by_driver_cb_class,
-                      &error_abort);
+                      0, &error_abort);
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1813,7 +1815,7 @@ static void test_drop_intermediate_poll(void)
             /* Takes the reference to chain[i - 1] */
             chain[i]->backing = bdrv_attach_child(chain[i], chain[i - 1],
                                                   "chain", &chain_child_class,
-                                                  &error_abort);
+                                                  0, &error_abort);
         }
     }
 
@@ -2031,7 +2033,7 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
 
     bdrv_ref(old_child_bs);
     parent_bs->backing = bdrv_attach_child(parent_bs, old_child_bs, "child",
-                                           &child_backing, &error_abort);
+                                           &child_backing, 0, &error_abort);
 
     for (i = 0; i < old_drain_count; i++) {
         bdrv_drained_begin(old_child_bs);
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index fef42cb294..8b8c186c9f 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -111,7 +111,7 @@ static void test_update_perm_tree(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
-    bdrv_attach_child(filter, bs, "child", &child_file, &error_abort);
+    bdrv_attach_child(filter, bs, "child", &child_file, 0, &error_abort);
 
     bdrv_append(filter, bs, &local_err);
 
@@ -177,7 +177,7 @@ static void test_should_update_child(void)
     bdrv_set_backing_hd(target, bs, &error_abort);
 
     g_assert(target->backing->bs == bs);
-    bdrv_attach_child(filter, target, "target", &child_file, &error_abort);
+    bdrv_attach_child(filter, target, "target", &child_file, 0, &error_abort);
     bdrv_append(filter, bs, &error_abort);
     g_assert(target->backing->bs == bs);
 
-- 
2.25.4


