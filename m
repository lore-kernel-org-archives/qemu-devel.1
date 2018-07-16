Received: from eggs.gnu.org ([2001:4830:134:3::10]:43776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff375-0001nW-E2
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36z-0002U1-BR
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:27 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:32 +0200
Message-Id: <1531745974-17187-16-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 15/17] hw/arm/stm32f205_soc: Fix
 introspection problem with 'stm32f205-soc' device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Valgrind complains:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'stm32f205-soc'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==28531== Invalid read of size 8
==28531==    at 0x6185BA: qdev_print (qdev-monitor.c:686)
==28531==    by 0x6185BA: qbus_print (qdev-monitor.c:719)
==28531==    by 0x452B38: handle_hmp_command (monitor.c:3446)
[...]

Fix it with the new sysbus_init_child_obj() function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/stm32f205_soc.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 2b2135d..c486d06 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -49,36 +49,32 @@ static void stm32f205_soc_initfn(Object *obj)
     STM32F205State *s = STM32F205_SOC(obj);
     int i;
 
-    object_initialize(&s->armv7m, sizeof(s->armv7m), TYPE_ARMV7M);
-    qdev_set_parent_bus(DEVICE(&s->armv7m), sysbus_get_default());
+    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
+                          TYPE_ARMV7M);
 
-    object_initialize(&s->syscfg, sizeof(s->syscfg), TYPE_STM32F2XX_SYSCFG);
-    qdev_set_parent_bus(DEVICE(&s->syscfg), sysbus_get_default());
+    sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
+                          TYPE_STM32F2XX_SYSCFG);
 
     for (i = 0; i < STM_NUM_USARTS; i++) {
-        object_initialize(&s->usart[i], sizeof(s->usart[i]),
-                          TYPE_STM32F2XX_USART);
-        qdev_set_parent_bus(DEVICE(&s->usart[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "usart[*]", &s->usart[i],
+                              sizeof(s->usart[i]), TYPE_STM32F2XX_USART);
     }
 
     for (i = 0; i < STM_NUM_TIMERS; i++) {
-        object_initialize(&s->timer[i], sizeof(s->timer[i]),
-                          TYPE_STM32F2XX_TIMER);
-        qdev_set_parent_bus(DEVICE(&s->timer[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
+                              sizeof(s->timer[i]), TYPE_STM32F2XX_TIMER);
     }
 
     s->adc_irqs = OR_IRQ(object_new(TYPE_OR_IRQ));
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
-        object_initialize(&s->adc[i], sizeof(s->adc[i]),
-                          TYPE_STM32F2XX_ADC);
-        qdev_set_parent_bus(DEVICE(&s->adc[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
+                              TYPE_STM32F2XX_ADC);
     }
 
     for (i = 0; i < STM_NUM_SPIS; i++) {
-        object_initialize(&s->spi[i], sizeof(s->spi[i]),
-                          TYPE_STM32F2XX_SPI);
-        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
+                              TYPE_STM32F2XX_SPI);
     }
 }
 
-- 
1.8.3.1
