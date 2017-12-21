Received: from eggs.gnu.org ([2001:4830:134:3::10]:53602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBU-0008QX-N9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBT-0007bq-3Y
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:32 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43152
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRwBS-0007aj-T9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:31 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:42 +0000
Message-Id: <20171221082045.14022-14-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 13/16] ebus: wire up OBIO interrupts to APB
 pbm via qdev GPIOs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This enables us to remove the static array mapping in the ISA IRQ
handler (and the embedded reference to the APB device) by formalising
the interrupt wiring via the qdev GPIO API.

For more clarity we replace the APB OBIO interrupt numbers with constants
designating the interrupt source, and rename isa_irq_handler() to
ebus_isa_irq_handler().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/apb.c         |  2 +-
 hw/sparc64/sun4u.c        | 49 ++++++++++++++++++++++++-----------------------
 include/hw/pci-host/apb.h |  8 +++++++-
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 53de1c93c1..cb24bb2108 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -704,7 +704,7 @@ static void pci_pbm_init(Object *obj)
     for (i = 0; i < 32; i++) {
         s->obio_irq_map[i] = ((0x1f << 6) | 0x20) + i;
     }
-    s->pbm_irqs = qemu_allocate_irqs(pci_apb_set_irq, s, MAX_IVEC);
+    qdev_init_gpio_in_named(DEVICE(s), pci_apb_set_irq, "pbm-irq", MAX_IVEC);
     qdev_init_gpio_out_named(DEVICE(s), s->ivec_irqs, "ivec-irq", MAX_IVEC);
     s->irq_request = NO_IRQ_REQUEST;
     s->pci_irq_in = 0ULL;
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 0a30fb8d08..1456c3370d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -86,6 +86,7 @@ typedef struct EbusState {
     PCIDevice parent_obj;
 
     ISABus *isa_bus;
+    qemu_irq isa_bus_irqs[ISA_NUM_IRQS];
     uint64_t console_serial_base;
     MemoryRegion bar0;
     MemoryRegion bar1;
@@ -211,23 +212,15 @@ typedef struct ResetData {
     uint64_t prom_addr;
 } ResetData;
 
-static void isa_irq_handler(void *opaque, int n, int level)
+static void ebus_isa_irq_handler(void *opaque, int n, int level)
 {
-    static const int isa_irq_to_ivec[16] = {
-        [1] = 0x29, /* keyboard */
-        [4] = 0x2b, /* serial */
-        [6] = 0x27, /* floppy */
-        [7] = 0x22, /* parallel */
-        [12] = 0x2a, /* mouse */
-    };
-    qemu_irq *irqs = opaque;
-    int ivec;
-
-    assert(n < ARRAY_SIZE(isa_irq_to_ivec));
-    ivec = isa_irq_to_ivec[n];
-    EBUS_DPRINTF("Set ISA IRQ %d level %d -> ivec 0x%x\n", n, level, ivec);
-    if (ivec) {
-        qemu_set_irq(irqs[ivec], level);
+    EbusState *s = EBUS(opaque);
+    qemu_irq irq = s->isa_bus_irqs[n];
+
+    /* Pass ISA bus IRQs onto their gpio equivalent */
+    EBUS_DPRINTF("Set ISA IRQ %d level %d\n", n, level);
+    if (irq) {
+        qemu_set_irq(irq, level);
     }
 }
 
@@ -235,7 +228,6 @@ static void isa_irq_handler(void *opaque, int n, int level)
 static void ebus_realize(PCIDevice *pci_dev, Error **errp)
 {
     EbusState *s = EBUS(pci_dev);
-    APBState *apb;
     DeviceState *dev;
     qemu_irq *isa_irq;
     DriveInfo *fd[MAX_FD];
@@ -248,14 +240,11 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
-    apb = APB_DEVICE(object_resolve_path_type("", TYPE_APB, NULL));
-    if (!apb) {
-        error_setg(errp, "unable to locate APB PCI host bridge");
-        return;
-    }
-
-    isa_irq = qemu_allocate_irqs(isa_irq_handler, apb->pbm_irqs, 16);
+    /* ISA bus */
+    isa_irq = qemu_allocate_irqs(ebus_isa_irq_handler, s, ISA_NUM_IRQS);
     isa_bus_irqs(s->isa_bus, isa_irq);
+    qdev_init_gpio_out_named(DEVICE(s), s->isa_bus_irqs, "isa-irq",
+                             ISA_NUM_IRQS);
 
     /* Serial ports */
     i = 0;
@@ -530,6 +519,18 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                          hwdef->console_serial_base);
     qdev_init_nofail(DEVICE(ebus));
 
+    /* Wire up "well-known" ISA IRQs to APB legacy obio IRQs */
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 7,
+        qdev_get_gpio_in_named(DEVICE(apb), "pbm-irq", OBIO_LPT_IRQ));
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 6,
+        qdev_get_gpio_in_named(DEVICE(apb), "pbm-irq", OBIO_FDD_IRQ));
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 1,
+        qdev_get_gpio_in_named(DEVICE(apb), "pbm-irq", OBIO_KBD_IRQ));
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 12,
+        qdev_get_gpio_in_named(DEVICE(apb), "pbm-irq", OBIO_MSE_IRQ));
+    qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 4,
+        qdev_get_gpio_in_named(DEVICE(apb), "pbm-irq", OBIO_SER_IRQ));
+
     pci_dev = pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
 
     memset(&macaddr, 0, sizeof(MACAddr));
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index dd49437ff1..09ebd53f60 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -52,6 +52,13 @@ typedef struct IOMMUState {
 
 #define MAX_IVEC 0x40
 
+/* OBIO IVEC IRQs */
+#define OBIO_LPT_IRQ         0x22
+#define OBIO_FDD_IRQ         0x27
+#define OBIO_KBD_IRQ         0x29
+#define OBIO_MSE_IRQ         0x2a
+#define OBIO_SER_IRQ         0x2b
+
 #define TYPE_APB "pbm"
 
 #define APB_DEVICE(obj) \
@@ -76,7 +83,6 @@ typedef struct APBState {
     uint32_t pci_irq_map[8];
     uint32_t pci_err_irq_map[4];
     uint32_t obio_irq_map[32];
-    qemu_irq *pbm_irqs;
     qemu_irq ivec_irqs[MAX_IVEC];
     unsigned int irq_request;
     uint32_t reset_control;
-- 
2.11.0
