Received: from eggs.gnu.org ([2001:4830:134:3::10]:43464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWg-00030Q-P0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWe-0004vF-GH
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWe-0004uL-4a
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:56 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWd-0001NJ-8F
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:55 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:21 +0000
Message-Id: <20180302110640.28004-21-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/39] hw/misc/iotkit-secctl: Add handling for
 PPCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The IoTKit Security Controller includes various registers
that expose to software the controls for the Peripheral
Protection Controllers in the system. Implement these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-17-peter.maydell@linaro.org
---
 include/hw/misc/iotkit-secctl.h |  64 +++++++++-
 hw/misc/iotkit-secctl.c         | 270 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 315 insertions(+), 19 deletions(-)

diff --git a/include/hw/misc/iotkit-secctl.h b/include/hw/misc/iotkit-secctl.h
index 872f652f8d..ea3d62967f 100644
--- a/include/hw/misc/iotkit-secctl.h
+++ b/include/hw/misc/iotkit-secctl.h
@@ -16,6 +16,28 @@
  * QEMU interface:
  *  + sysbus MMIO region 0 is the "secure privilege control block" registers
  *  + sysbus MMIO region 1 is the "non-secure privilege control block" registers
+ *  + named GPIO output "sec_resp_cfg" indicating whether blocked accesses
+ *    should RAZ/WI or bus error
+ * Controlling the 2 APB PPCs in the IoTKit:
+ *  + named GPIO outputs apb_ppc0_nonsec[0..2] and apb_ppc1_nonsec
+ *  + named GPIO outputs apb_ppc0_ap[0..2] and apb_ppc1_ap
+ *  + named GPIO outputs apb_ppc{0,1}_irq_enable
+ *  + named GPIO outputs apb_ppc{0,1}_irq_clear
+ *  + named GPIO inputs apb_ppc{0,1}_irq_status
+ * Controlling each of the 4 expansion APB PPCs which a system using the IoTKit
+ * might provide:
+ *  + named GPIO outputs apb_ppcexp{0,1,2,3}_nonsec[0..15]
+ *  + named GPIO outputs apb_ppcexp{0,1,2,3}_ap[0..15]
+ *  + named GPIO outputs apb_ppcexp{0,1,2,3}_irq_enable
+ *  + named GPIO outputs apb_ppcexp{0,1,2,3}_irq_clear
+ *  + named GPIO inputs apb_ppcexp{0,1,2,3}_irq_status
+ * Controlling each of the 4 expansion AHB PPCs which a system using the IoTKit
+ * might provide:
+ *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_nonsec[0..15]
+ *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_ap[0..15]
+ *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_enable
+ *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_clear
+ *  + named GPIO inputs ahb_ppcexp{0,1,2,3}_irq_status
  */
 
 #ifndef IOTKIT_SECCTL_H
@@ -26,14 +48,52 @@
 #define TYPE_IOTKIT_SECCTL "iotkit-secctl"
 #define IOTKIT_SECCTL(obj) OBJECT_CHECK(IoTKitSecCtl, (obj), TYPE_IOTKIT_SECCTL)
 
-typedef struct IoTKitSecCtl {
+#define IOTS_APB_PPC0_NUM_PORTS 3
+#define IOTS_APB_PPC1_NUM_PORTS 1
+#define IOTS_PPC_NUM_PORTS 16
+#define IOTS_NUM_APB_PPC 2
+#define IOTS_NUM_APB_EXP_PPC 4
+#define IOTS_NUM_AHB_EXP_PPC 4
+
+typedef struct IoTKitSecCtl IoTKitSecCtl;
+
+/* State and IRQ lines relating to a PPC. For the
+ * PPCs in the IoTKit not all the IRQ lines are used.
+ */
+typedef struct IoTKitSecCtlPPC {
+    qemu_irq nonsec[IOTS_PPC_NUM_PORTS];
+    qemu_irq ap[IOTS_PPC_NUM_PORTS];
+    qemu_irq irq_enable;
+    qemu_irq irq_clear;
+
+    uint32_t ns;
+    uint32_t sp;
+    uint32_t nsp;
+
+    /* Number of ports actually present */
+    int numports;
+    /* Offset of this PPC's interrupt bits in SECPPCINTSTAT */
+    int irq_bit_offset;
+    IoTKitSecCtl *parent;
+} IoTKitSecCtlPPC;
+
+struct IoTKitSecCtl {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
+    qemu_irq sec_resp_cfg;
 
     MemoryRegion s_regs;
     MemoryRegion ns_regs;
-} IoTKitSecCtl;
+
+    uint32_t secppcintstat;
+    uint32_t secppcinten;
+    uint32_t secrespcfg;
+
+    IoTKitSecCtlPPC apb[IOTS_NUM_APB_PPC];
+    IoTKitSecCtlPPC apbexp[IOTS_NUM_APB_EXP_PPC];
+    IoTKitSecCtlPPC ahbexp[IOTS_NUM_APB_EXP_PPC];
+};
 
 #endif
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index d106de95d7..1093f2910f 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -92,12 +92,41 @@ static const uint8_t iotkit_secctl_ns_idregs[] = {
     0x0d, 0xf0, 0x05, 0xb1,
 };
 
+/* The register sets for the various PPCs (AHB internal, APB internal,
+ * AHB expansion, APB expansion) are all set up so that they are
+ * in 16-aligned blocks so offsets 0xN0, 0xN4, 0xN8, 0xNC are PPCs
+ * 0, 1, 2, 3 of that type, so we can convert a register address offset
+ * into an an index into a PPC array easily.
+ */
+static inline int offset_to_ppc_idx(uint32_t offset)
+{
+    return extract32(offset, 2, 2);
+}
+
+typedef void PerPPCFunction(IoTKitSecCtlPPC *ppc);
+
+static void foreach_ppc(IoTKitSecCtl *s, PerPPCFunction *fn)
+{
+    int i;
+
+    for (i = 0; i < IOTS_NUM_APB_PPC; i++) {
+        fn(&s->apb[i]);
+    }
+    for (i = 0; i < IOTS_NUM_APB_EXP_PPC; i++) {
+        fn(&s->apbexp[i]);
+    }
+    for (i = 0; i < IOTS_NUM_AHB_EXP_PPC; i++) {
+        fn(&s->ahbexp[i]);
+    }
+}
+
 static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
                                         uint64_t *pdata,
                                         unsigned size, MemTxAttrs attrs)
 {
     uint64_t r;
     uint32_t offset = addr & ~0x3;
+    IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
 
     switch (offset) {
     case A_AHBNSPPC0:
@@ -105,34 +134,52 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
         r = 0;
         break;
     case A_SECRESPCFG:
-    case A_NSCCFG:
-    case A_SECMPCINTSTATUS:
+        r = s->secrespcfg;
+        break;
     case A_SECPPCINTSTAT:
+        r = s->secppcintstat;
+        break;
     case A_SECPPCINTEN:
-    case A_SECMSCINTSTAT:
-    case A_SECMSCINTEN:
-    case A_BRGINTSTAT:
-    case A_BRGINTEN:
+        r = s->secppcinten;
+        break;
     case A_AHBNSPPCEXP0:
     case A_AHBNSPPCEXP1:
     case A_AHBNSPPCEXP2:
     case A_AHBNSPPCEXP3:
+        r = s->ahbexp[offset_to_ppc_idx(offset)].ns;
+        break;
     case A_APBNSPPC0:
     case A_APBNSPPC1:
+        r = s->apb[offset_to_ppc_idx(offset)].ns;
+        break;
     case A_APBNSPPCEXP0:
     case A_APBNSPPCEXP1:
     case A_APBNSPPCEXP2:
     case A_APBNSPPCEXP3:
+        r = s->apbexp[offset_to_ppc_idx(offset)].ns;
+        break;
     case A_AHBSPPPCEXP0:
     case A_AHBSPPPCEXP1:
     case A_AHBSPPPCEXP2:
     case A_AHBSPPPCEXP3:
+        r = s->apbexp[offset_to_ppc_idx(offset)].sp;
+        break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
+        r = s->apb[offset_to_ppc_idx(offset)].sp;
+        break;
     case A_APBSPPPCEXP0:
     case A_APBSPPPCEXP1:
     case A_APBSPPPCEXP2:
     case A_APBSPPPCEXP3:
+        r = s->apbexp[offset_to_ppc_idx(offset)].sp;
+        break;
+    case A_NSCCFG:
+    case A_SECMPCINTSTATUS:
+    case A_SECMSCINTSTAT:
+    case A_SECMSCINTEN:
+    case A_BRGINTSTAT:
+    case A_BRGINTEN:
     case A_NSMSCEXP:
         qemu_log_mask(LOG_UNIMP,
                       "IoTKit SecCtl S block read: "
@@ -180,11 +227,66 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     return MEMTX_OK;
 }
 
+static void iotkit_secctl_update_ppc_ap(IoTKitSecCtlPPC *ppc)
+{
+    int i;
+
+    for (i = 0; i < ppc->numports; i++) {
+        bool v;
+
+        if (extract32(ppc->ns, i, 1)) {
+            v = extract32(ppc->nsp, i, 1);
+        } else {
+            v = extract32(ppc->sp, i, 1);
+        }
+        qemu_set_irq(ppc->ap[i], v);
+    }
+}
+
+static void iotkit_secctl_ppc_ns_write(IoTKitSecCtlPPC *ppc, uint32_t value)
+{
+    int i;
+
+    ppc->ns = value & MAKE_64BIT_MASK(0, ppc->numports);
+    for (i = 0; i < ppc->numports; i++) {
+        qemu_set_irq(ppc->nonsec[i], extract32(ppc->ns, i, 1));
+    }
+    iotkit_secctl_update_ppc_ap(ppc);
+}
+
+static void iotkit_secctl_ppc_sp_write(IoTKitSecCtlPPC *ppc, uint32_t value)
+{
+    ppc->sp = value & MAKE_64BIT_MASK(0, ppc->numports);
+    iotkit_secctl_update_ppc_ap(ppc);
+}
+
+static void iotkit_secctl_ppc_nsp_write(IoTKitSecCtlPPC *ppc, uint32_t value)
+{
+    ppc->nsp = value & MAKE_64BIT_MASK(0, ppc->numports);
+    iotkit_secctl_update_ppc_ap(ppc);
+}
+
+static void iotkit_secctl_ppc_update_irq_clear(IoTKitSecCtlPPC *ppc)
+{
+    uint32_t value = ppc->parent->secppcintstat;
+
+    qemu_set_irq(ppc->irq_clear, extract32(value, ppc->irq_bit_offset, 1));
+}
+
+static void iotkit_secctl_ppc_update_irq_enable(IoTKitSecCtlPPC *ppc)
+{
+    uint32_t value = ppc->parent->secppcinten;
+
+    qemu_set_irq(ppc->irq_enable, extract32(value, ppc->irq_bit_offset, 1));
+}
+
 static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
                                          uint64_t value,
                                          unsigned size, MemTxAttrs attrs)
 {
+    IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
     uint32_t offset = addr;
+    IoTKitSecCtlPPC *ppc;
 
     trace_iotkit_secctl_s_write(offset, value, size);
 
@@ -197,33 +299,61 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
 
     switch (offset) {
     case A_SECRESPCFG:
-    case A_NSCCFG:
+        value &= 1;
+        s->secrespcfg = value;
+        qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
+        break;
     case A_SECPPCINTCLR:
+        value &= 0x00f000f3;
+        foreach_ppc(s, iotkit_secctl_ppc_update_irq_clear);
+        break;
     case A_SECPPCINTEN:
-    case A_SECMSCINTCLR:
-    case A_SECMSCINTEN:
-    case A_BRGINTCLR:
-    case A_BRGINTEN:
+        s->secppcinten = value & 0x00f000f3;
+        foreach_ppc(s, iotkit_secctl_ppc_update_irq_enable);
+        break;
     case A_AHBNSPPCEXP0:
     case A_AHBNSPPCEXP1:
     case A_AHBNSPPCEXP2:
     case A_AHBNSPPCEXP3:
+        ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_ns_write(ppc, value);
+        break;
     case A_APBNSPPC0:
     case A_APBNSPPC1:
+        ppc = &s->apb[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_ns_write(ppc, value);
+        break;
     case A_APBNSPPCEXP0:
     case A_APBNSPPCEXP1:
     case A_APBNSPPCEXP2:
     case A_APBNSPPCEXP3:
+        ppc = &s->apbexp[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_ns_write(ppc, value);
+        break;
     case A_AHBSPPPCEXP0:
     case A_AHBSPPPCEXP1:
     case A_AHBSPPPCEXP2:
     case A_AHBSPPPCEXP3:
+        ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_sp_write(ppc, value);
+        break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
+        ppc = &s->apb[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_sp_write(ppc, value);
+        break;
     case A_APBSPPPCEXP0:
     case A_APBSPPPCEXP1:
     case A_APBSPPPCEXP2:
     case A_APBSPPPCEXP3:
+        ppc = &s->apbexp[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_sp_write(ppc, value);
+        break;
+    case A_NSCCFG:
+    case A_SECMSCINTCLR:
+    case A_SECMSCINTEN:
+    case A_BRGINTCLR:
+    case A_BRGINTEN:
         qemu_log_mask(LOG_UNIMP,
                       "IoTKit SecCtl S block write: "
                       "unimplemented offset 0x%x\n", offset);
@@ -265,6 +395,7 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
                                          uint64_t *pdata,
                                          unsigned size, MemTxAttrs attrs)
 {
+    IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
     uint64_t r;
     uint32_t offset = addr & ~0x3;
 
@@ -276,15 +407,17 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
     case A_AHBNSPPPCEXP1:
     case A_AHBNSPPPCEXP2:
     case A_AHBNSPPPCEXP3:
+        r = s->ahbexp[offset_to_ppc_idx(offset)].nsp;
+        break;
     case A_APBNSPPPC0:
     case A_APBNSPPPC1:
+        r = s->apb[offset_to_ppc_idx(offset)].nsp;
+        break;
     case A_APBNSPPPCEXP0:
     case A_APBNSPPPCEXP1:
     case A_APBNSPPPCEXP2:
     case A_APBNSPPPCEXP3:
-        qemu_log_mask(LOG_UNIMP,
-                      "IoTKit SecCtl NS block read: "
-                      "unimplemented offset 0x%x\n", offset);
+        r = s->apbexp[offset_to_ppc_idx(offset)].nsp;
         break;
     case A_PID4:
     case A_PID5:
@@ -324,7 +457,9 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
                                           uint64_t value,
                                           unsigned size, MemTxAttrs attrs)
 {
+    IoTKitSecCtl *s = IOTKIT_SECCTL(opaque);
     uint32_t offset = addr;
+    IoTKitSecCtlPPC *ppc;
 
     trace_iotkit_secctl_ns_write(offset, value, size);
 
@@ -340,15 +475,20 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
     case A_AHBNSPPPCEXP1:
     case A_AHBNSPPPCEXP2:
     case A_AHBNSPPPCEXP3:
+        ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_nsp_write(ppc, value);
+        break;
     case A_APBNSPPPC0:
     case A_APBNSPPPC1:
+        ppc = &s->apb[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_nsp_write(ppc, value);
+        break;
     case A_APBNSPPPCEXP0:
     case A_APBNSPPPCEXP1:
     case A_APBNSPPPCEXP2:
     case A_APBNSPPPCEXP3:
-        qemu_log_mask(LOG_UNIMP,
-                      "IoTKit SecCtl NS block write: "
-                      "unimplemented offset 0x%x\n", offset);
+        ppc = &s->apbexp[offset_to_ppc_idx(offset)];
+        iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
     case A_AHBNSPPPC0:
     case A_PID4:
@@ -397,15 +537,90 @@ static const MemoryRegionOps iotkit_secctl_ns_ops = {
     .impl.max_access_size = 4,
 };
 
+static void iotkit_secctl_reset_ppc(IoTKitSecCtlPPC *ppc)
+{
+    ppc->ns = 0;
+    ppc->sp = 0;
+    ppc->nsp = 0;
+}
+
 static void iotkit_secctl_reset(DeviceState *dev)
 {
+    IoTKitSecCtl *s = IOTKIT_SECCTL(dev);
 
+    s->secppcintstat = 0;
+    s->secppcinten = 0;
+    s->secrespcfg = 0;
+
+    foreach_ppc(s, iotkit_secctl_reset_ppc);
+}
+
+static void iotkit_secctl_ppc_irqstatus(void *opaque, int n, int level)
+{
+    IoTKitSecCtlPPC *ppc = opaque;
+    IoTKitSecCtl *s = IOTKIT_SECCTL(ppc->parent);
+    int irqbit = ppc->irq_bit_offset + n;
+
+    s->secppcintstat = deposit32(s->secppcintstat, irqbit, 1, level);
+}
+
+static void iotkit_secctl_init_ppc(IoTKitSecCtl *s,
+                                   IoTKitSecCtlPPC *ppc,
+                                   const char *name,
+                                   int numports,
+                                   int irq_bit_offset)
+{
+    char *gpioname;
+    DeviceState *dev = DEVICE(s);
+
+    ppc->numports = numports;
+    ppc->irq_bit_offset = irq_bit_offset;
+    ppc->parent = s;
+
+    gpioname = g_strdup_printf("%s_nonsec", name);
+    qdev_init_gpio_out_named(dev, ppc->nonsec, gpioname, numports);
+    g_free(gpioname);
+    gpioname = g_strdup_printf("%s_ap", name);
+    qdev_init_gpio_out_named(dev, ppc->ap, gpioname, numports);
+    g_free(gpioname);
+    gpioname = g_strdup_printf("%s_irq_enable", name);
+    qdev_init_gpio_out_named(dev, &ppc->irq_enable, gpioname, 1);
+    g_free(gpioname);
+    gpioname = g_strdup_printf("%s_irq_clear", name);
+    qdev_init_gpio_out_named(dev, &ppc->irq_clear, gpioname, 1);
+    g_free(gpioname);
+    gpioname = g_strdup_printf("%s_irq_status", name);
+    qdev_init_gpio_in_named_with_opaque(dev, iotkit_secctl_ppc_irqstatus,
+                                        ppc, gpioname, 1);
+    g_free(gpioname);
 }
 
 static void iotkit_secctl_init(Object *obj)
 {
     IoTKitSecCtl *s = IOTKIT_SECCTL(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    DeviceState *dev = DEVICE(obj);
+    int i;
+
+    iotkit_secctl_init_ppc(s, &s->apb[0], "apb_ppc0",
+                           IOTS_APB_PPC0_NUM_PORTS, 0);
+    iotkit_secctl_init_ppc(s, &s->apb[1], "apb_ppc1",
+                           IOTS_APB_PPC1_NUM_PORTS, 1);
+
+    for (i = 0; i < IOTS_NUM_APB_EXP_PPC; i++) {
+        IoTKitSecCtlPPC *ppc = &s->apbexp[i];
+        char *ppcname = g_strdup_printf("apb_ppcexp%d", i);
+        iotkit_secctl_init_ppc(s, ppc, ppcname, IOTS_PPC_NUM_PORTS, 4 + i);
+        g_free(ppcname);
+    }
+    for (i = 0; i < IOTS_NUM_AHB_EXP_PPC; i++) {
+        IoTKitSecCtlPPC *ppc = &s->ahbexp[i];
+        char *ppcname = g_strdup_printf("ahb_ppcexp%d", i);
+        iotkit_secctl_init_ppc(s, ppc, ppcname, IOTS_PPC_NUM_PORTS, 20 + i);
+        g_free(ppcname);
+    }
+
+    qdev_init_gpio_out_named(dev, &s->sec_resp_cfg, "sec_resp_cfg", 1);
 
     memory_region_init_io(&s->s_regs, obj, &iotkit_secctl_s_ops,
                           s, "iotkit-secctl-s-regs", 0x1000);
@@ -415,11 +630,32 @@ static void iotkit_secctl_init(Object *obj)
     sysbus_init_mmio(sbd, &s->ns_regs);
 }
 
+static const VMStateDescription iotkit_secctl_ppc_vmstate = {
+    .name = "iotkit-secctl-ppc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ns, IoTKitSecCtlPPC),
+        VMSTATE_UINT32(sp, IoTKitSecCtlPPC),
+        VMSTATE_UINT32(nsp, IoTKitSecCtlPPC),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription iotkit_secctl_vmstate = {
     .name = "iotkit-secctl",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
+        VMSTATE_UINT32(secppcintstat, IoTKitSecCtl),
+        VMSTATE_UINT32(secppcinten, IoTKitSecCtl),
+        VMSTATE_UINT32(secrespcfg, IoTKitSecCtl),
+        VMSTATE_STRUCT_ARRAY(apb, IoTKitSecCtl, IOTS_NUM_APB_PPC, 1,
+                             iotkit_secctl_ppc_vmstate, IoTKitSecCtlPPC),
+        VMSTATE_STRUCT_ARRAY(apbexp, IoTKitSecCtl, IOTS_NUM_APB_EXP_PPC, 1,
+                             iotkit_secctl_ppc_vmstate, IoTKitSecCtlPPC),
+        VMSTATE_STRUCT_ARRAY(ahbexp, IoTKitSecCtl, IOTS_NUM_AHB_EXP_PPC, 1,
+                             iotkit_secctl_ppc_vmstate, IoTKitSecCtlPPC),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.16.2
