Received: from eggs.gnu.org ([2001:4830:134:3::10]:44531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXaV-0000FR-OX
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXaU-0007oA-QJ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxXaU-0007nr-Kr
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:42 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 28 Sep 2017 13:06:20 +0100
Message-Id: <20170928120621.30288-6-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-1-berrange@redhat.com>
References: <20170928120621.30288-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 5/6] ui: convert key events to QKeyCodes
 immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Always use QKeyCode in the InputKeyEvent struct, by converting key
numbers to QKeyCode at the time the event is created. This allows
the code processing / consuming key events to assume QKeyCode is
used. The only place we accept a key number in the InputKeyEvent
struct is with QMP commands sent by the user.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/input.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/ui/input.c b/ui/input.c
index 3422d4a8ef..4b241aa823 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -157,9 +157,16 @@ void qmp_input_send_event(bool has_device, const char *device,
     }
 
     for (e = events; e != NULL; e = e->next) {
-        InputEvent *event = e->value;
-
-        qemu_input_event_send(con, event);
+        InputEvent *evt = e->value;
+
+        if (evt->type == INPUT_EVENT_KIND_KEY &&
+            evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER) {
+            KeyValue *key = evt->u.key.data->key;
+            QKeyCode code = qemu_input_key_number_to_qcode(key->u.qcode.data);
+            qemu_input_event_send_key_qcode(con, code, evt->u.key.data->down);
+        } else {
+            qemu_input_event_send(con, evt);
+        }
     }
 
     qemu_input_event_sync();
@@ -341,6 +348,11 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt)
 
 void qemu_input_event_send(QemuConsole *src, InputEvent *evt)
 {
+    /* Expect all parts of QEMU to send events with QCodes exclusively.
+     * Key numbers are only supported as end-user input via QMP */
+    assert(!(evt->type == INPUT_EVENT_KIND_KEY &&
+             evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER));
+
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
         return;
     }
@@ -400,10 +412,8 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
 
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down)
 {
-    KeyValue *key = g_new0(KeyValue, 1);
-    key->type = KEY_VALUE_KIND_NUMBER;
-    key->u.number.data = num;
-    qemu_input_event_send_key(src, key, down);
+    QKeyCode code = qemu_input_key_number_to_qcode(num);
+    qemu_input_event_send_key_qcode(src, code, down);
 }
 
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
-- 
2.13.5
