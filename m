Received: from eggs.gnu.org ([209.51.188.92]:54860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gjiA1-00044s-85
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gji9y-0001lH-0u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:10:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gji9u-0001fD-61
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:10:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E062BC000661
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 10:10:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 16 Jan 2019 11:10:49 +0100
Message-Id: <20190116101049.8929-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vnc: detect and optimize pageflips
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

When size and format of the display surface stays the same we can just
tag the guest display as dirty and be done with it.

There is no need need to resize the vnc server display or to touch the
vnc client dirty bits.  On the next refresh cycle
vnc_refresh_server_surface() will check for actual display content
changes and update the client dirty bits as needed.

The desktop resize and framebuffer format notifications to the vnc
client will be skipped too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9e4b2beb71..6002d09407 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -742,6 +742,17 @@ static void vnc_update_server_surface(VncDisplay *vd)
                        width, height);
 }
 
+static bool vnc_check_pageflip(DisplaySurface *s1,
+                               DisplaySurface *s2)
+{
+    return (s1 != NULL &&
+            s2 != NULL &&
+            surface_width(s1) == surface_width(s2) &&
+            surface_height(s1) == surface_height(s2) &&
+            surface_format(s1) == surface_format(s2));
+
+}
+
 static void vnc_dpy_switch(DisplayChangeListener *dcl,
                            DisplaySurface *surface)
 {
@@ -749,6 +760,7 @@ static void vnc_dpy_switch(DisplayChangeListener *dcl,
         "Display output is not active.";
     static DisplaySurface *placeholder;
     VncDisplay *vd = container_of(dcl, VncDisplay, dcl);
+    bool pageflip = vnc_check_pageflip(vd->ds, surface);
     VncState *vs;
 
     if (surface == NULL) {
@@ -761,14 +773,21 @@ static void vnc_dpy_switch(DisplayChangeListener *dcl,
     vnc_abort_display_jobs(vd);
     vd->ds = surface;
 
-    /* server surface */
-    vnc_update_server_surface(vd);
-
     /* guest surface */
     qemu_pixman_image_unref(vd->guest.fb);
     vd->guest.fb = pixman_image_ref(surface->image);
     vd->guest.format = surface->format;
 
+    if (pageflip) {
+        vnc_set_area_dirty(vd->guest.dirty, vd, 0, 0,
+                           surface_width(surface),
+                           surface_height(surface));
+        return;
+    }
+
+    /* server surface */
+    vnc_update_server_surface(vd);
+
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         vnc_colordepth(vs);
         vnc_desktop_resize(vs);
-- 
2.9.3
