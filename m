Received: from eggs.gnu.org ([2001:4830:134:3::10]:42287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrAC-0005Lu-K2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrA9-0003at-I5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:48:44 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:45580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrA9-0003Zn-9u
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:48:41 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Tue, 26 Sep 2017 14:43:39 +0000
Message-ID: <1506437019-17946-4-git-send-email-owen.smith@citrix.com>
In-Reply-To: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3 v4] xenfb: Add [feature|request]-raw-pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Owen Smith <owen.smith@citrix.com>

Writes "feature-raw-pointer" during init to indicate the backend
can pass raw unscaled values for absolute axes to the frontend.
Frontends set "request-raw-pointer" to indicate the backend should
not attempt to scale absolute values to console size.
"request-raw-pointer" is only valid if "request-abs-pointer" is
also set. Raw unscaled pointer values are in the range [0, 0x7fff]

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 hw/display/xenfb.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 33361b4..29428ae 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -52,6 +52,7 @@ struct common {
 struct XenInput {
     struct common c;
     int abs_pointer_wanted; /* Whether guest supports absolute pointer */
+    int raw_pointer_wanted; /* Whether guest supports raw (unscaled) pointer */
     QemuInputHandlerState *qkbd;
     QemuInputHandlerState *qmou;
     int mouse_axes[INPUT_AXIS__MAX];
@@ -264,21 +265,23 @@ static void xenfb_mouse_sync(DeviceState *dev)
                             in->abs_pointer_wanted);
 
     if (in->abs_pointer_wanted) {
-        QemuConsole *con = qemu_console_lookup_by_index(0);
-        DisplaySurface *surface;
-        int dw, dh;
-
-        if (!con) {
-            xen_pv_printf(&in->c.xendev, 0, "No QEMU console available");
-            return;
-        }
+        if (!in->raw_pointer_wanted) {
+            QemuConsole *con = qemu_console_lookup_by_index(0);
+            DisplaySurface *surface;
+            int dw, dh;
+
+            if (!con) {
+                xen_pv_printf(&in->c.xendev, 0, "No QEMU console available");
+                return;
+            }
 
-        surface = qemu_console_surface(con);
-        dw = surface_width(surface);
-        dh = surface_height(surface);
+            surface = qemu_console_surface(con);
+            dw = surface_width(surface);
+            dh = surface_height(surface);
 
-        dx = dx * (dw - 1) / 0x7fff;
-        dy = dy * (dh - 1) / 0x7fff;
+            dx = dx * (dw - 1) / 0x7fff;
+            dy = dy * (dh - 1) / 0x7fff;
+        }
 
         xenfb_send_position(in, dx, dy, dz);
     } else {
@@ -312,6 +315,7 @@ static QemuInputHandler xenfb_rel_mouse = {
 static int input_init(struct XenDevice *xendev)
 {
     xenstore_write_be_int(xendev, "feature-abs-pointer", 1);
+    xenstore_write_be_int(xendev, "feature-raw-pointer", 1);
     return 0;
 }
 
@@ -335,6 +339,13 @@ static void input_connected(struct XenDevice *xendev)
                              &in->abs_pointer_wanted) == -1) {
         in->abs_pointer_wanted = 0;
     }
+    if (xenstore_read_fe_int(xendev, "request-raw-pointer",
+                             &in->raw_pointer_wanted) == -1) {
+        in->raw_pointer_wanted = 0;
+    }
+    if (in->raw_pointer_wanted && !in->abs_pointer_wanted) {
+        xen_pv_printf(xendev, 0, "raw pointer set without absolute pointer.");
+    }
 
     if (in->qkbd) {
         qemu_input_handler_unregister(in->qkbd);
-- 
2.1.4
