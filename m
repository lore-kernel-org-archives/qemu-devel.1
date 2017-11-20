Received: from eggs.gnu.org ([2001:4830:134:3::10]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchX-0001gN-QJ
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchW-0006Td-Dl
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:51 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:12 -0600
Message-Id: <20171120032420.9134-5-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 04/12] e500: additional CCSR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Add CCSRBAR to allow CCSR region to be relocated.
Guest memory size introspection.
Dummy RAM error controls.
Guest clock introspection.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c      |  2 ++
 hw/ppc/e500.h      |  1 +
 hw/ppc/e500_ccsr.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ppc/e500plat.c  |  1 +
 hw/ppc/mpc8544ds.c |  1 +
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 474a46a985..057be1751b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -853,7 +853,9 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     dev = qdev_create(NULL, "e500-ccsr");
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
                               OBJECT(dev), NULL);
+    qdev_prop_set_uint32(dev, "porpllsr", params->porpllsr);
     qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
+    qdev_prop_set_uint32(dev, "ram-size", ram_size);
     qdev_init_nofail(dev);
     ccsr_addr_space = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
 
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 40f72f2de2..1f39095dfa 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -22,6 +22,7 @@ typedef struct PPCE500Params {
     hwaddr pci_mmio_base;
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
+    uint32_t porpllsr; /* value of PORPLLSR register */
     uint32_t decrementor_freq; /* in Hz */
     bool skip_load;
     bool tsec_nic;
diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
index 1b586c3f42..c58b17f06b 100644
--- a/hw/ppc/e500_ccsr.c
+++ b/hw/ppc/e500_ccsr.c
@@ -31,6 +31,16 @@
 
 /* E500_ denotes registers common to all */
 
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
 
@@ -44,7 +54,11 @@ typedef struct {
 
     MemoryRegion iomem;
 
-    uint32_t defbase;
+    uint32_t defbase, base;
+    uint32_t ram_size;
+    uint32_t merrd;
+
+    uint32_t porpllsr;
 } CCSRState;
 
 #define TYPE_E500_CCSR "e500-ccsr"
@@ -53,10 +67,28 @@ typedef struct {
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
@@ -72,10 +104,22 @@ static uint64_t e500_ccsr_read(void *opaque, hwaddr addr,
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
+        sysbus_mmio_map(SYS_BUS_DEVICE(ccsr), 0, ccsr->base);
+        return;
+    case E500_ERR_DISABLE:
+        ccsr->merrd = value & 0xd;
+        return;
+    }
+
     switch (svr) {
     case 0: /* generic.  assumed to be mpc8544ds or e500plat board */
     case 0x8034: /* mpc8544 */
@@ -104,11 +148,20 @@ static const MemoryRegionOps e500_ccsr_ops = {
     }
 };
 
+static int e500_ccsr_post_load(void *opaque, int version_id)
+{
+    CCSRState *ccsr = opaque;
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(ccsr), 0, ccsr->base);
+    return 0;
+}
+
 static void e500_ccsr_reset(DeviceState *dev)
 {
     CCSRState *ccsr = E500_CCSR(dev);
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ccsr->defbase);
+    ccsr->base = ccsr->defbase;
+    e500_ccsr_post_load(ccsr, 1);
 }
 
 static void e500_ccsr_initfn(Object *obj)
@@ -123,15 +176,30 @@ static void e500_ccsr_initfn(Object *obj)
 
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
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 3d07987bd1..4e763d9c09 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -47,6 +47,7 @@ static void e500plat_init(MachineState *machine)
         .pci_mmio_base = 0xC00000000ULL,
         .pci_mmio_bus_base = 0xE0000000ULL,
         .spin_base = 0xFEF000000ULL,
+        .porpllsr = 0, /* TODO missing valid value */
         .decrementor_freq = 400000000,
     };
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 6d9931c475..f5e0042245 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -40,6 +40,7 @@ static void mpc8544ds_init(MachineState *machine)
         .pci_mmio_bus_base = 0xC0000000ULL,
         .pci_pio_base = 0xE1000000ULL,
         .spin_base = 0xEF000000ULL,
+        .porpllsr = 0, /* TODO missing valid value */
         .decrementor_freq = 400000000,
     };
 
-- 
2.11.0
