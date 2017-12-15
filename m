Received: from eggs.gnu.org ([2001:4830:134:3::10]:42845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrG-0002qG-Hh
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrD-00064o-MD
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ePdrD-00063l-DL
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:07 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 14 Dec 2017 16:28:01 -0800
Message-Id: <1513297683-14295-4-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1513297683-14295-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
	<1513297683-14295-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 4/6] xenfb: Add [feature|request]-raw-pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Owen Smith <owen.smith@citrix.com>

From: Owen Smith <owen.smith@citrix.com>

Writes "feature-raw-pointer" during init to indicate the backend
can pass raw unscaled values for absolute axes to the frontend.
Frontends set "request-raw-pointer" to indicate the backend should
not attempt to scale absolute values to console size.
"request-raw-pointer" is only valid if "request-abs-pointer" is
also set. Raw unscaled pointer values are in the range [0, 0x7fff]

"feature-raw-pointer" and "request-raw-pointer" added to Xen
header in commit 7868654ff7fe5e4a2eeae2b277644fa884a5031e

Signed-off-by: Owen Smith <owen.smith@citrix.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/display/xenfb.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index ed06efa..776a2ce 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -52,6 +52,7 @@ struct common {
 struct XenInput {
     struct common c;
     int abs_pointer_wanted; /* Whether guest supports absolute pointer */
+    int raw_pointer_wanted; /* Whether guest supports raw (unscaled) pointer */
     QemuInputHandlerState *qkbd;
     QemuInputHandlerState *qmou;
     int axis[INPUT_AXIS__MAX];
@@ -264,24 +265,28 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
 
     case INPUT_EVENT_KIND_ABS:
         move = evt->u.abs.data;
-        con = qemu_console_lookup_by_index(0);
-        if (!con) {
-            xen_pv_printf(&xenfb->c.xendev, 0, "No QEMU console available");
-            return;
-        }
-        surface = qemu_console_surface(con);
-        switch (move->axis) {
-        case INPUT_AXIS_X:
-            scale = surface_width(surface) - 1;
-            break;
-        case INPUT_AXIS_Y:
-            scale = surface_height(surface) - 1;
-            break;
-        default:
-            scale = 0x8000;
-            break;
+        if (xenfb->raw_pointer_wanted) {
+            xenfb->axis[move->axis] = move->value;
+        } else {
+            con = qemu_console_lookup_by_index(0);
+            if (!con) {
+                xen_pv_printf(&xenfb->c.xendev, 0, "No QEMU console available");
+                return;
+            }
+            surface = qemu_console_surface(con);
+            switch (move->axis) {
+            case INPUT_AXIS_X:
+                scale = surface_width(surface) - 1;
+                break;
+            case INPUT_AXIS_Y:
+                scale = surface_height(surface) - 1;
+                break;
+            default:
+                scale = 0x8000;
+                break;
+            }
+            xenfb->axis[move->axis] = move->value * scale / 0x7fff;
         }
-        xenfb->axis[move->axis] = move->value * scale / 0x7fff;
         break;
 
     case INPUT_EVENT_KIND_REL:
@@ -339,6 +344,7 @@ static QemuInputHandler xenfb_rel_mouse = {
 static int input_init(struct XenDevice *xendev)
 {
     xenstore_write_be_int(xendev, "feature-abs-pointer", 1);
+    xenstore_write_be_int(xendev, "feature-raw-pointer", 1);
     return 0;
 }
 
@@ -362,6 +368,13 @@ static void input_connected(struct XenDevice *xendev)
                              &in->abs_pointer_wanted) == -1) {
         in->abs_pointer_wanted = 0;
     }
+    if (xenstore_read_fe_int(xendev, "request-raw-pointer",
+                             &in->raw_pointer_wanted) == -1) {
+        in->raw_pointer_wanted = 0;
+    }
+    if (in->raw_pointer_wanted && in->abs_pointer_wanted == 0) {
+        xen_pv_printf(xendev, 0, "raw pointer set without abs pointer");
+    }
 
     if (in->qkbd) {
         qemu_input_handler_unregister(in->qkbd);
-- 
1.9.1
