Received: from eggs.gnu.org ([2001:4830:134:3::10]:46689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZXiv-0006CO-Sk
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 01:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZXis-0007Lt-Ry
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 01:51:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZXis-0007Lf-JS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 01:51:54 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  3 Feb 2017 07:51:45 +0100
Message-Id: <1486104705-13761-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] xhci: fix event queue IRQ handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, M.Cerveny@computer.org, 1373228@bugs.launchpad.net

The qemu xhci emulation doesn't handle the ERDP_EHB flag correctly.

When the host adapter queues a new event the ERDP_EHB flag is set.  The
flag is cleared (via w1c) by the guest when it updates the ERDP (event
ring dequeue pointer) register to notify the host adapter which events
it has fetched.

An IRQ must raised in case the ERDP_EHB flag flips from clear to set.
If the flag is set already (which implies there are events queued up
which are not yet processed by the guest) xhci must *not* raise a IRQ.

Qemu got that wrong and raised an IRQ on every event, thereby generating
suspious interrupts in case we've queued events faster than the guest
processed them.  This patch fixes that.

With that change in place we also have to check ERDP updates, to see
whenever the guest has fetched all queued events.  In case there are
still pending events set ERDP_EHB and raise an IRQ again, to make sure
the events don't linger unseen forever.

The linux kernel driver and the microsoft windows driver (shipped with
win8+) can deal with the suspious interrupts without problems.  The
renesas windows driver (v2.1.39) which can be used on older windows
versions is quite upset though.  It does suspious ERDP updates now and
then (not every time, seems we must hit a race window for this to
happen), which in turn makes the qemu xhci emulation think the event
ring is full.  Things go south from here ...

tl;dr: This is the "fix xhci on win7" patch.

Cc: M.Cerveny@computer.org
Cc: 1373228@bugs.launchpad.net
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index df75907..4f05747 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -789,11 +789,15 @@ static void xhci_msix_update(XHCIState *xhci, int v)
 static void xhci_intr_raise(XHCIState *xhci, int v)
 {
     PCIDevice *pci_dev = PCI_DEVICE(xhci);
+    bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
 
     xhci->intr[v].erdp_low |= ERDP_EHB;
     xhci->intr[v].iman |= IMAN_IP;
     xhci->usbsts |= USBSTS_EINT;
 
+    if (pending) {
+        return;
+    }
     if (!(xhci->intr[v].iman & IMAN_IE)) {
         return;
     }
@@ -3352,6 +3356,15 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
             intr->erdp_low &= ~ERDP_EHB;
         }
         intr->erdp_low = (val & ~ERDP_EHB) | (intr->erdp_low & ERDP_EHB);
+        if (val & ERDP_EHB) {
+            dma_addr_t erdp = xhci_addr64(intr->erdp_low, intr->erdp_high);
+            unsigned int dp_idx = (erdp - intr->er_start) / TRB_SIZE;
+            if (erdp >= intr->er_start &&
+                erdp < (intr->er_start + TRB_SIZE * intr->er_size) &&
+                dp_idx != intr->er_ep_idx) {
+                xhci_intr_raise(xhci, v);
+            }
+        }
         break;
     case 0x1c: /* ERDP high */
         intr->erdp_high = val;
-- 
1.8.3.1
