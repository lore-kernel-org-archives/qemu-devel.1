Received: from eggs.gnu.org ([2001:4830:134:3::10]:33672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000Ap-2k
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Hf-Vj
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60841)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Eo-BL
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:09 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:24 +0800
Message-Id: <20170205133727.23424-7-zxq_yx_007@163.com>
In-Reply-To: <20170205133727.23424-1-zxq_yx_007@163.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 6/9] hw/timer: QOM'ify m48txx_sysbus
 (pass 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

assign DeviceClass::vmsd instead of using vmstate_register function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/timer/m48t59.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 39e425e950..6afcce4669 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -639,6 +639,28 @@ static const VMStateDescription vmstate_m48t59 = {
     }
 };
 
+static const VMStateDescription vmstate_m48t59_isa = {
+    .name = "m48t59",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(state, M48txxISAState, 0,
+                       vmstate_m48t59, M48t59State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_m48t59_sys_bus = {
+    .name = "m48t59",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(state, M48txxSysBusState, 0,
+                       vmstate_m48t59, M48t59State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void m48t59_reset_common(M48t59State *NVRAM)
 {
     NVRAM->addr = 0;
@@ -744,8 +766,6 @@ static void m48t59_realize_common(M48t59State *s, Error **errp)
         s->wd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &watchdog_cb, s);
     }
     qemu_get_timedate(&s->alarm, 0);
-
-    vmstate_register(NULL, -1, &vmstate_m48t59, s);
 }
 
 static void m48t59_isa_realize(DeviceState *dev, Error **errp)
@@ -824,6 +844,7 @@ static void m48txx_isa_class_init(ObjectClass *klass, void *data)
     dc->realize = m48t59_isa_realize;
     dc->reset = m48t59_reset_isa;
     dc->props = m48t59_isa_properties;
+    dc->vmsd = &vmstate_m48t59_isa;
     nc->read = m48txx_isa_read;
     nc->write = m48txx_isa_write;
     nc->toggle_lock = m48txx_isa_toggle_lock;
@@ -868,6 +889,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
     dc->realize = m48t59_realize;
     dc->reset = m48t59_reset_sysbus;
     dc->props = m48t59_sysbus_properties;
+    dc->vmsd = &vmstate_m48t59_sys_bus;
     nc->read = m48txx_sysbus_read;
     nc->write = m48txx_sysbus_write;
     nc->toggle_lock = m48txx_sysbus_toggle_lock;
-- 
2.11.0
