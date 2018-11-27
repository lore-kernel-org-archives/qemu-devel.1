Received: from eggs.gnu.org ([2001:4830:134:3::10]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1gRUTn-0000j2-HF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1gRUTg-0003be-Iy
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:56:07 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <felix.yzg@gmail.com>) id 1gRUTg-0003YJ-Cq
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:56:00 -0500
Received: by mail-pg1-x544.google.com with SMTP id 70so7190495pgh.8
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 19:56:00 -0800 (PST)
From: FelixYao <felix.yzg@gmail.com>
Date: Tue, 27 Nov 2018 11:55:49 +0800
Message-Id: <1543290949-30340-1-git-send-email-felix.yzg@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] input: improve performance of mouse event
 handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: yaozhenguo@jd.com, felix.yzg@gmail.com, qemu-devel@nongnu.org

Hi Gerd Hoffmann:

Qemu doesn't put mouse event into queue. It handle mouse event one by one independently.
So, I think there is no need to use g_new0 to malloc memory dynamically. 
Using local variable can improve event handle performance.

I have tested this patch in my platform. after applying this patch. Time of handling 100,000 
mouse move events changes from 50ms to 9ms.

Please review it and consider whether it can be applied!

Signed-off-by: FelixYao <felix.yzg@gmail.com>
---
 include/ui/input.h |  7 ++++---
 ui/input.c         | 47 +++++++++++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 34ebc67..bb5e782 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -49,7 +49,8 @@ int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
                                      int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
 
-InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
+void qemu_input_event_set_btn(InputButton btn, bool down,
+                            InputEvent *evt, InputBtnEvent *button_evt);
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
                                uint32_t button_old, uint32_t button_new);
@@ -58,8 +59,8 @@ bool qemu_input_is_absolute(void);
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out);
-InputEvent *qemu_input_event_new_move(InputEventKind kind,
-                                      InputAxis axis, int value);
+void qemu_input_event_set_move(InputEventKind kind, InputAxis axis, int value,
+                               InputEvent *evt, InputMoveEvent *move);
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in);
diff --git a/ui/input.c b/ui/input.c
index 7c9a410..70494b3 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -458,22 +458,24 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
     }
 }
 
-InputEvent *qemu_input_event_new_btn(InputButton btn, bool down)
+void qemu_input_event_set_btn(InputButton btn, bool down,
+	       	InputEvent *evt, InputBtnEvent *button_evt)
 {
-    InputEvent *evt = g_new0(InputEvent, 1);
-    evt->u.btn.data = g_new0(InputBtnEvent, 1);
+    memset(evt, 0, sizeof(*evt));
+    memset(button_evt, 0, sizeof(*button_evt));
+    evt->u.btn.data = button_evt;
     evt->type = INPUT_EVENT_KIND_BTN;
     evt->u.btn.data->button = btn;
     evt->u.btn.data->down = down;
-    return evt;
 }
 
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
 {
-    InputEvent *evt;
-    evt = qemu_input_event_new_btn(btn, down);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+    InputEvent event;
+    InputBtnEvent button;
+
+    qemu_input_event_set_btn(btn, down, &event, &button);
+    qemu_input_event_send(src, &event);
 }
 
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
@@ -513,37 +515,38 @@ int qemu_input_scale_axis(int value,
     return ((int64_t)value - min_in) * range_out / range_in + min_out;
 }
 
-InputEvent *qemu_input_event_new_move(InputEventKind kind,
-                                      InputAxis axis, int value)
-{
-    InputEvent *evt = g_new0(InputEvent, 1);
-    InputMoveEvent *move = g_new0(InputMoveEvent, 1);
 
+void qemu_input_event_set_move(InputEventKind kind, InputAxis axis, int value,
+		      InputEvent *evt, InputMoveEvent *move)
+{
+    memset(evt, 0, sizeof(*evt));
+    memset(move, 0, sizeof(*move));
     evt->type = kind;
     evt->u.rel.data = move; /* evt->u.rel is the same as evt->u.abs */
     move->axis = axis;
     move->value = value;
-    return evt;
 }
 
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
 {
-    InputEvent *evt;
-    evt = qemu_input_event_new_move(INPUT_EVENT_KIND_REL, axis, value);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+    InputEvent event;
+    InputMoveEvent move;
+
+    qemu_input_event_set_move(INPUT_EVENT_KIND_REL, axis, value, &event, &move);
+    qemu_input_event_send(src, &event);
 }
 
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in)
 {
-    InputEvent *evt;
+    InputEvent event;
+    InputMoveEvent move;
+
     int scaled = qemu_input_scale_axis(value, min_in, max_in,
                                        INPUT_EVENT_ABS_MIN,
                                        INPUT_EVENT_ABS_MAX);
-    evt = qemu_input_event_new_move(INPUT_EVENT_KIND_ABS, axis, scaled);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+    qemu_input_event_set_move(INPUT_EVENT_KIND_ABS, axis, scaled, &event, &move);
+    qemu_input_event_send(src, &event);
 }
 
 void qemu_input_check_mode_change(void)
-- 
1.8.3.1
