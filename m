Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWg-0002zs-Av
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWf-0004vo-7N
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWe-0004v9-W4
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWe-0001Na-12
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:56 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:22 +0000
Message-Id: <20180302110640.28004-22-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/39] hw/misc/iotkit-secctl: Add remaining
 simple registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add remaining easy registers to iotkit-secctl:
 * NSCCFG just routes its two bits out to external GPIO lines
 * BRGINSTAT/BRGINTCLR/BRGINTEN can be dummies, because QEMU's
   bus fabric can never report errors

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180220180325.29818-18-peter.maydell@linaro.org
---
 include/hw/misc/iotkit-secctl.h |  4 ++++
 hw/misc/iotkit-secctl.c         | 32 ++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/iotkit-secctl.h b/include/hw/misc/iotkit-secctl.h
index ea3d62967f..faad0c9190 100644
--- a/include/hw/misc/iotkit-secctl.h
+++ b/include/hw/misc/iotkit-secctl.h
@@ -18,6 +18,7 @@
  *  + sysbus MMIO region 1 is the "non-secure privilege control block" registers
  *  + named GPIO output "sec_resp_cfg" indicating whether blocked accesses
  *    should RAZ/WI or bus error
+ *  + named GPIO output "nsc_cfg" whose value tracks the NSCCFG register value
  * Controlling the 2 APB PPCs in the IoTKit:
  *  + named GPIO outputs apb_ppc0_nonsec[0..2] and apb_ppc1_nonsec
  *  + named GPIO outputs apb_ppc0_ap[0..2] and apb_ppc1_ap
@@ -83,6 +84,7 @@ struct IoTKitSecCtl {
 
     /*< public >*/
     qemu_irq sec_resp_cfg;
+    qemu_irq nsc_cfg_irq;
 
     MemoryRegion s_regs;
     MemoryRegion ns_regs;
@@ -90,6 +92,8 @@ struct IoTKitSecCtl {
     uint32_t secppcintstat;
     uint32_t secppcinten;
     uint32_t secrespcfg;
+    uint32_t nsccfg;
+    uint32_t brginten;
 
     IoTKitSecCtlPPC apb[IOTS_NUM_APB_PPC];
     IoTKitSecCtlPPC apbexp[IOTS_NUM_APB_EXP_PPC];
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 1093f2910f..ddd1584d34 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -136,12 +136,24 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_SECRESPCFG:
         r = s->secrespcfg;
         break;
+    case A_NSCCFG:
+        r = s->nsccfg;
+        break;
     case A_SECPPCINTSTAT:
         r = s->secppcintstat;
         break;
     case A_SECPPCINTEN:
         r = s->secppcinten;
         break;
+    case A_BRGINTSTAT:
+        /* QEMU's bus fabric can never report errors as it doesn't buffer
+         * writes, so we never report bridge interrupts.
+         */
+        r = 0;
+        break;
+    case A_BRGINTEN:
+        r = s->brginten;
+        break;
     case A_AHBNSPPCEXP0:
     case A_AHBNSPPCEXP1:
     case A_AHBNSPPCEXP2:
@@ -174,12 +186,9 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_APBSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].sp;
         break;
-    case A_NSCCFG:
     case A_SECMPCINTSTATUS:
     case A_SECMSCINTSTAT:
     case A_SECMSCINTEN:
-    case A_BRGINTSTAT:
-    case A_BRGINTEN:
     case A_NSMSCEXP:
         qemu_log_mask(LOG_UNIMP,
                       "IoTKit SecCtl S block read: "
@@ -298,6 +307,10 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
+    case A_NSCCFG:
+        s->nsccfg = value & 3;
+        qemu_set_irq(s->nsc_cfg_irq, s->nsccfg);
+        break;
     case A_SECRESPCFG:
         value &= 1;
         s->secrespcfg = value;
@@ -311,6 +324,11 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         s->secppcinten = value & 0x00f000f3;
         foreach_ppc(s, iotkit_secctl_ppc_update_irq_enable);
         break;
+    case A_BRGINTCLR:
+        break;
+    case A_BRGINTEN:
+        s->brginten = value & 0xffff0000;
+        break;
     case A_AHBNSPPCEXP0:
     case A_AHBNSPPCEXP1:
     case A_AHBNSPPCEXP2:
@@ -349,11 +367,8 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
-    case A_NSCCFG:
     case A_SECMSCINTCLR:
     case A_SECMSCINTEN:
-    case A_BRGINTCLR:
-    case A_BRGINTEN:
         qemu_log_mask(LOG_UNIMP,
                       "IoTKit SecCtl S block write: "
                       "unimplemented offset 0x%x\n", offset);
@@ -551,6 +566,8 @@ static void iotkit_secctl_reset(DeviceState *dev)
     s->secppcintstat = 0;
     s->secppcinten = 0;
     s->secrespcfg = 0;
+    s->nsccfg = 0;
+    s->brginten = 0;
 
     foreach_ppc(s, iotkit_secctl_reset_ppc);
 }
@@ -621,6 +638,7 @@ static void iotkit_secctl_init(Object *obj)
     }
 
     qdev_init_gpio_out_named(dev, &s->sec_resp_cfg, "sec_resp_cfg", 1);
+    qdev_init_gpio_out_named(dev, &s->nsc_cfg_irq, "nsc_cfg", 1);
 
     memory_region_init_io(&s->s_regs, obj, &iotkit_secctl_s_ops,
                           s, "iotkit-secctl-s-regs", 0x1000);
@@ -650,6 +668,8 @@ static const VMStateDescription iotkit_secctl_vmstate = {
         VMSTATE_UINT32(secppcintstat, IoTKitSecCtl),
         VMSTATE_UINT32(secppcinten, IoTKitSecCtl),
         VMSTATE_UINT32(secrespcfg, IoTKitSecCtl),
+        VMSTATE_UINT32(nsccfg, IoTKitSecCtl),
+        VMSTATE_UINT32(brginten, IoTKitSecCtl),
         VMSTATE_STRUCT_ARRAY(apb, IoTKitSecCtl, IOTS_NUM_APB_PPC, 1,
                              iotkit_secctl_ppc_vmstate, IoTKitSecCtlPPC),
         VMSTATE_STRUCT_ARRAY(apbexp, IoTKitSecCtl, IOTS_NUM_APB_EXP_PPC, 1,
-- 
2.16.2
