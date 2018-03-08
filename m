Received: from eggs.gnu.org ([2001:4830:134:3::10]:44826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrVI-0008GG-7T
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrVF-0005iG-JU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etrVF-0005hu-GH
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A365EB6F5
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 09:06:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 10:06:16 +0100
Message-Id: <20180308090618.30147-3-kraxel@redhat.com>
In-Reply-To: <20180308090618.30147-1-kraxel@redhat.com>
References: <20180308090618.30147-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/3] spice: add scanout_dmabuf support
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

Add support for scanout dmabufs.  Just
pass them through to spice-server.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-display.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 79ea4df02c..4c33c92ae5 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -936,6 +936,20 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     ssd->have_scanout = true;
 }
 
+static void qemu_spice_gl_scanout_dmabuf(DisplayChangeListener *dcl,
+                                         QemuDmaBuf *dmabuf)
+{
+    SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+
+    /* note: spice server will close the fd, so hand over a dup */
+    spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
+                         dmabuf->width, dmabuf->height,
+                         dmabuf->stride, dmabuf->fourcc, false);
+    qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->height);
+    ssd->have_surface = false;
+    ssd->have_scanout = true;
+}
+
 static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
@@ -969,6 +983,7 @@ static const DisplayChangeListenerOps display_listener_gl_ops = {
 
     .dpy_gl_scanout_disable  = qemu_spice_gl_scanout_disable,
     .dpy_gl_scanout_texture  = qemu_spice_gl_scanout_texture,
+    .dpy_gl_scanout_dmabuf   = qemu_spice_gl_scanout_dmabuf,
     .dpy_gl_update           = qemu_spice_gl_update,
 };
 
-- 
2.9.3
