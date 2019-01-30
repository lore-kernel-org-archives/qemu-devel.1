Received: from eggs.gnu.org ([209.51.188.92]:45536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOT-0004v9-FB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOR-00078L-TW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOR-00074h-Fg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:43 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:23 +0100
Message-Id: <20190130073426.11525-6-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] usb: implement XHCI underrun/overrun events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Yuri Benditovich <yuri.benditovich@janustech.com>

From: Yuri Benditovich <yuri.benditovich@janustech.com>

Implement underrun/overrun events of isochronous endpoints
according to XHCI spec (4.10.3.1)
Guest software restarts data streaming when receives these events.
The XHCI reports these events using interrupter assigned
to the slot (as these events do not have TRB), so current
commit adds the field of assigned interrupter to the
XHCISlot structure. Guest software assigns interrupter to the
slot on 'Address Device' and 'Evaluate Context' commands.

Signed-off-by: Yuri Benditovich <yuri.benditovich@janustech.com>
Message-id: 20190128200444.5128-3-yuri.benditovich@janustech.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.h |  1 +
 hw/usb/hcd-xhci.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index fc36a4c787..240caa4e51 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -140,6 +140,7 @@ typedef struct XHCIPort {
 typedef struct XHCISlot {
     bool enabled;
     bool addressed;
+    uint16_t intr;
     dma_addr_t ctx;
     USBPort *uport;
     XHCIEPContext *eps[31];
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 1a8fd9644e..19c64f7ff4 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1949,6 +1949,16 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
     while (1) {
         length = xhci_ring_chain_length(xhci, ring);
         if (length <= 0) {
+            if (epctx->type == ET_ISO_OUT || epctx->type == ET_ISO_IN) {
+                /* 4.10.3.1 */
+                XHCIEvent ev = { ER_TRANSFER };
+                ev.ccode  = epctx->type == ET_ISO_IN ?
+                    CC_RING_OVERRUN : CC_RING_UNDERRUN;
+                ev.slotid = epctx->slotid;
+                ev.epid   = epctx->epid;
+                ev.ptr    = epctx->ring.dequeue;
+                xhci_event(xhci, &ev, xhci->slots[epctx->slotid-1].intr);
+            }
             break;
         }
         xfer = xhci_ep_alloc_xfer(epctx, length);
@@ -2028,6 +2038,7 @@ static TRBCCode xhci_disable_slot(XHCIState *xhci, unsigned int slotid)
     xhci->slots[slotid-1].enabled = 0;
     xhci->slots[slotid-1].addressed = 0;
     xhci->slots[slotid-1].uport = NULL;
+    xhci->slots[slotid-1].intr = 0;
     return CC_SUCCESS;
 }
 
@@ -2127,6 +2138,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
     slot = &xhci->slots[slotid-1];
     slot->uport = uport;
     slot->ctx = octx;
+    slot->intr = get_field(slot_ctx[2], TRB_INTR);
 
     /* Make sure device is in USB_STATE_DEFAULT state */
     usb_device_reset(dev);
@@ -2300,8 +2312,9 @@ static TRBCCode xhci_evaluate_slot(XHCIState *xhci, unsigned int slotid,
 
         slot_ctx[1] &= ~0xFFFF; /* max exit latency */
         slot_ctx[1] |= islot_ctx[1] & 0xFFFF;
-        slot_ctx[2] &= ~0xFF00000; /* interrupter target */
-        slot_ctx[2] |= islot_ctx[2] & 0xFF000000;
+        /* update interrupter target field */
+        xhci->slots[slotid-1].intr = get_field(islot_ctx[2], TRB_INTR);
+        set_field(&slot_ctx[2], xhci->slots[slotid-1].intr, TRB_INTR);
 
         DPRINTF("xhci: output slot context: %08x %08x %08x %08x\n",
                 slot_ctx[0], slot_ctx[1], slot_ctx[2], slot_ctx[3]);
-- 
2.9.3
