Received: from eggs.gnu.org ([2001:4830:134:3::10]:49164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMEJ-0004KS-Cw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMEG-0007mc-8X
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:08:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWMEF-0007m9-Qa
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:08:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Dec 2018 15:08:08 +0100
Message-Id: <20181210140808.26794-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] input: avoid malloc for mouse events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, felix.yzg@gmail.com

There is no reason to allocate mouse events using malloc, we can
allcoate them from stack instead, save a few cpu cycles and make the
code more readable with c99 initializers.

Suggested-by: FelixYao <felix.yzg@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/input.h |  3 ---
 ui/input.c         | 68 +++++++++++++++++++++++++-----------------------------
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 34ebc67c5a..8c8ccb999f 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -49,7 +49,6 @@ int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
                                      int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
 
-InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
                                uint32_t button_old, uint32_t button_new);
@@ -58,8 +57,6 @@ bool qemu_input_is_absolute(void);
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out);
-InputEvent *qemu_input_event_new_move(InputEventKind kind,
-                                      InputAxis axis, int value);
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in);
diff --git a/ui/input.c b/ui/input.c
index 7c9a4109c4..f9d413fef9 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -458,22 +458,18 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
     }
 }
 
-InputEvent *qemu_input_event_new_btn(InputButton btn, bool down)
-{
-    InputEvent *evt = g_new0(InputEvent, 1);
-    evt->u.btn.data = g_new0(InputBtnEvent, 1);
-    evt->type = INPUT_EVENT_KIND_BTN;
-    evt->u.btn.data->button = btn;
-    evt->u.btn.data->down = down;
-    return evt;
-}
-
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
 {
-    InputEvent *evt;
-    evt = qemu_input_event_new_btn(btn, down);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+    InputBtnEvent bevt = {
+        .button = btn,
+        .down = down,
+    };
+    InputEvent evt = {
+        .type = INPUT_EVENT_KIND_BTN,
+        .u.btn.data = &bevt,
+    };
+
+    qemu_input_event_send(src, &evt);
 }
 
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
@@ -513,37 +509,35 @@ int qemu_input_scale_axis(int value,
     return ((int64_t)value - min_in) * range_out / range_in + min_out;
 }
 
-InputEvent *qemu_input_event_new_move(InputEventKind kind,
-                                      InputAxis axis, int value)
-{
-    InputEvent *evt = g_new0(InputEvent, 1);
-    InputMoveEvent *move = g_new0(InputMoveEvent, 1);
-
-    evt->type = kind;
-    evt->u.rel.data = move; /* evt->u.rel is the same as evt->u.abs */
-    move->axis = axis;
-    move->value = value;
-    return evt;
-}
-
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
 {
-    InputEvent *evt;
-    evt = qemu_input_event_new_move(INPUT_EVENT_KIND_REL, axis, value);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+    InputMoveEvent move = {
+        .axis = axis,
+        .value = value,
+    };
+    InputEvent evt = {
+        .type = INPUT_EVENT_KIND_REL,
+        .u.rel.data = &move,
+    };
+
+    qemu_input_event_send(src, &evt);
 }
 
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in)
 {
-    InputEvent *evt;
-    int scaled = qemu_input_scale_axis(value, min_in, max_in,
+    InputMoveEvent move = {
+        .axis = axis,
+        .value = qemu_input_scale_axis(value, min_in, max_in,
                                        INPUT_EVENT_ABS_MIN,
-                                       INPUT_EVENT_ABS_MAX);
-    evt = qemu_input_event_new_move(INPUT_EVENT_KIND_ABS, axis, scaled);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+                                       INPUT_EVENT_ABS_MAX),
+    };
+    InputEvent evt = {
+        .type = INPUT_EVENT_KIND_ABS,
+        .u.abs.data = &move,
+    };
+
+    qemu_input_event_send(src, &evt);
 }
 
 void qemu_input_check_mode_change(void)
-- 
2.9.3
