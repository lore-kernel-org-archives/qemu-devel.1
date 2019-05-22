Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91ECC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6A620645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6A620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39533 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTO8O-0000pe-D1
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:06:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTO6V-0008E8-9Z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTO0x-0005DW-VL
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hTO0x-0005Cy-O3
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3F71C04AC69
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:58:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EECD660478;
	Wed, 22 May 2019 09:58:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 26377A206; Wed, 22 May 2019 11:58:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 11:58:21 +0200
Message-Id: <20190522095821.15240-4-kraxel@redhat.com>
In-Reply-To: <20190522095821.15240-1-kraxel@redhat.com>
References: <20190522095821.15240-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 22 May 2019 09:58:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] egl-helpers: add dmabuf modifier support.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add modifier parameter to egl_get_fd_for_texture(), to return the used
modifier on dmabuf exports.

Check and use QemuDmaBuf->modifier in egl_dmabuf_import_texture() for
dmabuf imports.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h |  3 ++-
 ui/egl-helpers.c         | 37 ++++++++++++++++++++++++++-----------
 ui/spice-display.c       |  7 ++++---
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index b976cb872821..d71412779913 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -36,7 +36,8 @@ extern struct gbm_device *qemu_egl_rn_gbm_dev;
 extern EGLContext qemu_egl_rn_ctx;
 
 int egl_rendernode_init(const char *rendernode, DisplayGLMode mode);
-int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc);
+int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
+                           EGLuint64KHR *modifier);
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
 void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e90eef8c9c3a..87bfd32e8ddb 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -200,7 +200,8 @@ err:
     return -1;
 }
 
-int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc)
+int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
+                           EGLuint64KHR *modifier)
 {
     EGLImageKHR image;
     EGLint num_planes, fd;
@@ -214,7 +215,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc)
     }
 
     eglExportDMABUFImageQueryMESA(qemu_egl_display, image, fourcc,
-                                  &num_planes, NULL);
+                                  &num_planes, modifier);
     if (num_planes != 1) {
         eglDestroyImageKHR(qemu_egl_display, image);
         return -1;
@@ -228,20 +229,34 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc)
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
 {
     EGLImageKHR image = EGL_NO_IMAGE_KHR;
-    EGLint attrs[] = {
-        EGL_DMA_BUF_PLANE0_FD_EXT,      dmabuf->fd,
-        EGL_DMA_BUF_PLANE0_PITCH_EXT,   dmabuf->stride,
-        EGL_DMA_BUF_PLANE0_OFFSET_EXT,  0,
-        EGL_WIDTH,                      dmabuf->width,
-        EGL_HEIGHT,                     dmabuf->height,
-        EGL_LINUX_DRM_FOURCC_EXT,       dmabuf->fourcc,
-        EGL_NONE, /* end of list */
-    };
+    EGLint attrs[64];
+    int i = 0;
 
     if (dmabuf->texture != 0) {
         return;
     }
 
+    attrs[i++] = EGL_WIDTH;
+    attrs[i++] = dmabuf->width;
+    attrs[i++] = EGL_HEIGHT;
+    attrs[i++] = dmabuf->height;
+    attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
+    attrs[i++] = dmabuf->fourcc;
+
+    attrs[i++] = EGL_DMA_BUF_PLANE0_FD_EXT;
+    attrs[i++] = dmabuf->fd;
+    attrs[i++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
+    attrs[i++] = dmabuf->stride;
+    attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
+    attrs[i++] = 0;
+    if (dmabuf->modifier) {
+        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
+        attrs[i++] = (dmabuf->modifier >>  0) & 0xffffffff;
+        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
+        attrs[i++] = (dmabuf->modifier >> 32) & 0xffffffff;
+    }
+    attrs[i++] = EGL_NONE;
+
     image = eglCreateImageKHR(qemu_egl_display,
                               EGL_NO_CONTEXT,
                               EGL_LINUX_DMA_BUF_EXT,
diff --git a/ui/spice-display.c b/ui/spice-display.c
index a5e26479a866..104df2302575 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -888,7 +888,8 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
     if (ssd->ds) {
         surface_gl_create_texture(ssd->gls, ssd->ds);
         fd = egl_get_fd_for_texture(ssd->ds->texture,
-                                    &stride, &fourcc);
+                                    &stride, &fourcc,
+                                    NULL);
         if (fd < 0) {
             surface_gl_destroy_texture(ssd->gls, ssd->ds);
             return;
@@ -945,7 +946,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     int fd = -1;
 
     assert(tex_id);
-    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc);
+    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc, NULL);
     if (fd < 0) {
         fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
         return;
@@ -1063,7 +1064,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                 egl_fb_setup_new_tex(&ssd->blit_fb,
                                      dmabuf->width, dmabuf->height);
                 fd = egl_get_fd_for_texture(ssd->blit_fb.texture,
-                                            &stride, &fourcc);
+                                            &stride, &fourcc, NULL);
                 spice_qxl_gl_scanout(&ssd->qxl, fd,
                                      dmabuf->width, dmabuf->height,
                                      stride, fourcc, false);
-- 
2.18.1


