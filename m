Received: from eggs.gnu.org ([2001:4830:134:3::10]:51676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTA-0007U5-Tv
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT7-00035a-RO
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:24 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:43137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT7-00035A-MH
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:21 -0500
Received: by mail-qt0-x244.google.com with SMTP id w10so12062257qtb.10
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:50 -0300
Message-Id: <20180108024558.17983-22-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/29] piix: move southbridge related
 declarations/definitions to i82371_piix.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/acpi/piix4.h              |  6 ------
 include/hw/i386/pc.h                 | 12 ------------
 include/hw/southbridge/i82371_piix.h | 17 +++++++++++++++++
 hw/acpi/piix4.c                      |  2 +-
 hw/i386/acpi-build.c                 |  2 +-
 hw/i386/pc_piix.c                    |  1 +
 hw/mips/mips_malta.c                 |  2 +-
 hw/pci-host/piix.c                   |  1 -
 MAINTAINERS                          |  1 -
 9 files changed, 21 insertions(+), 23 deletions(-)
 delete mode 100644 include/hw/acpi/piix4.h

diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
deleted file mode 100644
index 26c2370e30..0000000000
--- a/include/hw/acpi/piix4.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef HW_ACPI_PIIX4_H
-#define HW_ACPI_PIIX4_H
-
-Object *piix4_pm_find(void);
-
-#endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 195c02febe..768428db3b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -236,12 +236,6 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
 #define PORT92_A20_LINE "a20"
 
-/* acpi_piix.c */
-
-I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
-                      qemu_irq sci_irq, qemu_irq smi_irq,
-                      int smm_enabled, DeviceState **piix4_pm);
-
 /* hpet.c */
 extern int no_hpet;
 
@@ -254,12 +248,6 @@ typedef struct PCII440FXState PCII440FXState;
 
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
 
-/*
- * Reset Control Register: PCI-accessible ISA-Compatible Register at address
- * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:7000).
- */
-#define RCR_IOPORT 0xcf9
-
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state, int *piix_devfn,
                     ISABus **isa_bus, qemu_irq *pic,
diff --git a/include/hw/southbridge/i82371_piix.h b/include/hw/southbridge/i82371_piix.h
index 95ac25becd..8a5f9a7596 100644
--- a/include/hw/southbridge/i82371_piix.h
+++ b/include/hw/southbridge/i82371_piix.h
@@ -10,8 +10,25 @@
 #define HW_ISA_PIIX_H
 
 #include "hw/pci/pci.h"
+#include "hw/isa/isa.h"
+
+#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
+
+#define PIIX_NUM_PIRQS          4ULL    /* PIRQ[A-D] */
+
+/*
+ * Reset Control Register: PCI-accessible ISA-Compatible Register at address
+ * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:7000).
+ */
+#define RCR_IOPORT 0xcf9
 
 /* piix4.c */
 extern PCIDevice *piix4_dev;
 
+/* acpi_piix.c */
+Object *piix4_pm_find(void);
+I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
+                      qemu_irq sci_irq, qemu_irq smi_irq,
+                      int smm_enabled, DeviceState **piix4_pm);
+
 #endif /* HW_ISA_PIIX_H */
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 32caa4f0fc..7e37587f3a 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/southbridge/i82371_piix.h"
 #include "hw/isa/apm.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
@@ -31,7 +32,6 @@
 #include "exec/ioport.h"
 #include "hw/nvram/fw_cfg.h"
 #include "exec/address-spaces.h"
-#include "hw/acpi/piix4.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5a6dee081c..d166187bc5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -48,7 +48,7 @@
 #include "sysemu/numa.h"
 
 /* Supported chipsets: */
-#include "hw/acpi/piix4.h"
+#include "hw/southbridge/i82371_piix.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/i386/ich9.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e47528993..89606c85db 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -31,6 +31,7 @@
 #include "hw/smbios/smbios.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
+#include "hw/southbridge/i82371_piix.h"
 #include "hw/usb.h"
 #include "net/net.h"
 #include "hw/boards.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 84b4d5c423..03fe98e35e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
+#include "hw/southbridge/i82371_piix.h"
 #include "hw/isa/superio.h"
 #include "hw/char/serial.h"
 #include "net/net.h"
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index a684a7cca9..0bd22fa33a 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -55,7 +55,6 @@ typedef struct I440FXState {
 } I440FXState;
 
 #define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
-#define PIIX_NUM_PIRQS          4ULL    /* PIRQ[A-D] */
 #define XEN_PIIX_NUM_PIRQS      128ULL
 #define PIIX_PIRQC              0x60
 
diff --git a/MAINTAINERS b/MAINTAINERS
index cead15b69b..968f32f93d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -859,7 +859,6 @@ F: hw/i2c/smbus_ich9.c
 F: hw/acpi/piix4.c
 F: hw/acpi/ich9.c
 F: include/hw/acpi/ich9.h
-F: include/hw/acpi/piix4.h
 F: hw/misc/sga.c
 
 PC Chipset
-- 
2.15.1
