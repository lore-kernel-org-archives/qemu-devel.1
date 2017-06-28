Received: from eggs.gnu.org ([2001:4830:134:3::10]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dQHq9-0000Yy-EM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dQHq6-0003DX-BX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dQHq6-0003CY-3A
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:37:22 -0400
Date: Wed, 28 Jun 2017 11:37:19 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1706281125330.2919@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH v2] xenfb: remove xen_init_display "temporary"
 hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, peter.maydell@linaro.org, anthony.perard@citrix.com, kraxel@redhat.com, paul.durrant@citrix.com

Initialize xenfb properly, as all other backends, from its own
"initialise" function.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

---
Changes in v2:
- remove xen_init_display from xen_backend.h
- handle cases where vkbd is missing

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index e76c0d8..3b0168b 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
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
 
@@ -855,6 +855,8 @@ static int fb_init(struct XenDevice *xendev)
 static int fb_initialise(struct XenDevice *xendev)
 {
     struct XenFB *fb = container_of(xendev, struct XenFB, c.xendev);
+    struct XenDevice *xin;
+    struct XenInput *in;
     struct xenfb_page *fb_page;
     int videoram;
     int rc;
@@ -877,16 +879,16 @@ static int fb_initialise(struct XenDevice *xendev)
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
+    fb->c.con = graphic_console_init(NULL, 0, &xenfb_ops, fb);
+
+    xin = xen_pv_find_xendev("vkbd", xen_domid, 0);
+    if (xin == NULL) {
+        xen_pv_printf(xendev, 1, "xenfb is up, but vkbd is not present\n");
+    } else {
+        in = container_of(xin, struct XenInput, c.xendev);
+        in->c.con = fb->c.con;
+        xen_be_check_state(xin);
     }
-#endif
 
     if (xenstore_read_fe_int(xendev, "feature-update", &fb->feature_update) == -1)
 	fb->feature_update = 0;
@@ -972,42 +974,3 @@ static const GraphicHwOps xenfb_ops = {
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
