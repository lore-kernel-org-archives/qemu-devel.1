Received: from eggs.gnu.org ([2001:4830:134:3::10]:52307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY18-000247-4w
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY14-0006lG-Mo
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dTY14-0006kO-EL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:10 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri,  7 Jul 2017 11:30:02 -0700
Message-Id: <1499452204-20769-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1707071117420.2919@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1707071117420.2919@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/3] xenfb: remove xen_init_display "temporary"
 hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

Initialize xenfb properly, as all other backends, from its own
"initialise" function.

Remove the dependency of vkbd on vfb: use qemu_console_lookup_by_index
to find the principal console (to get the size of the screen) instead of
relying on a vfb backend to be available (which adds a dependency
between the two).

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
---
 hw/display/xenfb.c           | 81 ++++++++++----------------------------------
 hw/xenpv/xen_machine_pv.c    |  3 --
 include/hw/xen/xen_backend.h |  2 --
 3 files changed, 18 insertions(+), 68 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index e76c0d8..df8b78f 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -46,7 +46,6 @@
 struct common {
     struct XenDevice  xendev;  /* must be first */
     void              *page;
-    QemuConsole       *con;
 };
 
 struct XenInput {
@@ -61,6 +60,7 @@ struct XenInput {
 
 struct XenFB {
     struct common     c;
+    QemuConsole       *con;
     size_t            fb_len;
     int               row_stride;
     int               depth;
@@ -71,7 +71,6 @@ struct XenFB {
     int               fbpages;
     int               feature_update;
     int               bug_trigger;
-    int               have_console;
     int               do_resize;
 
     struct {
@@ -80,6 +79,7 @@ struct XenFB {
     int               up_count;
     int               up_fullscreen;
 };
+static const GraphicHwOps xenfb_ops;
 
 /* -------------------------------------------------------------------- */
 
@@ -306,10 +306,18 @@ static void xenfb_mouse_event(void *opaque,
 			      int dx, int dy, int dz, int button_state)
 {
     struct XenInput *xenfb = opaque;
-    DisplaySurface *surface = qemu_console_surface(xenfb->c.con);
-    int dw = surface_width(surface);
-    int dh = surface_height(surface);
-    int i;
+    QemuConsole *con = qemu_console_lookup_by_index(0);
+    DisplaySurface *surface;
+    int dw, dh, i;
+
+    if (!con) {
+        xen_pv_printf(&xenfb->c.xendev, 0, "No QEMU console available");
+        return;
+    }
+
+    surface = qemu_console_surface(con);
+    dw = surface_width(surface);
+    dh = surface_height(surface);
 
     trace_xenfb_mouse_event(opaque, dx, dy, dz, button_state,
                             xenfb->abs_pointer_wanted);
@@ -344,11 +352,6 @@ static int input_initialise(struct XenDevice *xendev)
     struct XenInput *in = container_of(xendev, struct XenInput, c.xendev);
     int rc;
 
-    if (!in->c.con) {
-        xen_pv_printf(xendev, 1, "ds not set (yet)\n");
-        return -1;
-    }
-
     rc = common_bind(&in->c);
     if (rc != 0)
 	return rc;
@@ -608,7 +611,7 @@ static int xenfb_configure_fb(struct XenFB *xenfb, size_t fb_len_lim,
  */
 static void xenfb_guest_copy(struct XenFB *xenfb, int x, int y, int w, int h)
 {
-    DisplaySurface *surface = qemu_console_surface(xenfb->c.con);
+    DisplaySurface *surface = qemu_console_surface(xenfb->con);
     int line, oops = 0;
     int bpp = surface_bits_per_pixel(surface);
     int linesize = surface_stride(surface);
@@ -642,7 +645,7 @@ static void xenfb_guest_copy(struct XenFB *xenfb, int x, int y, int w, int h)
         xen_pv_printf(&xenfb->c.xendev, 0, "%s: oops: convert %d -> %d bpp?\n",
                       __FUNCTION__, xenfb->depth, bpp);
 
-    dpy_gfx_update(xenfb->c.con, x, y, w, h);
+    dpy_gfx_update(xenfb->con, x, y, w, h);
 }
 
 #ifdef XENFB_TYPE_REFRESH_PERIOD
@@ -728,7 +731,7 @@ static void xenfb_update(void *opaque)
             surface = qemu_create_displaysurface(xenfb->width, xenfb->height);
             break;
         }
-        dpy_gfx_replace_surface(xenfb->c.con, surface);
+        dpy_gfx_replace_surface(xenfb->con, surface);
         xen_pv_printf(&xenfb->c.xendev, 1,
                       "update: resizing: %dx%d @ %d bpp%s\n",
                       xenfb->width, xenfb->height, xenfb->depth,
@@ -877,16 +880,7 @@ static int fb_initialise(struct XenDevice *xendev)
     if (rc != 0)
 	return rc;
 
-#if 0  /* handled in xen_init_display() for now */
-    if (!fb->have_console) {
-        fb->c.ds = graphic_console_init(xenfb_update,
-                                        xenfb_invalidate,
-                                        NULL,
-                                        NULL,
-                                        fb);
-        fb->have_console = 1;
-    }
-#endif
+    fb->con = graphic_console_init(NULL, 0, &xenfb_ops, fb);
 
     if (xenstore_read_fe_int(xendev, "feature-update", &fb->feature_update) == -1)
 	fb->feature_update = 0;
@@ -972,42 +966,3 @@ static const GraphicHwOps xenfb_ops = {
     .gfx_update  = xenfb_update,
     .update_interval = xenfb_update_interval,
 };
-
-/*
- * FIXME/TODO: Kill this.
- * Temporary needed while DisplayState reorganization is in flight.
- */
-void xen_init_display(int domid)
-{
-    struct XenDevice *xfb, *xin;
-    struct XenFB *fb;
-    struct XenInput *in;
-    int i = 0;
-
-wait_more:
-    i++;
-    main_loop_wait(true);
-    xfb = xen_pv_find_xendev("vfb", domid, 0);
-    xin = xen_pv_find_xendev("vkbd", domid, 0);
-    if (!xfb || !xin) {
-        if (i < 256) {
-            usleep(10000);
-            goto wait_more;
-        }
-        xen_pv_printf(NULL, 1, "displaystate setup failed\n");
-        return;
-    }
-
-    /* vfb */
-    fb = container_of(xfb, struct XenFB, c.xendev);
-    fb->c.con = graphic_console_init(NULL, 0, &xenfb_ops, fb);
-    fb->have_console = 1;
-
-    /* vkbd */
-    in = container_of(xin, struct XenInput, c.xendev);
-    in->c.con = fb->c.con;
-
-    /* retry ->init() */
-    xen_be_check_state(xin);
-    xen_be_check_state(xfb);
-}
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 79aef4e..31d2f25 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -94,9 +94,6 @@ static void xen_init_pv(MachineState *machine)
 
     /* config cleanup hook */
     atexit(xen_config_cleanup);
-
-    /* setup framebuffer */
-    xen_init_display(xen_domid);
 }
 
 static void xenpv_machine_init(MachineClass *mc)
diff --git a/include/hw/xen/xen_backend.h b/include/hw/xen/xen_backend.h
index 852c2ea..8a6fbcb 100644
--- a/include/hw/xen/xen_backend.h
+++ b/include/hw/xen/xen_backend.h
@@ -55,8 +55,6 @@ extern struct XenDevOps xen_netdev_ops;       /* xen_nic.c         */
 extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
 #endif
 
-void xen_init_display(int domid);
-
 /* configuration (aka xenbus setup) */
 void xen_config_cleanup(void);
 int xen_config_dev_blk(DriveInfo *disk);
-- 
1.9.1
