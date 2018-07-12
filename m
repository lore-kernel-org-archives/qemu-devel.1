Received: from eggs.gnu.org ([2001:4830:134:3::10]:37644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fddYw-0005PS-SV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fddYv-00084r-LV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:31:22 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 12 Jul 2018 17:31:02 +0200
Message-Id: <1531409463-3843-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1531409463-3843-1-git-send-email-thuth@redhat.com>
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] hw/arm/armv7: Fix crash when introspecting
 the "iotkit" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

QEMU currently crashes when introspecting the "iotkit" device and
runnint "info qtree" afterwards, e.g. when running QEMU like this:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'iotkit'}}" "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio

Use the new functions object_initialize_as_child() and sysbus_init_child_obj()
to make sure that all objects get cleaned up correctly when the instances
are destroyed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/armv7m.c       |  9 ++++---
 hw/arm/iotkit.c       | 74 ++++++++++++++++++++++-----------------------------
 hw/intc/armv7m_nvic.c |  5 ++--
 3 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 9e00d40..7164e04 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -134,14 +134,15 @@ static void armv7m_instance_init(Object *obj)
 
     memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
 
-    object_initialize(&s->nvic, sizeof(s->nvic), TYPE_NVIC);
-    qdev_set_parent_bus(DEVICE(&s->nvic), sysbus_get_default());
+    sysbus_init_child_obj(obj, "nvnic", &s->nvic, sizeof(s->nvic), TYPE_NVIC);
     object_property_add_alias(obj, "num-irq",
                               OBJECT(&s->nvic), "num-irq", &error_abort);
 
     for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
-        object_initialize(&s->bitband[i], sizeof(s->bitband[i]), TYPE_BITBAND);
-        qdev_set_parent_bus(DEVICE(&s->bitband[i]), sysbus_get_default());
+        char *name = g_strdup_printf("bitband-%d", i);
+        sysbus_init_child_obj(obj, name, &s->bitband[i], sizeof(s->bitband[i]),
+                              TYPE_BITBAND);
+        g_free(name);
     }
 }
 
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index 133d5bb..d479323 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -30,15 +30,6 @@ static void make_alias(IoTKit *s, MemoryRegion *mr, const char *name,
     memory_region_add_subregion_overlap(&s->container, base, mr, -1500);
 }
 
-static void init_sysbus_child(Object *parent, const char *childname,
-                              void *child, size_t childsize,
-                              const char *childtype)
-{
-    object_initialize(child, childsize, childtype);
-    object_property_add_child(parent, childname, OBJECT(child), &error_abort);
-    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
-}
-
 static void irq_status_forwarder(void *opaque, int n, int level)
 {
     qemu_irq destirq = opaque;
@@ -119,53 +110,52 @@ static void iotkit_init(Object *obj)
 
     memory_region_init(&s->container, obj, "iotkit-container", UINT64_MAX);
 
-    init_sysbus_child(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
-                      TYPE_ARMV7M);
+    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
+                          TYPE_ARMV7M);
     qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
                          ARM_CPU_TYPE_NAME("cortex-m33"));
 
-    init_sysbus_child(obj, "secctl", &s->secctl, sizeof(s->secctl),
-                      TYPE_IOTKIT_SECCTL);
-    init_sysbus_child(obj, "apb-ppc0", &s->apb_ppc0, sizeof(s->apb_ppc0),
-                      TYPE_TZ_PPC);
-    init_sysbus_child(obj, "apb-ppc1", &s->apb_ppc1, sizeof(s->apb_ppc1),
-                      TYPE_TZ_PPC);
-    init_sysbus_child(obj, "mpc", &s->mpc, sizeof(s->mpc), TYPE_TZ_MPC);
-    object_initialize(&s->mpc_irq_orgate, sizeof(s->mpc_irq_orgate),
-                      TYPE_OR_IRQ);
-    object_property_add_child(obj, "mpc-irq-orgate",
-                              OBJECT(&s->mpc_irq_orgate), &error_abort);
+    sysbus_init_child_obj(obj, "secctl", &s->secctl, sizeof(s->secctl),
+                          TYPE_IOTKIT_SECCTL);
+    sysbus_init_child_obj(obj, "apb-ppc0", &s->apb_ppc0, sizeof(s->apb_ppc0),
+                          TYPE_TZ_PPC);
+    sysbus_init_child_obj(obj, "apb-ppc1", &s->apb_ppc1, sizeof(s->apb_ppc1),
+                          TYPE_TZ_PPC);
+    sysbus_init_child_obj(obj, "mpc", &s->mpc, sizeof(s->mpc), TYPE_TZ_MPC);
+    object_initialize_as_child(obj, "mpc-irq-orgate", &s->mpc_irq_orgate,
+                               sizeof(s->mpc_irq_orgate), TYPE_OR_IRQ,
+                               &error_abort);
+
     for (i = 0; i < ARRAY_SIZE(s->mpc_irq_splitter); i++) {
         char *name = g_strdup_printf("mpc-irq-splitter-%d", i);
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
 
-        object_initialize(splitter, sizeof(*splitter), TYPE_SPLIT_IRQ);
-        object_property_add_child(obj, name, OBJECT(splitter), &error_abort);
+        object_initialize_as_child(obj, name, splitter, sizeof(*splitter),
+                                   TYPE_SPLIT_IRQ, &error_abort);
         g_free(name);
     }
-    init_sysbus_child(obj, "timer0", &s->timer0, sizeof(s->timer0),
-                      TYPE_CMSDK_APB_TIMER);
-    init_sysbus_child(obj, "timer1", &s->timer1, sizeof(s->timer1),
-                      TYPE_CMSDK_APB_TIMER);
-    init_sysbus_child(obj, "dualtimer", &s->dualtimer, sizeof(s->dualtimer),
-                      TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize(&s->ppc_irq_orgate, sizeof(s->ppc_irq_orgate),
-                      TYPE_OR_IRQ);
-    object_property_add_child(obj, "ppc-irq-orgate",
-                              OBJECT(&s->ppc_irq_orgate), &error_abort);
-    object_initialize(&s->sec_resp_splitter, sizeof(s->sec_resp_splitter),
-                      TYPE_SPLIT_IRQ);
-    object_property_add_child(obj, "sec-resp-splitter",
-                              OBJECT(&s->sec_resp_splitter), &error_abort);
+    sysbus_init_child_obj(obj, "timer0", &s->timer0, sizeof(s->timer0),
+                          TYPE_CMSDK_APB_TIMER);
+    sysbus_init_child_obj(obj, "timer1", &s->timer1, sizeof(s->timer1),
+                          TYPE_CMSDK_APB_TIMER);
+    sysbus_init_child_obj(obj, "dualtimer", &s->dualtimer, sizeof(s->dualtimer),
+                          TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_as_child(obj, "ppc-irq-orgate", &s->ppc_irq_orgate,
+                               sizeof(s->ppc_irq_orgate), TYPE_OR_IRQ,
+                               &error_abort);
+    object_initialize_as_child(obj, "sec-resp-splitter", &s->sec_resp_splitter,
+                               sizeof(s->sec_resp_splitter), TYPE_SPLIT_IRQ,
+                               &error_abort);
     for (i = 0; i < ARRAY_SIZE(s->ppc_irq_splitter); i++) {
         char *name = g_strdup_printf("ppc-irq-splitter-%d", i);
         SplitIRQ *splitter = &s->ppc_irq_splitter[i];
 
-        object_initialize(splitter, sizeof(*splitter), TYPE_SPLIT_IRQ);
-        object_property_add_child(obj, name, OBJECT(splitter), &error_abort);
+        object_initialize_as_child(obj, name, splitter, sizeof(*splitter),
+                                   TYPE_SPLIT_IRQ, &error_abort);
+        g_free(name);
     }
-    init_sysbus_child(obj, "s32ktimer", &s->s32ktimer, sizeof(s->s32ktimer),
-                      TYPE_UNIMPLEMENTED_DEVICE);
+    sysbus_init_child_obj(obj, "s32ktimer", &s->s32ktimer, sizeof(s->s32ktimer),
+                          TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void iotkit_exp_irq(void *opaque, int n, int level)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 661be88..7a5330f 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2296,9 +2296,8 @@ static void armv7m_nvic_instance_init(Object *obj)
     NVICState *nvic = NVIC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_initialize(&nvic->systick[M_REG_NS],
-                      sizeof(nvic->systick[M_REG_NS]), TYPE_SYSTICK);
-    qdev_set_parent_bus(DEVICE(&nvic->systick[M_REG_NS]), sysbus_get_default());
+    sysbus_init_child_obj(obj, "systick-reg-ns", &nvic->systick[M_REG_NS],
+                          sizeof(nvic->systick[M_REG_NS]), TYPE_SYSTICK);
     /* We can't initialize the secure systick here, as we don't know
      * yet if we need it.
      */
-- 
1.8.3.1
