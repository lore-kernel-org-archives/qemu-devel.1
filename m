Received: from eggs.gnu.org ([2001:4830:134:3::10]:47298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fG-0005CI-36
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fC-0005Q5-AS
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d69fC-0005PA-1I
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:54 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 07:50:38 +0200
Message-Id: <20170504055040.31904-2-kraxel@redhat.com>
In-Reply-To: <20170504055040.31904-1-kraxel@redhat.com>
References: <20170504055040.31904-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] input: limit kbd queue depth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>, Huawei PSIRT <PSIRT@huawei.com>

Apply a limit to the number of items we accept into the keyboard queue.

Impact: Without this limit vnc clients can exhaust host memory by
sending keyboard events faster than qemu feeds them to the guest.

Fixes: CVE-2017-8379
Cc: P J P <ppandit@redhat.com>
Cc: Huawei PSIRT <PSIRT@huawei.com>
Reported-by: jiangxin1@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170428084237.23960-1-kraxel@redhat.com
---
 ui/input.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/ui/input.c b/ui/input.c
index ed88cda6d6..fb1f404095 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -41,6 +41,8 @@ static QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue) kbd_queue =
     QTAILQ_HEAD_INITIALIZER(kbd_queue);
 static QEMUTimer *kbd_timer;
 static uint32_t kbd_default_delay_ms = 10;
+static uint32_t queue_count;
+static uint32_t queue_limit = 1024;
 
 QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
                                                    QemuInputHandler *handler)
@@ -268,6 +270,7 @@ static void qemu_input_queue_process(void *opaque)
             break;
         }
         QTAILQ_REMOVE(queue, item, node);
+        queue_count--;
         g_free(item);
     }
 }
@@ -282,6 +285,7 @@ static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue,
     item->delay_ms = delay_ms;
     item->timer = timer;
     QTAILQ_INSERT_TAIL(queue, item, node);
+    queue_count++;
 
     if (start_timer) {
         timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)
@@ -298,6 +302,7 @@ static void qemu_input_queue_event(struct QemuInputEventQueueHead *queue,
     item->src = src;
     item->evt = evt;
     QTAILQ_INSERT_TAIL(queue, item, node);
+    queue_count++;
 }
 
 static void qemu_input_queue_sync(struct QemuInputEventQueueHead *queue)
@@ -306,6 +311,7 @@ static void qemu_input_queue_sync(struct QemuInputEventQueueHead *queue)
 
     item->type = QEMU_INPUT_QUEUE_SYNC;
     QTAILQ_INSERT_TAIL(queue, item, node);
+    queue_count++;
 }
 
 void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt)
@@ -381,7 +387,7 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
         qemu_input_event_send(src, evt);
         qemu_input_event_sync();
         qapi_free_InputEvent(evt);
-    } else {
+    } else if (queue_count < queue_limit) {
         qemu_input_queue_event(&kbd_queue, src, evt);
         qemu_input_queue_sync(&kbd_queue);
     }
@@ -409,8 +415,10 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
         kbd_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, qemu_input_queue_process,
                                  &kbd_queue);
     }
-    qemu_input_queue_delay(&kbd_queue, kbd_timer,
-                           delay_ms ? delay_ms : kbd_default_delay_ms);
+    if (queue_count < queue_limit) {
+        qemu_input_queue_delay(&kbd_queue, kbd_timer,
+                               delay_ms ? delay_ms : kbd_default_delay_ms);
+    }
 }
 
 InputEvent *qemu_input_event_new_btn(InputButton btn, bool down)
-- 
2.9.3
