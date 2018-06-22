Received: from eggs.gnu.org ([2001:4830:134:3::10]:50012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd5-0003WH-8U
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd4-0005NK-Az
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd4-0005Ms-3Y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd3-0003ym-36
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:57:06 +0100
Message-Id: <20180622125713.15303-22-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/28] hw/misc/iotkit-secctl.c: Implement
 SECMPCINTSTATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the SECMPCINTSTATUS register. This is the only register
in the security controller that deals with Memory Protection
Controllers, and it simply provides a read-only view of the
interrupt lines from the various MPCs in the system.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180620132032.28865-6-peter.maydell@linaro.org
---
 include/hw/misc/iotkit-secctl.h |  8 +++++++
 hw/misc/iotkit-secctl.c         | 38 +++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/iotkit-secctl.h b/include/hw/misc/iotkit-secctl.h
index faad0c91901..082c14c925e 100644
--- a/include/hw/misc/iotkit-secctl.h
+++ b/include/hw/misc/iotkit-secctl.h
@@ -39,6 +39,11 @@
  *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_enable
  *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_clear
  *  + named GPIO inputs ahb_ppcexp{0,1,2,3}_irq_status
+ * Controlling the MPC in the IoTKit:
+ *  + named GPIO input mpc_status
+ * Controlling each of the 16 expansion MPCs which a system using the IoTKit
+ * might provide:
+ *  + named GPIO inputs mpcexp_status[0..15]
  */
 
 #ifndef IOTKIT_SECCTL_H
@@ -55,6 +60,8 @@
 #define IOTS_NUM_APB_PPC 2
 #define IOTS_NUM_APB_EXP_PPC 4
 #define IOTS_NUM_AHB_EXP_PPC 4
+#define IOTS_NUM_EXP_MPC 16
+#define IOTS_NUM_MPC 1
 
 typedef struct IoTKitSecCtl IoTKitSecCtl;
 
@@ -94,6 +101,7 @@ struct IoTKitSecCtl {
     uint32_t secrespcfg;
     uint32_t nsccfg;
     uint32_t brginten;
+    uint32_t mpcintstatus;
 
     IoTKitSecCtlPPC apb[IOTS_NUM_APB_PPC];
     IoTKitSecCtlPPC apbexp[IOTS_NUM_APB_EXP_PPC];
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index ddd1584d341..de4fd8e36d2 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -139,6 +139,9 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_NSCCFG:
         r = s->nsccfg;
         break;
+    case A_SECMPCINTSTATUS:
+        r = s->mpcintstatus;
+        break;
     case A_SECPPCINTSTAT:
         r = s->secppcintstat;
         break;
@@ -186,7 +189,6 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_APBSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].sp;
         break;
-    case A_SECMPCINTSTATUS:
     case A_SECMSCINTSTAT:
     case A_SECMSCINTEN:
     case A_NSMSCEXP:
@@ -572,6 +574,20 @@ static void iotkit_secctl_reset(DeviceState *dev)
     foreach_ppc(s, iotkit_secctl_reset_ppc);
 }
 
+static void iotkit_secctl_mpc_status(void *opaque, int n, int level)
+{
+    IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
+
+    s->mpcintstatus = deposit32(s->mpcintstatus, 0, 1, !!level);
+}
+
+static void iotkit_secctl_mpcexp_status(void *opaque, int n, int level)
+{
+    IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
+
+    s->mpcintstatus = deposit32(s->mpcintstatus, n + 16, 1, !!level);
+}
+
 static void iotkit_secctl_ppc_irqstatus(void *opaque, int n, int level)
 {
     IoTKitSecCtlPPC *ppc = opaque;
@@ -640,6 +656,10 @@ static void iotkit_secctl_init(Object *obj)
     qdev_init_gpio_out_named(dev, &s->sec_resp_cfg, "sec_resp_cfg", 1);
     qdev_init_gpio_out_named(dev, &s->nsc_cfg_irq, "nsc_cfg", 1);
 
+    qdev_init_gpio_in_named(dev, iotkit_secctl_mpc_status, "mpc_status", 1);
+    qdev_init_gpio_in_named(dev, iotkit_secctl_mpcexp_status,
+                            "mpcexp_status", IOTS_NUM_EXP_MPC);
+
     memory_region_init_io(&s->s_regs, obj, &iotkit_secctl_s_ops,
                           s, "iotkit-secctl-s-regs", 0x1000);
     memory_region_init_io(&s->ns_regs, obj, &iotkit_secctl_ns_ops,
@@ -660,6 +680,16 @@ static const VMStateDescription iotkit_secctl_ppc_vmstate = {
     }
 };
 
+static const VMStateDescription iotkit_secctl_mpcintstatus_vmstate = {
+    .name = "iotkit-secctl-mpcintstatus",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(mpcintstatus, IoTKitSecCtl),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription iotkit_secctl_vmstate = {
     .name = "iotkit-secctl",
     .version_id = 1,
@@ -677,7 +707,11 @@ static const VMStateDescription iotkit_secctl_vmstate = {
         VMSTATE_STRUCT_ARRAY(ahbexp, IoTKitSecCtl, IOTS_NUM_AHB_EXP_PPC, 1,
                              iotkit_secctl_ppc_vmstate, IoTKitSecCtlPPC),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &iotkit_secctl_mpcintstatus_vmstate,
+        NULL
+    },
 };
 
 static void iotkit_secctl_class_init(ObjectClass *klass, void *data)
-- 
2.17.1
