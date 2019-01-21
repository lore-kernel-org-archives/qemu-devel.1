Received: from eggs.gnu.org ([209.51.188.92]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevU-0008OH-10
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefe-0002sL-M6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:44 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefe-0002d3-Eo
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:42 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so24571077wrx.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:03 +0000
Message-Id: <20190121185118.18550-9-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/23] hw/misc/iotkit-secctl: Support 4
 internal MPCs
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

The SSE-200 has 4 banks of SRAM, each with its own internal
Memory Protection Controller. The interrupt status for these
extra MPCs appears in the same security controller SECMPCINTSTATUS
register as the MPC for the IoTKit's single SRAM bank. Enhance the
iotkit-secctl device to allow 4 MPCs. (If the particular IoTKit/SSE
variant in use does not have all 4 MPCs then the unused inputs will
simply result in the SECMPCINTSTATUS bits being zero as required.)

The hardcoded constant "1"s in armsse.c indicate the actual number
of SRAM MPCs the IoTKit has, and will be replaced in the following
commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/iotkit-secctl.h | 6 +++---
 hw/arm/armsse.c                 | 6 +++---
 hw/misc/iotkit-secctl.c         | 5 +++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/misc/iotkit-secctl.h b/include/hw/misc/iotkit-secctl.h
index 1a193b306f1..bcb0437be5b 100644
--- a/include/hw/misc/iotkit-secctl.h
+++ b/include/hw/misc/iotkit-secctl.h
@@ -40,8 +40,8 @@
  *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_enable
  *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_clear
  *  + named GPIO inputs ahb_ppcexp{0,1,2,3}_irq_status
- * Controlling the MPC in the IoTKit:
- *  + named GPIO input mpc_status
+ * Controlling the (up to) 4 MPCs in the IoTKit/SSE:
+ *  + named GPIO inputs mpc_status[0..3]
  * Controlling each of the 16 expansion MPCs which a system using the IoTKit
  * might provide:
  *  + named GPIO inputs mpcexp_status[0..15]
@@ -67,7 +67,7 @@
 #define IOTS_NUM_APB_EXP_PPC 4
 #define IOTS_NUM_AHB_EXP_PPC 4
 #define IOTS_NUM_EXP_MPC 16
-#define IOTS_NUM_MPC 1
+#define IOTS_NUM_MPC 4
 #define IOTS_NUM_EXP_MSC 16
 
 typedef struct IoTKitSecCtl IoTKitSecCtl;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 8554be14128..074c1d3a6cf 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -138,7 +138,7 @@ static void armsse_init(Object *obj)
                             sizeof(s->mpc_irq_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
 
-    for (i = 0; i < ARRAY_SIZE(s->mpc_irq_splitter); i++) {
+    for (i = 0; i < IOTS_NUM_EXP_MPC + 1; i++) {
         char *name = g_strdup_printf("mpc-irq-splitter-%d", i);
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
 
@@ -363,7 +363,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
     /* We must OR together lines from the MPC splitters to go to the NVIC */
     object_property_set_int(OBJECT(&s->mpc_irq_orgate),
-                            IOTS_NUM_EXP_MPC + IOTS_NUM_MPC, "num-lines", &err);
+                            IOTS_NUM_EXP_MPC + 1, "num-lines", &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -636,7 +636,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* Wire up the splitters for the MPC IRQs */
-    for (i = 0; i < IOTS_NUM_EXP_MPC + IOTS_NUM_MPC; i++) {
+    for (i = 0; i < IOTS_NUM_EXP_MPC + 1; i++) {
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
         DeviceState *dev_splitter = DEVICE(splitter);
 
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 2222b3e147d..537601cd53f 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -600,7 +600,7 @@ static void iotkit_secctl_mpc_status(void *opaque, int n, int level)
 {
     IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
 
-    s->mpcintstatus = deposit32(s->mpcintstatus, 0, 1, !!level);
+    s->mpcintstatus = deposit32(s->mpcintstatus, n, 1, !!level);
 }
 
 static void iotkit_secctl_mpcexp_status(void *opaque, int n, int level)
@@ -686,7 +686,8 @@ static void iotkit_secctl_init(Object *obj)
     qdev_init_gpio_out_named(dev, &s->sec_resp_cfg, "sec_resp_cfg", 1);
     qdev_init_gpio_out_named(dev, &s->nsc_cfg_irq, "nsc_cfg", 1);
 
-    qdev_init_gpio_in_named(dev, iotkit_secctl_mpc_status, "mpc_status", 1);
+    qdev_init_gpio_in_named(dev, iotkit_secctl_mpc_status, "mpc_status",
+                            IOTS_NUM_MPC);
     qdev_init_gpio_in_named(dev, iotkit_secctl_mpcexp_status,
                             "mpcexp_status", IOTS_NUM_EXP_MPC);
 
-- 
2.20.1
