Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfw-0006HP-8X
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBft-0003Dw-CW
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:26 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48000
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBft-0003De-5V
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:25 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:11:53 +0000
Message-Id: <20180121091154.17426-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
References: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 09/10] sabre: convert from SABRE_DPRINTF
 macro to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
[for addition of trace-events to hw/pci-host]
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile.objs            |  1 +
 hw/pci-host/sabre.c      | 32 ++++++++++----------------------
 hw/pci-host/trace-events | 11 +++++++++++
 3 files changed, 22 insertions(+), 22 deletions(-)
 create mode 100644 hw/pci-host/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 669d8d684d..323ef12384 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -150,6 +150,7 @@ trace-events-subdirs += hw/i386/xen
 trace-events-subdirs += hw/9pfs
 trace-events-subdirs += hw/ppc
 trace-events-subdirs += hw/pci
+trace-events-subdirs += hw/pci-host
 trace-events-subdirs += hw/s390x
 trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/acpi
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 4054c17598..2268a41dd9 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -36,16 +36,7 @@
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-
-/* debug sabre */
-//#define DEBUG_SABRE
-
-#ifdef DEBUG_SABRE
-#define SABRE_DPRINTF(fmt, ...) \
-do { printf("sabre: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define SABRE_DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 /*
  * Chipset docs:
@@ -69,8 +60,7 @@ do { printf("sabre: " fmt , ## __VA_ARGS__); } while (0)
 
 static inline void sabre_set_request(SabreState *s, unsigned int irq_num)
 {
-    SABRE_DPRINTF("%s: request irq %d\n", __func__, irq_num);
-
+    trace_sabre_set_request(irq_num);
     s->irq_request = irq_num;
     qemu_set_irq(s->ivec_irqs[irq_num], 1);
 }
@@ -108,7 +98,7 @@ static inline void sabre_check_irqs(SabreState *s)
 
 static inline void sabre_clear_request(SabreState *s, unsigned int irq_num)
 {
-    SABRE_DPRINTF("%s: clear request irq %d\n", __func__, irq_num);
+    trace_sabre_clear_request(irq_num);
     qemu_set_irq(s->ivec_irqs[irq_num], 0);
     s->irq_request = NO_IRQ_REQUEST;
 }
@@ -125,8 +115,7 @@ static void sabre_config_write(void *opaque, hwaddr addr,
 {
     SabreState *s = opaque;
 
-    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__,
-                  addr, val);
+    trace_sabre_config_write(addr, val);
 
     switch (addr & 0xffff) {
     case 0x30 ... 0x4f: /* DMA error registers */
@@ -250,7 +239,7 @@ static uint64_t sabre_config_read(void *opaque,
         val = 0;
         break;
     }
-    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, val);
+    trace_sabre_config_read(addr, val);
 
     return val;
 }
@@ -267,8 +256,7 @@ static void sabre_pci_config_write(void *opaque, hwaddr addr,
     SabreState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
-    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__,
-                  addr, val);
+    trace_sabre_pci_config_write(addr, val);
     pci_data_write(phb->bus, addr, val, size);
 }
 
@@ -280,7 +268,7 @@ static uint64_t sabre_pci_config_read(void *opaque, hwaddr addr,
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
     ret = pci_data_read(phb->bus, addr, size);
-    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, ret);
+    trace_sabre_pci_config_read(addr, ret);
     return ret;
 }
 
@@ -318,7 +306,8 @@ static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
 {
     SabreState *s = opaque;
 
-    SABRE_DPRINTF("%s: set irq_in %d level %d\n", __func__, irq_num, level);
+    trace_sabre_pci_set_irq(irq_num, level);
+
     /* PCI IRQ map onto the first 32 INO.  */
     if (irq_num < 32) {
         if (level) {
@@ -332,8 +321,7 @@ static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
     } else {
         /* OBIO IRQ map onto the next 32 INO.  */
         if (level) {
-            SABRE_DPRINTF("%s: set irq %d level %d\n", __func__, irq_num,
-                          level);
+            trace_sabre_pci_set_obio_irq(irq_num, level);
             s->pci_irq_in |= 1ULL << irq_num;
             if ((s->irq_request == NO_IRQ_REQUEST)
                 && (s->obio_irq_map[irq_num - 32] & PBM_PCI_IMR_ENABLED)) {
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
new file mode 100644
index 0000000000..32dfc84692
--- /dev/null
+++ b/hw/pci-host/trace-events
@@ -0,0 +1,11 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/pci-host/sabre.c
+sabre_set_request(int irq_num) "request irq %d"
+sabre_clear_request(int irq_num) "clear request irq %d"
+sabre_config_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
+sabre_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
+sabre_pci_config_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
+sabre_pci_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
+sabre_pci_set_irq(int irq_num, int level) "set irq_in %d level %d"
+sabre_pci_set_obio_irq(int irq_num, int level) "set irq %d level %d"
-- 
2.11.0
