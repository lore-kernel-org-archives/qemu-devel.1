Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05328C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B455E20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTfXzYqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B455E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaBk-0008V6-Qe
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjd-0003pC-EF
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZja-0002TU-IQ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/fknbCpDX4Rqz976/8tznfqTx3nyWAzIGoSeF304Ek=;
 b=aTfXzYqORgylU3WkWuvk1rgmqa9Kvb/ak7seOPG1oaEu7VWGnMrfZmm312Wz/K7jPUU2T3
 Nxrpl/qaxhLm4Os21iVzirmODBB386r0copNeTgYdGTaiK2h2AcF9EF0x0P0XDy+trap2N
 Juz5pOeoVGUM8HLD7IsbJv1qu7p6xjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-_rM0k2jHOIyo2S3Ktw0L5A-1; Fri, 15 May 2020 08:46:35 -0400
X-MC-Unique: _rM0k2jHOIyo2S3Ktw0L5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92D0A19200C0;
 Fri, 15 May 2020 12:46:34 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 998A42E024;
 Fri, 15 May 2020 12:46:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 46/51] block: Drop @child_class from bdrv_child_perm()
Date: Fri, 15 May 2020 14:45:16 +0200
Message-Id: <20200515124521.335403-47-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Implementations should decide the necessary permissions based on @role.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-35-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h   |  4 +---
 block.c                     | 39 +++++++++++++++----------------------
 block/backup-top.c          |  3 +--
 block/blkdebug.c            |  3 +--
 block/blklogwrites.c        |  3 +--
 block/commit.c              |  1 -
 block/copy-on-read.c        |  1 -
 block/mirror.c              |  1 -
 block/quorum.c              |  1 -
 block/replication.c         |  1 -
 block/vvfat.c               |  4 +---
 tests/test-bdrv-drain.c     | 19 +-----------------
 tests/test-bdrv-graph-mod.c |  1 -
 13 files changed, 22 insertions(+), 59 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7fbe3206b4..5e4f4c348c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -563,7 +563,6 @@ struct BlockDriver {
      * @reopen_queue.
      */
      void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildClass *child_class,
                              BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t parent_perm, uint64_t parent_shared,
@@ -1270,8 +1269,7 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs,
  * child_of_bds child class and set an appropriate BdrvChildRole.
  */
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
-                        const BdrvChildClass *child_class, BdrvChildRole role,
-                        BlockReopenQueue *reopen_queue,
+                        BdrvChildRole role, BlockReopenQueue *reopen_queue,
                         uint64_t perm, uint64_t shared,
                         uint64_t *nperm, uint64_t *nshared);
 
diff --git a/block.c b/block.c
index 6a24b23d51..8416376c9b 100644
--- a/block.c
+++ b/block.c
@@ -1947,13 +1947,13 @@ bool bdrv_is_writable(BlockDriverState *bs)
 }
 
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
-                            BdrvChild *c, const BdrvChildClass *child_class,
-                            BdrvChildRole role, BlockReopenQueue *reopen_queue,
+                            BdrvChild *c, BdrvChildRole role,
+                            BlockReopenQueue *reopen_queue,
                             uint64_t parent_perm, uint64_t parent_shared,
                             uint64_t *nperm, uint64_t *nshared)
 {
     assert(bs->drv && bs->drv->bdrv_child_perm);
-    bs->drv->bdrv_child_perm(bs, c, child_class, role, reopen_queue,
+    bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
                              parent_perm, parent_shared,
                              nperm, nshared);
     /* TODO Take force_share from reopen_queue */
@@ -2047,7 +2047,7 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
         uint64_t cur_perm, cur_shared;
         bool child_tighten_restr;
 
-        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, q,
+        bdrv_child_perm(bs, c->bs, c, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret = bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore_children,
@@ -2114,7 +2114,7 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
+        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
@@ -2342,7 +2342,7 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp)
     uint64_t perms, shared;
 
     bdrv_get_cumulative_perm(bs, &parent_perms, &parent_shared);
-    bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
+    bdrv_child_perm(bs, c->bs, c, c->role, NULL,
                     parent_perms, parent_shared, &perms, &shared);
 
     return bdrv_child_try_set_perm(c, perms, shared, errp);
@@ -2354,7 +2354,6 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp)
  * filtered child.
  */
 static void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                                      const BdrvChildClass *child_class,
                                       BdrvChildRole role,
                                       BlockReopenQueue *reopen_queue,
                                       uint64_t perm, uint64_t shared,
@@ -2365,13 +2364,12 @@ static void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
 }
 
 static void bdrv_default_perms_for_cow(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildClass *child_class,
                                        BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
 {
-    assert(child_class == &child_of_bds && (role & BDRV_CHILD_COW));
+    assert(role & BDRV_CHILD_COW);
 
     /*
      * We want consistent read from backing files if the parent needs it.
@@ -2402,7 +2400,6 @@ static void bdrv_default_perms_for_cow(BlockDriverState *bs, BdrvChild *c,
 }
 
 static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
-                                           const BdrvChildClass *child_class,
                                            BdrvChildRole role,
                                            BlockReopenQueue *reopen_queue,
                                            uint64_t perm, uint64_t shared,
@@ -2410,8 +2407,7 @@ static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
 {
     int flags;
 
-    assert(child_class == &child_of_bds &&
-           (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA)));
+    assert(role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA));
 
     flags = bdrv_reopen_get_flags(reopen_queue, bs);
 
@@ -2419,7 +2415,7 @@ static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
      * Apart from the modifications below, the same permissions are
      * forwarded and left alone as for filters
      */
-    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+    bdrv_filter_default_perms(bs, c, role, reopen_queue,
                               perm, shared, &perm, &shared);
 
     if (role & BDRV_CHILD_METADATA) {
@@ -2483,24 +2479,21 @@ static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
 }
 
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
-                        const BdrvChildClass *child_class, BdrvChildRole role,
-                        BlockReopenQueue *reopen_queue,
+                        BdrvChildRole role, BlockReopenQueue *reopen_queue,
                         uint64_t perm, uint64_t shared,
                         uint64_t *nperm, uint64_t *nshared)
 {
-    assert(child_class == &child_of_bds);
-
     if (role & BDRV_CHILD_FILTERED) {
         assert(!(role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
                          BDRV_CHILD_COW)));
-        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+        bdrv_filter_default_perms(bs, c, role, reopen_queue,
                                   perm, shared, nperm, nshared);
     } else if (role & BDRV_CHILD_COW) {
         assert(!(role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA)));
-        bdrv_default_perms_for_cow(bs, c, child_class, role, reopen_queue,
+        bdrv_default_perms_for_cow(bs, c, role, reopen_queue,
                                    perm, shared, nperm, nshared);
     } else if (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA)) {
-        bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_queue,
+        bdrv_default_perms_for_storage(bs, c, role, reopen_queue,
                                        perm, shared, nperm, nshared);
     } else {
         g_assert_not_reached();
@@ -2744,7 +2737,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
 
     assert(parent_bs->drv);
-    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, child_role, NULL,
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_role, NULL,
                     perm, shared_perm, &perm, &shared_perm);
 
     child = bdrv_root_attach_child(child_bs, child_name, child_class,
@@ -3807,7 +3800,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         if (state->replace_backing_bs && state->new_backing_bs) {
             uint64_t nperm, nshared;
             bdrv_child_perm(state->bs, state->new_backing_bs,
-                            NULL, &child_of_bds, bdrv_backing_role(state->bs),
+                            NULL, bdrv_backing_role(state->bs),
                             bs_queue, state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret = bdrv_check_update_perm(state->new_backing_bs, NULL,
@@ -3930,7 +3923,7 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, BlockDriverState *bs,
         } else {
             uint64_t nperm, nshared;
 
-            bdrv_child_perm(parent->state.bs, bs, c, c->klass, c->role, q,
+            bdrv_child_perm(parent->state.bs, bs, c, c->role, q,
                             parent->state.perm, parent->state.shared_perm,
                             &nperm, &nshared);
 
diff --git a/block/backup-top.c b/block/backup-top.c
index f0efec18b5..af2f20f346 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -122,7 +122,6 @@ static void backup_top_refresh_filename(BlockDriverState *bs)
 }
 
 static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                  const BdrvChildClass *child_class,
                                   BdrvChildRole role,
                                   BlockReopenQueue *reopen_queue,
                                   uint64_t perm, uint64_t shared,
@@ -156,7 +155,7 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
         *nperm = BLK_PERM_WRITE;
     } else {
         /* Source child */
-        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+        bdrv_default_perms(bs, c, role, reopen_queue,
                            perm, shared, nperm, nshared);
 
         if (perm & BLK_PERM_WRITE) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index a925d8295e..7194bc7f06 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -995,7 +995,6 @@ static int blkdebug_reopen_prepare(BDRVReopenState *reopen_state,
 }
 
 static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                const BdrvChildClass *child_class,
                                 BdrvChildRole role,
                                 BlockReopenQueue *reopen_queue,
                                 uint64_t perm, uint64_t shared,
@@ -1003,7 +1002,7 @@ static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
 {
     BDRVBlkdebugState *s = bs->opaque;
 
-    bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+    bdrv_default_perms(bs, c, role, reopen_queue,
                        perm, shared, nperm, nshared);
 
     *nperm |= s->take_child_perms;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 8684fb1c74..6753bd9a3e 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -283,7 +283,6 @@ static int64_t blk_log_writes_getlength(BlockDriverState *bs)
 }
 
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                      const BdrvChildClass *child_class,
                                       BdrvChildRole role,
                                       BlockReopenQueue *ro_q,
                                       uint64_t perm, uint64_t shrd,
@@ -295,7 +294,7 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
         return;
     }
 
-    bdrv_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
+    bdrv_default_perms(bs, c, role, ro_q, perm, shrd,
                        nperm, nshrd);
 }
 
diff --git a/block/commit.c b/block/commit.c
index 6af1c808bc..7732d02dfe 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -223,7 +223,6 @@ static void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
 }
 
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildClass *child_class,
                                        BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index c857ea0da7..a6e3c74a68 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -52,7 +52,6 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
 #define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
 
 static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
-                           const BdrvChildClass *child_class,
                            BdrvChildRole role,
                            BlockReopenQueue *reopen_queue,
                            uint64_t perm, uint64_t shared,
diff --git a/block/mirror.c b/block/mirror.c
index cb4bdad32a..e8e8844afc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1492,7 +1492,6 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 }
 
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildClass *child_class,
                                        BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
diff --git a/block/quorum.c b/block/quorum.c
index 616ac3a927..7cf7ab1546 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1153,7 +1153,6 @@ static char *quorum_dirname(BlockDriverState *bs, Error **errp)
 }
 
 static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
-                              const BdrvChildClass *child_class,
                               BdrvChildRole role,
                               BlockReopenQueue *reopen_queue,
                               uint64_t perm, uint64_t shared,
diff --git a/block/replication.c b/block/replication.c
index cc9c473ad1..ccf7b78160 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -164,7 +164,6 @@ static void replication_close(BlockDriverState *bs)
 }
 
 static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                   const BdrvChildClass *child_class,
                                    BdrvChildRole role,
                                    BlockReopenQueue *reopen_queue,
                                    uint64_t perm, uint64_t shared,
diff --git a/block/vvfat.c b/block/vvfat.c
index 089abe1e29..c65a98e3ee 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3213,7 +3213,6 @@ err:
 }
 
 static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildClass *child_class,
                              BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t perm, uint64_t shared,
@@ -3221,8 +3220,7 @@ static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
 {
     BDRVVVFATState *s = bs->opaque;
 
-    assert(c == s->qcow ||
-           (child_class == &child_of_bds && (role & BDRV_CHILD_COW)));
+    assert(c == s->qcow || (role & BDRV_CHILD_COW));
 
     if (c == s->qcow) {
         /* This is a private node, nobody should try to attach to it */
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 655fd0d085..1107271840 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -85,23 +85,6 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
     return 0;
 }
 
-static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                 const BdrvChildClass *child_class,
-                                 BdrvChildRole role,
-                                 BlockReopenQueue *reopen_queue,
-                                 uint64_t perm, uint64_t shared,
-                                 uint64_t *nperm, uint64_t *nshared)
-{
-    /*
-     * bdrv_default_perms() accepts nothing else, so disguise
-     * detach_by_driver_cb_parent.
-     */
-    child_class = &child_of_bds;
-
-    bdrv_default_perms(bs, c, child_class, role, reopen_queue,
-                       perm, shared, nperm, nshared);
-}
-
 static int bdrv_test_change_backing_file(BlockDriverState *bs,
                                          const char *backing_file,
                                          const char *backing_fmt)
@@ -119,7 +102,7 @@ static BlockDriver bdrv_test = {
     .bdrv_co_drain_begin    = bdrv_test_co_drain_begin,
     .bdrv_co_drain_end      = bdrv_test_co_drain_end,
 
-    .bdrv_child_perm        = bdrv_test_child_perm,
+    .bdrv_child_perm        = bdrv_default_perms,
 
     .bdrv_change_backing_file = bdrv_test_change_backing_file,
 };
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index a2d0318b16..f93f3168b0 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -30,7 +30,6 @@ static BlockDriver bdrv_pass_through = {
 };
 
 static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
-                                         const BdrvChildClass *child_class,
                                          BdrvChildRole role,
                                          BlockReopenQueue *reopen_queue,
                                          uint64_t perm, uint64_t shared,
-- 
2.25.4


