Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWeFt-0007If-Rx
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWeFs-0001ml-4F
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:44528
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fWeFr-0001kl-UD
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:48 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 23 Jun 2018 09:50:28 +0100
Message-Id: <20180623085028.29553-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] pci: allow DeviceClass fw_name to override
 pci_dev_fw_name() if set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, marcel@redhat.com, armbru@redhat.com, mst@redhat.com

The current implementation of pci_dev_fw_name() scans through a fixed
set of PCI class descriptions to determine the firmware device name
but in some cases this isn't always appropriate, for example with
the macio device which uses a class code of 0xff (unassigned).

Rather than add a new entry for the macio device and risk a potential
clash with another unassigned device later, add a check to
pcibus_get_fw_dev_path() that will use DeviceClass fw_name if set in
preference to pci_dev_fw_name().

This enables PCI devices such as macio to set dc->fw_name as required
to match the name specified in the firmware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 80bc45930d..126dd683dc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2411,12 +2411,14 @@ static char *pci_dev_fw_name(DeviceState *dev, char *buf, int len)
 
 static char *pcibus_get_fw_dev_path(DeviceState *dev)
 {
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
     PCIDevice *d = (PCIDevice *)dev;
     char path[50], name[33];
     int off;
 
     off = snprintf(path, sizeof(path), "%s@%x",
-                   pci_dev_fw_name(dev, name, sizeof name),
+                   dc->fw_name ? dc->fw_name :
+                       pci_dev_fw_name(dev, name, sizeof name),
                    PCI_SLOT(d->devfn));
     if (PCI_FUNC(d->devfn))
         snprintf(path + off, sizeof(path) + off, ",%x", PCI_FUNC(d->devfn));
-- 
2.11.0
