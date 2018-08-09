Received: from eggs.gnu.org ([2001:4830:134:3::10]:47364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZX-00063T-Ri
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZR-0003Ps-P6
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  9 Aug 2018 14:01:07 +0100
Message-Id: <20180809130115.28951-9-peter.maydell@linaro.org>
In-Reply-To: <20180809130115.28951-1-peter.maydell@linaro.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/16] hw/misc/iotkit-secctl: Wire up registers
 for controlling MSCs
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

The IoTKit does not have any Master Security Contollers itself,
but it does provide registers in the secure privilege control
block which allow control of MSCs in the external system.
Add support for these registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/iotkit-secctl.h | 14 +++++++
 hw/misc/iotkit-secctl.c         | 73 +++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/include/hw/misc/iotkit-secctl.h b/include/hw/misc/iotkit-secctl.h
index 082c14c925e..1a193b306f1 100644
--- a/include/hw/misc/iotkit-secctl.h
+++ b/include/hw/misc/iotkit-secctl.h
@@ -19,6 +19,7 @@
  *  + named GPIO output "sec_resp_cfg" indicating whether blocked accesses
  *    should RAZ/WI or bus error
  *  + named GPIO output "nsc_cfg" whose value tracks the NSCCFG register value
+ *  + named GPIO output "msc_irq" for the combined IRQ line from the MSCs
  * Controlling the 2 APB PPCs in the IoTKit:
  *  + named GPIO outputs apb_ppc0_nonsec[0..2] and apb_ppc1_nonsec
  *  + named GPIO outputs apb_ppc0_ap[0..2] and apb_ppc1_ap
@@ -44,6 +45,11 @@
  * Controlling each of the 16 expansion MPCs which a system using the IoTKit
  * might provide:
  *  + named GPIO inputs mpcexp_status[0..15]
+ * Controlling each of the 16 expansion MSCs which a system using the IoTKit
+ * might provide:
+ *  + named GPIO inputs mscexp_status[0..15]
+ *  + named GPIO outputs mscexp_clear[0..15]
+ *  + named GPIO outputs mscexp_ns[0..15]
  */
 
 #ifndef IOTKIT_SECCTL_H
@@ -62,6 +68,7 @@
 #define IOTS_NUM_AHB_EXP_PPC 4
 #define IOTS_NUM_EXP_MPC 16
 #define IOTS_NUM_MPC 1
+#define IOTS_NUM_EXP_MSC 16
 
 typedef struct IoTKitSecCtl IoTKitSecCtl;
 
@@ -103,6 +110,13 @@ struct IoTKitSecCtl {
     uint32_t brginten;
     uint32_t mpcintstatus;
 
+    uint32_t secmscintstat;
+    uint32_t secmscinten;
+    uint32_t nsmscexp;
+    qemu_irq mscexp_clear[IOTS_NUM_EXP_MSC];
+    qemu_irq mscexp_ns[IOTS_NUM_EXP_MSC];
+    qemu_irq msc_irq;
+
     IoTKitSecCtlPPC apb[IOTS_NUM_APB_PPC];
     IoTKitSecCtlPPC apbexp[IOTS_NUM_APB_EXP_PPC];
     IoTKitSecCtlPPC ahbexp[IOTS_NUM_APB_EXP_PPC];
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index de4fd8e36d2..2222b3e147d 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -190,12 +190,13 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
         r = s->apbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_SECMSCINTSTAT:
+        r = s->secmscintstat;
+        break;
     case A_SECMSCINTEN:
+        r = s->secmscinten;
+        break;
     case A_NSMSCEXP:
-        qemu_log_mask(LOG_UNIMP,
-                      "IoTKit SecCtl S block read: "
-                      "unimplemented offset 0x%x\n", offset);
-        r = 0;
+        r = s->nsmscexp;
         break;
     case A_PID4:
     case A_PID5:
@@ -291,6 +292,23 @@ static void iotkit_secctl_ppc_update_irq_enable(IoTKitSecCtlPPC *ppc)
     qemu_set_irq(ppc->irq_enable, extract32(value, ppc->irq_bit_offset, 1));
 }
 
+static void iotkit_secctl_update_mscexp_irqs(qemu_irq *msc_irqs, uint32_t value)
+{
+    int i;
+
+    for (i = 0; i < IOTS_NUM_EXP_MSC; i++) {
+        qemu_set_irq(msc_irqs[i], extract32(value, i + 16, 1));
+    }
+}
+
+static void iotkit_secctl_update_msc_irq(IoTKitSecCtl *s)
+{
+    /* Update the combined MSC IRQ, based on S_MSCEXP_STATUS and S_MSCEXP_EN */
+    bool level = s->secmscintstat & s->secmscinten;
+
+    qemu_set_irq(s->msc_irq, level);
+}
+
 static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
                                          uint64_t value,
                                          unsigned size, MemTxAttrs attrs)
@@ -370,10 +388,15 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
     case A_SECMSCINTCLR:
+        iotkit_secctl_update_mscexp_irqs(s->mscexp_clear, value);
+        break;
     case A_SECMSCINTEN:
-        qemu_log_mask(LOG_UNIMP,
-                      "IoTKit SecCtl S block write: "
-                      "unimplemented offset 0x%x\n", offset);
+        s->secmscinten = value;
+        iotkit_secctl_update_msc_irq(s);
+        break;
+    case A_NSMSCEXP:
+        s->nsmscexp = value;
+        iotkit_secctl_update_mscexp_irqs(s->mscexp_ns, value);
         break;
     case A_SECMPCINTSTATUS:
     case A_SECPPCINTSTAT:
@@ -381,7 +404,6 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     case A_BRGINTSTAT:
     case A_AHBNSPPC0:
     case A_AHBSPPPC0:
-    case A_NSMSCEXP:
     case A_PID4:
     case A_PID5:
     case A_PID6:
@@ -588,6 +610,14 @@ static void iotkit_secctl_mpcexp_status(void *opaque, int n, int level)
     s->mpcintstatus = deposit32(s->mpcintstatus, n + 16, 1, !!level);
 }
 
+static void iotkit_secctl_mscexp_status(void *opaque, int n, int level)
+{
+    IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
+
+    s->secmscintstat = deposit32(s->secmscintstat, n + 16, 1, !!level);
+    iotkit_secctl_update_msc_irq(s);
+}
+
 static void iotkit_secctl_ppc_irqstatus(void *opaque, int n, int level)
 {
     IoTKitSecCtlPPC *ppc = opaque;
@@ -660,6 +690,14 @@ static void iotkit_secctl_init(Object *obj)
     qdev_init_gpio_in_named(dev, iotkit_secctl_mpcexp_status,
                             "mpcexp_status", IOTS_NUM_EXP_MPC);
 
+    qdev_init_gpio_in_named(dev, iotkit_secctl_mscexp_status,
+                            "mscexp_status", IOTS_NUM_EXP_MSC);
+    qdev_init_gpio_out_named(dev, s->mscexp_clear, "mscexp_clear",
+                             IOTS_NUM_EXP_MSC);
+    qdev_init_gpio_out_named(dev, s->mscexp_ns, "mscexp_ns",
+                             IOTS_NUM_EXP_MSC);
+    qdev_init_gpio_out_named(dev, &s->msc_irq, "msc_irq", 1);
+
     memory_region_init_io(&s->s_regs, obj, &iotkit_secctl_s_ops,
                           s, "iotkit-secctl-s-regs", 0x1000);
     memory_region_init_io(&s->ns_regs, obj, &iotkit_secctl_ns_ops,
@@ -690,6 +728,24 @@ static const VMStateDescription iotkit_secctl_mpcintstatus_vmstate = {
     }
 };
 
+static bool needed_always(void *opaque)
+{
+    return true;
+}
+
+static const VMStateDescription iotkit_secctl_msc_vmstate = {
+    .name = "iotkit-secctl/msc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = needed_always,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(secmscintstat, IoTKitSecCtl),
+        VMSTATE_UINT32(secmscinten, IoTKitSecCtl),
+        VMSTATE_UINT32(nsmscexp, IoTKitSecCtl),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription iotkit_secctl_vmstate = {
     .name = "iotkit-secctl",
     .version_id = 1,
@@ -710,6 +766,7 @@ static const VMStateDescription iotkit_secctl_vmstate = {
     },
     .subsections = (const VMStateDescription*[]) {
         &iotkit_secctl_mpcintstatus_vmstate,
+        &iotkit_secctl_msc_vmstate,
         NULL
     },
 };
-- 
2.17.1
