Received: from eggs.gnu.org ([2001:4830:134:3::10]:58836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsis-0006Wl-OY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsir-0004Gl-EZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:46 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsir-0004Fr-5Z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id v65so2495065wrc.11
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:17 +0100
Message-Id: <20180313224719.4954-68-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 67/69] replay: save vmstate of the asynchronous
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch fixes saving and loading the snapshots in the replay mode.
It is required for the snapshots created in the moment when the header
of the asynchronous event is read. This information was not saved in
the snapshot. After loading the vmstate replay continued with the file offset
passed the event header. The event header is lost in this case and replay
hangs.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <20180227095322.1060.53929.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay-events.c   | 44 +++++++++++++++++++++-----------------------
 replay/replay-internal.h |  6 ++++++
 replay/replay-snapshot.c |  3 +++
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 3d5fc8a479..707de3867b 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -27,10 +27,6 @@ typedef struct Event {
 } Event;
 
 static QTAILQ_HEAD(, Event) events_list = QTAILQ_HEAD_INITIALIZER(events_list);
-static unsigned int read_event_kind = -1;
-static uint64_t read_id = -1;
-static int read_checkpoint = -1;
-
 static bool events_enabled;
 
 /* Functions */
@@ -218,58 +214,60 @@ void replay_save_events(int checkpoint)
 static Event *replay_read_event(int checkpoint)
 {
     Event *event;
-    if (read_event_kind == -1) {
-        read_checkpoint = replay_get_byte();
-        read_event_kind = replay_get_byte();
-        read_id = -1;
+    if (replay_state.read_event_kind == -1) {
+        replay_state.read_event_checkpoint = replay_get_byte();
+        replay_state.read_event_kind = replay_get_byte();
+        replay_state.read_event_id = -1;
         replay_check_error();
     }
 
-    if (checkpoint != read_checkpoint) {
+    if (checkpoint != replay_state.read_event_checkpoint) {
         return NULL;
     }
 
     /* Events that has not to be in the queue */
-    switch (read_event_kind) {
+    switch (replay_state.read_event_kind) {
     case REPLAY_ASYNC_EVENT_BH:
-        if (read_id == -1) {
-            read_id = replay_get_qword();
+        if (replay_state.read_event_id == -1) {
+            replay_state.read_event_id = replay_get_qword();
         }
         break;
     case REPLAY_ASYNC_EVENT_INPUT:
         event = g_malloc0(sizeof(Event));
-        event->event_kind = read_event_kind;
+        event->event_kind = replay_state.read_event_kind;
         event->opaque = replay_read_input_event();
         return event;
     case REPLAY_ASYNC_EVENT_INPUT_SYNC:
         event = g_malloc0(sizeof(Event));
-        event->event_kind = read_event_kind;
+        event->event_kind = replay_state.read_event_kind;
         event->opaque = 0;
         return event;
     case REPLAY_ASYNC_EVENT_CHAR_READ:
         event = g_malloc0(sizeof(Event));
-        event->event_kind = read_event_kind;
+        event->event_kind = replay_state.read_event_kind;
         event->opaque = replay_event_char_read_load();
         return event;
     case REPLAY_ASYNC_EVENT_BLOCK:
-        if (read_id == -1) {
-            read_id = replay_get_qword();
+        if (replay_state.read_event_id == -1) {
+            replay_state.read_event_id = replay_get_qword();
         }
         break;
     case REPLAY_ASYNC_EVENT_NET:
         event = g_malloc0(sizeof(Event));
-        event->event_kind = read_event_kind;
+        event->event_kind = replay_state.read_event_kind;
         event->opaque = replay_event_net_load();
         return event;
     default:
-        error_report("Unknown ID %d of replay event", read_event_kind);
+        error_report("Unknown ID %d of replay event",
+            replay_state.read_event_kind);
         exit(1);
         break;
     }
 
     QTAILQ_FOREACH(event, &events_list, events) {
-        if (event->event_kind == read_event_kind
-            && (read_id == -1 || read_id == event->id)) {
+        if (event->event_kind == replay_state.read_event_kind
+            && (replay_state.read_event_id == -1
+                || replay_state.read_event_id == event->id)) {
             break;
         }
     }
@@ -295,7 +293,7 @@ void replay_read_events(int checkpoint)
             break;
         }
         replay_finish_event();
-        read_event_kind = -1;
+        replay_state.read_event_kind = -1;
         replay_run_event(event);
 
         g_free(event);
@@ -304,7 +302,7 @@ void replay_read_events(int checkpoint)
 
 void replay_init_events(void)
 {
-    read_event_kind = -1;
+    replay_state.read_event_kind = -1;
 }
 
 void replay_finish_events(void)
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index d4037058e4..ac4b27b674 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -80,6 +80,12 @@ typedef struct ReplayState {
     uint64_t block_request_id;
     /*! Prior value of the host clock */
     uint64_t host_clock_last;
+    /*! Asynchronous event type read from the log */
+    int32_t read_event_kind;
+    /*! Asynchronous event id read from the log */
+    uint64_t read_event_id;
+    /*! Asynchronous event checkpoint id read from the log */
+    int32_t read_event_checkpoint;
 } ReplayState;
 extern ReplayState replay_state;
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index e0b2204765..2ab85cfc60 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -57,6 +57,9 @@ static const VMStateDescription vmstate_replay = {
         VMSTATE_UINT64(file_offset, ReplayState),
         VMSTATE_UINT64(block_request_id, ReplayState),
         VMSTATE_UINT64(host_clock_last, ReplayState),
+        VMSTATE_INT32(read_event_kind, ReplayState),
+        VMSTATE_UINT64(read_event_id, ReplayState),
+        VMSTATE_INT32(read_event_checkpoint, ReplayState),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.14.3
