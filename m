Received: from eggs.gnu.org ([2001:4830:134:3::10]:46999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aF6-0002CN-KP
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aF5-0006ai-0M
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aF4-0006aV-QB
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:42 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:18 +0200
Message-Id: <20170505101337.4650-3-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/21] hw/i386: Build-time assertion on pc/q35
 reset register being identical.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>

From: Phil Dennis-Jordan <phil@philjordan.eu>

This adds a clarifying comment and build time assert to the FADT reset register field initialisation: the reset register is the same on both machine types.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-Id: <1489558827-28971-3-git-send-email-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/acpi-build.c | 3 +++
 hw/pci-host/piix.c   | 6 ------
 include/hw/i386/pc.h | 6 ++++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7997f06823..1d8c645ed3 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -310,6 +310,9 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
     fadt->reset_register.space_id = AML_SYSTEM_IO;
     fadt->reset_register.bit_width = 8;
     fadt->reset_register.address = cpu_to_le64(ICH9_RST_CNT_IOPORT);
+    /* The above need not be conditional on machine type because the reset port
+     * happens to be the same on PIIX (pc) and ICH9 (q35). */
+    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT != RCR_IOPORT);
 
     fadt->xpm1a_event_block.space_id = AML_SYSTEM_IO;
     fadt->xpm1a_event_block.bit_width = fadt->pm1_evt_len * 8;
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index f9218aa952..bf4221d4bf 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -58,12 +58,6 @@ typedef struct I440FXState {
 #define XEN_PIIX_NUM_PIRQS      128ULL
 #define PIIX_PIRQC              0x60
 
-/*
- * Reset Control Register: PCI-accessible ISA-Compatible Register at address
- * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:7000).
- */
-#define RCR_IOPORT 0xcf9
-
 typedef struct PIIX3State {
     PCIDevice dev;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f278b3ae89..416aaa56ea 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -303,6 +303,12 @@ typedef struct PCII440FXState PCII440FXState;
 
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
 
+/*
+ * Reset Control Register: PCI-accessible ISA-Compatible Register at address
+ * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:7000).
+ */
+#define RCR_IOPORT 0xcf9
+
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state, int *piix_devfn,
                     ISABus **isa_bus, qemu_irq *pic,
-- 
2.12.2
