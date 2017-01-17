Received: from eggs.gnu.org ([2001:4830:134:3::10]:50353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1X-00079w-0a
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1W-0007cd-2E
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:38 -0500
Received: from [59.151.112.132] (port=54479 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1V-0007T8-Eg
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:38 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 14:18:51 +0800
Message-ID: <1484633936-25344-7-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 06/11] hcd-xhci: change behaviour of msix
 switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Resolve the TODO, msix=auto means msix on; if user specify msix=on,
then device creation fail on msix_init failure.

CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/usb/hcd-xhci.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index fe64dd8525c7..aaca57cb5f1f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3636,12 +3636,14 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     if (xhci->numintrs < 1) {
         xhci->numintrs = 1;
     }
+
     if (xhci->numslots > MAXSLOTS) {
         xhci->numslots = MAXSLOTS;
     }
     if (xhci->numslots < 1) {
         xhci->numslots = 1;
     }
+
     if (xhci_get_flag(xhci, XHCI_FLAG_ENABLE_STREAMS)) {
         xhci->max_pstreams_mask = 7; /* == 256 primary streams */
     } else {
@@ -3669,6 +3671,28 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
 
     memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
+    if (xhci->msix != ON_OFF_AUTO_OFF) {
+        ret = msix_init(dev, xhci->numintrs,
+                        &xhci->mem, 0, OFF_MSIX_TABLE,
+                        &xhci->mem, 0, OFF_MSIX_PBA,
+                        0x90, &err);
+        /* Any error other than -ENOTSUP(board's MSI support is broken)
+         * is a programming error */
+        assert(!ret || ret == -ENOTSUP);
+        if (ret && xhci->msix == ON_OFF_AUTO_ON) {
+            /* Can't satisfy user's explicit msix=on request, fail */
+            error_append_hint(&err, "You have to use msix=auto (default) or "
+                    "msix=off with this machine type.\n");
+            /* No instance_finalize method, need to free the resource here */
+            object_unref(OBJECT(&xhci->mem));
+            error_propagate(errp, err);
+            return;
+        }
+        assert(!err || xhci->msix == ON_OFF_AUTO_AUTO);
+        /* With msix=auto, we fall back to MSI off silently */
+        error_free(err);
+    }
+
     memory_region_init_io(&xhci->mem_cap, OBJECT(xhci), &xhci_cap_ops, xhci,
                           "capabilities", LEN_CAP);
     memory_region_init_io(&xhci->mem_oper, OBJECT(xhci), &xhci_oper_ops, xhci,
@@ -3701,14 +3725,6 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
         ret = pcie_endpoint_cap_init(dev, 0xa0);
         assert(ret >= 0);
     }
-
-    if (xhci->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, xhci->numintrs,
-                  &xhci->mem, 0, OFF_MSIX_TABLE,
-                  &xhci->mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
-    }
 }
 
 static void usb_xhci_exit(PCIDevice *dev)
-- 
2.1.0
