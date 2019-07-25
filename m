Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AD5C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D1F217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D1F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgbX-0007oU-UN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hqgad-0004BT-KG
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hqgaX-0003xz-Cd
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hqgaS-0003tL-Ev; Thu, 25 Jul 2019 12:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E96C300CB0E;
 Thu, 25 Jul 2019 16:27:23 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-146.ams2.redhat.com
 [10.36.117.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1405D772;
 Thu, 25 Jul 2019 16:27:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:27:04 +0200
Message-Id: <20190725162704.12622-5-kwolf@redhat.com>
In-Reply-To: <20190725162704.12622-1-kwolf@redhat.com>
References: <20190725162704.12622-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 25 Jul 2019 16:27:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] block-backend: Queue requests while drained
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, dplotnikov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes device like IDE that can still start new requests from I/O
handlers in the CPU thread while the block backend is drained.

The basic assumption is that in a drain section, no new requests should
be allowed through a BlockBackend (blk_drained_begin/end don't exist,
we get drain sections only on the node level). However, there are two
special cases where requests should not be queued:

1. Block jobs: We already make sure that block jobs are paused in a
   drain section, so they won't start new requests. However, if the
   drain_begin is called on the job's BlockBackend first, it can happen
   that we deadlock because the job stays busy until it reaches a pause
   point - which it can't if it's requests aren't processed any more.

   The proper solution here would be to make all requests through the
   job's filter node instead of using a BlockBackend. For now, just
   disabling request queuin on the job BlockBackend is simpler.

2. In test cases where making requests through bdrv_* would be
   cumbersome because we'd need a BdrvChild. As we already got the
   functionality to disable request queuing from 1., use it in tests,
   too, for convenience.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h | 11 +++---
 block/backup.c                 |  1 +
 block/block-backend.c          | 69 +++++++++++++++++++++++++++++-----
 block/commit.c                 |  2 +
 block/mirror.c                 |  6 ++-
 blockjob.c                     |  3 ++
 tests/test-bdrv-drain.c        |  1 +
 7 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 7320b58467..d453a4e9a1 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -104,6 +104,7 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, =
uint64_t *shared_perm);
=20
 void blk_set_allow_write_beyond_eof(BlockBackend *blk, bool allow);
 void blk_set_allow_aio_context_change(BlockBackend *blk, bool allow);
+void blk_set_disable_request_queuing(BlockBackend *blk, bool disable);
 void blk_iostatus_enable(BlockBackend *blk);
 bool blk_iostatus_is_enabled(const BlockBackend *blk);
 BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk);
@@ -119,10 +120,10 @@ BlockBackend *blk_by_qdev_id(const char *id, Error =
**errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *op=
aque);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
-                               BdrvRequestFlags flags);
+                               BdrvRequestFlags flags, bool wait_while_d=
rained);
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
-                               BdrvRequestFlags flags);
+                                unsigned int bytes, QEMUIOVector *qiov,
+                                BdrvRequestFlags flags, bool wait_while_=
drained);
=20
 static inline int coroutine_fn blk_co_pread(BlockBackend *blk, int64_t o=
ffset,
                                             unsigned int bytes, void *bu=
f,
@@ -130,7 +131,7 @@ static inline int coroutine_fn blk_co_pread(BlockBack=
end *blk, int64_t offset,
 {
     QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
=20
-    return blk_co_preadv(blk, offset, bytes, &qiov, flags);
+    return blk_co_preadv(blk, offset, bytes, &qiov, flags, true);
 }
=20
 static inline int coroutine_fn blk_co_pwrite(BlockBackend *blk, int64_t =
offset,
@@ -139,7 +140,7 @@ static inline int coroutine_fn blk_co_pwrite(BlockBac=
kend *blk, int64_t offset,
 {
     QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
=20
-    return blk_co_pwritev(blk, offset, bytes, &qiov, flags);
+    return blk_co_pwritev(blk, offset, bytes, &qiov, flags, true);
 }
=20
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
diff --git a/block/backup.c b/block/backup.c
index 715e1d3be8..f66b2f4ee7 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -635,6 +635,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     if (ret < 0) {
         goto error;
     }
+    blk_set_disable_request_queuing(job->target, true);
=20
     job->on_source_error =3D on_source_error;
     job->on_target_error =3D on_target_error;
diff --git a/block/block-backend.c b/block/block-backend.c
index fdd6b01ecf..603b281743 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -79,6 +79,9 @@ struct BlockBackend {
     QLIST_HEAD(, BlockBackendAioNotifier) aio_notifiers;
=20
     int quiesce_counter;
+    CoQueue queued_requests;
+    bool disable_request_queuing;
+
     VMChangeStateEntry *vmsh;
     bool force_allow_inactivate;
=20
@@ -339,6 +342,7 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm,=
 uint64_t shared_perm)
=20
     block_acct_init(&blk->stats);
=20
+    qemu_co_queue_init(&blk->queued_requests);
     notifier_list_init(&blk->remove_bs_notifiers);
     notifier_list_init(&blk->insert_bs_notifiers);
     QLIST_INIT(&blk->aio_notifiers);
@@ -1096,6 +1100,11 @@ void blk_set_allow_aio_context_change(BlockBackend=
 *blk, bool allow)
     blk->allow_aio_context_change =3D allow;
 }
=20
+void blk_set_disable_request_queuing(BlockBackend *blk, bool disable)
+{
+    blk->disable_request_queuing =3D disable;
+}
+
 static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
                                   size_t size)
 {
@@ -1127,13 +1136,26 @@ static int blk_check_byte_request(BlockBackend *b=
lk, int64_t offset,
     return 0;
 }
=20
+static void blk_wait_while_drained(BlockBackend *blk)
+{
+    if (blk->quiesce_counter && !blk->disable_request_queuing) {
+        qemu_co_queue_wait(&blk->queued_requests, NULL);
+    }
+}
+
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
-                               BdrvRequestFlags flags)
+                               BdrvRequestFlags flags, bool wait_while_d=
rained)
 {
     int ret;
-    BlockDriverState *bs =3D blk_bs(blk);
+    BlockDriverState *bs;
=20
+    if (wait_while_drained) {
+        blk_wait_while_drained(blk);
+    }
+
+    /* Call blk_bs() only after waiting, the graph may have changed */
+    bs =3D blk_bs(blk);
     trace_blk_co_preadv(blk, bs, offset, bytes, flags);
=20
     ret =3D blk_check_byte_request(blk, offset, bytes);
@@ -1156,11 +1178,17 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk,=
 int64_t offset,
=20
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
                                 unsigned int bytes, QEMUIOVector *qiov,
-                                BdrvRequestFlags flags)
+                                BdrvRequestFlags flags, bool wait_while_=
drained)
 {
     int ret;
-    BlockDriverState *bs =3D blk_bs(blk);
+    BlockDriverState *bs;
+
+    if (wait_while_drained) {
+        blk_wait_while_drained(blk);
+    }
=20
+    /* Call blk_bs() only after waiting, the graph may have changed */
+    bs =3D blk_bs(blk);
     trace_blk_co_pwritev(blk, bs, offset, bytes, flags);
=20
     ret =3D blk_check_byte_request(blk, offset, bytes);
@@ -1198,7 +1226,7 @@ static void blk_read_entry(void *opaque)
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
     rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
-                              qiov, rwco->flags);
+                              qiov, rwco->flags, true);
     aio_wait_kick();
 }
=20
@@ -1208,7 +1236,7 @@ static void blk_write_entry(void *opaque)
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
     rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
-                               qiov, rwco->flags);
+                               qiov, rwco->flags, true);
     aio_wait_kick();
 }
=20
@@ -1349,9 +1377,15 @@ static void blk_aio_read_entry(void *opaque)
     BlkRwCo *rwco =3D &acb->rwco;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
+    if (rwco->blk->quiesce_counter) {
+        blk_dec_in_flight(rwco->blk);
+        blk_wait_while_drained(rwco->blk);
+        blk_inc_in_flight(rwco->blk);
+    }
+
     assert(qiov->size =3D=3D acb->bytes);
     rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, acb->bytes,
-                              qiov, rwco->flags);
+                              qiov, rwco->flags, false);
     blk_aio_complete(acb);
 }
=20
@@ -1361,9 +1395,15 @@ static void blk_aio_write_entry(void *opaque)
     BlkRwCo *rwco =3D &acb->rwco;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
+    if (rwco->blk->quiesce_counter) {
+        blk_dec_in_flight(rwco->blk);
+        blk_wait_while_drained(rwco->blk);
+        blk_inc_in_flight(rwco->blk);
+    }
+
     assert(!qiov || qiov->size =3D=3D acb->bytes);
     rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, acb->bytes,
-                               qiov, rwco->flags);
+                               qiov, rwco->flags, false);
     blk_aio_complete(acb);
 }
=20
@@ -1482,6 +1522,8 @@ void blk_aio_cancel_async(BlockAIOCB *acb)
=20
 int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
 {
+    blk_wait_while_drained(blk);
+
     if (!blk_is_available(blk)) {
         return -ENOMEDIUM;
     }
@@ -1522,7 +1564,11 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsig=
ned long int req, void *buf,
=20
 int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
 {
-    int ret =3D blk_check_byte_request(blk, offset, bytes);
+    int ret;
+
+    blk_wait_while_drained(blk);
+
+    ret =3D blk_check_byte_request(blk, offset, bytes);
     if (ret < 0) {
         return ret;
     }
@@ -2004,7 +2050,7 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend =
*blk, int64_t offset,
                                       int bytes, BdrvRequestFlags flags)
 {
     return blk_co_pwritev(blk, offset, bytes, NULL,
-                          flags | BDRV_REQ_ZERO_WRITE);
+                          flags | BDRV_REQ_ZERO_WRITE, true);
 }
=20
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void =
*buf,
@@ -2232,6 +2278,9 @@ static void blk_root_drained_end(BdrvChild *child, =
int *drained_end_counter)
         if (blk->dev_ops && blk->dev_ops->drained_end) {
             blk->dev_ops->drained_end(blk->dev_opaque);
         }
+        while (qemu_co_enter_next(&blk->queued_requests, NULL)) {
+            /* Resume all queued requests */
+        }
     }
 }
=20
diff --git a/block/commit.c b/block/commit.c
index 2c5a6d4ebc..408ae15389 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -350,6 +350,7 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
     if (ret < 0) {
         goto fail;
     }
+    blk_set_disable_request_queuing(s->base, true);
     s->base_bs =3D base;
=20
     /* Required permissions are already taken with block_job_add_bdrv() =
*/
@@ -358,6 +359,7 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
     if (ret < 0) {
         goto fail;
     }
+    blk_set_disable_request_queuing(s->top, true);
=20
     s->backing_file_str =3D g_strdup(backing_file_str);
     s->on_error =3D on_error;
diff --git a/block/mirror.c b/block/mirror.c
index 7483051f8d..8d0a3a987d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -231,7 +231,8 @@ static void coroutine_fn mirror_read_complete(MirrorO=
p *op, int ret)
         return;
     }
=20
-    ret =3D blk_co_pwritev(s->target, op->offset, op->qiov.size, &op->qi=
ov, 0);
+    ret =3D blk_co_pwritev(s->target, op->offset, op->qiov.size, &op->qi=
ov, 0,
+                         false);
     mirror_write_complete(op, ret);
 }
=20
@@ -1237,7 +1238,7 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMet=
hod method,
         switch (method) {
         case MIRROR_METHOD_COPY:
             ret =3D blk_co_pwritev(job->target, dirty_offset, dirty_byte=
s,
-                                 qiov ? &target_qiov : NULL, flags);
+                                 qiov ? &target_qiov : NULL, flags, fals=
e);
             break;
=20
         case MIRROR_METHOD_ZERO:
@@ -1624,6 +1625,7 @@ static BlockJob *mirror_start_job(
         blk_set_force_allow_inactivate(s->target);
     }
     blk_set_allow_aio_context_change(s->target, true);
+    blk_set_disable_request_queuing(s->target, true);
=20
     s->replaces =3D g_strdup(replaces);
     s->on_source_error =3D on_source_error;
diff --git a/blockjob.c b/blockjob.c
index 20b7f557da..73d9f1ba2b 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -445,6 +445,9 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
=20
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
=20
+    /* Disable request queuing in the BlockBackend to avoid deadlocks on=
 drain:
+     * The job reports that it's busy until it reaches a pause point. */
+    blk_set_disable_request_queuing(blk, true);
     blk_set_allow_aio_context_change(blk, true);
=20
     /* Only set speed when necessary to avoid NotSupported error */
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 03fa1142a1..3fcf7c1c95 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -677,6 +677,7 @@ static void test_iothread_common(enum drain_type drai=
n_type, int drain_thread)
                               &error_abort);
     s =3D bs->opaque;
     blk_insert_bs(blk, bs, &error_abort);
+    blk_set_disable_request_queuing(blk, true);
=20
     blk_set_aio_context(blk, ctx_a, &error_abort);
     aio_context_acquire(ctx_a);
--=20
2.20.1


