Received: from eggs.gnu.org ([2001:4830:134:3::10]:44545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIA-0007uv-OD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSI7-0005Ch-5i
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:26 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:36451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSI6-0005CF-Si
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:23 -0400
Received: by mail-pl0-x242.google.com with SMTP id 61-v6so9824271plf.3
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:22 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:33:58 +1000
Message-Id: <6067bc3c91c9ee629a35723dfb474ef168ff4ebf.1520867955.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 13/30] pc/xen: Xen Q35 support: provide IRQ
 handling for PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

The primary difference in PCI device IRQ management between Xen HVM and
QEMU is that Xen PCI IRQs are "device-centric" while QEMU PCI IRQs are
"chipset-centric". Namely, Xen uses PCI device BDF and INTx as coordinates
to assert IRQ while QEMU finds out to which chipset PIRQ the IRQ is routed
through the hierarchy of PCI buses and manages IRQ assertion on chipset
side (as PIRQ inputs).

Two callback functions are used for this purpose: .map_irq and .set_irq
(named after corresponding structure fields). Corresponding Xen-specific
callback functions are piix3_set_irq() and pci_slot_get_pirq(). In Xen
case these functions do not operate on pirq pin numbers. Instead, they use
a specific value to pass BDF/INTx information between .map_irq and
.set_irq -- PCI device devfn and INTx pin number are combined into
pseudo-PIRQ in pci_slot_get_pirq, which piix3_set_irq later decodes back
into devfn and INTx number for passing to *set_pci_intx_level() call.

For Xen on Q35 this scheme is still applicable, with the exception that
function names are non-descriptive now and need to be renamed to show
their common i440/Q35 nature. Proposed new names are:

xen_pci_slot_get_pirq --> xen_cmn_pci_slot_get_pirq
xen_piix3_set_irq     --> xen_cmn_set_irq

Another IRQ-related difference between i440 and Q35 is the number of PIRQ
inputs and PIRQ routers (PCI IRQ links in terms of ACPI) available. i440
has 4 PCI interrupt links, while Q35 has 8 (PIRQA...PIRQH).
Currently Xen have support for only 4 PCI links, so we describe only 4 of
8 PCI links in ACPI tables. Also, hvmloader disables PIRQ routing for
PIRQE..PIRQH by writing 80h into corresponding PIRQ[n]_ROUT registers.

All this PCI interrupt routing stuff is largely an ancient legacy from PIC
era. It's hardly worth to extend number of PCI links supported as we
normally deal with APIC mode and/or MSI interrupts.

The only useful thing to do with PIRQE..PIRQH routing currently is to
check if guest actually attempts to use it for some reason (despite ACPI
PCI routing information provided). In this case, a warning is logged.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/i386/pc_q35.c       | 13 ++++++++++---
 hw/i386/xen/xen-hvm.c  | 32 +++++++++++++++++++++++++++++---
 hw/isa/lpc_ich9.c      |  4 ++++
 hw/pci-host/piix.c     |  2 +-
 include/hw/i386/ich9.h |  1 +
 include/hw/xen/xen.h   |  5 +++--
 stubs/xen-hvm.c        |  8 ++++++--
 7 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0c0bc48137..0db670f6d7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -203,9 +203,16 @@ static void pc_q35_init(MachineState *machine)
     for (i = 0; i < GSI_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, pcms->gsi[i]);
     }
-    pci_bus_irqs(host_bus, ich9_lpc_set_irq, ich9_lpc_map_irq, ich9_lpc,
-                 ICH9_LPC_NB_PIRQS);
-    pci_bus_set_route_irq_fn(host_bus, ich9_route_intx_pin_to_irq);
+
+    if (xen_enabled()) {
+        pci_bus_irqs(host_bus, xen_cmn_set_irq, xen_cmn_pci_slot_get_pirq,
+                     ich9_lpc, ICH9_XEN_NUM_IRQ_SOURCES);
+    } else {
+        pci_bus_irqs(host_bus, ich9_lpc_set_irq, ich9_lpc_map_irq, ich9_lpc,
+                     ICH9_LPC_NB_PIRQS);
+        pci_bus_set_route_irq_fn(host_bus, ich9_route_intx_pin_to_irq);
+    }
+
     isa_bus = ich9_lpc->isa_bus;
 
     if (kvm_pic_in_kernel()) {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f24b7d4923..40a5c13fa6 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
+#include "hw/i386/ich9.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
@@ -115,14 +116,14 @@ typedef struct XenIOState {
     Notifier wakeup;
 } XenIOState;
 
-/* Xen specific function for piix pci */
+/* Xen-specific functions for pci dev IRQ handling */
 
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
+int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
 {
     return irq_num + ((pci_dev->devfn >> 3) << 2);
 }
 
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+void xen_cmn_set_irq(void *opaque, int irq_num, int level)
 {
     xen_set_pci_intx_level(xen_domid, 0, 0, irq_num >> 2,
                            irq_num & 3, level);
@@ -145,6 +146,31 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
     }
 }
 
+void xen_ich9_pci_write_config_client(uint32_t address, uint32_t val, int len)
+{
+    static bool pirqe_f_warned = false;
+
+    if (ranges_overlap(address, len, ICH9_LPC_PIRQA_ROUT, 4)) {
+        /* handle PIRQA..PIRQD routing */
+        xen_piix_pci_write_config_client(address, val, len);
+    } else if (ranges_overlap(address, len, ICH9_LPC_PIRQE_ROUT, 4)) {
+        while (len--) {
+            if (range_covers_byte(ICH9_LPC_PIRQE_ROUT, 4, address) &&
+                (val & 0x80) == 0) {
+                /* print warning only once */
+                if (!pirqe_f_warned) {
+                    pirqe_f_warned = true;
+                    fprintf(stderr, "WARNING: guest domain attempted to use PIRQ%c "
+                            "routing which is not supported for Xen/Q35 currently\n",
+                            (char)(address - ICH9_LPC_PIRQE_ROUT + 'E'));
+                    break;
+                }
+            }
+            address++, val >>= 8;
+        }
+    }
+}
+
 int xen_is_pirq_msi(uint32_t msi_data)
 {
     /* If vector is 0, the msi is remapped into a pirq, passed as
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index e692b9fdc1..b17ac82ed6 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -49,6 +49,7 @@
 #include "qom/cpu.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/cutils.h"
+#include "hw/xen/xen.h"
 
 /*****************************************************************************/
 /* ICH9 LPC PCI to ISA bridge */
@@ -514,6 +515,9 @@ static void ich9_lpc_config_write(PCIDevice *d,
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(d);
     uint32_t rcba_old = pci_get_long(d->config + ICH9_LPC_RCBA);
 
+    if (xen_enabled()){
+        xen_ich9_pci_write_config_client(addr, val, len);
+    }
     pci_default_write_config(d, addr, val, len);
     if (ranges_overlap(addr, len, ICH9_LPC_PMBASE, 4) ||
         ranges_overlap(addr, len, ICH9_LPC_ACPI_CTRL, 1)) {
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 0e608347c1..2627c06fae 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -415,7 +415,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
         PCIDevice *pci_dev = pci_create_simple_multifunction(b,
                              -1, true, "PIIX3-xen");
         piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
+        pci_bus_irqs(b, xen_cmn_set_irq, xen_cmn_pci_slot_get_pirq,
                 piix3, XEN_PIIX_NUM_PIRQS);
     } else {
         PCIDevice *pci_dev = pci_create_simple_multifunction(b,
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 673d13d28f..3dc42fcbce 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -143,6 +143,7 @@ Object *ich9_lpc_find(void);
 
 #define ICH9_A2_LPC_REVISION                    0x2
 #define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
+#define ICH9_XEN_NUM_IRQ_SOURCES                128
 
 #define ICH9_LPC_PMBASE                         0x40
 #define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       Q35_MASK(32, 15, 7)
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 7efcdaa8fe..55c6cad543 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -30,9 +30,10 @@ static inline bool xen_enabled(void)
     return xen_allowed;
 }
 
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
-void xen_piix3_set_irq(void *opaque, int irq_num, int level);
+int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
+void xen_cmn_set_irq(void *opaque, int irq_num, int level);
 void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
+void xen_ich9_pci_write_config_client(uint32_t address, uint32_t val, int len);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
 int xen_is_pirq_msi(uint32_t msi_data);
 
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 0067bcc6db..c1bc45744c 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -14,12 +14,12 @@
 #include "exec/memory.h"
 #include "qapi/qapi-commands-misc.h"
 
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
+int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
 {
     return -1;
 }
 
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+void xen_cmn_set_irq(void *opaque, int irq_num, int level)
 {
 }
 
@@ -27,6 +27,10 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
 {
 }
 
+void xen_ich9_pci_write_config_client(uint32_t address, uint32_t val, int len)
+{
+}
+
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
 {
 }
-- 
2.11.0
