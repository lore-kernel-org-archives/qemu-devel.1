Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoM-0003rj-6O
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoJ-0005lv-U0
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfpoJ-0005lY-L9
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C899C0828AC
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:55:46 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 16:55:12 +0100
Message-Id: <20170810155522.31099-6-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-1-berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 05/15] ui: use QKeyCode exclusively in
 InputKeyEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Now that keycode numbers are converted to QKeyCodes immediately
when creating input events, the InputKeyEvent struct can be
changed to only accept a QKeyCode, instead of a KeyValue.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/char/escc.c              |  2 +-
 hw/input/adb.c              |  2 +-
 hw/input/hid.c              |  6 +++---
 hw/input/ps2.c              |  2 +-
 hw/input/virtio-input-hid.c |  2 +-
 include/ui/input.h          |  7 ++-----
 qapi-schema.json            |  2 +-
 replay/replay-input.c       | 36 ++++------------------------------
 ui/input-keymap.c           | 32 ++++++++----------------------
 ui/input-legacy.c           | 31 +++++++++++++++++-------------
 ui/input.c                  | 47 +++++++++++++--------------------------------
 ui/trace-events             |  1 -
 12 files changed, 53 insertions(+), 117 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 1aca564e33..5af7f0cddf 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -847,7 +847,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
 
     assert(evt->type == INPUT_EVENT_KIND_KEY);
     key = evt->u.key.data;
-    qcode = qemu_input_key_value_to_qcode(key->key);
+    qcode = key->key;
     trace_escc_sunkbd_event_in(qcode, QKeyCode_lookup[qcode],
                                key->down);
 
diff --git a/hw/input/adb.c b/hw/input/adb.c
index fcca3a8eb9..992f5bd1c4 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -438,7 +438,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
     KBDState *s = (KBDState *)dev;
     int qcode, keycode;
 
-    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
+    qcode = evt->u.key.data->key;
     if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
         return;
     }
diff --git a/hw/input/hid.c b/hw/input/hid.c
index 0d049ff61c..fdb77b8b2a 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -231,9 +231,9 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
     int slot;
     InputKeyEvent *key = evt->u.key.data;
 
-    count = qemu_input_key_value_to_scancode(key->key,
-                                             key->down,
-                                             scancodes);
+    count = qemu_input_qcode_to_scancode(key->key,
+                                         key->down,
+                                         scancodes);
     if (hs->n + count > QUEUE_LENGTH) {
         trace_hid_kbd_queue_full();
         return;
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 77906d5f46..14b1d85f6c 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -599,7 +599,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    qcode = qemu_input_key_value_to_qcode(key->key);
+    qcode = key->key;
 
     if (s->scancode_set == 1) {
         if (qcode == Q_KEY_CODE_PAUSE) {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 46c038110c..7a04e21b33 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -200,7 +200,7 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
         key = evt->u.key.data;
-        qcode = qemu_input_key_value_to_qcode(key->key);
+        qcode = key->key;
         if (qcode && keymap_qcode[qcode]) {
             event.type  = cpu_to_le16(EV_KEY);
             event.code  = cpu_to_le16(keymap_qcode[qcode]);
diff --git a/include/ui/input.h b/include/ui/input.h
index 576006c370..5577cbcb04 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -38,15 +38,12 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt);
 void qemu_input_event_sync(void);
 void qemu_input_event_sync_impl(void);
 
-void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down);
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down);
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
 void qemu_input_event_send_key_delay(uint32_t delay_ms);
 int qemu_input_key_number_to_qcode(unsigned int nr);
-int qemu_input_key_value_to_number(const KeyValue *value);
-int qemu_input_key_value_to_qcode(const KeyValue *value);
-int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
-                                     int *codes);
+int qemu_input_qcode_to_number(QKeyCode qcode);
+int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
 
 InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53d00..fa6e99ee9c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5747,7 +5747,7 @@
 # Since: 2.0
 ##
 { 'struct'  : 'InputKeyEvent',
-  'data'  : { 'key'     : 'KeyValue',
+  'data'  : { 'key'     : 'QKeyCode',
               'down'    : 'bool' } }
 
 ##
diff --git a/replay/replay-input.c b/replay/replay-input.c
index bd93554d8e..577609f24b 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -28,21 +28,8 @@ void replay_save_input_event(InputEvent *evt)
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
         key = evt->u.key.data;
-        replay_put_dword(key->key->type);
-
-        switch (key->key->type) {
-        case KEY_VALUE_KIND_NUMBER:
-            replay_put_qword(key->key->u.number.data);
-            replay_put_byte(key->down);
-            break;
-        case KEY_VALUE_KIND_QCODE:
-            replay_put_dword(key->key->u.qcode.data);
-            replay_put_byte(key->down);
-            break;
-        case KEY_VALUE_KIND__MAX:
-            /* keep gcc happy */
-            break;
-        }
+        replay_put_dword(key->key);
+        replay_put_byte(key->down);
         break;
     case INPUT_EVENT_KIND_BTN:
         btn = evt->u.btn.data;
@@ -68,9 +55,7 @@ void replay_save_input_event(InputEvent *evt)
 InputEvent *replay_read_input_event(void)
 {
     InputEvent evt;
-    KeyValue keyValue;
     InputKeyEvent key;
-    key.key = &keyValue;
     InputBtnEvent btn;
     InputMoveEvent rel;
     InputMoveEvent abs;
@@ -79,21 +64,8 @@ InputEvent *replay_read_input_event(void)
     switch (evt.type) {
     case INPUT_EVENT_KIND_KEY:
         evt.u.key.data = &key;
-        evt.u.key.data->key->type = replay_get_dword();
-
-        switch (evt.u.key.data->key->type) {
-        case KEY_VALUE_KIND_NUMBER:
-            evt.u.key.data->key->u.number.data = replay_get_qword();
-            evt.u.key.data->down = replay_get_byte();
-            break;
-        case KEY_VALUE_KIND_QCODE:
-            evt.u.key.data->key->u.qcode.data = (QKeyCode)replay_get_dword();
-            evt.u.key.data->down = replay_get_byte();
-            break;
-        case KEY_VALUE_KIND__MAX:
-            /* keep gcc happy */
-            break;
-        }
+        evt.u.key.data->key = (QKeyCode)replay_get_dword();
+        evt.u.key.data->down = replay_get_byte();
         break;
     case INPUT_EVENT_KIND_BTN:
         evt.u.btn.data = &btn;
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index bbbb66bae7..f585ab764b 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -17,17 +17,12 @@ int qemu_input_linux_to_qcode(unsigned int lnx)
     return qemu_input_map_linux2qcode[lnx];
 }
 
-int qemu_input_key_value_to_number(const KeyValue *value)
+int qemu_input_qcode_to_number(QKeyCode qcode)
 {
-    if (value->type == KEY_VALUE_KIND_QCODE) {
-        if (value->u.qcode.data >= qemu_input_map_qcode2qnum_len) {
-            return 0;
-        }
-        return qemu_input_map_qcode2qnum[value->u.qcode.data];
-    } else {
-        assert(value->type == KEY_VALUE_KIND_NUMBER);
-        return value->u.number.data;
+    if (qcode >= qemu_input_map_qcode2qnum_len) {
+        return 0;
     }
+    return qemu_input_map_qcode2qnum[qcode];
 }
 
 int qemu_input_key_number_to_qcode(unsigned int nr)
@@ -38,24 +33,13 @@ int qemu_input_key_number_to_qcode(unsigned int nr)
     return qemu_input_map_qnum2qcode[nr];
 }
 
-int qemu_input_key_value_to_qcode(const KeyValue *value)
-{
-    if (value->type == KEY_VALUE_KIND_QCODE) {
-        return value->u.qcode.data;
-    } else {
-        assert(value->type == KEY_VALUE_KIND_NUMBER);
-        return qemu_input_key_number_to_qcode(value->u.number.data);
-    }
-}
-
-int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
-                                     int *codes)
+int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down,
+                                 int *codes)
 {
-    int keycode = qemu_input_key_value_to_number(value);
+    int keycode = qemu_input_qcode_to_number(qcode);
     int count = 0;
 
-    if (value->type == KEY_VALUE_KIND_QCODE &&
-        value->u.qcode.data == Q_KEY_CODE_PAUSE) {
+    if (qcode == Q_KEY_CODE_PAUSE) {
         /* specific case */
         int v = down ? 0 : 0x80;
         codes[count++] = 0xe1;
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 7159747404..204b2ba2ae 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -72,18 +72,12 @@ int index_from_key(const char *key, size_t key_length)
     return i;
 }
 
-static KeyValue *copy_key_value(KeyValue *src)
-{
-    KeyValue *dst = g_new(KeyValue, 1);
-    memcpy(dst, src, sizeof(*src));
-    return dst;
-}
 
 void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
                   Error **errp)
 {
     KeyValueList *p;
-    KeyValue **up = NULL;
+    QKeyCode *up = NULL;
     int count = 0;
 
     if (!has_hold_time) {
@@ -91,15 +85,26 @@ void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
     }
 
     for (p = keys; p != NULL; p = p->next) {
-        qemu_input_event_send_key(NULL, copy_key_value(p->value), true);
+        QKeyCode qcode;
+        switch (p->value->type) {
+        case KEY_VALUE_KIND_NUMBER:
+            qcode = qemu_input_key_number_to_qcode(p->value->u.number.data);
+            break;
+        case KEY_VALUE_KIND_QCODE:
+            qcode = p->value->u.qcode.data;
+            break;
+        default:
+            continue;
+        }
+        qemu_input_event_send_key_qcode(NULL, qcode, true);
         qemu_input_event_send_key_delay(hold_time);
         up = g_realloc(up, sizeof(*up) * (count+1));
-        up[count] = copy_key_value(p->value);
+        up[count] = qcode;
         count++;
     }
     while (count) {
         count--;
-        qemu_input_event_send_key(NULL, up[count], false);
+        qemu_input_event_send_key_qcode(NULL, up[count], false);
         qemu_input_event_send_key_delay(hold_time);
     }
     g_free(up);
@@ -115,9 +120,9 @@ static void legacy_kbd_event(DeviceState *dev, QemuConsole *src,
     if (!entry || !entry->put_kbd) {
         return;
     }
-    count = qemu_input_key_value_to_scancode(key->key,
-                                             key->down,
-                                             scancodes);
+    count = qemu_input_qcode_to_scancode(key->key,
+                                         key->down,
+                                         scancodes);
     for (i = 0; i < count; i++) {
         entry->put_kbd(entry->opaque, scancodes[i]);
     }
diff --git a/ui/input.c b/ui/input.c
index ba85bf01a9..8529929ea9 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -199,7 +199,7 @@ static void qemu_input_transform_abs_rotate(InputEvent *evt)
 static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
 {
     const char *name;
-    int qcode, idx = -1;
+    int idx = -1;
     InputKeyEvent *key;
     InputBtnEvent *btn;
     InputMoveEvent *move;
@@ -210,21 +210,8 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
         key = evt->u.key.data;
-        switch (key->key->type) {
-        case KEY_VALUE_KIND_NUMBER:
-            qcode = qemu_input_key_number_to_qcode(key->key->u.number.data);
-            name = QKeyCode_lookup[qcode];
-            trace_input_event_key_number(idx, key->key->u.number.data,
-                                         name, key->down);
-            break;
-        case KEY_VALUE_KIND_QCODE:
-            name = QKeyCode_lookup[key->key->u.qcode.data];
-            trace_input_event_key_qcode(idx, name, key->down);
-            break;
-        case KEY_VALUE_KIND__MAX:
-            /* keep gcc happy */
-            break;
-        }
+        name = QKeyCode_lookup[key->key];
+        trace_input_event_key_qcode(idx, name, key->down);
         break;
     case INPUT_EVENT_KIND_BTN:
         btn = evt->u.btn.data;
@@ -374,20 +361,26 @@ void qemu_input_event_sync(void)
     replay_input_sync_event();
 }
 
-static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
+static InputEvent *qemu_input_event_new_key(QKeyCode qcode, bool down)
 {
     InputEvent *evt = g_new0(InputEvent, 1);
     evt->u.key.data = g_new0(InputKeyEvent, 1);
     evt->type = INPUT_EVENT_KIND_KEY;
-    evt->u.key.data->key = key;
+    evt->u.key.data->key = qcode;
     evt->u.key.data->down = down;
     return evt;
 }
 
-void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
+void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down)
+{
+    QKeyCode code = qemu_input_key_number_to_qcode(num);
+    qemu_input_event_send_key_qcode(src, code, down);
+}
+
+void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode qcode, bool down)
 {
     InputEvent *evt;
-    evt = qemu_input_event_new_key(key, down);
+    evt = qemu_input_event_new_key(qcode, down);
     if (QTAILQ_EMPTY(&kbd_queue)) {
         qemu_input_event_send(src, evt);
         qemu_input_event_sync();
@@ -398,20 +391,6 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
     }
 }
 
-void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down)
-{
-    QKeyCode code = qemu_input_key_number_to_qcode(num);
-    qemu_input_event_send_key_qcode(src, code, down);
-}
-
-void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
-{
-    KeyValue *key = g_new0(KeyValue, 1);
-    key->type = KEY_VALUE_KIND_QCODE;
-    key->u.qcode.data = q;
-    qemu_input_event_send_key(src, key, down);
-}
-
 void qemu_input_event_send_key_delay(uint32_t delay_ms)
 {
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
diff --git a/ui/trace-events b/ui/trace-events
index 34c2213700..2a69660e5a 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -31,7 +31,6 @@ vnc_key_sync_numlock(bool on) "%d"
 vnc_key_sync_capslock(bool on) "%d"
 
 # ui/input.c
-input_event_key_number(int conidx, int number, const char *qcode, bool down) "con %d, key number 0x%x [%s], down %d"
 input_event_key_qcode(int conidx, const char *qcode, bool down) "con %d, key qcode %s, down %d"
 input_event_btn(int conidx, const char *btn, bool down) "con %d, button %s, down %d"
 input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
-- 
2.13.3
