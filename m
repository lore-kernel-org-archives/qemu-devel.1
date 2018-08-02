Received: from eggs.gnu.org ([2001:4830:134:3::10]:58855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flFw5-00039J-7d
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flFw3-0007mq-Lv
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flFw3-0007lv-Ab
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 16:51:47 +0100
Message-Id: <20180802155147.1863-3-peter.maydell@linaro.org>
In-Reply-To: <20180802155147.1863-1-peter.maydell@linaro.org>
References: <20180802155147.1863-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] hw/pci-host/bonito: Move away from
 old_mmio accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>

Move away from the old_mmio MemoryRegion accessors in the
bonito pci controller.

This device is used only in the MIPS "fulong2e" machine.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/bonito.c | 145 +++++--------------------------------------
 1 file changed, 15 insertions(+), 130 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 2d25e9bf7ca..9868e2eccc6 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -460,8 +460,8 @@ static uint32_t bonito_sbridge_pciaddr(void *opaque, hwaddr addr)
     return pciaddr;
 }
 
-static void bonito_spciconf_writeb(void *opaque, hwaddr addr,
-                                   uint32_t val)
+static void bonito_spciconf_write(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
 {
     PCIBonitoState *s = opaque;
     PCIDevice *d = PCI_DEVICE(s);
@@ -469,34 +469,8 @@ static void bonito_spciconf_writeb(void *opaque, hwaddr addr,
     uint32_t pciaddr;
     uint16_t status;
 
-    DPRINTF("bonito_spciconf_writeb "TARGET_FMT_plx" val %x\n", addr, val);
-    pciaddr = bonito_sbridge_pciaddr(s, addr);
-
-    if (pciaddr == 0xffffffff) {
-        return;
-    }
-
-    /* set the pci address in s->config_reg */
-    phb->config_reg = (pciaddr) | (1u << 31);
-    pci_data_write(phb->bus, phb->config_reg, val & 0xff, 1);
-
-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT */
-    status = pci_get_word(d->config + PCI_STATUS);
-    status &= ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT);
-    pci_set_word(d->config + PCI_STATUS, status);
-}
-
-static void bonito_spciconf_writew(void *opaque, hwaddr addr,
-                                   uint32_t val)
-{
-    PCIBonitoState *s = opaque;
-    PCIDevice *d = PCI_DEVICE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
-    uint32_t pciaddr;
-    uint16_t status;
-
-    DPRINTF("bonito_spciconf_writew "TARGET_FMT_plx" val %x\n", addr, val);
-    assert((addr & 0x1) == 0);
+    DPRINTF("bonito_spciconf_write "TARGET_FMT_plx" size %d val %x\n",
+            addr, size, val);
 
     pciaddr = bonito_sbridge_pciaddr(s, addr);
 
@@ -506,7 +480,7 @@ static void bonito_spciconf_writew(void *opaque, hwaddr addr,
 
     /* set the pci address in s->config_reg */
     phb->config_reg = (pciaddr) | (1u << 31);
-    pci_data_write(phb->bus, phb->config_reg, val, 2);
+    pci_data_write(phb->bus, phb->config_reg, val, size);
 
     /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT */
     status = pci_get_word(d->config + PCI_STATUS);
@@ -514,8 +488,7 @@ static void bonito_spciconf_writew(void *opaque, hwaddr addr,
     pci_set_word(d->config + PCI_STATUS, status);
 }
 
-static void bonito_spciconf_writel(void *opaque, hwaddr addr,
-                                   uint32_t val)
+static uint64_t bonito_spciconf_read(void *opaque, hwaddr addr, unsigned size)
 {
     PCIBonitoState *s = opaque;
     PCIDevice *d = PCI_DEVICE(s);
@@ -523,38 +496,12 @@ static void bonito_spciconf_writel(void *opaque, hwaddr addr,
     uint32_t pciaddr;
     uint16_t status;
 
-    DPRINTF("bonito_spciconf_writel "TARGET_FMT_plx" val %x\n", addr, val);
-    assert((addr & 0x3) == 0);
+    DPRINTF("bonito_spciconf_read "TARGET_FMT_plx" size %d\n", addr, size);
 
     pciaddr = bonito_sbridge_pciaddr(s, addr);
 
     if (pciaddr == 0xffffffff) {
-        return;
-    }
-
-    /* set the pci address in s->config_reg */
-    phb->config_reg = (pciaddr) | (1u << 31);
-    pci_data_write(phb->bus, phb->config_reg, val, 4);
-
-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT */
-    status = pci_get_word(d->config + PCI_STATUS);
-    status &= ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT);
-    pci_set_word(d->config + PCI_STATUS, status);
-}
-
-static uint32_t bonito_spciconf_readb(void *opaque, hwaddr addr)
-{
-    PCIBonitoState *s = opaque;
-    PCIDevice *d = PCI_DEVICE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
-    uint32_t pciaddr;
-    uint16_t status;
-
-    DPRINTF("bonito_spciconf_readb "TARGET_FMT_plx"\n", addr);
-    pciaddr = bonito_sbridge_pciaddr(s, addr);
-
-    if (pciaddr == 0xffffffff) {
-        return 0xff;
+        return MAKE_64BIT_MASK(0, size * 8);
     }
 
     /* set the pci address in s->config_reg */
@@ -565,79 +512,17 @@ static uint32_t bonito_spciconf_readb(void *opaque, hwaddr addr)
     status &= ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT);
     pci_set_word(d->config + PCI_STATUS, status);
 
-    return pci_data_read(phb->bus, phb->config_reg, 1);
-}
-
-static uint32_t bonito_spciconf_readw(void *opaque, hwaddr addr)
-{
-    PCIBonitoState *s = opaque;
-    PCIDevice *d = PCI_DEVICE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
-    uint32_t pciaddr;
-    uint16_t status;
-
-    DPRINTF("bonito_spciconf_readw "TARGET_FMT_plx"\n", addr);
-    assert((addr & 0x1) == 0);
-
-    pciaddr = bonito_sbridge_pciaddr(s, addr);
-
-    if (pciaddr == 0xffffffff) {
-        return 0xffff;
-    }
-
-    /* set the pci address in s->config_reg */
-    phb->config_reg = (pciaddr) | (1u << 31);
-
-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT */
-    status = pci_get_word(d->config + PCI_STATUS);
-    status &= ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT);
-    pci_set_word(d->config + PCI_STATUS, status);
-
-    return pci_data_read(phb->bus, phb->config_reg, 2);
-}
-
-static uint32_t bonito_spciconf_readl(void *opaque, hwaddr addr)
-{
-    PCIBonitoState *s = opaque;
-    PCIDevice *d = PCI_DEVICE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
-    uint32_t pciaddr;
-    uint16_t status;
-
-    DPRINTF("bonito_spciconf_readl "TARGET_FMT_plx"\n", addr);
-    assert((addr & 0x3) == 0);
-
-    pciaddr = bonito_sbridge_pciaddr(s, addr);
-
-    if (pciaddr == 0xffffffff) {
-        return 0xffffffff;
-    }
-
-    /* set the pci address in s->config_reg */
-    phb->config_reg = (pciaddr) | (1u << 31);
-
-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT */
-    status = pci_get_word(d->config + PCI_STATUS);
-    status &= ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT);
-    pci_set_word(d->config + PCI_STATUS, status);
-
-    return pci_data_read(phb->bus, phb->config_reg, 4);
+    return pci_data_read(phb->bus, phb->config_reg, size);
 }
 
 /* south bridge PCI configure space. 0x1fe8 0000 - 0x1fef ffff */
 static const MemoryRegionOps bonito_spciconf_ops = {
-    .old_mmio = {
-        .read = {
-            bonito_spciconf_readb,
-            bonito_spciconf_readw,
-            bonito_spciconf_readl,
-        },
-        .write = {
-            bonito_spciconf_writeb,
-            bonito_spciconf_writew,
-            bonito_spciconf_writel,
-        },
-    },
+    .read = bonito_spciconf_read,
+    .write = bonito_spciconf_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.1
