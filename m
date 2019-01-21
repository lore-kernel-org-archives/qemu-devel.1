Received: from eggs.gnu.org ([209.51.188.92]:38654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleui-0007jF-9f
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefT-0002dr-6j
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefR-0002bk-B9
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:31 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so24556309wrr.12
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:01 +0000
Message-Id: <20190121185118.18550-7-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/23] hw/arm/iotkit: Rename 'iotkit' local
 variables and functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Rename various internal uses of 'iotkit' in hw/arm/iotkit.c to
'armsse', for consistency. The remaining occurences are:
 * related to the devices TYPE_IOTKIT_SYSCTL, TYPE_IOTKIT_SYSINFO,
   etc, which this refactor is not touching
 * references that apply specifically to the IoTKit (like
   the lack of a private CPU region)
 * the vmstate, which keeps its old "iotkit" name for
   migration compatibility reasons

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/iotkit.c | 68 ++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index d5b172933c3..7ff14fd5aef 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -56,7 +56,7 @@ static void nsccfg_handler(void *opaque, int n, int level)
     s->nsccfg = level;
 }
 
-static void iotkit_forward_ppc(ARMSSE *s, const char *ppcname, int ppcnum)
+static void armsse_forward_ppc(ARMSSE *s, const char *ppcname, int ppcnum)
 {
     /* Each of the 4 AHB and 4 APB PPCs that might be present in a
      * system using the ARMSSE has a collection of control lines which
@@ -65,22 +65,22 @@ static void iotkit_forward_ppc(ARMSSE *s, const char *ppcname, int ppcnum)
      * code using the ARMSSE can wire them up to the PPCs.
      */
     SplitIRQ *splitter = &s->ppc_irq_splitter[ppcnum];
-    DeviceState *iotkitdev = DEVICE(s);
+    DeviceState *armssedev = DEVICE(s);
     DeviceState *dev_secctl = DEVICE(&s->secctl);
     DeviceState *dev_splitter = DEVICE(splitter);
     char *name;
 
     name = g_strdup_printf("%s_nonsec", ppcname);
-    qdev_pass_gpios(dev_secctl, iotkitdev, name);
+    qdev_pass_gpios(dev_secctl, armssedev, name);
     g_free(name);
     name = g_strdup_printf("%s_ap", ppcname);
-    qdev_pass_gpios(dev_secctl, iotkitdev, name);
+    qdev_pass_gpios(dev_secctl, armssedev, name);
     g_free(name);
     name = g_strdup_printf("%s_irq_enable", ppcname);
-    qdev_pass_gpios(dev_secctl, iotkitdev, name);
+    qdev_pass_gpios(dev_secctl, armssedev, name);
     g_free(name);
     name = g_strdup_printf("%s_irq_clear", ppcname);
-    qdev_pass_gpios(dev_secctl, iotkitdev, name);
+    qdev_pass_gpios(dev_secctl, armssedev, name);
     g_free(name);
 
     /* irq_status is a little more tricky, because we need to
@@ -96,15 +96,15 @@ static void iotkit_forward_ppc(ARMSSE *s, const char *ppcname, int ppcnum)
     qdev_connect_gpio_out(dev_splitter, 1,
                           qdev_get_gpio_in(DEVICE(&s->ppc_irq_orgate), ppcnum));
     s->irq_status_in[ppcnum] = qdev_get_gpio_in(dev_splitter, 0);
-    qdev_init_gpio_in_named_with_opaque(iotkitdev, irq_status_forwarder,
+    qdev_init_gpio_in_named_with_opaque(armssedev, irq_status_forwarder,
                                         s->irq_status_in[ppcnum], name, 1);
     g_free(name);
 }
 
-static void iotkit_forward_sec_resp_cfg(ARMSSE *s)
+static void armsse_forward_sec_resp_cfg(ARMSSE *s)
 {
     /* Forward the 3rd output from the splitter device as a
-     * named GPIO output of the iotkit object.
+     * named GPIO output of the armsse object.
      */
     DeviceState *dev = DEVICE(s);
     DeviceState *dev_splitter = DEVICE(&s->sec_resp_splitter);
@@ -115,12 +115,12 @@ static void iotkit_forward_sec_resp_cfg(ARMSSE *s)
     qdev_connect_gpio_out(dev_splitter, 2, s->sec_resp_cfg_in);
 }
 
-static void iotkit_init(Object *obj)
+static void armsse_init(Object *obj)
 {
     ARMSSE *s = ARMSSE(obj);
     int i;
 
-    memory_region_init(&s->container, obj, "iotkit-container", UINT64_MAX);
+    memory_region_init(&s->container, obj, "armsse-container", UINT64_MAX);
 
     sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
                           TYPE_ARMV7M);
@@ -160,9 +160,9 @@ static void iotkit_init(Object *obj)
                           sizeof(s->nswatchdog), TYPE_CMSDK_APB_WATCHDOG);
     sysbus_init_child_obj(obj, "swatchdog", &s->swatchdog,
                           sizeof(s->swatchdog), TYPE_CMSDK_APB_WATCHDOG);
-    sysbus_init_child_obj(obj, "iotkit-sysctl", &s->sysctl,
+    sysbus_init_child_obj(obj, "armsse-sysctl", &s->sysctl,
                           sizeof(s->sysctl), TYPE_IOTKIT_SYSCTL);
-    sysbus_init_child_obj(obj, "iotkit-sysinfo", &s->sysinfo,
+    sysbus_init_child_obj(obj, "armsse-sysinfo", &s->sysinfo,
                           sizeof(s->sysinfo), TYPE_IOTKIT_SYSINFO);
     object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
                             sizeof(s->nmi_orgate), TYPE_OR_IRQ,
@@ -183,20 +183,20 @@ static void iotkit_init(Object *obj)
     }
 }
 
-static void iotkit_exp_irq(void *opaque, int n, int level)
+static void armsse_exp_irq(void *opaque, int n, int level)
 {
     ARMSSE *s = ARMSSE(opaque);
 
     qemu_set_irq(s->exp_irqs[n], level);
 }
 
-static void iotkit_mpcexp_status(void *opaque, int n, int level)
+static void armsse_mpcexp_status(void *opaque, int n, int level)
 {
     ARMSSE *s = ARMSSE(opaque);
     qemu_set_irq(s->mpcexp_status_in[n], level);
 }
 
-static void iotkit_realize(DeviceState *dev, Error **errp)
+static void armsse_realize(DeviceState *dev, Error **errp)
 {
     ARMSSE *s = ARMSSE(dev);
     int i;
@@ -287,7 +287,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->exp_numirq; i++) {
         s->exp_irqs[i] = qdev_get_gpio_in(DEVICE(&s->armv7m), i + 32);
     }
-    qdev_init_gpio_in_named(dev, iotkit_exp_irq, "EXP_IRQ", s->exp_numirq);
+    qdev_init_gpio_in_named(dev, armsse_exp_irq, "EXP_IRQ", s->exp_numirq);
 
     /* Set up the big aliases first */
     make_alias(s, &s->alias1, "alias 1", 0x10000000, 0x10000000, 0x00000000);
@@ -336,7 +336,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
                                 qdev_get_gpio_in(dev_splitter, 0));
 
     /* This RAM lives behind the Memory Protection Controller */
-    memory_region_init_ram(&s->sram0, NULL, "iotkit.sram0", 0x00008000, &err);
+    memory_region_init_ram(&s->sram0, NULL, "armsse.sram0", 0x00008000, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -608,14 +608,14 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < IOTS_NUM_AHB_EXP_PPC; i++) {
         char *ppcname = g_strdup_printf("ahb_ppcexp%d", i);
 
-        iotkit_forward_ppc(s, ppcname, i);
+        armsse_forward_ppc(s, ppcname, i);
         g_free(ppcname);
     }
 
     for (i = 0; i < IOTS_NUM_APB_EXP_PPC; i++) {
         char *ppcname = g_strdup_printf("apb_ppcexp%d", i);
 
-        iotkit_forward_ppc(s, ppcname, i + IOTS_NUM_AHB_EXP_PPC);
+        armsse_forward_ppc(s, ppcname, i + IOTS_NUM_AHB_EXP_PPC);
         g_free(ppcname);
     }
 
@@ -672,10 +672,10 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     /* Create GPIO inputs which will pass the line state for our
      * mpcexp_irq inputs to the correct splitter devices.
      */
-    qdev_init_gpio_in_named(dev, iotkit_mpcexp_status, "mpcexp_status",
+    qdev_init_gpio_in_named(dev, armsse_mpcexp_status, "mpcexp_status",
                             IOTS_NUM_EXP_MPC);
 
-    iotkit_forward_sec_resp_cfg(s);
+    armsse_forward_sec_resp_cfg(s);
 
     /* Forward the MSC related signals */
     qdev_pass_gpios(dev_secctl, dev, "mscexp_status");
@@ -695,7 +695,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     system_clock_scale = NANOSECONDS_PER_SECOND / s->mainclk_frq;
 }
 
-static void iotkit_idau_check(IDAUInterface *ii, uint32_t address,
+static void armsse_idau_check(IDAUInterface *ii, uint32_t address,
                               int *iregion, bool *exempt, bool *ns, bool *nsc)
 {
     /*
@@ -713,7 +713,7 @@ static void iotkit_idau_check(IDAUInterface *ii, uint32_t address,
     *iregion = region;
 }
 
-static const VMStateDescription iotkit_vmstate = {
+static const VMStateDescription armsse_vmstate = {
     .name = "iotkit",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -723,7 +723,7 @@ static const VMStateDescription iotkit_vmstate = {
     }
 };
 
-static Property iotkit_properties[] = {
+static Property armsse_properties[] = {
     DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
@@ -731,24 +731,24 @@ static Property iotkit_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void iotkit_reset(DeviceState *dev)
+static void armsse_reset(DeviceState *dev)
 {
     ARMSSE *s = ARMSSE(dev);
 
     s->nsccfg = 0;
 }
 
-static void iotkit_class_init(ObjectClass *klass, void *data)
+static void armsse_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(klass);
     ARMSSEClass *asc = ARMSSE_CLASS(klass);
 
-    dc->realize = iotkit_realize;
-    dc->vmsd = &iotkit_vmstate;
-    dc->props = iotkit_properties;
-    dc->reset = iotkit_reset;
-    iic->check = iotkit_idau_check;
+    dc->realize = armsse_realize;
+    dc->vmsd = &armsse_vmstate;
+    dc->props = armsse_properties;
+    dc->reset = armsse_reset;
+    iic->check = armsse_idau_check;
     asc->info = data;
 }
 
@@ -756,7 +756,7 @@ static const TypeInfo armsse_info = {
     .name = TYPE_ARMSSE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMSSE),
-    .instance_init = iotkit_init,
+    .instance_init = armsse_init,
     .abstract = true,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_IDAU_INTERFACE },
@@ -774,7 +774,7 @@ static void armsse_register_types(void)
         TypeInfo ti = {
             .name = armsse_variants[i].name,
             .parent = TYPE_ARMSSE,
-            .class_init = iotkit_class_init,
+            .class_init = armsse_class_init,
             .class_data = (void *)&armsse_variants[i],
         };
         type_register(&ti);
-- 
2.20.1
