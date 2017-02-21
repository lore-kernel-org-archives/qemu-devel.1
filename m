Received: from eggs.gnu.org ([2001:4830:134:3::10]:59256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gc-0002yf-4c
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gZ-00087L-VK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4gZ-00086z-Pn
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:31 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E98912B24
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:16:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:22 +0100
Message-Id: <1487661385-7720-9-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/11] xhci: drop via vendor command handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Seems pretty pointless, we don't emulate an via xhci controller.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1486382139-30630-5-git-send-email-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4ac67ae..28dd2f2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -198,7 +198,6 @@ typedef enum TRBType {
     ER_DEVICE_NOTIFICATION,
     ER_MFINDEX_WRAP,
     /* vendor specific bits */
-    CR_VENDOR_VIA_CHALLENGE_RESPONSE = 48,
     CR_VENDOR_NEC_FIRMWARE_REVISION  = 49,
     CR_VENDOR_NEC_CHALLENGE_RESPONSE = 50,
 } TRBType;
@@ -554,7 +553,6 @@ static const char *TRBType_names[] = {
     [ER_HOST_CONTROLLER]               = "ER_HOST_CONTROLLER",
     [ER_DEVICE_NOTIFICATION]           = "ER_DEVICE_NOTIFICATION",
     [ER_MFINDEX_WRAP]                  = "ER_MFINDEX_WRAP",
-    [CR_VENDOR_VIA_CHALLENGE_RESPONSE] = "CR_VENDOR_VIA_CHALLENGE_RESPONSE",
     [CR_VENDOR_NEC_FIRMWARE_REVISION]  = "CR_VENDOR_NEC_FIRMWARE_REVISION",
     [CR_VENDOR_NEC_CHALLENGE_RESPONSE] = "CR_VENDOR_NEC_CHALLENGE_RESPONSE",
 };
@@ -2622,32 +2620,6 @@ static uint32_t xhci_nec_challenge(uint32_t hi, uint32_t lo)
     return ~val;
 }
 
-static void xhci_via_challenge(XHCIState *xhci, uint64_t addr)
-{
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
-    uint32_t buf[8];
-    uint32_t obuf[8];
-    dma_addr_t paddr = xhci_mask64(addr);
-
-    pci_dma_read(pci_dev, paddr, &buf, 32);
-
-    memcpy(obuf, buf, sizeof(obuf));
-
-    if ((buf[0] & 0xff) == 2) {
-        obuf[0] = 0x49932000 + 0x54dc200 * buf[2] + 0x7429b578 * buf[3];
-        obuf[0] |=  (buf[2] * buf[3]) & 0xff;
-        obuf[1] = 0x0132bb37 + 0xe89 * buf[2] + 0xf09 * buf[3];
-        obuf[2] = 0x0066c2e9 + 0x2091 * buf[2] + 0x19bd * buf[3];
-        obuf[3] = 0xd5281342 + 0x2cc9691 * buf[2] + 0x2367662 * buf[3];
-        obuf[4] = 0x0123c75c + 0x1595 * buf[2] + 0x19ec * buf[3];
-        obuf[5] = 0x00f695de + 0x26fd * buf[2] + 0x3e9 * buf[3];
-        obuf[6] = obuf[2] ^ obuf[3] ^ 0x29472956;
-        obuf[7] = obuf[2] ^ obuf[3] ^ 0x65866593;
-    }
-
-    pci_dma_write(pci_dev, paddr, &obuf, 32);
-}
-
 static void xhci_process_commands(XHCIState *xhci)
 {
     XHCITRB trb;
@@ -2743,9 +2715,6 @@ static void xhci_process_commands(XHCIState *xhci)
         case CR_GET_PORT_BANDWIDTH:
             event.ccode = xhci_get_port_bandwidth(xhci, trb.parameter);
             break;
-        case CR_VENDOR_VIA_CHALLENGE_RESPONSE:
-            xhci_via_challenge(xhci, trb.parameter);
-            break;
         case CR_VENDOR_NEC_FIRMWARE_REVISION:
             if (xhci->nec_quirks) {
                 event.type = 48; /* NEC reply */
-- 
1.8.3.1
