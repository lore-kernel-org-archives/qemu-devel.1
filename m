Received: from eggs.gnu.org ([2001:4830:134:3::10]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmx.de>) id 1cPRIf-0006NB-RS
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmx.de>) id 1cPRIc-0006WC-Le
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:59:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:49770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@gmx.de>) id 1cPRIc-0006W1-Ae
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:59:02 -0500
Date: Fri, 6 Jan 2017 10:58:55 +0100
From: Thomas Huth <th.huth@gmx.de>
Message-ID: <20170106105855.12c0ce73@thl530>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] m68k: QOMify the MCF Fast Ethernet Controller
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

When running qemu-system-m68k with the "-net" parameter (for example
simply "-net nic -net user"), there is currently a confusing warning
message saying:

 Warning: requested NIC (anonymous, model mcf_fec) was not created
 (not supported by this machine?)

This seems to happen because the MCF NIC has never been adapted to
the currently expected QEMU device behavior. Thus let's QOMify the
NIC now to get rid of the warning message.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5208.c     | 20 ++++++++++++++
 hw/net/mcf_fec.c      | 75 ++++++++++++++++++++++++++++++++++++++-------------
 include/hw/m68k/mcf.h |  4 ---
 3 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 3438314..f9e1adb 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -18,6 +18,7 @@
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/sysbus.h"
 #include "elf.h"
 #include "exec/address-spaces.h"
 
@@ -192,6 +193,25 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
     }
 }
 
+static void mcf_fec_init(MemoryRegion *sysmem, NICInfo *nd, hwaddr base,
+                         qemu_irq *irqs)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+    int i;
+
+    dev = qdev_create(NULL, "mcf-fec");
+    qdev_set_nic_properties(dev, nd);
+    qdev_init_nofail(dev);
+
+    s = SYS_BUS_DEVICE(dev);
+    for (i = 0; i < 13; i++) {
+        sysbus_connect_irq(s, i, irqs[i]);
+    }
+
+    memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
+}
+
 static void mcf5208evb_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 4025eb3..e95d100 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -10,6 +10,7 @@
 #include "net/net.h"
 #include "hw/m68k/mcf.h"
 #include "hw/net/mii.h"
+#include "hw/sysbus.h"
 /* For crc32 */
 #include <zlib.h>
 #include "exec/address-spaces.h"
@@ -23,13 +24,19 @@ do { printf("mcf_fec: " fmt , ## __VA_ARGS__); } while (0)
 #define DPRINTF(fmt, ...) do {} while(0)
 #endif
 
+#define TYPE_MCF_FEC_NET "mcf-fec"
+#define MCF_FEC_NET(obj) OBJECT_CHECK(mcf_fec_state, (obj), TYPE_MCF_FEC_NET)
+
 #define FEC_MAX_DESC 1024
 #define FEC_MAX_FRAME_SIZE 2032
 
+#define FEC_NUM_IRQ 13
+
 typedef struct {
-    MemoryRegion *sysmem;
+    SysBusDevice parent_obj;
+
     MemoryRegion iomem;
-    qemu_irq *irq;
+    qemu_irq irq[FEC_NUM_IRQ];
     NICState *nic;
     NICConf conf;
     uint32_t irq_state;
@@ -68,7 +75,6 @@ typedef struct {
 #define FEC_RESET   1
 
 /* Map interrupt flags onto IRQ lines.  */
-#define FEC_NUM_IRQ 13
 static const uint32_t mcf_fec_irq_map[FEC_NUM_IRQ] = {
     FEC_INT_TXF,
     FEC_INT_TXB,
@@ -208,8 +214,10 @@ static void mcf_fec_enable_rx(mcf_fec_state *s)
     }
 }
 
-static void mcf_fec_reset(mcf_fec_state *s)
+static void mcf_fec_reset(DeviceState *dev)
 {
+    mcf_fec_state *s = MCF_FEC_NET(dev);
+
     s->eir = 0;
     s->eimr = 0;
     s->rx_enabled = 0;
@@ -330,7 +338,7 @@ static void mcf_fec_write(void *opaque, hwaddr addr,
         s->ecr = value;
         if (value & FEC_RESET) {
             DPRINTF("Reset\n");
-            mcf_fec_reset(s);
+            mcf_fec_reset(opaque);
         }
         if ((s->ecr & FEC_EN) == 0) {
             s->rx_enabled = 0;
@@ -513,24 +521,55 @@ static NetClientInfo net_mcf_fec_info = {
     .receive = mcf_fec_receive,
 };
 
-void mcf_fec_init(MemoryRegion *sysmem, NICInfo *nd,
-                  hwaddr base, qemu_irq *irq)
+static void mcf_fec_realize(DeviceState *dev, Error **errp)
+{
+    mcf_fec_state *s = MCF_FEC_NET(dev);
+
+    s->nic = qemu_new_nic(&net_mcf_fec_info, &s->conf,
+                          object_get_typename(OBJECT(dev)), dev->id, s);
+    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+}
+
+static void mcf_fec_instance_init(Object *obj)
 {
-    mcf_fec_state *s;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    mcf_fec_state *s = MCF_FEC_NET(obj);
+    int i;
 
-    qemu_check_nic_model(nd, "mcf_fec");
+    memory_region_init_io(&s->iomem, obj, &mcf_fec_ops, s, "fec", 0x400);
+    sysbus_init_mmio(sbd, &s->iomem);
+    for (i = 0; i < FEC_NUM_IRQ; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+}
 
-    s = (mcf_fec_state *)g_malloc0(sizeof(mcf_fec_state));
-    s->sysmem = sysmem;
-    s->irq = irq;
+static Property mcf_fec_properties[] = {
+    DEFINE_NIC_PROPERTIES(mcf_fec_state, conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
 
-    memory_region_init_io(&s->iomem, NULL, &mcf_fec_ops, s, "fec", 0x400);
-    memory_region_add_subregion(sysmem, base, &s->iomem);
+static void mcf_fec_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
-    s->conf.macaddr = nd->macaddr;
-    s->conf.peers.ncs[0] = nd->netdev;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->realize = mcf_fec_realize;
+    dc->desc = "MCF Fast Ethernet Controller network device";
+    dc->reset = mcf_fec_reset;
+    dc->props = mcf_fec_properties;
+}
 
-    s->nic = qemu_new_nic(&net_mcf_fec_info, &s->conf, nd->model, nd->name, s);
+static const TypeInfo mcf_fec_info = {
+    .name          = TYPE_MCF_FEC_NET,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(mcf_fec_state),
+    .instance_init = mcf_fec_instance_init,
+    .class_init    = mcf_fec_class_init,
+};
 
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+static void mcf_fec_register_types(void)
+{
+    type_register_static(&mcf_fec_info);
 }
+
+type_init(mcf_fec_register_types)
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index fdae229..bf43998 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -21,10 +21,6 @@ qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
                         hwaddr base,
                         M68kCPU *cpu);
 
-/* mcf_fec.c */
-void mcf_fec_init(struct MemoryRegion *sysmem, NICInfo *nd,
-                  hwaddr base, qemu_irq *irq);
-
 /* mcf5206.c */
 qemu_irq *mcf5206_init(struct MemoryRegion *sysmem,
                        uint32_t base, M68kCPU *cpu);
-- 
2.7.4
