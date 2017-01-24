Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9i3-0008SM-MO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9i0-0005vG-JD
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:37:03 -0500
Received: from mail.kernel.org ([198.145.29.136]:37406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9i0-0005v8-9p
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:37:00 -0500
Date: Wed, 25 Jan 2017 00:36:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485297322-10595-13-git-send-email-mst@redhat.com>
References: <1485297322-10595-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485297322-10595-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/16] hcd-xhci: check & correct param before
 using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/usb/hcd-xhci.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4acf0c6..0ace273 100644
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
MST
