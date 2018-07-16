Received: from eggs.gnu.org ([2001:4830:134:3::10]:43669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36o-0001Tj-6j
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36i-0002Ew-89
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:10 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:27 +0200
Message-Id: <1531745974-17187-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/17] hw/arm/fsl-imx25: Fix introspection
 problem with the "fsl, imx25" device
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
 "'arguments':{'typename':'fsl,imx25'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==26724== Invalid read of size 8
==26724==    at 0x6190DA: qdev_print (qdev-monitor.c:686)
==26724==    by 0x6190DA: qbus_print (qdev-monitor.c:719)
[...]

Use the new sysbus_init_child_obj() to make sure that the objects are
cleaned up correctly when the parent gets destroyed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx25.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 37056f9..bd07040 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -39,38 +39,36 @@ static void fsl_imx25_init(Object *obj)
 
     object_initialize(&s->cpu, sizeof(s->cpu), "arm926-" TYPE_ARM_CPU);
 
-    object_initialize(&s->avic, sizeof(s->avic), TYPE_IMX_AVIC);
-    qdev_set_parent_bus(DEVICE(&s->avic), sysbus_get_default());
+    sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
+                          TYPE_IMX_AVIC);
 
-    object_initialize(&s->ccm, sizeof(s->ccm), TYPE_IMX25_CCM);
-    qdev_set_parent_bus(DEVICE(&s->ccm), sysbus_get_default());
+    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX25_CCM);
 
     for (i = 0; i < FSL_IMX25_NUM_UARTS; i++) {
-        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_IMX_SERIAL);
-        qdev_set_parent_bus(DEVICE(&s->uart[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "uart[*]", &s->uart[i], sizeof(s->uart[i]),
+                              TYPE_IMX_SERIAL);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_GPTS; i++) {
-        object_initialize(&s->gpt[i], sizeof(s->gpt[i]), TYPE_IMX25_GPT);
-        qdev_set_parent_bus(DEVICE(&s->gpt[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "gpt[*]", &s->gpt[i], sizeof(s->gpt[i]),
+                              TYPE_IMX25_GPT);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_EPITS; i++) {
-        object_initialize(&s->epit[i], sizeof(s->epit[i]), TYPE_IMX_EPIT);
-        qdev_set_parent_bus(DEVICE(&s->epit[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "epit[*]", &s->epit[i], sizeof(s->epit[i]),
+                              TYPE_IMX_EPIT);
     }
 
-    object_initialize(&s->fec, sizeof(s->fec), TYPE_IMX_FEC);
-    qdev_set_parent_bus(DEVICE(&s->fec), sysbus_get_default());
+    sysbus_init_child_obj(obj, "fec", &s->fec, sizeof(s->fec), TYPE_IMX_FEC);
 
     for (i = 0; i < FSL_IMX25_NUM_I2CS; i++) {
-        object_initialize(&s->i2c[i], sizeof(s->i2c[i]), TYPE_IMX_I2C);
-        qdev_set_parent_bus(DEVICE(&s->i2c[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "i2c[*]", &s->i2c[i], sizeof(s->i2c[i]),
+                              TYPE_IMX_I2C);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_GPIOS; i++) {
-        object_initialize(&s->gpio[i], sizeof(s->gpio[i]), TYPE_IMX_GPIO);
-        qdev_set_parent_bus(DEVICE(&s->gpio[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
+                              TYPE_IMX_GPIO);
     }
 }
 
-- 
1.8.3.1
