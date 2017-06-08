Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJD-0004L5-G8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002Do-6d
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:07 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:14895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002D2-01
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:04 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Thu, 8 Jun 2017 13:15:31 +0000
Message-ID: <1496927734-29174-2-git-send-email-owen.smith@citrix.com>
In-Reply-To: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/4] xenfb: Add feature-vkbd-standalone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com, xen-devel@lists.xenproject.org, Owen Smith <owen.smith@citrix.com>

Advertise "feature-vkbd-standalone" to indicate the backend
can connect without a vfb device connection.
When "request-vkbd-standalone" is set to 1, the backend does
not wait for a QemuConsole to be setup before connecting the 
vkbd device. This also means that absolute coordinates cannot
be scaled to the non-existent QemuConsole's sizes, and remain
unscaled, in the range [0, 0x7FFF].

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 hw/display/xenfb.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index e76c0d8..2ebc81b 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -52,6 +52,7 @@ struct common {
 struct XenInput {
     struct common c;
     int abs_pointer_wanted; /* Whether guest supports absolute pointer */
+    int vkbd_standalone;    /* Guest supports vkbd without vfb device */
     int button_state;       /* Last seen pointer button state */
     int extended;
     QEMUPutMouseEntry *qmouse;
@@ -306,18 +307,22 @@ static void xenfb_mouse_event(void *opaque,
 			      int dx, int dy, int dz, int button_state)
 {
     struct XenInput *xenfb = opaque;
-    DisplaySurface *surface = qemu_console_surface(xenfb->c.con);
-    int dw = surface_width(surface);
-    int dh = surface_height(surface);
-    int i;
+    int i, x, y;
+    if (xenfb->c.con != NULL) {
+        DisplaySurface *surface = qemu_console_surface(xenfb->c.con);
+        int dw = surface_width(surface);
+        int dh = surface_height(surface);
+        x = dx * (dh - 1) / 0x7fff;
+        y = dy * (dw - 1) / 0x7fff;
+    } else {
+        x = dx;
+        y = dy;
+    }
 
     trace_xenfb_mouse_event(opaque, dx, dy, dz, button_state,
                             xenfb->abs_pointer_wanted);
     if (xenfb->abs_pointer_wanted)
-	xenfb_send_position(xenfb,
-			    dx * (dw - 1) / 0x7fff,
-			    dy * (dh - 1) / 0x7fff,
-			    dz);
+        xenfb_send_position(xenfb, x, y, dz);
     else
 	xenfb_send_motion(xenfb, dx, dy, dz);
 
@@ -336,6 +341,7 @@ static void xenfb_mouse_event(void *opaque,
 static int input_init(struct XenDevice *xendev)
 {
     xenstore_write_be_int(xendev, "feature-abs-pointer", 1);
+    xenstore_write_be_int(xendev, "feature-vkbd-standalone", 1);
     return 0;
 }
 
@@ -345,8 +351,14 @@ static int input_initialise(struct XenDevice *xendev)
     int rc;
 
     if (!in->c.con) {
-        xen_pv_printf(xendev, 1, "ds not set (yet)\n");
-        return -1;
+        if (xenstore_read_fe_int(xendev, "request-vkbd-standalone",
+                                 &in->vkbd_standalone) == -1) {
+            in->vkbd_standalone = 0;
+        }
+        if (in->vkbd_standalone == 0) {
+            xen_pv_printf(xendev, 1, "ds not set (yet)\n");
+            return -1;
+        }
     }
 
     rc = common_bind(&in->c);
-- 
2.1.4
