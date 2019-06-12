Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C6DC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546BC20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546BC20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBy6-000589-BU
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBSq-0008Nt-HY
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBSo-00089J-BR
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSg-00083M-Ql; Wed, 12 Jun 2019 18:11:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC67030C31A4;
 Wed, 12 Jun 2019 22:11:16 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ABF75DEDF;
 Wed, 12 Jun 2019 22:11:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:49 +0200
Message-Id: <20190612221004.2317-28-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 22:11:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 27/42] commit: Deal with filters
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes some permission limiting (for example, we only need to
take the RESIZE permission if the base is smaller than the top).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-backend.c | 16 ++++---
 block/commit.c        | 97 ++++++++++++++++++++++++++++++++-----------
 blockdev.c            |  6 ++-
 3 files changed, 87 insertions(+), 32 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f5d9407d20..227a6951a0 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2156,11 +2156,17 @@ int blk_commit_all(void)
         AioContext *aio_context =3D blk_get_aio_context(blk);
=20
         aio_context_acquire(aio_context);
-        if (blk_is_inserted(blk) && blk->root->bs->backing) {
-            int ret =3D bdrv_commit(blk->root->bs);
-            if (ret < 0) {
-                aio_context_release(aio_context);
-                return ret;
+        if (blk_is_inserted(blk)) {
+            BlockDriverState *non_filter;
+
+            /* Legacy function, so skip implicit filters */
+            non_filter =3D bdrv_skip_implicit_filters(blk->root->bs);
+            if (bdrv_filtered_cow_child(non_filter)) {
+                int ret =3D bdrv_commit(non_filter);
+                if (ret < 0) {
+                    aio_context_release(aio_context);
+                    return ret;
+                }
             }
         }
         aio_context_release(aio_context);
diff --git a/block/commit.c b/block/commit.c
index f20a26fecd..ec5a8c8edf 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -112,7 +112,7 @@ static void commit_abort(Job *job)
      * something to base, the intermediate images aren't valid any more.=
 */
     bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
+    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
                       &error_abort);
=20
     bdrv_unref(s->commit_top_bs);
@@ -137,6 +137,7 @@ static void commit_clean(Job *job)
 static int coroutine_fn commit_run(Job *job, Error **errp)
 {
     CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.job);
+    BlockDriverState *filtered_base;
     int64_t offset;
     uint64_t delay_ns =3D 0;
     int ret =3D 0;
@@ -163,6 +164,9 @@ static int coroutine_fn commit_run(Job *job, Error **=
errp)
         }
     }
=20
+    filtered_base =3D bdrv_filtered_cow_bs(bdrv_find_overlay(blk_bs(s->t=
op),
+                                                           blk_bs(s->bas=
e)));
+
     buf =3D blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
=20
     for (offset =3D 0; offset < len; offset +=3D n) {
@@ -176,7 +180,7 @@ static int coroutine_fn commit_run(Job *job, Error **=
errp)
             break;
         }
         /* Copy if allocated above the base */
-        ret =3D bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),
+        ret =3D bdrv_is_allocated_above(blk_bs(s->top), filtered_base,
                                       offset, COMMIT_BUFFER_SIZE, &n);
         copy =3D (ret =3D=3D 1);
         trace_commit_one_iteration(s, offset, n, ret);
@@ -269,15 +273,35 @@ void commit_start(const char *job_id, BlockDriverSt=
ate *bs,
     CommitBlockJob *s;
     BlockDriverState *iter;
     BlockDriverState *commit_top_bs =3D NULL;
+    BlockDriverState *filtered_base;
     Error *local_err =3D NULL;
+    int64_t base_size, top_size;
+    uint64_t perms, iter_shared_perms;
     int ret;
=20
     assert(top !=3D bs);
-    if (top =3D=3D base) {
+    if (bdrv_skip_rw_filters(top) =3D=3D bdrv_skip_rw_filters(base)) {
         error_setg(errp, "Invalid files for merge: top and base are the =
same");
         return;
     }
=20
+    base_size =3D bdrv_getlength(base);
+    if (base_size < 0) {
+        error_setg_errno(errp, -base_size, "Could not inquire base image=
 size");
+        return;
+    }
+
+    top_size =3D bdrv_getlength(top);
+    if (top_size < 0) {
+        error_setg_errno(errp, -top_size, "Could not inquire top image s=
ize");
+        return;
+    }
+
+    perms =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+    if (base_size < top_size) {
+        perms |=3D BLK_PERM_RESIZE;
+    }
+
     s =3D block_job_create(job_id, &commit_job_driver, NULL, bs, 0, BLK_=
PERM_ALL,
                          speed, creation_flags, NULL, NULL, errp);
     if (!s) {
@@ -313,17 +337,43 @@ void commit_start(const char *job_id, BlockDriverSt=
ate *bs,
=20
     s->commit_top_bs =3D commit_top_bs;
=20
-    /* Block all nodes between top and base, because they will
-     * disappear from the chain after this operation. */
+    /*
+     * Block all nodes between top and base, because they will
+     * disappear from the chain after this operation.
+     * Note that this assumes that the user is fine with removing all
+     * nodes (including R/W filters) between top and base.  Assuring
+     * this is the responsibility of the interface (i.e. whoever calls
+     * commit_start()).
+     */
     assert(bdrv_chain_contains(top, base));
-    for (iter =3D top; iter !=3D base; iter =3D backing_bs(iter)) {
-        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ours=
elves
-         * at s->base (if writes are blocked for a node, they are also b=
locked
-         * for its backing file). The other options would be a second fi=
lter
-         * driver above s->base. */
+
+    /*
+     * The topmost node with
+     * bdrv_skip_rw_filters(filtered_base) =3D=3D bdrv_skip_rw_filters(b=
ase)
+     */
+    filtered_base =3D bdrv_filtered_cow_bs(bdrv_find_overlay(top, base))=
;
+
+    assert(bdrv_skip_rw_filters(filtered_base) =3D=3D bdrv_skip_rw_filte=
rs(base));
+
+    /*
+     * XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselve=
s
+     * at s->base (if writes are blocked for a node, they are also block=
ed
+     * for its backing file). The other options would be a second filter
+     * driver above s->base.
+     */
+    iter_shared_perms =3D BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
+
+    for (iter =3D top; iter !=3D base; iter =3D bdrv_filtered_bs(iter)) =
{
+        if (iter =3D=3D filtered_base) {
+            /*
+             * From here on, all nodes are filters on the base.  This
+             * allows us to share BLK_PERM_CONSISTENT_READ.
+             */
+            iter_shared_perms |=3D BLK_PERM_CONSISTENT_READ;
+        }
+
         ret =3D block_job_add_bdrv(&s->common, "intermediate node", iter=
, 0,
-                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRI=
TE,
-                                 errp);
+                                 iter_shared_perms, errp);
         if (ret < 0) {
             goto fail;
         }
@@ -340,9 +390,7 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
     }
=20
     s->base =3D blk_new(s->common.job.aio_context,
-                      BLK_PERM_CONSISTENT_READ
-                      | BLK_PERM_WRITE
-                      | BLK_PERM_RESIZE,
+                      perms,
                       BLK_PERM_CONSISTENT_READ
                       | BLK_PERM_GRAPH_MOD
                       | BLK_PERM_WRITE_UNCHANGED);
@@ -408,19 +456,22 @@ int bdrv_commit(BlockDriverState *bs)
     if (!drv)
         return -ENOMEDIUM;
=20
-    if (!bs->backing) {
+    backing_file_bs =3D bdrv_filtered_cow_bs(bs);
+
+    if (!backing_file_bs) {
         return -ENOTSUP;
     }
=20
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
-        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARGET,=
 NULL)) {
+        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET,=
 NULL))
+    {
         return -EBUSY;
     }
=20
-    ro =3D bs->backing->bs->read_only;
+    ro =3D backing_file_bs->read_only;
=20
     if (ro) {
-        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) {
+        if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) {
             return -EACCES;
         }
     }
@@ -436,8 +487,6 @@ int bdrv_commit(BlockDriverState *bs)
     }
=20
     /* Insert commit_top block node above backing, so we can write to it=
 */
-    backing_file_bs =3D backing_bs(bs);
-
     commit_top_bs =3D bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_=
O_RDWR,
                                          &local_err);
     if (commit_top_bs =3D=3D NULL) {
@@ -522,15 +571,13 @@ ro_cleanup:
     qemu_vfree(buf);
=20
     blk_unref(backing);
-    if (backing_file_bs) {
-        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
-    }
+    bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     bdrv_unref(commit_top_bs);
     blk_unref(src);
=20
     if (ro) {
         /* ignoring error return here */
-        bdrv_reopen_set_read_only(bs->backing->bs, true, NULL);
+        bdrv_reopen_set_read_only(backing_file_bs, true, NULL);
     }
=20
     return ret;
diff --git a/blockdev.c b/blockdev.c
index 605e7b0994..5036d064d4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1095,7 +1095,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
             return;
         }
=20
-        bs =3D blk_bs(blk);
+        bs =3D bdrv_skip_implicit_filters(blk_bs(blk));
         aio_context =3D bdrv_get_aio_context(bs);
         aio_context_acquire(aio_context);
=20
@@ -3392,7 +3392,9 @@ void qmp_block_commit(bool has_job_id, const char *=
job_id, const char *device,
=20
     assert(bdrv_get_aio_context(base_bs) =3D=3D aio_context);
=20
-    for (iter =3D top_bs; iter !=3D backing_bs(base_bs); iter =3D backin=
g_bs(iter)) {
+    for (iter =3D top_bs; iter !=3D bdrv_filtered_bs(base_bs);
+         iter =3D bdrv_filtered_bs(iter))
+    {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_COMMIT_TARGET, errp))=
 {
             goto out;
         }
--=20
2.21.0


