Received: from eggs.gnu.org ([2001:4830:134:3::10]:43620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36i-0001Ox-Dx
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36h-0002Cm-0Y
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:04 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:26 +0200
Message-Id: <1531745974-17187-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/17] hw/arm/fsl-imx7: Fix introspection
 problems with the "fsl, imx7" device
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

Running QEMU with valgrind indicates a problem here:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'fsl,imx7'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==27284== Invalid read of size 8
==27284==    at 0x618F7A: qdev_print (qdev-monitor.c:686)
==27284==    by 0x618F7A: qbus_print (qdev-monitor.c:719)
==27284==    by 0x452B38: handle_hmp_command (monitor.c:3446)
[...]

Use the new sysbus_init_child_obj() and object_initialize_child() to make
sure that the objects are removed correctly when the parent gets destroyed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx7.c | 97 +++++++++++++++++++------------------------------------
 1 file changed, 33 insertions(+), 64 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 44fde03..d5e2685 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -30,157 +30,126 @@
 
 static void fsl_imx7_init(Object *obj)
 {
-    BusState *sysbus = sysbus_get_default();
     FslIMX7State *s = FSL_IMX7(obj);
     char name[NAME_SIZE];
     int i;
 
 
     for (i = 0; i < MIN(smp_cpus, FSL_IMX7_NUM_CPUS); i++) {
-        object_initialize(&s->cpu[i], sizeof(s->cpu[i]),
-                          ARM_CPU_TYPE_NAME("cortex-a7"));
         snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_property_add_child(obj, name, OBJECT(&s->cpu[i]),
-                                  &error_fatal);
+        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
+                                ARM_CPU_TYPE_NAME("cortex-a7"), &error_abort,
+                                NULL);
     }
 
     /*
      * A7MPCORE
      */
-    object_initialize(&s->a7mpcore, sizeof(s->a7mpcore), TYPE_A15MPCORE_PRIV);
-    qdev_set_parent_bus(DEVICE(&s->a7mpcore), sysbus);
-    object_property_add_child(obj, "a7mpcore",
-                              OBJECT(&s->a7mpcore), &error_fatal);
+    sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore, sizeof(s->a7mpcore),
+                          TYPE_A15MPCORE_PRIV);
 
     /*
      * GPIOs 1 to 7
      */
     for (i = 0; i < FSL_IMX7_NUM_GPIOS; i++) {
-        object_initialize(&s->gpio[i], sizeof(s->gpio[i]),
-                          TYPE_IMX_GPIO);
-        qdev_set_parent_bus(DEVICE(&s->gpio[i]), sysbus);
         snprintf(name, NAME_SIZE, "gpio%d", i);
-        object_property_add_child(obj, name,
-                                  OBJECT(&s->gpio[i]), &error_fatal);
+        sysbus_init_child_obj(obj, name, &s->gpio[i], sizeof(s->gpio[i]),
+                          TYPE_IMX_GPIO);
     }
 
     /*
      * GPT1, 2, 3, 4
      */
     for (i = 0; i < FSL_IMX7_NUM_GPTS; i++) {
-        object_initialize(&s->gpt[i], sizeof(s->gpt[i]), TYPE_IMX7_GPT);
-        qdev_set_parent_bus(DEVICE(&s->gpt[i]), sysbus);
         snprintf(name, NAME_SIZE, "gpt%d", i);
-        object_property_add_child(obj, name, OBJECT(&s->gpt[i]),
-                                  &error_fatal);
+        sysbus_init_child_obj(obj, name, &s->gpt[i], sizeof(s->gpt[i]),
+                              TYPE_IMX7_GPT);
     }
 
     /*
      * CCM
      */
-    object_initialize(&s->ccm, sizeof(s->ccm), TYPE_IMX7_CCM);
-    qdev_set_parent_bus(DEVICE(&s->ccm), sysbus);
-    object_property_add_child(obj, "ccm", OBJECT(&s->ccm), &error_fatal);
+    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX7_CCM);
 
     /*
      * Analog
      */
-    object_initialize(&s->analog, sizeof(s->analog), TYPE_IMX7_ANALOG);
-    qdev_set_parent_bus(DEVICE(&s->analog), sysbus);
-    object_property_add_child(obj, "analog", OBJECT(&s->analog), &error_fatal);
+    sysbus_init_child_obj(obj, "analog", &s->analog, sizeof(s->analog),
+                          TYPE_IMX7_ANALOG);
 
     /*
      * GPCv2
      */
-    object_initialize(&s->gpcv2, sizeof(s->gpcv2), TYPE_IMX_GPCV2);
-    qdev_set_parent_bus(DEVICE(&s->gpcv2), sysbus);
-    object_property_add_child(obj, "gpcv2", OBJECT(&s->gpcv2), &error_fatal);
+    sysbus_init_child_obj(obj, "gpcv2", &s->gpcv2, sizeof(s->gpcv2),
+                          TYPE_IMX_GPCV2);
 
     for (i = 0; i < FSL_IMX7_NUM_ECSPIS; i++) {
-        object_initialize(&s->spi[i], sizeof(s->spi[i]), TYPE_IMX_SPI);
-        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->spi[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
+                              TYPE_IMX_SPI);
     }
 
 
     for (i = 0; i < FSL_IMX7_NUM_I2CS; i++) {
-        object_initialize(&s->i2c[i], sizeof(s->i2c[i]), TYPE_IMX_I2C);
-        qdev_set_parent_bus(DEVICE(&s->i2c[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->i2c[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->i2c[i], sizeof(s->i2c[i]),
+                              TYPE_IMX_I2C);
     }
 
     /*
      * UART
      */
     for (i = 0; i < FSL_IMX7_NUM_UARTS; i++) {
-            object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_IMX_SERIAL);
-            qdev_set_parent_bus(DEVICE(&s->uart[i]), sysbus);
             snprintf(name, NAME_SIZE, "uart%d", i);
-            object_property_add_child(obj, name, OBJECT(&s->uart[i]),
-                                      &error_fatal);
+            sysbus_init_child_obj(obj, name, &s->uart[i], sizeof(s->uart[i]),
+                                  TYPE_IMX_SERIAL);
     }
 
     /*
      * Ethernet
      */
     for (i = 0; i < FSL_IMX7_NUM_ETHS; i++) {
-            object_initialize(&s->eth[i], sizeof(s->eth[i]), TYPE_IMX_ENET);
-            qdev_set_parent_bus(DEVICE(&s->eth[i]), sysbus);
             snprintf(name, NAME_SIZE, "eth%d", i);
-            object_property_add_child(obj, name, OBJECT(&s->eth[i]),
-                                      &error_fatal);
+            sysbus_init_child_obj(obj, name, &s->eth[i], sizeof(s->eth[i]),
+                                  TYPE_IMX_ENET);
     }
 
     /*
      * SDHCI
      */
     for (i = 0; i < FSL_IMX7_NUM_USDHCS; i++) {
-            object_initialize(&s->usdhc[i], sizeof(s->usdhc[i]),
-                              TYPE_IMX_USDHC);
-            qdev_set_parent_bus(DEVICE(&s->usdhc[i]), sysbus);
             snprintf(name, NAME_SIZE, "usdhc%d", i);
-            object_property_add_child(obj, name, OBJECT(&s->usdhc[i]),
-                                      &error_fatal);
+            sysbus_init_child_obj(obj, name, &s->usdhc[i], sizeof(s->usdhc[i]),
+                              TYPE_IMX_USDHC);
     }
 
     /*
      * SNVS
      */
-    object_initialize(&s->snvs, sizeof(s->snvs), TYPE_IMX7_SNVS);
-    qdev_set_parent_bus(DEVICE(&s->snvs), sysbus);
-    object_property_add_child(obj, "snvs", OBJECT(&s->snvs), &error_fatal);
+    sysbus_init_child_obj(obj, "snvs", &s->snvs, sizeof(s->snvs),
+                          TYPE_IMX7_SNVS);
 
     /*
      * Watchdog
      */
     for (i = 0; i < FSL_IMX7_NUM_WDTS; i++) {
-            object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_IMX2_WDT);
-            qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus);
             snprintf(name, NAME_SIZE, "wdt%d", i);
-            object_property_add_child(obj, name, OBJECT(&s->wdt[i]),
-                                      &error_fatal);
+            sysbus_init_child_obj(obj, name, &s->wdt[i], sizeof(s->wdt[i]),
+                                  TYPE_IMX2_WDT);
     }
 
     /*
      * GPR
      */
-    object_initialize(&s->gpr, sizeof(s->gpr), TYPE_IMX7_GPR);
-    qdev_set_parent_bus(DEVICE(&s->gpr), sysbus);
-    object_property_add_child(obj, "gpr", OBJECT(&s->gpr), &error_fatal);
+    sysbus_init_child_obj(obj, "gpr", &s->gpr, sizeof(s->gpr), TYPE_IMX7_GPR);
 
-    object_initialize(&s->pcie, sizeof(s->pcie), TYPE_DESIGNWARE_PCIE_HOST);
-    qdev_set_parent_bus(DEVICE(&s->pcie), sysbus);
-    object_property_add_child(obj, "pcie", OBJECT(&s->pcie), &error_fatal);
+    sysbus_init_child_obj(obj, "pcie", &s->pcie, sizeof(s->pcie),
+                          TYPE_DESIGNWARE_PCIE_HOST);
 
     for (i = 0; i < FSL_IMX7_NUM_USBS; i++) {
-        object_initialize(&s->usb[i],
-                          sizeof(s->usb[i]), TYPE_CHIPIDEA);
-        qdev_set_parent_bus(DEVICE(&s->usb[i]), sysbus);
         snprintf(name, NAME_SIZE, "usb%d", i);
-        object_property_add_child(obj, name,
-                                  OBJECT(&s->usb[i]), &error_fatal);
+        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
+                              TYPE_CHIPIDEA);
     }
 }
 
-- 
1.8.3.1
