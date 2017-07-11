Received: from eggs.gnu.org ([2001:4830:134:3::10]:56354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36L-0001Jq-Do
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36K-0005OK-LV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35131
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36K-0005Nc-DY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:48 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:24 +0100
Message-Id: <1499810007-28613-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/8] apb: fix endianness for APB and PCI config
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 622c341..5ad7678 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -561,7 +561,7 @@ static uint64_t apb_config_readl (void *opaque,
 static const MemoryRegionOps apb_config_ops = {
     .read = apb_config_readl,
     .write = apb_config_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void apb_pci_config_write(void *opaque, hwaddr addr,
@@ -570,7 +570,6 @@ static void apb_pci_config_write(void *opaque, hwaddr addr,
     APBState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
-    val = qemu_bswap_len(val, size);
     APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
     pci_data_write(phb->bus, addr, val, size);
 }
@@ -583,7 +582,6 @@ static uint64_t apb_pci_config_read(void *opaque, hwaddr addr,
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
     ret = pci_data_read(phb->bus, addr, size);
-    ret = qemu_bswap_len(ret, size);
     APB_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, ret);
     return ret;
 }
@@ -744,7 +742,7 @@ static void pci_pbm_reset(DeviceState *d)
 static const MemoryRegionOps pci_config_ops = {
     .read = apb_pci_config_read,
     .write = apb_pci_config_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static int pci_pbm_init_device(SysBusDevice *dev)
-- 
1.7.10.4
