Received: from eggs.gnu.org ([209.51.188.92]:50161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDP-0005XC-PD
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDO-0002xr-2S
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52352)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDL-0002wK-Pc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:08 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 31 Jan 2019 16:17:09 +0300
Message-ID: <20190131131709.23264.33457.stgit@pasha-VirtualBox>
In-Reply-To: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
References: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v11 19/25] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Replay is capable of recording normal BH events, but sometimes
there are single use callbacks scheduled with aio_bh_schedule_oneshot
function. This patch enables recording and replaying such callbacks.
Block layer uses these events for calling the completion function.
Replaying these calls makes the execution deterministic.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v6:
 - moved stub function to the separate file for fixing linux-user build
v10:
 - replaced all block layer aio_bh_schedule_oneshot calls
---
 block/block-backend.c    |    8 +++++---
 block/io.c               |    4 ++--
 block/iscsi.c            |    5 +++--
 block/nfs.c              |    5 +++--
 block/null.c             |    4 +++-
 block/nvme.c             |    6 ++++--
 block/rbd.c              |    5 +++--
 block/vxhs.c             |    5 +++--
 include/sysemu/replay.h  |    3 +++
 replay/replay-events.c   |   16 ++++++++++++++++
 replay/replay-internal.h |    1 +
 replay/replay.c          |    2 +-
 stubs/Makefile.objs      |    1 +
 stubs/replay-user.c      |    9 +++++++++
 14 files changed, 57 insertions(+), 17 deletions(-)
 create mode 100644 stubs/replay-user.c

diff --git a/block/block-backend.c b/block/block-backend.c
index 60d37a0..32c56e9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -17,6 +17,7 @@
 #include "block/throttle-groups.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
@@ -1324,7 +1325,8 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
     acb->blk = blk;
     acb->ret = ret;
 
-    aio_bh_schedule_oneshot(blk_get_aio_context(blk), error_callback_bh, acb);
+    replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+                                     error_callback_bh, acb);
     return &acb->common;
 }
 
@@ -1380,8 +1382,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
-                                blk_aio_complete_bh, acb);
+        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+                                         blk_aio_complete_bh, acb);
     }
 
     return &acb->common;
diff --git a/block/io.c b/block/io.c
index f9a9c5a..fb3b2a9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -340,8 +340,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     if (bs) {
         bdrv_inc_in_flight(bs);
     }
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
-                            bdrv_co_drain_bh_cb, &data);
+    replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
+                                     bdrv_co_drain_bh_cb, &data);
 
     qemu_coroutine_yield();
     /* If we are resumed from some other event (such as an aio completion or a
diff --git a/block/iscsi.c b/block/iscsi.c
index ff47320..571bec8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -38,6 +38,7 @@
 #include "qemu/iov.h"
 #include "qemu/option.h"
 #include "qemu/uuid.h"
+#include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
@@ -275,8 +276,8 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 
 out:
     if (iTask->co) {
-        aio_bh_schedule_oneshot(iTask->iscsilun->aio_context,
-                                 iscsi_co_generic_bh_cb, iTask);
+        replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
+                                         iscsi_co_generic_bh_cb, iTask);
     } else {
         iTask->complete = 1;
     }
diff --git a/block/nfs.c b/block/nfs.c
index eab1a2c..e8b6c90 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -36,6 +36,7 @@
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
@@ -256,8 +257,8 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    aio_bh_schedule_oneshot(task->client->aio_context,
-                            nfs_co_generic_bh_cb, task);
+    replay_bh_schedule_oneshot_event(task->client->aio_context,
+                                     nfs_co_generic_bh_cb, task);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
diff --git a/block/null.c b/block/null.c
index d442d3e..733873c 100644
--- a/block/null.c
+++ b/block/null.c
@@ -16,6 +16,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
+#include "sysemu/replay.h"
 
 #define NULL_OPT_LATENCY "latency-ns"
 #define NULL_OPT_ZEROES  "read-zeroes"
@@ -178,7 +179,8 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
         timer_mod_ns(&acb->timer,
                      qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + s->latency_ns);
     } else {
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), null_bh_cb, acb);
+        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
+                                         null_bh_cb, acb);
     }
     return &acb->common;
 }
diff --git a/block/nvme.c b/block/nvme.c
index 982097b..f6677e8 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -21,6 +21,7 @@
 #include "qemu/option.h"
 #include "qemu/vfio-helpers.h"
 #include "block/block_int.h"
+#include "sysemu/replay.h"
 #include "trace.h"
 
 #include "block/nvme.h"
@@ -346,7 +347,8 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
         smp_mb_release();
         *q->cq.doorbell = cpu_to_le32(q->cq.head);
         if (!qemu_co_queue_empty(&q->free_req_queue)) {
-            aio_bh_schedule_oneshot(s->aio_context, nvme_free_req_queue_cb, q);
+            replay_bh_schedule_oneshot_event(s->aio_context,
+                                             nvme_free_req_queue_cb, q);
         }
     }
     q->busy = false;
@@ -896,7 +898,7 @@ static void nvme_rw_cb(void *opaque, int ret)
         /* The rw coroutine hasn't yielded, don't try to enter. */
         return;
     }
-    aio_bh_schedule_oneshot(data->ctx, nvme_rw_cb_bh, data);
+    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
diff --git a/block/rbd.c b/block/rbd.c
index 8a1a9f4..daaddbc 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -21,6 +21,7 @@
 #include "block/qdict.h"
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
+#include "sysemu/replay.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
@@ -858,8 +859,8 @@ static void rbd_finish_aiocb(rbd_completion_t c, RADOSCB *rcb)
     rcb->ret = rbd_aio_get_return_value(c);
     rbd_aio_release(c);
 
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
-                            rbd_finish_bh, rcb);
+    replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->common.bs),
+                                     rbd_finish_bh, rcb);
 }
 
 static int rbd_aio_discard_wrapper(rbd_image_t image,
diff --git a/block/vxhs.c b/block/vxhs.c
index 0cb0a00..3ac35cb 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 #include "crypto/tlscredsx509.h"
+#include "sysemu/replay.h"
 
 #define VXHS_OPT_FILENAME           "filename"
 #define VXHS_OPT_VDISK_ID           "vdisk-id"
@@ -104,8 +105,8 @@ static void vxhs_iio_callback(void *ctx, uint32_t opcode, uint32_t error)
             trace_vxhs_iio_callback(error);
         }
 
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
-                                vxhs_complete_aio_bh, acb);
+        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->common.bs),
+                                         vxhs_complete_aio_bh, acb);
         break;
 
     default:
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 1d18c9b..b7394a1 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -163,6 +163,9 @@ bool replay_events_enabled(void);
 void replay_flush_events(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
+/* Adds oneshot bottom half event to the queue */
+void replay_bh_schedule_oneshot_event(AioContext *ctx,
+    QEMUBHFunc *cb, void *opaque);
 /*! Adds input event to the queue */
 void replay_input_event(QemuConsole *src, InputEvent *evt);
 /*! Adds input sync event to the queue */
diff --git a/replay/replay-events.c b/replay/replay-events.c
index d9a2d49..fc9b082 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -37,6 +37,9 @@ static void replay_run_event(Event *event)
     case REPLAY_ASYNC_EVENT_BH:
         aio_bh_call(event->opaque);
         break;
+    case REPLAY_ASYNC_EVENT_BH_ONESHOT:
+        ((QEMUBHFunc *)event->opaque)(event->opaque2);
+        break;
     case REPLAY_ASYNC_EVENT_INPUT:
         qemu_input_event_send_impl(NULL, (InputEvent *)event->opaque);
         qapi_free_InputEvent((InputEvent *)event->opaque);
@@ -132,6 +135,17 @@ void replay_bh_schedule_event(QEMUBH *bh)
     }
 }
 
+void replay_bh_schedule_oneshot_event(AioContext *ctx,
+    QEMUBHFunc *cb, void *opaque)
+{
+    if (events_enabled) {
+        uint64_t id = replay_get_current_step();
+        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
+    } else {
+        aio_bh_schedule_oneshot(ctx, cb, opaque);
+    }
+}
+
 void replay_add_input_event(struct InputEvent *event)
 {
     replay_add_event(REPLAY_ASYNC_EVENT_INPUT, event, NULL, 0);
@@ -162,6 +176,7 @@ static void replay_save_event(Event *event, int checkpoint)
         /* save event-specific data */
         switch (event->event_kind) {
         case REPLAY_ASYNC_EVENT_BH:
+        case REPLAY_ASYNC_EVENT_BH_ONESHOT:
             replay_put_qword(event->id);
             break;
         case REPLAY_ASYNC_EVENT_INPUT:
@@ -217,6 +232,7 @@ static Event *replay_read_event(int checkpoint)
     /* Events that has not to be in the queue */
     switch (replay_state.read_event_kind) {
     case REPLAY_ASYNC_EVENT_BH:
+    case REPLAY_ASYNC_EVENT_BH_ONESHOT:
         if (replay_state.read_event_id == -1) {
             replay_state.read_event_id = replay_get_qword();
         }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 9458023..e9786b2 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -51,6 +51,7 @@ enum ReplayEvents {
 
 enum ReplayAsyncEventKind {
     REPLAY_ASYNC_EVENT_BH,
+    REPLAY_ASYNC_EVENT_BH_ONESHOT,
     REPLAY_ASYNC_EVENT_INPUT,
     REPLAY_ASYNC_EVENT_INPUT_SYNC,
     REPLAY_ASYNC_EVENT_CHAR_READ,
diff --git a/replay/replay.c b/replay/replay.c
index 1be34aa..e578958 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02007
+#define REPLAY_VERSION              0xe02008
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5dd0aee..8e8df1e 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -24,6 +24,7 @@ stub-obj-y += monitor.o
 stub-obj-y += notify-event.o
 stub-obj-y += qtest.o
 stub-obj-y += replay.o
+stub-obj-y += replay-user.o
 stub-obj-y += runstate-check.o
 stub-obj-y += set-fd-handler.o
 stub-obj-y += slirp.o
diff --git a/stubs/replay-user.c b/stubs/replay-user.c
new file mode 100644
index 0000000..2ad9e27
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
