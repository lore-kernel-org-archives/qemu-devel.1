Received: from eggs.gnu.org ([2001:4830:134:3::10]:50295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahtc-0006mI-No
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahtZ-00043n-O3
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cahtZ-00043B-Fh
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97235C05678D
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 11:55:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Feb 2017 12:55:36 +0100
Message-Id: <1486382139-30630-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486382139-30630-1-git-send-email-kraxel@redhat.com>
References: <1486382139-30630-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] xhci: drop ER_FULL_HACK workaround
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

The nec/renesas driver problems have finally been debugged and root
caused, see commit "7da76e1 xhci: fix event queue IRQ handling".

It's pretty clear now that
 (a) The whole "driver can't handle ring full" story is most likely
     wrong.
 (b) The ER_FULL_HACK workaround based on the false assumtion doesn't
     much.  It avoids the driver crashing (without commit 7da76e1), but
     it doesn't make usb work.
 (c) With 7da76e1 applied it doesn't trigger any more.

So, lets kill it.  Or, to be exact, lets almost kill it.  Some data
fields are kept unused in the state struct, for live migration backward
compatibility.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 117 +++++-------------------------------------------------
 1 file changed, 11 insertions(+), 106 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 54b3901..74184ac 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -49,9 +49,6 @@
 
 /* Very pessimistic, let's hope it's enough for all cases */
 #define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
-/* Do not deliver ER Full events. NEC's driver does some things not bound
- * to the specs when it gets them */
-#define ER_FULL_HACK
 
 #define TRB_LINK_LIMIT  4
 
@@ -431,12 +428,14 @@ typedef struct XHCIInterrupter {
     uint32_t erdp_low;
     uint32_t erdp_high;
 
-    bool msix_used, er_pcs, er_full;
+    bool msix_used, er_pcs;
 
     dma_addr_t er_start;
     uint32_t er_size;
     unsigned int er_ep_idx;
 
+    /* kept for live migration compat only */
+    bool er_full_unused;
     XHCIEvent ev_buffer[EV_QUEUE];
     unsigned int ev_buffer_put;
     unsigned int ev_buffer_get;
@@ -826,7 +825,7 @@ static void xhci_intr_raise(XHCIState *xhci, int v)
 
 static inline int xhci_running(XHCIState *xhci)
 {
-    return !(xhci->usbsts & USBSTS_HCH) && !xhci->intr[0].er_full;
+    return !(xhci->usbsts & USBSTS_HCH);
 }
 
 static void xhci_die(XHCIState *xhci)
@@ -865,74 +864,6 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
     }
 }
 
-static void xhci_events_update(XHCIState *xhci, int v)
-{
-    XHCIInterrupter *intr = &xhci->intr[v];
-    dma_addr_t erdp;
-    unsigned int dp_idx;
-    bool do_irq = 0;
-
-    if (xhci->usbsts & USBSTS_HCH) {
-        return;
-    }
-
-    erdp = xhci_addr64(intr->erdp_low, intr->erdp_high);
-    if (erdp < intr->er_start ||
-        erdp >= (intr->er_start + TRB_SIZE*intr->er_size)) {
-        DPRINTF("xhci: ERDP out of bounds: "DMA_ADDR_FMT"\n", erdp);
-        DPRINTF("xhci: ER[%d] at "DMA_ADDR_FMT" len %d\n",
-                v, intr->er_start, intr->er_size);
-        xhci_die(xhci);
-        return;
-    }
-    dp_idx = (erdp - intr->er_start) / TRB_SIZE;
-    assert(dp_idx < intr->er_size);
-
-    /* NEC didn't read section 4.9.4 of the spec (v1.0 p139 top Note) and thus
-     * deadlocks when the ER is full. Hack it by holding off events until
-     * the driver decides to free at least half of the ring */
-    if (intr->er_full) {
-        int er_free = dp_idx - intr->er_ep_idx;
-        if (er_free <= 0) {
-            er_free += intr->er_size;
-        }
-        if (er_free < (intr->er_size/2)) {
-            DPRINTF("xhci_events_update(): event ring still "
-                    "more than half full (hack)\n");
-            return;
-        }
-    }
-
-    while (intr->ev_buffer_put != intr->ev_buffer_get) {
-        assert(intr->er_full);
-        if (((intr->er_ep_idx+1) % intr->er_size) == dp_idx) {
-            DPRINTF("xhci_events_update(): event ring full again\n");
-#ifndef ER_FULL_HACK
-            XHCIEvent full = {ER_HOST_CONTROLLER, CC_EVENT_RING_FULL_ERROR};
-            xhci_write_event(xhci, &full, v);
-#endif
-            do_irq = 1;
-            break;
-        }
-        XHCIEvent *event = &intr->ev_buffer[intr->ev_buffer_get];
-        xhci_write_event(xhci, event, v);
-        intr->ev_buffer_get++;
-        do_irq = 1;
-        if (intr->ev_buffer_get == EV_QUEUE) {
-            intr->ev_buffer_get = 0;
-        }
-    }
-
-    if (do_irq) {
-        xhci_intr_raise(xhci, v);
-    }
-
-    if (intr->er_full && intr->ev_buffer_put == intr->ev_buffer_get) {
-        DPRINTF("xhci_events_update(): event ring no longer full\n");
-        intr->er_full = 0;
-    }
-}
-
 static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
 {
     XHCIInterrupter *intr;
@@ -945,19 +876,6 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     }
     intr = &xhci->intr[v];
 
-    if (intr->er_full) {
-        DPRINTF("xhci_event(): ER full, queueing\n");
-        if (((intr->ev_buffer_put+1) % EV_QUEUE) == intr->ev_buffer_get) {
-            DPRINTF("xhci: event queue full, dropping event!\n");
-            return;
-        }
-        intr->ev_buffer[intr->ev_buffer_put++] = *event;
-        if (intr->ev_buffer_put == EV_QUEUE) {
-            intr->ev_buffer_put = 0;
-        }
-        return;
-    }
-
     erdp = xhci_addr64(intr->erdp_low, intr->erdp_high);
     if (erdp < intr->er_start ||
         erdp >= (intr->er_start + TRB_SIZE*intr->er_size)) {
@@ -971,21 +889,12 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     dp_idx = (erdp - intr->er_start) / TRB_SIZE;
     assert(dp_idx < intr->er_size);
 
-    if ((intr->er_ep_idx+1) % intr->er_size == dp_idx) {
-        DPRINTF("xhci_event(): ER full, queueing\n");
-#ifndef ER_FULL_HACK
+    if ((intr->er_ep_idx + 2) % intr->er_size == dp_idx) {
+        DPRINTF("xhci: ER %d full, send ring full error\n", v);
         XHCIEvent full = {ER_HOST_CONTROLLER, CC_EVENT_RING_FULL_ERROR};
-        xhci_write_event(xhci, &full);
-#endif
-        intr->er_full = 1;
-        if (((intr->ev_buffer_put+1) % EV_QUEUE) == intr->ev_buffer_get) {
-            DPRINTF("xhci: event queue full, dropping event!\n");
-            return;
-        }
-        intr->ev_buffer[intr->ev_buffer_put++] = *event;
-        if (intr->ev_buffer_put == EV_QUEUE) {
-            intr->ev_buffer_put = 0;
-        }
+        xhci_write_event(xhci, &full, v);
+    } else if ((intr->er_ep_idx + 1) % intr->er_size == dp_idx) {
+        DPRINTF("xhci: ER %d full, drop event\n", v);
     } else {
         xhci_write_event(xhci, event, v);
     }
@@ -1124,7 +1033,6 @@ static void xhci_er_reset(XHCIState *xhci, int v)
 
     intr->er_ep_idx = 0;
     intr->er_pcs = 1;
-    intr->er_full = 0;
 
     DPRINTF("xhci: event ring[%d]:" DMA_ADDR_FMT " [%d]\n",
             v, intr->er_start, intr->er_size);
@@ -2978,7 +2886,6 @@ static void xhci_reset(DeviceState *dev)
 
         xhci->intr[i].er_ep_idx = 0;
         xhci->intr[i].er_pcs = 1;
-        xhci->intr[i].er_full = 0;
         xhci->intr[i].ev_buffer_put = 0;
         xhci->intr[i].ev_buffer_get = 0;
     }
@@ -3368,7 +3275,6 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
         break;
     case 0x1c: /* ERDP high */
         intr->erdp_high = val;
-        xhci_events_update(xhci, v);
         break;
     default:
         trace_usb_xhci_unimplemented("oper write", reg);
@@ -3866,8 +3772,7 @@ static const VMStateDescription vmstate_xhci_event = {
 
 static bool xhci_er_full(void *opaque, int version_id)
 {
-    struct XHCIInterrupter *intr = opaque;
-    return intr->er_full;
+    return false;
 }
 
 static const VMStateDescription vmstate_xhci_intr = {
@@ -3891,7 +3796,7 @@ static const VMStateDescription vmstate_xhci_intr = {
         VMSTATE_UINT32(er_ep_idx,     XHCIInterrupter),
 
         /* event queue (used if ring is full) */
-        VMSTATE_BOOL(er_full,         XHCIInterrupter),
+        VMSTATE_BOOL(er_full_unused,  XHCIInterrupter),
         VMSTATE_UINT32_TEST(ev_buffer_put, XHCIInterrupter, xhci_er_full),
         VMSTATE_UINT32_TEST(ev_buffer_get, XHCIInterrupter, xhci_er_full),
         VMSTATE_STRUCT_ARRAY_TEST(ev_buffer, XHCIInterrupter, EV_QUEUE,
-- 
1.8.3.1
