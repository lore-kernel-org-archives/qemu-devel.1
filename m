Received: from eggs.gnu.org ([2001:4830:134:3::10]:56914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xv-00078c-Rv
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xr-0002vT-7f
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:55 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:06 -0600
Message-Id: <11edba0f74534a8013e6264f8a4f0cdf064a9ecd.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 08/17] e500: additional CCSR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Add CCSRBAR to allow CCSR region to be relocated.

Guest memory size introspection via RAM config
registers.

Dummy RAM error controls.

Clock introspection via Power on Reset PLL
Status Register.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

ccsrbase also update iack
---
 hw/ppc/e500.c      |  5 ++-
 hw/ppc/e500_ccsr.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b90f4231a6..e22919f4f1 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -51,7 +51,9 @@
 
 #define RAM_SIZES_ALIGN            (64UL << 20)
 
-/* TODO: parameterize */
+/* TODO: parameterize
+ * Some CCSR offsets duplicated in e500_ccsr.c
+ */
 #define MPC8544_CCSRBAR_SIZE       0x00100000ULL
 #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
 #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
@@ -856,6 +858,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
                               OBJECT(dev), NULL);
     qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
+    qdev_prop_set_uint32(dev, "ram-size", ram_size);
     qdev_init_nofail(dev);
     ccsr_addr_space = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
 
diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
index 1b586c3f42..9400d7cf13 100644
--- a/hw/ppc/e500_ccsr.c
+++ b/hw/ppc/e500_ccsr.c
@@ -30,13 +30,26 @@
 #include "hw/sysbus.h"
 
 /* E500_ denotes registers common to all */
+/* Some CCSR offsets duplicated in e500.c */
 
+#define E500_CCSRBAR     (0)
+
+#define E500_CS0_BNDS    (0x2000)
+
+#define E500_CS0_CONFIG  (0x2080)
+
+#define E500_ERR_DETECT  (0x2e40)
+#define E500_ERR_DISABLE (0x2e44)
+
+#define E500_PORPLLSR    (0xE0000)
 #define E500_PVR         (0xE00A0)
 #define E500_SVR         (0xE00A4)
 
 #define MPC8544_RSTCR       (0xE00B0)
 #define MPC8544_RSTCR_RESET      (0x02)
 
+#define E500_MPIC_OFFSET   (0x40000ULL)
+
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -44,19 +57,59 @@ typedef struct {
 
     MemoryRegion iomem;
 
-    uint32_t defbase;
+    uint32_t defbase, base;
+    uint32_t ram_size;
+    uint32_t merrd;
+
+    uint32_t porpllsr;
+
+    DeviceState *pic;
 } CCSRState;
 
 #define TYPE_E500_CCSR "e500-ccsr"
 #define E500_CCSR(obj) OBJECT_CHECK(CCSRState, (obj), TYPE_E500_CCSR)
 
+/* call after changing CCSRState::base */
+static void e500_ccsr_post_move(CCSRState *ccsr)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *env = &cpu->env;
+
+        env->mpic_iack = ccsr->base +
+                         E500_MPIC_OFFSET + 0xa0;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(ccsr), 0, ccsr->base);
+}
+
 static uint64_t e500_ccsr_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
+    CCSRState *ccsr = opaque;
     PowerPCCPU *cpu = POWERPC_CPU(current_cpu);
     CPUPPCState *env = &cpu->env;
 
     switch (addr) {
+    case E500_CCSRBAR:
+        return ccsr->base >> 12;
+    case E500_CS0_BNDS:
+        /* we model all RAM in a single chip with addresses [0, ram_size) */
+        return (ccsr->ram_size - 1) >> 24;
+    case E500_CS0_CONFIG:
+        return 1 << 31;
+    case E500_ERR_DETECT:
+        return 0; /* (errors not modeled) */
+    case E500_ERR_DISABLE:
+        return ccsr->merrd;
+    case E500_PORPLLSR:
+        if (!ccsr->porpllsr) {
+            qemu_log_mask(LOG_UNIMP,
+                          "Machine does not provide valid PORPLLSR\n");
+        }
+        return ccsr->porpllsr;
     case E500_PVR:
         return env->spr[SPR_PVR];
     case E500_SVR:
@@ -72,10 +125,22 @@ static uint64_t e500_ccsr_read(void *opaque, hwaddr addr,
 static void e500_ccsr_write(void *opaque, hwaddr addr,
                                uint64_t value, unsigned size)
 {
+    CCSRState *ccsr = opaque;
     PowerPCCPU *cpu = POWERPC_CPU(current_cpu);
     CPUPPCState *env = &cpu->env;
     uint32_t svr = env->spr[SPR_E500_SVR] >> 16;
 
+    switch (addr) {
+    case E500_CCSRBAR:
+        value &= 0x000fff00;
+        ccsr->base = value << 12;
+        e500_ccsr_post_move(ccsr);
+        return;
+    case E500_ERR_DISABLE:
+        ccsr->merrd = value & 0xd;
+        return;
+    }
+
     switch (svr) {
     case 0: /* generic.  assumed to be mpc8544ds or e500plat board */
     case 0x8034: /* mpc8544 */
@@ -104,11 +169,20 @@ static const MemoryRegionOps e500_ccsr_ops = {
     }
 };
 
+static int e500_ccsr_post_load(void *opaque, int version_id)
+{
+    CCSRState *ccsr = opaque;
+
+    e500_ccsr_post_move(ccsr);
+    return 0;
+}
+
 static void e500_ccsr_reset(DeviceState *dev)
 {
     CCSRState *ccsr = E500_CCSR(dev);
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ccsr->defbase);
+    ccsr->base = ccsr->defbase;
+    e500_ccsr_post_move(ccsr);
 }
 
 static void e500_ccsr_initfn(Object *obj)
@@ -123,15 +197,30 @@ static void e500_ccsr_initfn(Object *obj)
 
 static Property e500_ccsr_props[] = {
     DEFINE_PROP_UINT32("base", CCSRState, defbase, 0xff700000),
+    DEFINE_PROP_UINT32("ram-size", CCSRState, ram_size, 0),
+    DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
+static const VMStateDescription vmstate_e500_ccsr = {
+    .name = TYPE_E500_CCSR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = e500_ccsr_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(base, CCSRState),
+        VMSTATE_UINT32(merrd, CCSRState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static
 void e500_ccsr_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->props = e500_ccsr_props;
+    dc->vmsd = &vmstate_e500_ccsr;
     dc->reset = e500_ccsr_reset;
 }
 
-- 
2.11.0
