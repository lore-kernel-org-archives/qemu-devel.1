Received: from eggs.gnu.org ([2001:4830:134:3::10]:59257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gc-0002yg-4R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gZ-00087J-VP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4gZ-00086x-NL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:31 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF1F5C04BD40
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:16:31 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:21 +0100
Message-Id: <1487661385-7720-8-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] xhci: fix nec vendor quirk handling
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

Only the TYPE_NEC_XHCI controller will have the nec vendor quirks.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1486382139-30630-4-git-send-email-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index c534b43..4ac67ae 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -487,6 +487,8 @@ struct XHCIState {
     XHCIInterrupter intr[MAXINTRS];
 
     XHCIRing cmd_ring;
+
+    bool nec_quirks;
 };
 
 #define TYPE_XHCI "base-xhci"
@@ -2745,20 +2747,26 @@ static void xhci_process_commands(XHCIState *xhci)
             xhci_via_challenge(xhci, trb.parameter);
             break;
         case CR_VENDOR_NEC_FIRMWARE_REVISION:
-            event.type = 48; /* NEC reply */
-            event.length = 0x3025;
+            if (xhci->nec_quirks) {
+                event.type = 48; /* NEC reply */
+                event.length = 0x3025;
+            } else {
+                event.ccode = CC_TRB_ERROR;
+            }
             break;
         case CR_VENDOR_NEC_CHALLENGE_RESPONSE:
-        {
-            uint32_t chi = trb.parameter >> 32;
-            uint32_t clo = trb.parameter;
-            uint32_t val = xhci_nec_challenge(chi, clo);
-            event.length = val & 0xFFFF;
-            event.epid = val >> 16;
-            slotid = val >> 24;
-            event.type = 48; /* NEC reply */
-        }
-        break;
+            if (xhci->nec_quirks) {
+                uint32_t chi = trb.parameter >> 32;
+                uint32_t clo = trb.parameter;
+                uint32_t val = xhci_nec_challenge(chi, clo);
+                event.length = val & 0xFFFF;
+                event.epid = val >> 16;
+                slotid = val >> 24;
+                event.type = 48; /* NEC reply */
+            } else {
+                event.ccode = CC_TRB_ERROR;
+            }
+            break;
         default:
             trace_usb_xhci_unimplemented("command", type);
             event.ccode = CC_TRB_ERROR;
@@ -3265,9 +3273,12 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
         intr->erstsz = val & 0xffff;
         break;
     case 0x10: /* ERSTBA low */
-        /* XXX NEC driver bug: it doesn't align this to 64 bytes
-        intr->erstba_low = val & 0xffffffc0; */
-        intr->erstba_low = val & 0xfffffff0;
+        if (xhci->nec_quirks) {
+            /* NEC driver bug: it doesn't align this to 64 bytes */
+            intr->erstba_low = val & 0xfffffff0;
+        } else {
+            intr->erstba_low = val & 0xffffffc0;
+        }
         break;
     case 0x14: /* ERSTBA high */
         intr->erstba_high = val;
@@ -3562,6 +3573,9 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
     dev->config[0x60] = 0x30; /* release number */
 
+    if (strcmp(object_get_typename(OBJECT(dev)), TYPE_NEC_XHCI) == 0) {
+        xhci->nec_quirks = true;
+    }
     if (xhci->numintrs > MAXINTRS) {
         xhci->numintrs = MAXINTRS;
     }
-- 
1.8.3.1
