Received: from eggs.gnu.org ([2001:4830:134:3::10]:49976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJXB-0007CR-Lv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX5-0004Ye-4b
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evJX4-0004Vu-Ud
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15751406804F
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:14:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 10:14:04 +0100
Message-Id: <20180312091405.19610-14-kraxel@redhat.com>
In-Reply-To: <20180312091405.19610-1-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/14] spice: add cursor_dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add support for cursor dmabufs.  qemu has to render the cursor for
that, so in case a cursor is present qemu allocates a new dmabuf, blits
the scanout, blends in the pointer and passes on the new dmabuf to
spice-server.  Without cursor qemu continues to simply pass on the
scanout dmabuf as-is.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180308090618.30147-4-kraxel@redhat.com
---
 include/ui/spice-display.h |   9 ++++
 ui/spice-display.c         | 114 +++++++++++++++++++++++++++++++++++++++=
++++--
 ui/trace-events            |   3 ++
 3 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 6b5c73b21c..87a84a59d4 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -122,6 +122,15 @@ struct SimpleSpiceDisplay {
     int gl_updates;
     bool have_scanout;
     bool have_surface;
+
+    QemuDmaBuf *guest_dmabuf;
+    bool guest_dmabuf_refresh;
+    bool render_cursor;
+
+    egl_fb guest_fb;
+    egl_fb blit_fb;
+    egl_fb cursor_fb;
+    bool have_hot;
 #endif
 };
=20
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 4c33c92ae5..fe734821dd 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -941,25 +941,126 @@ static void qemu_spice_gl_scanout_dmabuf(DisplayCh=
angeListener *dcl,
 {
     SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
=20
-    /* note: spice server will close the fd, so hand over a dup */
-    spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
-                         dmabuf->width, dmabuf->height,
-                         dmabuf->stride, dmabuf->fourcc, false);
-    qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->heigh=
t);
+    ssd->guest_dmabuf =3D dmabuf;
+    ssd->guest_dmabuf_refresh =3D true;
+
     ssd->have_surface =3D false;
     ssd->have_scanout =3D true;
 }
=20
+static void qemu_spice_gl_cursor_dmabuf(DisplayChangeListener *dcl,
+                                        QemuDmaBuf *dmabuf, bool have_ho=
t,
+                                        uint32_t hot_x, uint32_t hot_y)
+{
+    SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
+
+    ssd->have_hot =3D have_hot;
+    ssd->hot_x =3D hot_x;
+    ssd->hot_y =3D hot_y;
+
+    trace_qemu_spice_gl_cursor(ssd->qxl.id, dmabuf !=3D NULL, have_hot);
+    if (dmabuf) {
+        egl_dmabuf_import_texture(dmabuf);
+        if (!dmabuf->texture) {
+            return;
+        }
+        egl_fb_setup_for_tex(&ssd->cursor_fb, dmabuf->width, dmabuf->hei=
ght,
+                             dmabuf->texture, false);
+    } else {
+        egl_fb_destroy(&ssd->cursor_fb);
+    }
+}
+
+static void qemu_spice_gl_cursor_position(DisplayChangeListener *dcl,
+                                          uint32_t pos_x, uint32_t pos_y=
)
+{
+    SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
+
+    ssd->ptr_x =3D pos_x;
+    ssd->ptr_y =3D pos_y;
+}
+
+static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
+                                         QemuDmaBuf *dmabuf)
+{
+    SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
+
+    if (ssd->guest_dmabuf =3D=3D dmabuf) {
+        ssd->guest_dmabuf =3D NULL;
+        ssd->guest_dmabuf_refresh =3D false;
+    }
+    egl_dmabuf_release_texture(dmabuf);
+}
+
 static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uin=
t32_t h)
 {
     SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
+    EGLint stride =3D 0, fourcc =3D 0;
+    bool render_cursor =3D false;
+    bool y_0_top =3D false; /* FIXME */
     uint64_t cookie;
+    int fd;
=20
     if (!ssd->have_scanout) {
         return;
     }
=20
+    if (ssd->cursor_fb.texture) {
+        render_cursor =3D true;
+    }
+    if (ssd->render_cursor !=3D render_cursor) {
+        ssd->render_cursor =3D render_cursor;
+        ssd->guest_dmabuf_refresh =3D true;
+        egl_fb_destroy(&ssd->blit_fb);
+    }
+
+    if (ssd->guest_dmabuf_refresh) {
+        QemuDmaBuf *dmabuf =3D ssd->guest_dmabuf;
+        if (render_cursor) {
+            egl_dmabuf_import_texture(dmabuf);
+            if (!dmabuf->texture) {
+                return;
+            }
+
+            /* source framebuffer */
+            egl_fb_setup_for_tex(&ssd->guest_fb,
+                                 dmabuf->width, dmabuf->height,
+                                 dmabuf->texture, false);
+
+            /* dest framebuffer */
+            if (ssd->blit_fb.width  !=3D dmabuf->width ||
+                ssd->blit_fb.height !=3D dmabuf->height) {
+                trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, dmabuf->w=
idth,
+                                                  dmabuf->height);
+                egl_fb_destroy(&ssd->blit_fb);
+                egl_fb_setup_new_tex(&ssd->blit_fb,
+                                     dmabuf->width, dmabuf->height);
+                fd =3D egl_get_fd_for_texture(ssd->blit_fb.texture,
+                                            &stride, &fourcc);
+                spice_qxl_gl_scanout(&ssd->qxl, fd,
+                                     dmabuf->width, dmabuf->height,
+                                     stride, fourcc, false);
+            }
+        } else {
+            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id,
+                                               dmabuf->width, dmabuf->he=
ight);
+            /* note: spice server will close the fd, so hand over a dup =
*/
+            spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
+                                 dmabuf->width, dmabuf->height,
+                                 dmabuf->stride, dmabuf->fourcc, false);
+        }
+        qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->h=
eight);
+        ssd->guest_dmabuf_refresh =3D false;
+    }
+
+    if (render_cursor) {
+        egl_texture_blit(ssd->gls, &ssd->blit_fb, &ssd->guest_fb,
+                         !y_0_top);
+        egl_texture_blend(ssd->gls, &ssd->blit_fb, &ssd->cursor_fb,
+                          !y_0_top, ssd->ptr_x, ssd->ptr_y);
+        glFlush();
+    }
=20
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
@@ -984,6 +1085,9 @@ static const DisplayChangeListenerOps display_listen=
er_gl_ops =3D {
     .dpy_gl_scanout_disable  =3D qemu_spice_gl_scanout_disable,
     .dpy_gl_scanout_texture  =3D qemu_spice_gl_scanout_texture,
     .dpy_gl_scanout_dmabuf   =3D qemu_spice_gl_scanout_dmabuf,
+    .dpy_gl_cursor_dmabuf    =3D qemu_spice_gl_cursor_dmabuf,
+    .dpy_gl_cursor_position  =3D qemu_spice_gl_cursor_position,
+    .dpy_gl_release_dmabuf   =3D qemu_spice_gl_release_dmabuf,
     .dpy_gl_update           =3D qemu_spice_gl_update,
 };
=20
diff --git a/ui/trace-events b/ui/trace-events
index 518e950a01..a957f363f1 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -83,6 +83,9 @@ qemu_spice_ui_info(int qid, uint32_t width, uint32_t he=
ight) "%d %dx%d"
 qemu_spice_gl_surface(int qid, uint32_t w, uint32_t h, uint32_t fourcc) =
"%d %dx%d, fourcc 0x%x"
 qemu_spice_gl_scanout_disable(int qid) "%d"
 qemu_spice_gl_scanout_texture(int qid, uint32_t w, uint32_t h, uint32_t =
fourcc) "%d %dx%d, fourcc 0x%x"
+qemu_spice_gl_cursor(int qid, bool enabled, bool hotspot) "%d enabled %d=
, hotspot %d"
+qemu_spice_gl_forward_dmabuf(int qid, uint32_t width, uint32_t height) "=
%d %dx%d"
+qemu_spice_gl_render_dmabuf(int qid, uint32_t width, uint32_t height) "%=
d %dx%d"
 qemu_spice_gl_update(int qid, uint32_t x, uint32_t y, uint32_t w, uint32=
_t h) "%d +%d+%d %dx%d"
=20
 # ui/keymaps.c
--=20
2.9.3
