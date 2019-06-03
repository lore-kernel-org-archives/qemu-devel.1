Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC42FC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9522324CF9
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9522324CF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXogc-0001kg-OD
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:15:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVd-0001De-V7
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVT-0000R9-UD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoV8-0008Hw-BN; Mon, 03 Jun 2019 11:03:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88AACC1EB1EE;
	Mon,  3 Jun 2019 15:03:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5A1D61B6A;
	Mon,  3 Jun 2019 15:03:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:18 +0200
Message-Id: <20190603150233.6614-14-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 03 Jun 2019 15:03:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/28] block: Add BlockBackend.ctx
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a new parameter to blk_new() which requires its callers to
declare from which AioContext this BlockBackend is going to be used (or
the locks of which AioContext need to be taken anyway).

The given context is only stored and kept up to date when changing
AioContexts. Actually applying the stored AioContext to the root node
is saved for another commit.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h   |  2 +-
 block.c                          |  2 +-
 block/backup.c                   |  3 ++-
 block/block-backend.c            | 18 +++++++++++++++---
 block/commit.c                   | 11 +++++++----
 block/crypto.c                   |  3 ++-
 block/mirror.c                   |  3 ++-
 block/parallels.c                |  3 ++-
 block/qcow.c                     |  3 ++-
 block/qcow2.c                    |  6 ++++--
 block/qed.c                      |  3 ++-
 block/sheepdog.c                 |  3 ++-
 block/vdi.c                      |  3 ++-
 block/vhdx.c                     |  3 ++-
 block/vmdk.c                     |  3 ++-
 block/vpc.c                      |  3 ++-
 blockdev.c                       |  4 ++--
 blockjob.c                       |  2 +-
 hmp.c                            |  3 ++-
 hw/block/fdc.c                   |  2 +-
 hw/block/xen-block.c             |  2 +-
 hw/core/qdev-properties-system.c |  4 +++-
 hw/ide/qdev.c                    |  2 +-
 hw/scsi/scsi-disk.c              |  2 +-
 migration/block.c                |  3 ++-
 nbd/server.c                     |  5 +++--
 qemu-img.c                       |  6 ++++--
 tests/test-bdrv-drain.c          | 30 +++++++++++++++---------------
 tests/test-bdrv-graph-mod.c      |  5 +++--
 tests/test-block-backend.c       |  6 ++++--
 tests/test-block-iothread.c      | 10 +++++-----
 tests/test-blockjob.c            |  2 +-
 tests/test-throttle.c            |  6 +++---
 33 files changed, 102 insertions(+), 64 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 228fb3fb83..733c4957eb 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -76,7 +76,7 @@ typedef struct BlockBackendPublic {
     ThrottleGroupMember throttle_group_member;
 } BlockBackendPublic;
=20
-BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm);
+BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_pe=
rm);
 BlockBackend *blk_new_open(const char *filename, const char *reference,
                            QDict *options, int flags, Error **errp);
 int blk_get_refcnt(BlockBackend *blk);
diff --git a/block.c b/block.c
index 4c3902508d..69ceac6377 100644
--- a/block.c
+++ b/block.c
@@ -2884,7 +2884,7 @@ static BlockDriverState *bdrv_open_inherit(const ch=
ar *filename,
             /* Not requesting BLK_PERM_CONSISTENT_READ because we're onl=
y
              * looking at the header to guess the image format. This wor=
ks even
              * in cases where a guest would not see a consistent state. =
*/
-            file =3D blk_new(0, BLK_PERM_ALL);
+            file =3D blk_new(bdrv_get_aio_context(file_bs), 0, BLK_PERM_=
ALL);
             blk_insert_bs(file, file_bs, &local_err);
             bdrv_unref(file_bs);
             if (local_err) {
diff --git a/block/backup.c b/block/backup.c
index 00f4f8af53..715e1d3be8 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -627,7 +627,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     }
=20
     /* The target must match the source in size, so no resize here eithe=
r */
-    job->target =3D blk_new(BLK_PERM_WRITE,
+    job->target =3D blk_new(job->common.job.aio_context,
+                          BLK_PERM_WRITE,
                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD)=
;
     ret =3D blk_insert_bs(job->target, target, errp);
diff --git a/block/block-backend.c b/block/block-backend.c
index 390fde6f71..f03f14acb0 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -42,6 +42,7 @@ struct BlockBackend {
     char *name;
     int refcnt;
     BdrvChild *root;
+    AioContext *ctx;
     DriveInfo *legacy_dinfo;    /* null unless created by drive_new() */
     QTAILQ_ENTRY(BlockBackend) link;         /* for block_backends */
     QTAILQ_ENTRY(BlockBackend) monitor_link; /* for monitor_block_backen=
ds */
@@ -322,12 +323,13 @@ static const BdrvChildRole child_root =3D {
  *
  * Return the new BlockBackend on success, null on failure.
  */
-BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
+BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_pe=
rm)
 {
     BlockBackend *blk;
=20
     blk =3D g_new0(BlockBackend, 1);
     blk->refcnt =3D 1;
+    blk->ctx =3D ctx;
     blk->perm =3D perm;
     blk->shared_perm =3D shared_perm;
     blk_set_enable_write_cache(blk, true);
@@ -347,6 +349,7 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_=
perm)
=20
 /*
  * Creates a new BlockBackend, opens a new BlockDriverState, and connect=
s both.
+ * The new BlockBackend is in the main AioContext.
  *
  * Just as with bdrv_open(), after having called this function the refer=
ence to
  * @options belongs to the block layer (even on failure).
@@ -382,7 +385,7 @@ BlockBackend *blk_new_open(const char *filename, cons=
t char *reference,
         perm |=3D BLK_PERM_RESIZE;
     }
=20
-    blk =3D blk_new(perm, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), perm, BLK_PERM_ALL);
     bs =3D bdrv_open(filename, reference, options, flags, errp);
     if (!bs) {
         blk_unref(blk);
@@ -1856,7 +1859,15 @@ void blk_op_unblock_all(BlockBackend *blk, Error *=
reason)
=20
 AioContext *blk_get_aio_context(BlockBackend *blk)
 {
-    return bdrv_get_aio_context(blk_bs(blk));
+    BlockDriverState *bs =3D blk_bs(blk);
+
+    /* FIXME The AioContext of bs and blk can be inconsistent. For the m=
oment,
+     * we prefer the one of bs for compatibility. */
+    if (bs) {
+        return bdrv_get_aio_context(blk_bs(blk));
+    }
+
+    return blk->ctx;
 }
=20
 static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
@@ -1888,6 +1899,7 @@ static int blk_do_set_aio_context(BlockBackend *blk=
, AioContext *new_context,
         }
     }
=20
+    blk->ctx =3D new_context;
     return 0;
 }
=20
diff --git a/block/commit.c b/block/commit.c
index 14e5bb394c..4d519506d6 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -338,7 +338,8 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
         goto fail;
     }
=20
-    s->base =3D blk_new(BLK_PERM_CONSISTENT_READ
+    s->base =3D blk_new(s->common.job.aio_context,
+                      BLK_PERM_CONSISTENT_READ
                       | BLK_PERM_WRITE
                       | BLK_PERM_RESIZE,
                       BLK_PERM_CONSISTENT_READ
@@ -351,7 +352,7 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
     s->base_bs =3D base;
=20
     /* Required permissions are already taken with block_job_add_bdrv() =
*/
-    s->top =3D blk_new(0, BLK_PERM_ALL);
+    s->top =3D blk_new(s->common.job.aio_context, 0, BLK_PERM_ALL);
     ret =3D blk_insert_bs(s->top, top, errp);
     if (ret < 0) {
         goto fail;
@@ -395,6 +396,7 @@ int bdrv_commit(BlockDriverState *bs)
     BlockDriverState *backing_file_bs =3D NULL;
     BlockDriverState *commit_top_bs =3D NULL;
     BlockDriver *drv =3D bs->drv;
+    AioContext *ctx;
     int64_t offset, length, backing_length;
     int ro;
     int64_t n;
@@ -422,8 +424,9 @@ int bdrv_commit(BlockDriverState *bs)
         }
     }
=20
-    src =3D blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
-    backing =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ctx =3D bdrv_get_aio_context(bs);
+    src =3D blk_new(ctx, BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    backing =3D blk_new(ctx, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_=
ALL);
=20
     ret =3D blk_insert_bs(src, bs, &local_err);
     if (ret < 0) {
diff --git a/block/crypto.c b/block/crypto.c
index 3af46b805f..7351fd479d 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -257,7 +257,8 @@ static int block_crypto_co_create_generic(BlockDriver=
State *bs,
     QCryptoBlock *crypto =3D NULL;
     struct BlockCryptoCreateData data;
=20
-    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
=20
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
diff --git a/block/mirror.c b/block/mirror.c
index ec4bd9f404..eb96b52de9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1584,7 +1584,8 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
      * We can allow anything except resize there.*/
     target_is_backing =3D bdrv_chain_contains(bs, target);
     target_graph_mod =3D (backing_mode !=3D MIRROR_LEAVE_BACKING_CHAIN);
-    s->target =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE |
+    s->target =3D blk_new(s->common.job.aio_context,
+                        BLK_PERM_WRITE | BLK_PERM_RESIZE |
                         (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
                         BLK_PERM_WRITE_UNCHANGED |
                         (target_is_backing ? BLK_PERM_CONSISTENT_READ |
diff --git a/block/parallels.c b/block/parallels.c
index 2747400577..00fae125d1 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -554,7 +554,8 @@ static int coroutine_fn parallels_co_create(BlockdevC=
reateOptions* opts,
         return -EIO;
     }
=20
-    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto out;
diff --git a/block/qcow.c b/block/qcow.c
index 1bb8fd05e2..6dee5bb792 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -844,7 +844,8 @@ static int coroutine_fn qcow_co_create(BlockdevCreate=
Options *opts,
         return -EIO;
     }
=20
-    qcow_blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL)=
;
+    qcow_blk =3D blk_new(bdrv_get_aio_context(bs),
+                       BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret =3D blk_insert_bs(qcow_blk, bs, errp);
     if (ret < 0) {
         goto exit;
diff --git a/block/qcow2.c b/block/qcow2.c
index 14f914117f..9396d490d5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3174,7 +3174,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
     }
=20
     /* Create BlockBackend to write to the image */
-    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto out;
@@ -5006,7 +5007,8 @@ static int qcow2_amend_options(BlockDriverState *bs=
, QemuOpts *opts,
     }
=20
     if (new_size) {
-        BlockBackend *blk =3D blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
+        BlockBackend *blk =3D blk_new(bdrv_get_aio_context(bs),
+                                    BLK_PERM_RESIZE, BLK_PERM_ALL);
         ret =3D blk_insert_bs(blk, bs, errp);
         if (ret < 0) {
             blk_unref(blk);
diff --git a/block/qed.c b/block/qed.c
index dcdcd62b4a..bb4f5c9863 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -649,7 +649,8 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCr=
eateOptions *opts,
         return -EIO;
     }
=20
-    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto out;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index cbdfe9ab6e..f76d6ddbbc 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1800,7 +1800,8 @@ static int sd_prealloc(BlockDriverState *bs, int64_=
t old_size, int64_t new_size,
     void *buf =3D NULL;
     int ret;
=20
-    blk =3D blk_new(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM=
_RESIZE,
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_R=
ESIZE,
                   BLK_PERM_ALL);
=20
     ret =3D blk_insert_bs(blk, bs, errp);
diff --git a/block/vdi.c b/block/vdi.c
index d7ef6628e7..b9845a4cbd 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -803,7 +803,8 @@ static int coroutine_fn vdi_co_do_create(BlockdevCrea=
teOptions *create_options,
         goto exit;
     }
=20
-    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(bdrv_get_aio_context(bs_file),
+                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret =3D blk_insert_bs(blk, bs_file, errp);
     if (ret < 0) {
         goto exit;
diff --git a/block/vhdx.c b/block/vhdx.c
index a143a57657..d6070b6fa8 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1900,7 +1900,8 @@ static int coroutine_fn vhdx_co_create(BlockdevCrea=
teOptions *opts,
         return -EIO;
     }
=20
-    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto delete_and_exit;
diff --git a/block/vmdk.c b/block/vmdk.c
index de8cb859f8..51067c774f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2356,7 +2356,8 @@ static BlockBackend *vmdk_co_create_cb(int64_t size=
, int idx,
     if (!bs) {
         return NULL;
     }
-    blk =3D blk_new(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM=
_RESIZE,
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_R=
ESIZE,
                   BLK_PERM_ALL);
     if (blk_insert_bs(blk, bs, errp)) {
         bdrv_unref(bs);
diff --git a/block/vpc.c b/block/vpc.c
index 0c279b87c8..d4776ee8a5 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1011,7 +1011,8 @@ static int coroutine_fn vpc_co_create(BlockdevCreat=
eOptions *opts,
         return -EIO;
     }
=20
-    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(bdrv_get_aio_context(bs),
+                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto out;
diff --git a/blockdev.c b/blockdev.c
index d88dc115f2..80dad6d117 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -574,7 +574,7 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
     if ((!file || !*file) && !qdict_size(bs_opts)) {
         BlockBackendRootState *blk_rs;
=20
-        blk =3D blk_new(0, BLK_PERM_ALL);
+        blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
         blk_rs =3D blk_get_root_state(blk);
         blk_rs->open_flags    =3D bdrv_flags;
         blk_rs->read_only     =3D read_only;
@@ -3154,7 +3154,7 @@ void qmp_block_resize(bool has_device, const char *=
device,
         goto out;
     }
=20
-    blk =3D blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_RESIZE, BLK_PERM_AL=
L);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto out;
diff --git a/blockjob.c b/blockjob.c
index cc5f18e7cd..29517ae162 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -392,7 +392,7 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
         job_id =3D bdrv_get_device_name(bs);
     }
=20
-    blk =3D blk_new(perm, shared_perm);
+    blk =3D blk_new(bdrv_get_aio_context(bs), perm, shared_perm);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         blk_unref(blk);
diff --git a/hmp.c b/hmp.c
index 56a3ed7375..be5e345c6f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2560,7 +2560,8 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
     if (!blk) {
         BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
         if (bs) {
-            blk =3D local_blk =3D blk_new(0, BLK_PERM_ALL);
+            blk =3D local_blk =3D blk_new(bdrv_get_aio_context(bs),
+                                      0, BLK_PERM_ALL);
             ret =3D blk_insert_bs(blk, bs, &err);
             if (ret < 0) {
                 goto fail;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 6f19f127a5..37ccedc9f7 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -538,7 +538,7 @@ static void floppy_drive_realize(DeviceState *qdev, E=
rror **errp)
=20
     if (!dev->conf.blk) {
         /* Anonymous BlockBackend for an empty drive */
-        dev->conf.blk =3D blk_new(0, BLK_PERM_ALL);
+        dev->conf.blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_AL=
L);
         ret =3D blk_attach_dev(dev->conf.blk, qdev);
         assert(ret =3D=3D 0);
     }
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index ef635be4c2..31b0f5ccc8 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -609,7 +609,7 @@ static void xen_cdrom_realize(XenBlockDevice *blockde=
v, Error **errp)
         int rc;
=20
         /* Set up an empty drive */
-        conf->blk =3D blk_new(0, BLK_PERM_ALL);
+        conf->blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
=20
         rc =3D blk_attach_dev(conf->blk, DEVICE(blockdev));
         if (!rc) {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index b45a7ef54b..42e048f190 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -80,7 +80,9 @@ static void parse_drive(DeviceState *dev, const char *s=
tr, void **ptr,
     if (!blk) {
         BlockDriverState *bs =3D bdrv_lookup_bs(NULL, str, NULL);
         if (bs) {
-            blk =3D blk_new(0, BLK_PERM_ALL);
+            /* BlockBackends of devices start in the main context and ar=
e only
+             * later moved into another context if the device supports t=
hat. */
+            blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
             blk_created =3D true;
=20
             ret =3D blk_insert_bs(blk, bs, errp);
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 573b022e1e..360cd20bd8 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -168,7 +168,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKi=
nd kind, Error **errp)
             return;
         } else {
             /* Anonymous BlockBackend for an empty drive */
-            dev->conf.blk =3D blk_new(0, BLK_PERM_ALL);
+            dev->conf.blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PER=
M_ALL);
             ret =3D blk_attach_dev(dev->conf.blk, &dev->qdev);
             assert(ret =3D=3D 0);
         }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7e865ab3b..91c5a8b1ac 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2417,7 +2417,7 @@ static void scsi_cd_realize(SCSIDevice *dev, Error =
**errp)
     if (!dev->conf.blk) {
         /* Anonymous BlockBackend for an empty drive. As we put it into
          * dev->conf, qdev takes care of detaching on unplug. */
-        dev->conf.blk =3D blk_new(0, BLK_PERM_ALL);
+        dev->conf.blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_AL=
L);
         ret =3D blk_attach_dev(dev->conf.blk, &dev->qdev);
         assert(ret =3D=3D 0);
     }
diff --git a/migration/block.c b/migration/block.c
index 83c633fb3f..91f98ef44a 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -417,7 +417,8 @@ static int init_blk_migration(QEMUFile *f)
         }
=20
         bmds =3D g_new0(BlkMigDevState, 1);
-        bmds->blk =3D blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+        bmds->blk =3D blk_new(qemu_get_aio_context(),
+                            BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
         bmds->blk_name =3D g_strdup(bdrv_get_device_name(bs));
         bmds->bulk_completed =3D 0;
         bmds->total_sectors =3D sectors;
diff --git a/nbd/server.c b/nbd/server.c
index d1375350bc..aeca3893fe 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1484,8 +1484,9 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
     if ((nbdflags & NBD_FLAG_READ_ONLY) =3D=3D 0) {
         perm |=3D BLK_PERM_WRITE;
     }
-    blk =3D blk_new(perm, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCH=
ANGED |
-                        BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
+    blk =3D blk_new(bdrv_get_aio_context(bs), perm,
+                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                  BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
     ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto fail;
diff --git a/qemu-img.c b/qemu-img.c
index b0535919b1..07b6e2a808 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3313,7 +3313,8 @@ static int img_rebase(int argc, char **argv)
         BlockDriverState *base_bs =3D backing_bs(bs);
=20
         if (base_bs) {
-            blk_old_backing =3D blk_new(BLK_PERM_CONSISTENT_READ,
+            blk_old_backing =3D blk_new(qemu_get_aio_context(),
+                                      BLK_PERM_CONSISTENT_READ,
                                       BLK_PERM_ALL);
             ret =3D blk_insert_bs(blk_old_backing, base_bs,
                                 &local_err);
@@ -3360,7 +3361,8 @@ static int img_rebase(int argc, char **argv)
             prefix_chain_bs =3D bdrv_find_backing_image(bs, out_real_pat=
h);
             if (prefix_chain_bs) {
                 g_free(out_real_path);
-                blk_new_backing =3D blk_new(BLK_PERM_CONSISTENT_READ,
+                blk_new_backing =3D blk_new(qemu_get_aio_context(),
+                                          BLK_PERM_CONSISTENT_READ,
                                           BLK_PERM_ALL);
                 ret =3D blk_insert_bs(blk_new_backing, prefix_chain_bs,
                                     &local_err);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index e86798923f..fabbd52d93 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -206,7 +206,7 @@ static void test_drv_cb_common(enum drain_type drain_=
type, bool recursive)
=20
     QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs =3D bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
     s =3D bs->opaque;
@@ -290,7 +290,7 @@ static void test_quiesce_common(enum drain_type drain=
_type, bool recursive)
     BlockBackend *blk;
     BlockDriverState *bs, *backing;
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs =3D bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
     blk_insert_bs(blk, bs, &error_abort);
@@ -353,7 +353,7 @@ static void test_nested(void)
     BDRVTestState *s, *backing_s;
     enum drain_type outer, inner;
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs =3D bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
     s =3D bs->opaque;
@@ -402,13 +402,13 @@ static void test_multiparent(void)
     BlockDriverState *bs_a, *bs_b, *backing;
     BDRVTestState *a_s, *b_s, *backing_s;
=20
-    blk_a =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_a =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL=
);
     bs_a =3D bdrv_new_open_driver(&bdrv_test, "test-node-a", BDRV_O_RDWR=
,
                                 &error_abort);
     a_s =3D bs_a->opaque;
     blk_insert_bs(blk_a, bs_a, &error_abort);
=20
-    blk_b =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_b =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL=
);
     bs_b =3D bdrv_new_open_driver(&bdrv_test, "test-node-b", BDRV_O_RDWR=
,
                                 &error_abort);
     b_s =3D bs_b->opaque;
@@ -475,13 +475,13 @@ static void test_graph_change_drain_subtree(void)
     BlockDriverState *bs_a, *bs_b, *backing;
     BDRVTestState *a_s, *b_s, *backing_s;
=20
-    blk_a =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_a =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL=
);
     bs_a =3D bdrv_new_open_driver(&bdrv_test, "test-node-a", BDRV_O_RDWR=
,
                                 &error_abort);
     a_s =3D bs_a->opaque;
     blk_insert_bs(blk_a, bs_a, &error_abort);
=20
-    blk_b =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_b =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL=
);
     bs_b =3D bdrv_new_open_driver(&bdrv_test, "test-node-b", BDRV_O_RDWR=
,
                                 &error_abort);
     b_s =3D bs_b->opaque;
@@ -555,7 +555,7 @@ static void test_graph_change_drain_all(void)
     BDRVTestState *a_s, *b_s;
=20
     /* Create node A with a BlockBackend */
-    blk_a =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_a =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL=
);
     bs_a =3D bdrv_new_open_driver(&bdrv_test, "test-node-a", BDRV_O_RDWR=
,
                                 &error_abort);
     a_s =3D bs_a->opaque;
@@ -571,7 +571,7 @@ static void test_graph_change_drain_all(void)
     g_assert_cmpint(a_s->drain_count, =3D=3D, 1);
=20
     /* Create node B with a BlockBackend */
-    blk_b =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_b =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL=
);
     bs_b =3D bdrv_new_open_driver(&bdrv_test, "test-node-b", BDRV_O_RDWR=
,
                                 &error_abort);
     b_s =3D bs_b->opaque;
@@ -672,7 +672,7 @@ static void test_iothread_common(enum drain_type drai=
n_type, int drain_thread)
         goto out;
     }
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs =3D bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
     s =3D bs->opaque;
@@ -883,7 +883,7 @@ static void test_blockjob_common_drain_node(enum drai=
n_type drain_type,
     bdrv_set_backing_hd(src, src_backing, &error_abort);
     bdrv_unref(src_backing);
=20
-    blk_src =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_src =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_A=
LL);
     blk_insert_bs(blk_src, src_overlay, &error_abort);
=20
     switch (drain_node) {
@@ -910,7 +910,7 @@ static void test_blockjob_common_drain_node(enum drai=
n_type drain_type,
=20
     target =3D bdrv_new_open_driver(&bdrv_test, "target", BDRV_O_RDWR,
                                   &error_abort);
-    blk_target =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_target =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PER=
M_ALL);
     blk_insert_bs(blk_target, target, &error_abort);
=20
     aio_context_acquire(ctx);
@@ -1205,7 +1205,7 @@ static void do_test_delete_by_drain(bool detach_ins=
tead_of_delete,
                         &error_abort);
     bdrv_attach_child(bs, null_bs, "null-child", &child_file, &error_abo=
rt);
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
=20
     /* Referenced by blk now */
@@ -1368,7 +1368,7 @@ static void test_detach_indirect(bool by_parent_cb)
     c =3D bdrv_new_open_driver(&bdrv_test, "c", BDRV_O_RDWR, &error_abor=
t);
=20
     /* blk is a BB for parent-a */
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, parent_a, &error_abort);
     bdrv_unref(parent_a);
=20
@@ -1460,7 +1460,7 @@ static void test_append_to_drained(void)
     BlockDriverState *base, *overlay;
     BDRVTestState *base_s, *overlay_s;
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     base =3D bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &erro=
r_abort);
     base_s =3D base->opaque;
     blk_insert_bs(blk, base, &error_abort);
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 747c0bf8fc..cfeec36566 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -102,7 +102,8 @@ static void test_update_perm_tree(void)
 {
     Error *local_err =3D NULL;
=20
-    BlockBackend *root =3D blk_new(BLK_PERM_WRITE | BLK_PERM_CONSISTENT_=
READ,
+    BlockBackend *root =3D blk_new(qemu_get_aio_context(),
+                                 BLK_PERM_WRITE | BLK_PERM_CONSISTENT_RE=
AD,
                                  BLK_PERM_ALL & ~BLK_PERM_WRITE);
     BlockDriverState *bs =3D no_perm_node("node");
     BlockDriverState *filter =3D pass_through_node("filter");
@@ -165,7 +166,7 @@ static void test_update_perm_tree(void)
  */
 static void test_should_update_child(void)
 {
-    BlockBackend *root =3D blk_new(0, BLK_PERM_ALL);
+    BlockBackend *root =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_A=
LL);
     BlockDriverState *bs =3D no_perm_node("node");
     BlockDriverState *filter =3D no_perm_node("filter");
     BlockDriverState *target =3D no_perm_node("target");
diff --git a/tests/test-block-backend.c b/tests/test-block-backend.c
index fd59f02bd0..5b5d6845c0 100644
--- a/tests/test-block-backend.c
+++ b/tests/test-block-backend.c
@@ -37,7 +37,8 @@ static void test_drain_aio_error_flush_cb(void *opaque,=
 int ret)
=20
 static void test_drain_aio_error(void)
 {
-    BlockBackend *blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    BlockBackend *blk =3D blk_new(qemu_get_aio_context(),
+                                BLK_PERM_ALL, BLK_PERM_ALL);
     BlockAIOCB *acb;
     bool completed =3D false;
=20
@@ -53,7 +54,8 @@ static void test_drain_aio_error(void)
=20
 static void test_drain_all_aio_error(void)
 {
-    BlockBackend *blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    BlockBackend *blk =3D blk_new(qemu_get_aio_context(),
+                                BLK_PERM_ALL, BLK_PERM_ALL);
     BlockAIOCB *acb;
     bool completed =3D false;
=20
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 1d47ea9895..2200487d76 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -336,7 +336,7 @@ static void test_sync_op(const void *opaque)
     BlockDriverState *bs;
     BdrvChild *c;
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs =3D bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_=
abort);
     bs->total_sectors =3D 65536 / BDRV_SECTOR_SIZE;
     blk_insert_bs(blk, bs, &error_abort);
@@ -415,7 +415,7 @@ static void test_attach_blockjob(void)
     BlockDriverState *bs;
     TestBlockJob *tjob;
=20
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs =3D bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_=
abort);
     blk_insert_bs(blk, bs, &error_abort);
=20
@@ -481,7 +481,7 @@ static void test_propagate_basic(void)
     QDict *options;
=20
     /* Create bs_a and its BlockBackend */
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs_a =3D bdrv_new_open_driver(&bdrv_test, "bs_a", BDRV_O_RDWR, &erro=
r_abort);
     blk_insert_bs(blk, bs_a, &error_abort);
=20
@@ -561,7 +561,7 @@ static void test_propagate_diamond(void)
     qdict_put_str(options, "raw", "bs_c");
=20
     bs_verify =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abo=
rt);
-    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs_verify, &error_abort);
=20
     /* Switch the AioContext */
@@ -628,7 +628,7 @@ static void test_propagate_mirror(void)
     g_assert(bdrv_get_aio_context(filter) =3D=3D main_ctx);
=20
     /* With a BlockBackend on src, changing target must fail */
-    blk =3D blk_new(0, BLK_PERM_ALL);
+    blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
     blk_insert_bs(blk, src, &error_abort);
=20
     bdrv_try_set_aio_context(target, ctx, &local_err);
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 652d1e8359..8c91980c70 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -68,7 +68,7 @@ static BlockJob *do_test_id(BlockBackend *blk, const ch=
ar *id,
 static BlockBackend *create_blk(const char *name)
 {
     /* No I/O is performed on this device */
-    BlockBackend *blk =3D blk_new(0, BLK_PERM_ALL);
+    BlockBackend *blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_AL=
L);
     BlockDriverState *bs;
=20
     bs =3D bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 948a42c991..5644cf95ca 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -675,9 +675,9 @@ static void test_groups(void)
     ThrottleGroupMember *tgm1, *tgm2, *tgm3;
=20
     /* No actual I/O is performed on these devices */
-    blk1 =3D blk_new(0, BLK_PERM_ALL);
-    blk2 =3D blk_new(0, BLK_PERM_ALL);
-    blk3 =3D blk_new(0, BLK_PERM_ALL);
+    blk1 =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
+    blk2 =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
+    blk3 =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
=20
     blkp1 =3D blk_get_public(blk1);
     blkp2 =3D blk_get_public(blk2);
--=20
2.20.1


