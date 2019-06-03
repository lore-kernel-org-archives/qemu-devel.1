Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D759C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E529420449
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E529420449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36403 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXodM-0007FX-0j
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:12:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoV0-0000j3-GP
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUv-0007s0-8l
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoUq-0007jS-L0; Mon, 03 Jun 2019 11:03:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70FC13001572;
	Mon,  3 Jun 2019 15:03:28 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84FE267279;
	Mon,  3 Jun 2019 15:03:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:13 +0200
Message-Id: <20190603150233.6614-9-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 03 Jun 2019 15:03:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/28] block/linux-aio: Drop unused BlockAIOCB
 submission method
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

From: Julia Suvorova <jusual@mail.ru>

Callback-based laio_submit() and laio_cancel() were left after
rewriting Linux AIO backend to coroutines in hope that they would be
used in other code that could bypass coroutines. They can be safely
removed because they have not been used since that time.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/raw-aio.h |  3 --
 block/linux-aio.c       | 72 ++++++-----------------------------------
 2 files changed, 10 insertions(+), 65 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index ba223dd1f1..0cb7cc74a2 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -50,9 +50,6 @@ LinuxAioState *laio_init(Error **errp);
 void laio_cleanup(LinuxAioState *s);
 int coroutine_fn laio_co_submit(BlockDriverState *bs, LinuxAioState *s, =
int fd,
                                 uint64_t offset, QEMUIOVector *qiov, int=
 type);
-BlockAIOCB *laio_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque, int type);
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context);
 void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
 void laio_io_plug(BlockDriverState *bs, LinuxAioState *s);
diff --git a/block/linux-aio.c b/block/linux-aio.c
index d4b61fb251..27100c2fd1 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -30,7 +30,6 @@
 #define MAX_EVENTS 128
=20
 struct qemu_laiocb {
-    BlockAIOCB common;
     Coroutine *co;
     LinuxAioState *ctx;
     struct iocb iocb;
@@ -72,7 +71,7 @@ static inline ssize_t io_event_ret(struct io_event *ev)
 }
=20
 /*
- * Completes an AIO request (calls the callback and frees the ACB).
+ * Completes an AIO request.
  */
 static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
 {
@@ -94,18 +93,15 @@ static void qemu_laio_process_completion(struct qemu_=
laiocb *laiocb)
     }
=20
     laiocb->ret =3D ret;
-    if (laiocb->co) {
-        /* If the coroutine is already entered it must be in ioq_submit(=
) and
-         * will notice laio->ret has been filled in when it eventually r=
uns
-         * later.  Coroutines cannot be entered recursively so avoid doi=
ng
-         * that!
-         */
-        if (!qemu_coroutine_entered(laiocb->co)) {
-            aio_co_wake(laiocb->co);
-        }
-    } else {
-        laiocb->common.cb(laiocb->common.opaque, ret);
-        qemu_aio_unref(laiocb);
+
+    /*
+     * If the coroutine is already entered it must be in ioq_submit() an=
d
+     * will notice laio->ret has been filled in when it eventually runs
+     * later.  Coroutines cannot be entered recursively so avoid doing
+     * that!
+     */
+    if (!qemu_coroutine_entered(laiocb->co)) {
+        aio_co_wake(laiocb->co);
     }
 }
=20
@@ -273,30 +269,6 @@ static bool qemu_laio_poll_cb(void *opaque)
     return true;
 }
=20
-static void laio_cancel(BlockAIOCB *blockacb)
-{
-    struct qemu_laiocb *laiocb =3D (struct qemu_laiocb *)blockacb;
-    struct io_event event;
-    int ret;
-
-    if (laiocb->ret !=3D -EINPROGRESS) {
-        return;
-    }
-    ret =3D io_cancel(laiocb->ctx->ctx, &laiocb->iocb, &event);
-    laiocb->ret =3D -ECANCELED;
-    if (ret !=3D 0) {
-        /* iocb is not cancelled, cb will be called by the event loop la=
ter */
-        return;
-    }
-
-    laiocb->common.cb(laiocb->common.opaque, laiocb->ret);
-}
-
-static const AIOCBInfo laio_aiocb_info =3D {
-    .aiocb_size         =3D sizeof(struct qemu_laiocb),
-    .cancel_async       =3D laio_cancel,
-};
-
 static void ioq_init(LaioQueue *io_q)
 {
     QSIMPLEQ_INIT(&io_q->pending);
@@ -431,30 +403,6 @@ int coroutine_fn laio_co_submit(BlockDriverState *bs=
, LinuxAioState *s, int fd,
     return laiocb.ret;
 }
=20
-BlockAIOCB *laio_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque, int type)
-{
-    struct qemu_laiocb *laiocb;
-    off_t offset =3D sector_num * BDRV_SECTOR_SIZE;
-    int ret;
-
-    laiocb =3D qemu_aio_get(&laio_aiocb_info, bs, cb, opaque);
-    laiocb->nbytes =3D nb_sectors * BDRV_SECTOR_SIZE;
-    laiocb->ctx =3D s;
-    laiocb->ret =3D -EINPROGRESS;
-    laiocb->is_read =3D (type =3D=3D QEMU_AIO_READ);
-    laiocb->qiov =3D qiov;
-
-    ret =3D laio_do_submit(fd, laiocb, offset, type);
-    if (ret < 0) {
-        qemu_aio_unref(laiocb);
-        return NULL;
-    }
-
-    return &laiocb->common;
-}
-
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context)
 {
     aio_set_event_notifier(old_context, &s->e, false, NULL, NULL);
--=20
2.20.1


