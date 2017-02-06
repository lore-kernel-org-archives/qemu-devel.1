Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1caiIJ-0004kl-GF
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1caiIF-0006Kl-J0
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:21:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1caiIF-0006KL-BD
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:21:15 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1BC581252
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 12:21:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Feb 2017 13:21:09 +0100
Message-Id: <1486383669-6421-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] xhci: apply limits to loops
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

Limits should be big enough that normal guest should not hit it.
Add a tracepoint to log them, just in case.  Also, while being
at it, log the existing link trb limit too.

Reported-by: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c   | 15 ++++++++++++++-
 hw/usb/trace-events |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index fbf8a8b..28dd2f2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -51,6 +51,8 @@
 #define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
=20
 #define TRB_LINK_LIMIT  4
+#define COMMAND_LIMIT   256
+#define TRANSFER_LIMIT  256
=20
 #define LEN_CAP         0x40
 #define LEN_OPER        (0x400 + 0x10 * MAXPORTS)
@@ -943,6 +945,7 @@ static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIR=
ing *ring, XHCITRB *trb,
             return type;
         } else {
             if (++link_cnt > TRB_LINK_LIMIT) {
+                trace_usb_xhci_enforced_limit("trb-link");
                 return 0;
             }
             ring->dequeue =3D xhci_mask64(trb->parameter);
@@ -2060,6 +2063,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, u=
nsigned int streamid)
     XHCIRing *ring;
     USBEndpoint *ep =3D NULL;
     uint64_t mfindex;
+    unsigned int count =3D 0;
     int length;
     int i;
=20
@@ -2172,6 +2176,10 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, =
unsigned int streamid)
             epctx->retry =3D xfer;
             break;
         }
+        if (count++ > TRANSFER_LIMIT) {
+            trace_usb_xhci_enforced_limit("transfers");
+            break;
+        }
     }
     epctx->kick_active--;
=20
@@ -2618,7 +2626,7 @@ static void xhci_process_commands(XHCIState *xhci)
     TRBType type;
     XHCIEvent event =3D {ER_COMMAND_COMPLETE, CC_SUCCESS};
     dma_addr_t addr;
-    unsigned int i, slotid =3D 0;
+    unsigned int i, slotid =3D 0, count =3D 0;
=20
     DPRINTF("xhci_process_commands()\n");
     if (!xhci_running(xhci)) {
@@ -2735,6 +2743,11 @@ static void xhci_process_commands(XHCIState *xhci)
         }
         event.slotid =3D slotid;
         xhci_event(xhci, &event, 0);
+
+        if (count++ > COMMAND_LIMIT) {
+            trace_usb_xhci_enforced_limit("commands");
+            return;
+        }
     }
 }
=20
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index fdd1d29..0c323d4 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -174,6 +174,7 @@ usb_xhci_xfer_retry(void *xfer) "%p"
 usb_xhci_xfer_success(void *xfer, uint32_t bytes) "%p: len %d"
 usb_xhci_xfer_error(void *xfer, uint32_t ret) "%p: ret %d"
 usb_xhci_unimplemented(const char *item, int nr) "%s (0x%x)"
+usb_xhci_enforced_limit(const char *item) "%s"
=20
 # hw/usb/desc.c
 usb_desc_device(int addr, int len, int ret) "dev %d query device, len %d=
, ret %d"
--=20
1.8.3.1
