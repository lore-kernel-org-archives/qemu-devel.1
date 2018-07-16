Received: from eggs.gnu.org ([2001:4830:134:3::10]:43524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36b-0001I5-6E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36Z-00028o-Ub
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:57 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:25 +0200
Message-Id: <1531745974-17187-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/17] hw/arm/fsl-imx6: Fix introspection
 problems with the "fsl, imx6" device
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
 "'arguments':{'typename':'fsl,imx6'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==32417== Invalid read of size 8
==32417==    at 0x618A7A: qdev_print (qdev-monitor.c:686)
==32417==    by 0x618A7A: qbus_print (qdev-monitor.c:719)
==32417==    by 0x452B38: handle_hmp_command (monitor.c:3446)
[...]

Use the new sysbus_init_child_obj() and object_initialize_child() to make
sure that the objects are removed correctly when the parent gets destroyed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx6.c | 56 ++++++++++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 4f51bd9..7b7b97f 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -38,73 +38,57 @@ static void fsl_imx6_init(Object *obj)
     int i;
 
     for (i = 0; i < MIN(smp_cpus, FSL_IMX6_NUM_CPUS); i++) {
-        object_initialize(&s->cpu[i], sizeof(s->cpu[i]),
-                          "cortex-a9-" TYPE_ARM_CPU);
         snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_property_add_child(obj, name, OBJECT(&s->cpu[i]), NULL);
+        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
+                                "cortex-a9-" TYPE_ARM_CPU, &error_abort, NULL);
     }
 
-    object_initialize(&s->a9mpcore, sizeof(s->a9mpcore), TYPE_A9MPCORE_PRIV);
-    qdev_set_parent_bus(DEVICE(&s->a9mpcore), sysbus_get_default());
-    object_property_add_child(obj, "a9mpcore", OBJECT(&s->a9mpcore), NULL);
+    sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore, sizeof(s->a9mpcore),
+                          TYPE_A9MPCORE_PRIV);
 
-    object_initialize(&s->ccm, sizeof(s->ccm), TYPE_IMX6_CCM);
-    qdev_set_parent_bus(DEVICE(&s->ccm), sysbus_get_default());
-    object_property_add_child(obj, "ccm", OBJECT(&s->ccm), NULL);
+    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX6_CCM);
 
-    object_initialize(&s->src, sizeof(s->src), TYPE_IMX6_SRC);
-    qdev_set_parent_bus(DEVICE(&s->src), sysbus_get_default());
-    object_property_add_child(obj, "src", OBJECT(&s->src), NULL);
+    sysbus_init_child_obj(obj, "src", &s->src, sizeof(s->src), TYPE_IMX6_SRC);
 
     for (i = 0; i < FSL_IMX6_NUM_UARTS; i++) {
-        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_IMX_SERIAL);
-        qdev_set_parent_bus(DEVICE(&s->uart[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "uart%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->uart[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->uart[i], sizeof(s->uart[i]),
+                              TYPE_IMX_SERIAL);
     }
 
-    object_initialize(&s->gpt, sizeof(s->gpt), TYPE_IMX6_GPT);
-    qdev_set_parent_bus(DEVICE(&s->gpt), sysbus_get_default());
-    object_property_add_child(obj, "gpt", OBJECT(&s->gpt), NULL);
+    sysbus_init_child_obj(obj, "gpt", &s->gpt, sizeof(s->gpt), TYPE_IMX6_GPT);
 
     for (i = 0; i < FSL_IMX6_NUM_EPITS; i++) {
-        object_initialize(&s->epit[i], sizeof(s->epit[i]), TYPE_IMX_EPIT);
-        qdev_set_parent_bus(DEVICE(&s->epit[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "epit%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->epit[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->epit[i], sizeof(s->epit[i]),
+                              TYPE_IMX_EPIT);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_I2CS; i++) {
-        object_initialize(&s->i2c[i], sizeof(s->i2c[i]), TYPE_IMX_I2C);
-        qdev_set_parent_bus(DEVICE(&s->i2c[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->i2c[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->i2c[i], sizeof(s->i2c[i]),
+                              TYPE_IMX_I2C);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_GPIOS; i++) {
-        object_initialize(&s->gpio[i], sizeof(s->gpio[i]), TYPE_IMX_GPIO);
-        qdev_set_parent_bus(DEVICE(&s->gpio[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "gpio%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->gpio[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->gpio[i], sizeof(s->gpio[i]),
+                              TYPE_IMX_GPIO);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
-        object_initialize(&s->esdhc[i], sizeof(s->esdhc[i]), TYPE_IMX_USDHC);
-        qdev_set_parent_bus(DEVICE(&s->esdhc[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "sdhc%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->esdhc[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->esdhc[i], sizeof(s->esdhc[i]),
+                              TYPE_IMX_USDHC);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
-        object_initialize(&s->spi[i], sizeof(s->spi[i]), TYPE_IMX_SPI);
-        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
-        object_property_add_child(obj, name, OBJECT(&s->spi[i]), NULL);
+        sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
+                              TYPE_IMX_SPI);
     }
 
-    object_initialize(&s->eth, sizeof(s->eth), TYPE_IMX_ENET);
-    qdev_set_parent_bus(DEVICE(&s->eth), sysbus_get_default());
-    object_property_add_child(obj, "eth", OBJECT(&s->eth), NULL);
+    sysbus_init_child_obj(obj, "eth", &s->eth, sizeof(s->eth), TYPE_IMX_ENET);
 }
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
-- 
1.8.3.1
