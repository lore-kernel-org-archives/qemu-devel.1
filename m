Received: from eggs.gnu.org ([2001:4830:134:3::10]:50278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1U-00079M-Uh
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1T-0007b6-M3
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:36 -0500
Received: from [59.151.112.132] (port=64480 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1T-0007Ql-9j
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:35 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 14:18:47 +0800
Message-ID: <1484633936-25344-3-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 02/11] hcd-xhci: check & correct param
 before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

usb_xhci_realize() corrects invalid values of property "intrs"
automatically, but the uncorrected value is passed to msi_init(),
which chokes on invalid values.  Delay that until after the
correction.

Resources allocated by usb_xhci_init() are leaked when msi_init()
fails.  Fix by calling it after msi_init().

CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/usb/hcd-xhci.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4acf0c6dd8c0..0ace273da472 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3627,25 +3627,6 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
     dev->config[0x60] = 0x30; /* release number */
 
-    usb_xhci_init(xhci);
-
-    if (xhci->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0x70, xhci->numintrs, true, false, &err);
-        /* Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error */
-        assert(!ret || ret == -ENOTSUP);
-        if (ret && xhci->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&err, "You have to use msi=auto (default) or "
-                    "msi=off with this machine type.\n");
-            error_propagate(errp, err);
-            return;
-        }
-        assert(!err || xhci->msi == ON_OFF_AUTO_AUTO);
-        /* With msi=auto, we fall back to MSI off silently */
-        error_free(err);
-    }
-
     if (xhci->numintrs > MAXINTRS) {
         xhci->numintrs = MAXINTRS;
     }
@@ -3667,6 +3648,24 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
         xhci->max_pstreams_mask = 0;
     }
 
+    if (xhci->msi != ON_OFF_AUTO_OFF) {
+        ret = msi_init(dev, 0x70, xhci->numintrs, true, false, &err);
+        /* Any error other than -ENOTSUP(board's MSI support is broken)
+         * is a programming error */
+        assert(!ret || ret == -ENOTSUP);
+        if (ret && xhci->msi == ON_OFF_AUTO_ON) {
+            /* Can't satisfy user's explicit msi=on request, fail */
+            error_append_hint(&err, "You have to use msi=auto (default) or "
+                    "msi=off with this machine type.\n");
+            error_propagate(errp, err);
+            return;
+        }
+        assert(!err || xhci->msi == ON_OFF_AUTO_AUTO);
+        /* With msi=auto, we fall back to MSI off silently */
+        error_free(err);
+    }
+
+    usb_xhci_init(xhci);
     xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
 
     memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
-- 
2.1.0
