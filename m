Received: from eggs.gnu.org ([2001:4830:134:3::10]:47035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDST-0003Uy-UX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSQ-0006Y4-NS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:41 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55758)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSQ-0006XY-5a
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:38 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 18 Dec 2018 14:22:39 +0300
Message-ID: <20181218112239.11727.86110.stgit@pasha-VirtualBox>
In-Reply-To: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 18/20] replay: add BH oneshot event for
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
---
 block/block-backend.c    |    5 +++--
 include/sysemu/replay.h  |    3 +++
 replay/replay-events.c   |   16 ++++++++++++++++
 replay/replay-internal.h |    1 +
 replay/replay.c          |    2 +-
 stubs/Makefile.objs      |    1 +
 stubs/replay-user.c      |    9 +++++++++
 7 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 stubs/replay-user.c

diff --git a/block/block-backend.c b/block/block-backend.c
index 60d37a0..41ee871 100644
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
@@ -1380,8 +1381,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
-                                blk_aio_complete_bh, acb);
+        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+                                         blk_aio_complete_bh, acb);
     }
 
     return &acb->common;
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 05cb40a..5c71858 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -157,6 +157,9 @@ bool replay_events_enabled(void);
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
index d9a2d49..60e8c21 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -37,6 +37,9 @@ static void replay_run_event(Event *event)
     case REPLAY_ASYNC_EVENT_BH:
         aio_bh_call(event->opaque);
         break;
+    case REPLAY_ASYNC_EVENT_BH_ONESHOT:
+        ((QEMUBHFunc*)event->opaque)(event->opaque2);
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
index e37b201..af2b941 100644
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
index 3996499..fdf1778 100644
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
