Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F85AC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A7320854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A7320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2xD-0005UI-6L
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK2pJ-00034B-Er
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK2pH-0006ax-GK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK2pD-0006UI-4N; Mon, 14 Oct 2019 12:03:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59E3418CB8FE;
 Mon, 14 Oct 2019 16:03:58 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7045C1D4;
 Mon, 14 Oct 2019 16:03:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/15] replay: add BH oneshot event for block layer
Date: Mon, 14 Oct 2019 18:03:41 +0200
Message-Id: <20191014160343.8211-8-kwolf@redhat.com>
In-Reply-To: <20191014160343.8211-1-kwolf@redhat.com>
References: <20191014160343.8211-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 14 Oct 2019 16:03:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Replay is capable of recording normal BH events, but sometimes
there are single use callbacks scheduled with aio_bh_schedule_oneshot
function. This patch enables recording and replaying such callbacks.
Block layer uses these events for calling the completion function.
Replaying these calls makes the execution deterministic.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/replay.h  |  4 ++++
 replay/replay-internal.h |  1 +
 block/block-backend.c    |  9 ++++++---
 block/io.c               |  4 ++--
 block/iscsi.c            |  5 +++--
 block/nfs.c              |  6 ++++--
 block/null.c             |  4 +++-
 block/nvme.c             |  6 ++++--
 block/rbd.c              |  5 +++--
 block/vxhs.c             |  5 +++--
 replay/replay-events.c   | 16 ++++++++++++++++
 stubs/replay-user.c      |  9 +++++++++
 stubs/Makefile.objs      |  1 +
 13 files changed, 59 insertions(+), 16 deletions(-)
 create mode 100644 stubs/replay-user.c

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index dfc7a31c66..8df517298c 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -15,6 +15,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qapi/qapi-types-ui.h"
+#include "block/aio.h"
=20
 /* replay clock kinds */
 enum ReplayClockKind {
@@ -140,6 +141,9 @@ void replay_enable_events(void);
 bool replay_events_enabled(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
+/* Adds oneshot bottom half event to the queue */
+void replay_bh_schedule_oneshot_event(AioContext *ctx,
+    QEMUBHFunc *cb, void *opaque);
 /*! Adds input event to the queue */
 void replay_input_event(QemuConsole *src, InputEvent *evt);
 /*! Adds input sync event to the queue */
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index afba9a3e0c..55fca1ac6b 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -51,6 +51,7 @@ enum ReplayEvents {
=20
 enum ReplayAsyncEventKind {
     REPLAY_ASYNC_EVENT_BH,
+    REPLAY_ASYNC_EVENT_BH_ONESHOT,
     REPLAY_ASYNC_EVENT_INPUT,
     REPLAY_ASYNC_EVENT_INPUT_SYNC,
     REPLAY_ASYNC_EVENT_CHAR_READ,
diff --git a/block/block-backend.c b/block/block-backend.c
index 1c605d5444..eb22ff306e 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -18,6 +18,8 @@
 #include "hw/qdev-core.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
@@ -1306,7 +1308,8 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk=
,
     acb->blk =3D blk;
     acb->ret =3D ret;
=20
-    aio_bh_schedule_oneshot(blk_get_aio_context(blk), error_callback_bh,=
 acb);
+    replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+                                     error_callback_bh, acb);
     return &acb->common;
 }
=20
@@ -1362,8 +1365,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, =
int64_t offset, int bytes,
=20
     acb->has_returned =3D true;
     if (acb->rwco.ret !=3D NOT_DONE) {
-        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
-                                blk_aio_complete_bh, acb);
+        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+                                         blk_aio_complete_bh, acb);
     }
=20
     return &acb->common;
diff --git a/block/io.c b/block/io.c
index 834841142a..8b6dace056 100644
--- a/block/io.c
+++ b/block/io.c
@@ -369,8 +369,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
     if (bs) {
         bdrv_inc_in_flight(bs);
     }
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
-                            bdrv_co_drain_bh_cb, &data);
+    replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
+                                     bdrv_co_drain_bh_cb, &data);
=20
     qemu_coroutine_yield();
     /* If we are resumed from some other event (such as an aio completio=
n or a
diff --git a/block/iscsi.c b/block/iscsi.c
index 506bf5f875..2ced15066a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -40,6 +40,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/uuid.h"
+#include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
@@ -280,8 +281,8 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int =
status,
     }
=20
     if (iTask->co) {
-        aio_bh_schedule_oneshot(iTask->iscsilun->aio_context,
-                                 iscsi_co_generic_bh_cb, iTask);
+        replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
+                                         iscsi_co_generic_bh_cb, iTask);
     } else {
         iTask->complete =3D 1;
     }
diff --git a/block/nfs.c b/block/nfs.c
index f39acfdb28..40f23495a0 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -37,6 +37,8 @@
 #include "qemu/option.h"
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
@@ -257,8 +259,8 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, v=
oid *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    aio_bh_schedule_oneshot(task->client->aio_context,
-                            nfs_co_generic_bh_cb, task);
+    replay_bh_schedule_oneshot_event(task->client->aio_context,
+                                     nfs_co_generic_bh_cb, task);
 }
=20
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t off=
set,
diff --git a/block/null.c b/block/null.c
index 699aa295cb..15e1d56746 100644
--- a/block/null.c
+++ b/block/null.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
+#include "sysemu/replay.h"
=20
 #define NULL_OPT_LATENCY "latency-ns"
 #define NULL_OPT_ZEROES  "read-zeroes"
@@ -179,7 +180,8 @@ static inline BlockAIOCB *null_aio_common(BlockDriver=
State *bs,
         timer_mod_ns(&acb->timer,
                      qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + s->latency=
_ns);
     } else {
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), null_bh_cb, ac=
b);
+        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
+                                         null_bh_cb, acb);
     }
     return &acb->common;
 }
diff --git a/block/nvme.c b/block/nvme.c
index 5be3a39b63..910872ec59 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -23,6 +23,7 @@
 #include "qemu/option.h"
 #include "qemu/vfio-helpers.h"
 #include "block/block_int.h"
+#include "sysemu/replay.h"
 #include "trace.h"
=20
 #include "block/nvme.h"
@@ -351,7 +352,8 @@ static bool nvme_process_completion(BDRVNVMeState *s,=
 NVMeQueuePair *q)
         smp_mb_release();
         *q->cq.doorbell =3D cpu_to_le32(q->cq.head);
         if (!qemu_co_queue_empty(&q->free_req_queue)) {
-            aio_bh_schedule_oneshot(s->aio_context, nvme_free_req_queue_=
cb, q);
+            replay_bh_schedule_oneshot_event(s->aio_context,
+                                             nvme_free_req_queue_cb, q);
         }
     }
     q->busy =3D false;
@@ -935,7 +937,7 @@ static void nvme_rw_cb(void *opaque, int ret)
         /* The rw coroutine hasn't yielded, don't try to enter. */
         return;
     }
-    aio_bh_schedule_oneshot(data->ctx, nvme_rw_cb_bh, data);
+    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
 }
=20
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
diff --git a/block/rbd.c b/block/rbd.c
index 057af43d48..c71e45d7c3 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -22,6 +22,7 @@
 #include "block/qdict.h"
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
+#include "sysemu/replay.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
@@ -884,8 +885,8 @@ static void rbd_finish_aiocb(rbd_completion_t c, RADO=
SCB *rcb)
     rcb->ret =3D rbd_aio_get_return_value(c);
     rbd_aio_release(c);
=20
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
-                            rbd_finish_bh, rcb);
+    replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->common.bs=
),
+                                     rbd_finish_bh, rcb);
 }
=20
 static int rbd_aio_discard_wrapper(rbd_image_t image,
diff --git a/block/vxhs.c b/block/vxhs.c
index 77fd5eb20d..d79fc97df6 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 #include "crypto/tlscredsx509.h"
+#include "sysemu/replay.h"
=20
 #define VXHS_OPT_FILENAME           "filename"
 #define VXHS_OPT_VDISK_ID           "vdisk-id"
@@ -105,8 +106,8 @@ static void vxhs_iio_callback(void *ctx, uint32_t opc=
ode, uint32_t error)
             trace_vxhs_iio_callback(error);
         }
=20
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
-                                vxhs_complete_aio_bh, acb);
+        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->commo=
n.bs),
+                                         vxhs_complete_aio_bh, acb);
         break;
=20
     default:
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 008e80f636..302b84043a 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -36,6 +36,9 @@ static void replay_run_event(Event *event)
     case REPLAY_ASYNC_EVENT_BH:
         aio_bh_call(event->opaque);
         break;
+    case REPLAY_ASYNC_EVENT_BH_ONESHOT:
+        ((QEMUBHFunc *)event->opaque)(event->opaque2);
+        break;
     case REPLAY_ASYNC_EVENT_INPUT:
         qemu_input_event_send_impl(NULL, (InputEvent *)event->opaque);
         qapi_free_InputEvent((InputEvent *)event->opaque);
@@ -131,6 +134,17 @@ void replay_bh_schedule_event(QEMUBH *bh)
     }
 }
=20
+void replay_bh_schedule_oneshot_event(AioContext *ctx,
+    QEMUBHFunc *cb, void *opaque)
+{
+    if (events_enabled) {
+        uint64_t id =3D replay_get_current_icount();
+        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
+    } else {
+        aio_bh_schedule_oneshot(ctx, cb, opaque);
+    }
+}
+
 void replay_add_input_event(struct InputEvent *event)
 {
     replay_add_event(REPLAY_ASYNC_EVENT_INPUT, event, NULL, 0);
@@ -161,6 +175,7 @@ static void replay_save_event(Event *event, int check=
point)
         /* save event-specific data */
         switch (event->event_kind) {
         case REPLAY_ASYNC_EVENT_BH:
+        case REPLAY_ASYNC_EVENT_BH_ONESHOT:
             replay_put_qword(event->id);
             break;
         case REPLAY_ASYNC_EVENT_INPUT:
@@ -216,6 +231,7 @@ static Event *replay_read_event(int checkpoint)
     /* Events that has not to be in the queue */
     switch (replay_state.read_event_kind) {
     case REPLAY_ASYNC_EVENT_BH:
+    case REPLAY_ASYNC_EVENT_BH_ONESHOT:
         if (replay_state.read_event_id =3D=3D -1) {
             replay_state.read_event_id =3D replay_get_qword();
         }
diff --git a/stubs/replay-user.c b/stubs/replay-user.c
new file mode 100644
index 0000000000..2ad9e27203
--- /dev/null
+++ b/stubs/replay-user.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "sysemu/replay.h"
+#include "sysemu/sysemu.h"
+
+void replay_bh_schedule_oneshot_event(AioContext *ctx,
+    QEMUBHFunc *cb, void *opaque)
+{
+    aio_bh_schedule_oneshot(ctx, cb, opaque);
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 9c7393b08c..4a50e95ec3 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -20,6 +20,7 @@ stub-obj-y +=3D monitor.o
 stub-obj-y +=3D notify-event.o
 stub-obj-y +=3D qtest.o
 stub-obj-y +=3D replay.o
+stub-obj-y +=3D replay-user.o
 stub-obj-y +=3D runstate-check.o
 stub-obj-y +=3D set-fd-handler.o
 stub-obj-y +=3D sysbus.o
--=20
2.20.1


