Received: from eggs.gnu.org ([2001:4830:134:3::10]:34391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3r-0000lx-RE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3p-00046F-Tn
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:20 -0400
Message-Id: <20180531222835.16558-2-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/16] ahci: add port register enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: f4bug@amsat.org, John Snow <jsnow@redhat.com>

Instead of tracking offsets, lets count the registers.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c          | 25 +++++++++++++++++++++++++
 hw/ide/ahci_internal.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be05f..48130c6439 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -46,6 +46,31 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
 
+__attribute__((__unused__)) /* TODO */
+static const char *AHCIPortReg_lookup[AHCI_PORT_REG__COUNT] = {
+    [AHCI_PORT_REG_LST_ADDR]    = "PxCLB",
+    [AHCI_PORT_REG_LST_ADDR_HI] = "PxCLBU",
+    [AHCI_PORT_REG_FIS_ADDR]    = "PxFB",
+    [AHCI_PORT_REG_FIS_ADDR_HI] = "PxFBU",
+    [AHCI_PORT_REG_IRQ_STAT]    = "PxIS",
+    [AHCI_PORT_REG_IRQ_MASK]    = "PXIE",
+    [AHCI_PORT_REG_CMD]         = "PxCMD",
+    [7]                         = "Reserved",
+    [AHCI_PORT_REG_TFDATA]      = "PxTFD",
+    [AHCI_PORT_REG_SIG]         = "PxSIG",
+    [AHCI_PORT_REG_SCR_STAT]    = "PxSSTS",
+    [AHCI_PORT_REG_SCR_CTL]     = "PxSCTL",
+    [AHCI_PORT_REG_SCR_ERR]     = "PxSERR",
+    [AHCI_PORT_REG_SCR_ACT]     = "PxSACT",
+    [AHCI_PORT_REG_CMD_ISSUE]   = "PxCI",
+    [AHCI_PORT_REG_SCR_NOTIF]   = "PxSNTF",
+    [AHCI_PORT_REG_FIS_CTL]     = "PxFBS",
+    [AHCI_PORT_REG_DEV_SLEEP]   = "PxDEVSLP",
+    [18 ... 27]                 = "Reserved",
+    [AHCI_PORT_REG_VENDOR_1 ...
+     AHCI_PORT_REG_VENDOR_4]    = "PxVS",
+};
+
 static const char *AHCIPortIRQ_lookup[AHCI_PORT_IRQ__COUNT] = {
     [AHCI_PORT_IRQ_BIT_DHRS] = "DHRS",
     [AHCI_PORT_IRQ_BIT_PSS]  = "PSS",
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 1a25d6c039..eb7e1eefc0 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -74,6 +74,34 @@
 #define HOST_CAP_NCQ              (1 << 30) /* Native Command Queueing */
 #define HOST_CAP_64               (1U << 31) /* PCI DAC (64-bit DMA) support */
 
+/* registers for each SATA port */
+enum AHCIPortReg {
+    AHCI_PORT_REG_LST_ADDR    = 0, /* PxCLB: command list DMA addr */
+    AHCI_PORT_REG_LST_ADDR_HI = 1, /* PxCLBU: command list DMA addr hi */
+    AHCI_PORT_REG_FIS_ADDR    = 2, /* PxFB: FIS rx buf addr */
+    AHCI_PORT_REG_FIS_ADDR_HI = 3, /* PxFBU: FIX rx buf addr hi */
+    AHCI_PORT_REG_IRQ_STAT    = 4, /* PxIS: interrupt status */
+    AHCI_PORT_REG_IRQ_MASK    = 5, /* PxIE: interrupt enable/disable mask */
+    AHCI_PORT_REG_CMD         = 6, /* PxCMD: port command */
+    /* RESERVED */
+    AHCI_PORT_REG_TFDATA      = 8, /* PxTFD: taskfile data */
+    AHCI_PORT_REG_SIG         = 9, /* PxSIG: device TF signature */
+    AHCI_PORT_REG_SCR_STAT    = 10, /* PxSSTS: SATA phy register: SStatus */
+    AHCI_PORT_REG_SCR_CTL     = 11, /* PxSCTL: SATA phy register: SControl */
+    AHCI_PORT_REG_SCR_ERR     = 12, /* PxSERR: SATA phy register: SError */
+    AHCI_PORT_REG_SCR_ACT     = 13, /* PxSACT: SATA phy register: SActive */
+    AHCI_PORT_REG_CMD_ISSUE   = 14, /* PxCI: command issue */
+    AHCI_PORT_REG_SCR_NOTIF   = 15, /* PxSNTF: SATA phy register: SNotification */
+    AHCI_PORT_REG_FIS_CTL     = 16, /* PxFBS: Port multiplier switching ctl */
+    AHCI_PORT_REG_DEV_SLEEP   = 17, /* PxDEVSLP: device sleep control */
+    /* RESERVED */
+    AHCI_PORT_REG_VENDOR_1    = 28, /* PxVS: Vendor Specific */
+    AHCI_PORT_REG_VENDOR_2    = 29,
+    AHCI_PORT_REG_VENDOR_3    = 30,
+    AHCI_PORT_REG_VENDOR_4    = 31,
+    AHCI_PORT_REG__COUNT      = 32
+};
+
 /* registers for each SATA port */
 #define PORT_LST_ADDR             0x00 /* command list DMA addr */
 #define PORT_LST_ADDR_HI          0x04 /* command list DMA addr hi */
@@ -82,6 +110,7 @@
 #define PORT_IRQ_STAT             0x10 /* interrupt status */
 #define PORT_IRQ_MASK             0x14 /* interrupt enable/disable mask */
 #define PORT_CMD                  0x18 /* port command */
+
 #define PORT_TFDATA               0x20 /* taskfile data */
 #define PORT_SIG                  0x24 /* device TF signature */
 #define PORT_SCR_STAT             0x28 /* SATA phy register: SStatus */
-- 
2.14.3
