Received: from eggs.gnu.org ([2001:4830:134:3::10]:54899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cJT8e-0004i8-2H
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 17:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cJT8a-00040Y-Mc
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 17:44:04 -0500
Received: from mail-co1nam03on0065.outbound.protection.outlook.com
	([104.47.40.65]:57952
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cJT8a-000405-CW
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 17:44:00 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 20 Dec 2016 14:42:04 -0800
Message-ID: <b9c61e0c893b6215531ea210e566c9057d28c792.1482265908.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1482265908.git.alistair.francis@xilinx.com>
References: <cover.1482265908.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/3] arm_generic_timer: Add support for the
 ReadBase memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, fred.konrad@greensocs.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Add support for the read only regions in the ReadBase memory map.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/timer/arm_generic_timer.c         | 27 +++++++++++++++++++++++++++
 include/hw/timer/arm_generic_timer.h | 12 ++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/hw/timer/arm_generic_timer.c b/hw/timer/arm_generic_timer.c
index da434a7..5392657 100644
--- a/hw/timer/arm_generic_timer.c
+++ b/hw/timer/arm_generic_timer.c
@@ -100,6 +100,17 @@ static RegisterAccessInfo arm_gen_timer_regs_info[] = {
     /* We don't model the CounterID registers either */
 };
 
+static RegisterAccessInfo arm_gen_timer_read_regs_info[] = {
+    {   .name = "CNTCV_READ_LOWER",
+        .addr = A_CNTCV_READ_LOWER, .ro = 0xFFFF,
+        .post_read = counter_low_value_postr,
+    },{ .name = "CNTCV_READ_UPPER",
+        .addr = A_CNTCV_READ_UPPER, .ro = 0xFFFF,
+        .post_read = counter_high_value_postr,
+    }
+    /* We don't model the CounterID registers */
+};
+
 static void arm_gen_timer_reset(DeviceState *dev)
 {
     ARMGenTimer *s = ARM_GEN_TIMER(dev);
@@ -166,6 +177,7 @@ static void arm_gen_timer_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     RegisterInfoArray *reg_array;
 
+    /* Create the ControlBase memory region */
     memory_region_init_io(&s->iomem, obj, &arm_gen_timer_ops, s,
                           TYPE_ARM_GEN_TIMER, R_ARM_GEN_TIMER_MAX * 4);
     reg_array =
@@ -179,6 +191,21 @@ static void arm_gen_timer_init(Object *obj)
                                 A_CNTCR,
                                 &reg_array->mem);
     sysbus_init_mmio(sbd, &s->iomem);
+
+    /* Create the ReadBase memory region */
+    memory_region_init_io(&s->iomem_read, obj, &arm_gen_timer_ops, s,
+                          TYPE_ARM_GEN_TIMER "-read", R_ARM_GEN_TIMER_READ_MAX * 4);
+    reg_array =
+        register_init_block32(DEVICE(obj), arm_gen_timer_read_regs_info,
+                              ARRAY_SIZE(arm_gen_timer_read_regs_info),
+                              s->regs_read_info, s->regs_read,
+                              &arm_gen_timer_ops,
+                              ARM_GEN_TIMER_ERR_DEBUG,
+                              R_ARM_GEN_TIMER_READ_MAX * 4);
+    memory_region_add_subregion(&s->iomem_read,
+                                R_CNTCV_READ_LOWER,
+                                &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->iomem_read);
 }
 
 static void arm_gen_timer_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/timer/arm_generic_timer.h b/include/hw/timer/arm_generic_timer.h
index ae4319c..462ee5b 100644
--- a/include/hw/timer/arm_generic_timer.h
+++ b/include/hw/timer/arm_generic_timer.h
@@ -33,6 +33,7 @@
 #define ARM_GEN_TIMER(obj) \
             OBJECT_CHECK(ARMGenTimer, (obj), TYPE_ARM_GEN_TIMER)
 
+/* ControlBase Memory Map */
 REG32(CNTCR, 0x00)
     FIELD(CNTCR, EN, 0, 1)
     FIELD(CNTCR, HDBG, 1, 1)
@@ -46,10 +47,18 @@ REG32(CNTFID0, 0x20)
 
 #define R_ARM_GEN_TIMER_MAX (R_CNTFID0 + 1)
 
+/* Read Base Memory Map */
+REG32(CNTCV_READ_LOWER, 0x00)
+REG32(CNTCV_READ_UPPER, 0x04)
+/* We don't model the CounterID registers */
+
+#define R_ARM_GEN_TIMER_READ_MAX (R_CNTCV_READ_UPPER + 1)
+
 typedef struct ARMGenTimer {
     /* <private> */
     SysBusDevice parent_obj;
     MemoryRegion iomem;
+    MemoryRegion iomem_read;
 
     /* <public> */
     bool enabled;
@@ -57,6 +66,9 @@ typedef struct ARMGenTimer {
 
     uint32_t regs[R_ARM_GEN_TIMER_MAX];
     RegisterInfo regs_info[R_ARM_GEN_TIMER_MAX];
+
+    uint32_t regs_read[R_ARM_GEN_TIMER_READ_MAX];
+    RegisterInfo regs_read_info[R_ARM_GEN_TIMER_READ_MAX];
 } ARMGenTimer;
 
 #endif
-- 
2.7.4
