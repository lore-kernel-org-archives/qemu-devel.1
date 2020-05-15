Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0757AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8132074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq0LBgOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8132074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZuh-0000c1-JP
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj8-0002kX-NA
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38096
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj5-0002IL-96
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXbZmViBCSNXKe0OjVMWlzRN0Eg8d8uaFthSAn+STKI=;
 b=Iq0LBgOIHmDnbdsTGjYJQbqXKA9GbjIZKAhuPhm7319BtP+7qtTB1j5d6xSF4optHZYFMD
 bFzgVTQ0Ycj6cM74zjcjPDbAZg+LvLUY35tgVayC1RR5OZBWk2e1/SFVnfoEl9ibPay/d8
 L33m1EWbIr9oazsXRQThnmpvuJrwPS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-TVeHH-sdM4yAK4Xuaf157w-1; Fri, 15 May 2020 08:45:59 -0400
X-MC-Unique: TVeHH-sdM4yAK4Xuaf157w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D053C19200C5;
 Fri, 15 May 2020 12:45:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 477CD2E16D;
 Fri, 15 May 2020 12:45:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/51] block: Pass BdrvChildRole to bdrv_child_perm()
Date: Fri, 15 May 2020 14:44:48 +0200
Message-Id: <20200515124521.335403-19-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
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

For now, all callers pass 0 and no callee evaluates this value.  Later
patches will change both.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200513110544.176672-7-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h   |  5 ++++-
 block.c                     | 22 ++++++++++++----------
 block/backup-top.c          |  3 ++-
 block/blkdebug.c            |  5 +++--
 block/blklogwrites.c        |  9 +++++----
 block/commit.c              |  1 +
 block/copy-on-read.c        |  1 +
 block/mirror.c              |  1 +
 block/quorum.c              |  1 +
 block/replication.c         |  1 +
 block/vvfat.c               |  1 +
 tests/test-bdrv-drain.c     |  5 +++--
 tests/test-bdrv-graph-mod.c |  1 +
 13 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1c6641c17a..dc4bc486d6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -556,7 +556,7 @@ struct BlockDriver {
      * the parents in @parent_perm and @parent_shared.
      *
      * If @c is NULL, return the permissions for attaching a new child for the
-     * given @child_class.
+     * given @child_class and @role.
      *
      * If @reopen_queue is non-NULL, don't return the currently needed
      * permissions, but those that will be needed after applying the
@@ -564,6 +564,7 @@ struct BlockDriver {
      */
      void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
                              const BdrvChildClass *child_class,
+                             BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
@@ -1266,6 +1267,7 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp);
  * all children */
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole child_role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
@@ -1276,6 +1278,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
  * CONSISTENT_READ and doesn't share WRITE. */
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole child_role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
diff --git a/block.c b/block.c
index 14810e0426..5d9a331f5b 100644
--- a/block.c
+++ b/block.c
@@ -1954,12 +1954,12 @@ bool bdrv_is_writable(BlockDriverState *bs)
 
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
                             BdrvChild *c, const BdrvChildClass *child_class,
-                            BlockReopenQueue *reopen_queue,
+                            BdrvChildRole role, BlockReopenQueue *reopen_queue,
                             uint64_t parent_perm, uint64_t parent_shared,
                             uint64_t *nperm, uint64_t *nshared)
 {
     assert(bs->drv && bs->drv->bdrv_child_perm);
-    bs->drv->bdrv_child_perm(bs, c, child_class, reopen_queue,
+    bs->drv->bdrv_child_perm(bs, c, child_class, role, reopen_queue,
                              parent_perm, parent_shared,
                              nperm, nshared);
     /* TODO Take force_share from reopen_queue */
@@ -2053,7 +2053,7 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
         uint64_t cur_perm, cur_shared;
         bool child_tighten_restr;
 
-        bdrv_child_perm(bs, c->bs, c, c->klass, q,
+        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret = bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore_children,
@@ -2120,7 +2120,7 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->klass, NULL,
+        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
@@ -2348,14 +2348,15 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp)
     uint64_t perms, shared;
 
     bdrv_get_cumulative_perm(bs, &parent_perms, &parent_shared);
-    bdrv_child_perm(bs, c->bs, c, c->klass, NULL, parent_perms, parent_shared,
-                    &perms, &shared);
+    bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
+                    parent_perms, parent_shared, &perms, &shared);
 
     return bdrv_child_try_set_perm(c, perms, shared, errp);
 }
 
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
@@ -2366,6 +2367,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
 
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
@@ -2378,7 +2380,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
 
         /* Apart from the modifications below, the same permissions are
          * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
                                   perm, shared, &perm, &shared);
 
         /* Format drivers may touch metadata even if the guest doesn't write */
@@ -2655,7 +2657,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
 
     assert(parent_bs->drv);
-    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, NULL,
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, child_role, NULL,
                     perm, shared_perm, &perm, &shared_perm);
 
     child = bdrv_root_attach_child(child_bs, child_name, child_class,
@@ -3683,7 +3685,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         if (state->replace_backing_bs && state->new_backing_bs) {
             uint64_t nperm, nshared;
             bdrv_child_perm(state->bs, state->new_backing_bs,
-                            NULL, &child_backing, bs_queue,
+                            NULL, &child_backing, 0, bs_queue,
                             state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret = bdrv_check_update_perm(state->new_backing_bs, NULL,
@@ -3806,7 +3808,7 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, BlockDriverState *bs,
         } else {
             uint64_t nperm, nshared;
 
-            bdrv_child_perm(parent->state.bs, bs, c, c->klass, q,
+            bdrv_child_perm(parent->state.bs, bs, c, c->klass, c->role, q,
                             parent->state.perm, parent->state.shared_perm,
                             &nperm, &nshared);
 
diff --git a/block/backup-top.c b/block/backup-top.c
index f891dd7838..e2b4d2acd3 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -123,6 +123,7 @@ static void backup_top_refresh_filename(BlockDriverState *bs)
 
 static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                   const BdrvChildClass *child_class,
+                                  BdrvChildRole role,
                                   BlockReopenQueue *reopen_queue,
                                   uint64_t perm, uint64_t shared,
                                   uint64_t *nperm, uint64_t *nshared)
@@ -155,7 +156,7 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
         *nperm = BLK_PERM_WRITE;
     } else {
         /* Source child */
-        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
                                   perm, shared, nperm, nshared);
 
         if (perm & BLK_PERM_WRITE) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index c91e78d5c8..8dd8ed6055 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -994,14 +994,15 @@ static int blkdebug_reopen_prepare(BDRVReopenState *reopen_state,
 
 static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
                                 const BdrvChildClass *child_class,
+                                BdrvChildRole role,
                                 BlockReopenQueue *reopen_queue,
                                 uint64_t perm, uint64_t shared,
                                 uint64_t *nperm, uint64_t *nshared)
 {
     BDRVBlkdebugState *s = bs->opaque;
 
-    bdrv_filter_default_perms(bs, c, child_class, reopen_queue, perm, shared,
-                              nperm, nshared);
+    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, nperm, nshared);
 
     *nperm |= s->take_child_perms;
     *nshared &= ~s->unshare_child_perms;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 739db6dcf6..4faf912ef1 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -283,6 +283,7 @@ static int64_t blk_log_writes_getlength(BlockDriverState *bs)
 
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
                                       const BdrvChildClass *child_class,
+                                      BdrvChildRole role,
                                       BlockReopenQueue *ro_q,
                                       uint64_t perm, uint64_t shrd,
                                       uint64_t *nperm, uint64_t *nshrd)
@@ -294,11 +295,11 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
     }
 
     if (!strcmp(c->name, "log")) {
-        bdrv_format_default_perms(bs, c, child_class, ro_q, perm, shrd, nperm,
-                                  nshrd);
+        bdrv_format_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
+                                  nperm, nshrd);
     } else {
-        bdrv_filter_default_perms(bs, c, child_class, ro_q, perm, shrd, nperm,
-                                  nshrd);
+        bdrv_filter_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
+                                  nperm, nshrd);
     }
 }
 
diff --git a/block/commit.c b/block/commit.c
index 834eeae412..6af1c808bc 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -224,6 +224,7 @@ static void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
 
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildClass *child_class,
+                                       BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index a2c4e6dc58..a2d92ac394 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -52,6 +52,7 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
 
 static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
                            const BdrvChildClass *child_class,
+                           BdrvChildRole role,
                            BlockReopenQueue *reopen_queue,
                            uint64_t perm, uint64_t shared,
                            uint64_t *nperm, uint64_t *nshared)
diff --git a/block/mirror.c b/block/mirror.c
index d6598463d5..cb4bdad32a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1493,6 +1493,7 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildClass *child_class,
+                                       BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/quorum.c b/block/quorum.c
index 024de76e6f..d37b77a522 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1152,6 +1152,7 @@ static char *quorum_dirname(BlockDriverState *bs, Error **errp)
 
 static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
                               const BdrvChildClass *child_class,
+                              BdrvChildRole role,
                               BlockReopenQueue *reopen_queue,
                               uint64_t perm, uint64_t shared,
                               uint64_t *nperm, uint64_t *nshared)
diff --git a/block/replication.c b/block/replication.c
index 052c7ef601..ea87b1a4f0 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -164,6 +164,7 @@ static void replication_close(BlockDriverState *bs)
 
 static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
                                    const BdrvChildClass *child_class,
+                                   BdrvChildRole role,
                                    BlockReopenQueue *reopen_queue,
                                    uint64_t perm, uint64_t shared,
                                    uint64_t *nperm, uint64_t *nshared)
diff --git a/block/vvfat.c b/block/vvfat.c
index cd8ae50a2c..6cf3c74fe3 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3211,6 +3211,7 @@ err:
 
 static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
                              const BdrvChildClass *child_class,
+                             BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t perm, uint64_t shared,
                              uint64_t *nperm, uint64_t *nshared)
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c03705ea37..b3d7960bd0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -87,6 +87,7 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
 
 static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
                                  const BdrvChildClass *child_class,
+                                 BdrvChildRole role,
                                  BlockReopenQueue *reopen_queue,
                                  uint64_t perm, uint64_t shared,
                                  uint64_t *nperm, uint64_t *nshared)
@@ -99,8 +100,8 @@ static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
         child_class = &child_file;
     }
 
-    bdrv_format_default_perms(bs, c, child_class, reopen_queue, perm, shared,
-                              nperm, nshared);
+    bdrv_format_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, nperm, nshared);
 }
 
 static int bdrv_test_change_backing_file(BlockDriverState *bs,
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 8b8c186c9f..3707e2533c 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -31,6 +31,7 @@ static BlockDriver bdrv_pass_through = {
 
 static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
                                          const BdrvChildClass *child_class,
+                                         BdrvChildRole role,
                                          BlockReopenQueue *reopen_queue,
                                          uint64_t perm, uint64_t shared,
                                          uint64_t *nperm, uint64_t *nshared)
-- 
2.25.4


