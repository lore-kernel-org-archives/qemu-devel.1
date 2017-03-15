Received: from eggs.gnu.org ([2001:4830:134:3::10]:34928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1co2J2-0006Zu-Hu
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1co2J1-0000dK-BY
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:21:08 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1co2J1-0000ct-5d
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:21:07 -0400
Received: by mail-pf0-x244.google.com with SMTP id j5so1100904pfb.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 23:21:07 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 15 Mar 2017 19:20:27 +1300
Message-Id: <1489558827-28971-3-git-send-email-phil@philjordan.eu>
In-Reply-To: <1489558827-28971-1-git-send-email-phil@philjordan.eu>
References: <1489558827-28971-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH v3 2/2] hw/i386: Build-time assertion on pc/q35
 reset register being identical.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>

This adds a clarifying comment and build time assert to the FADT reset register field initialisation: the reset register is the same on both machine types.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/i386/acpi-build.c | 3 +++
 hw/pci-host/piix.c   | 6 ------
 include/hw/i386/pc.h | 6 ++++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7997f06..1d8c645 100644
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
index f9218aa..bf4221d 100644
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
index f278b3a..416aaa5 100644
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
2.3.2 (Apple Git-55)
