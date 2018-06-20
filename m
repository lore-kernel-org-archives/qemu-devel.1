Received: from eggs.gnu.org ([2001:4830:134:3::10]:55249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2X-00086X-BN
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2W-0002sV-5j
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:20:31 +0100
Message-Id: <20180620132032.28865-8-peter.maydell@linaro.org>
In-Reply-To: <20180620132032.28865-1-peter.maydell@linaro.org>
References: <20180620132032.28865-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 7/8] hw/arm/iotkit: Wire up MPC interrupt
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eric Auger <eric.auger@redhat.com>

The interrupt outputs from the MPC in the IoTKit and the expansion
MPCs in the board must be wired up to the security controller, and
also all ORed together to produce a single line to the NVIC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/arm/iotkit.h |  6 ++++
 hw/arm/iotkit.c         | 74 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
index b21cf1ab9d1..2cddde55dd1 100644
--- a/include/hw/arm/iotkit.h
+++ b/include/hw/arm/iotkit.h
@@ -42,6 +42,9 @@
  *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_enable
  *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_clear
  *  + named GPIO inputs ahb_ppcexp{0,1,2,3}_irq_status
+ * Controlling each of the 16 expansion MPCs which a system using the IoTKit
+ * might provide:
+ *  + named GPIO inputs mpcexp_status[0..15]
  */
 
 #ifndef IOTKIT_H
@@ -81,6 +84,8 @@ typedef struct IoTKit {
     qemu_or_irq ppc_irq_orgate;
     SplitIRQ sec_resp_splitter;
     SplitIRQ ppc_irq_splitter[NUM_PPCS];
+    SplitIRQ mpc_irq_splitter[IOTS_NUM_EXP_MPC + IOTS_NUM_MPC];
+    qemu_or_irq mpc_irq_orgate;
 
     UnimplementedDeviceState dualtimer;
     UnimplementedDeviceState s32ktimer;
@@ -99,6 +104,7 @@ typedef struct IoTKit {
     qemu_irq nsc_cfg_in;
 
     qemu_irq irq_status_in[NUM_EXTERNAL_PPCS];
+    qemu_irq mpcexp_status_in[IOTS_NUM_EXP_MPC];
 
     uint32_t nsccfg;
 
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index 160e40c7449..133d5bb34f4 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -131,6 +131,18 @@ static void iotkit_init(Object *obj)
     init_sysbus_child(obj, "apb-ppc1", &s->apb_ppc1, sizeof(s->apb_ppc1),
                       TYPE_TZ_PPC);
     init_sysbus_child(obj, "mpc", &s->mpc, sizeof(s->mpc), TYPE_TZ_MPC);
+    object_initialize(&s->mpc_irq_orgate, sizeof(s->mpc_irq_orgate),
+                      TYPE_OR_IRQ);
+    object_property_add_child(obj, "mpc-irq-orgate",
+                              OBJECT(&s->mpc_irq_orgate), &error_abort);
+    for (i = 0; i < ARRAY_SIZE(s->mpc_irq_splitter); i++) {
+        char *name = g_strdup_printf("mpc-irq-splitter-%d", i);
+        SplitIRQ *splitter = &s->mpc_irq_splitter[i];
+
+        object_initialize(splitter, sizeof(*splitter), TYPE_SPLIT_IRQ);
+        object_property_add_child(obj, name, OBJECT(splitter), &error_abort);
+        g_free(name);
+    }
     init_sysbus_child(obj, "timer0", &s->timer0, sizeof(s->timer0),
                       TYPE_CMSDK_APB_TIMER);
     init_sysbus_child(obj, "timer1", &s->timer1, sizeof(s->timer1),
@@ -163,6 +175,12 @@ static void iotkit_exp_irq(void *opaque, int n, int level)
     qemu_set_irq(s->exp_irqs[n], level);
 }
 
+static void iotkit_mpcexp_status(void *opaque, int n, int level)
+{
+    IoTKit *s = IOTKIT(opaque);
+    qemu_set_irq(s->mpcexp_status_in[n], level);
+}
+
 static void iotkit_realize(DeviceState *dev, Error **errp)
 {
     IoTKit *s = IOTKIT(dev);
@@ -328,6 +346,22 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mpc),
                                                        0));
 
+    /* We must OR together lines from the MPC splitters to go to the NVIC */
+    object_property_set_int(OBJECT(&s->mpc_irq_orgate),
+                            IOTS_NUM_EXP_MPC + IOTS_NUM_MPC, "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->mpc_irq_orgate), true,
+                             "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->mpc_irq_orgate), 0,
+                          qdev_get_gpio_in(DEVICE(&s->armv7m), 9));
+
     /* Devices behind APB PPC0:
      *   0x40000000: timer0
      *   0x40001000: timer1
@@ -536,6 +570,46 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
         g_free(gpioname);
     }
 
+    /* Wire up the splitters for the MPC IRQs */
+    for (i = 0; i < IOTS_NUM_EXP_MPC + IOTS_NUM_MPC; i++) {
+        SplitIRQ *splitter = &s->mpc_irq_splitter[i];
+        DeviceState *dev_splitter = DEVICE(splitter);
+
+        object_property_set_int(OBJECT(splitter), 2, "num-lines", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        object_property_set_bool(OBJECT(splitter), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        if (i < IOTS_NUM_EXP_MPC) {
+            /* Splitter input is from GPIO input line */
+            s->mpcexp_status_in[i] = qdev_get_gpio_in(dev_splitter, 0);
+            qdev_connect_gpio_out(dev_splitter, 0,
+                                  qdev_get_gpio_in_named(dev_secctl,
+                                                         "mpcexp_status", i));
+        } else {
+            /* Splitter input is from our own MPC */
+            qdev_connect_gpio_out_named(DEVICE(&s->mpc), "irq", 0,
+                                        qdev_get_gpio_in(dev_splitter, 0));
+            qdev_connect_gpio_out(dev_splitter, 0,
+                                  qdev_get_gpio_in_named(dev_secctl,
+                                                         "mpc_status", 0));
+        }
+
+        qdev_connect_gpio_out(dev_splitter, 1,
+                              qdev_get_gpio_in(DEVICE(&s->mpc_irq_orgate), i));
+    }
+    /* Create GPIO inputs which will pass the line state for our
+     * mpcexp_irq inputs to the correct splitter devices.
+     */
+    qdev_init_gpio_in_named(dev, iotkit_mpcexp_status, "mpcexp_status",
+                            IOTS_NUM_EXP_MPC);
+
     iotkit_forward_sec_resp_cfg(s);
 
     system_clock_scale = NANOSECONDS_PER_SECOND / s->mainclk_frq;
-- 
2.17.1
