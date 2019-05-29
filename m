Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1DC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8E3208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8E3208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsxj-0003gt-0w
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:25:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVsuH-00010d-IJ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVsuG-0004y3-33
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVsuF-0004xG-V1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:21:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA44B9D43B
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 07:21:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4753E5D9D6;
	Wed, 29 May 2019 07:21:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 99FC417524; Wed, 29 May 2019 09:21:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:21:44 +0200
Message-Id: <20190529072144.26737-5-kraxel@redhat.com>
In-Reply-To: <20190529072144.26737-1-kraxel@redhat.com>
References: <20190529072144.26737-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 29 May 2019 07:21:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/4] egl-helpers: add modifier support to
 egl_dmabuf_import_texture()
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

Check and use QemuDmaBuf->modifier in egl_dmabuf_import_texture()
for dmabuf imports.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/egl-helpers.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 0c9716067cfb..edc53f6d3464 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -229,20 +229,36 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
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
+#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
+    if (dmabuf->modifier) {
+        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
+        attrs[i++] = (dmabuf->modifier >>  0) & 0xffffffff;
+        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
+        attrs[i++] = (dmabuf->modifier >> 32) & 0xffffffff;
+    }
+#endif
+    attrs[i++] = EGL_NONE;
+
     image = eglCreateImageKHR(qemu_egl_display,
                               EGL_NO_CONTEXT,
                               EGL_LINUX_DMA_BUF_EXT,
-- 
2.18.1


