Received: from eggs.gnu.org ([2001:4830:134:3::10]:50297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahtc-0006mL-O4
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahtZ-00043g-NF
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cahtZ-000438-Fi
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:45 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54E5D7E9D5
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 11:55:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Feb 2017 12:55:38 +0100
Message-Id: <1486382139-30630-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486382139-30630-1-git-send-email-kraxel@redhat.com>
References: <1486382139-30630-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] xhci: fix nec vendor quirk handling
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
---
 hw/usb/hcd-xhci.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 887bb39..0e25943 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -485,6 +485,8 @@ struct XHCIState {
     XHCIInterrupter intr[MAXINTRS];
 
     XHCIRing cmd_ring;
+
+    bool nec_quirks;
 };
 
 #define TYPE_XHCI "base-xhci"
@@ -2737,20 +2739,26 @@ static void xhci_process_commands(XHCIState *xhci)
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
@@ -3252,9 +3260,12 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
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
@@ -3549,6 +3560,9 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
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
