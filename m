Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFACC00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FECB21A4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FECB21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7EHs-000646-Ea
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 03:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i7EGe-0005WF-Sq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i7EGb-0005vE-WC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i7EGa-0005tU-Lh
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:39:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DAE03A46C32
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 07:39:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-59.ams2.redhat.com
 [10.36.117.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50D945C1D8;
 Mon,  9 Sep 2019 07:39:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8AB7E268; Mon,  9 Sep 2019 09:39:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 09:39:11 +0200
Message-Id: <20190909073911.24787-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 09 Sep 2019 07:39:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] ui/egl: fix framebuffer reads
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix egl_fb_read() to use the (destination) surface size instead of the
(source) framebuffer source for glReadPixels.  Pass the DisplaySurface
instead of the pixeldata pointer to egl_fb_read() to make this possible.

With that in place framebuffer reads work fine even if the surface and
framebuffer sizes don't match, so we can remove the guest-triggerable
asserts in egl_scanout_flush().

Buglink: https://bugzilla.redhat.com//show_bug.cgi?id=1749659
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h | 2 +-
 ui/egl-headless.c        | 4 +---
 ui/egl-helpers.c         | 6 +++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index dad19e9873fb..94a4b3e6f3bd 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -25,7 +25,7 @@ void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
                           GLuint texture, bool delete);
 void egl_fb_setup_new_tex(egl_fb *fb, int width, int height);
 void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip);
-void egl_fb_read(void *dst, egl_fb *src);
+void egl_fb_read(DisplaySurface *dst, egl_fb *src);
 
 void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip);
 void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 05b2e7d7b17f..fe2a0d1eab98 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -133,8 +133,6 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
     if (!edpy->guest_fb.texture || !edpy->ds) {
         return;
     }
-    assert(surface_width(edpy->ds)  == edpy->guest_fb.width);
-    assert(surface_height(edpy->ds) == edpy->guest_fb.height);
     assert(surface_format(edpy->ds) == PIXMAN_x8r8g8b8);
 
     if (edpy->cursor_fb.texture) {
@@ -149,7 +147,7 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
         egl_fb_blit(&edpy->blit_fb, &edpy->guest_fb, edpy->y_0_top);
     }
 
-    egl_fb_read(surface_data(edpy->ds), &edpy->blit_fb);
+    egl_fb_read(edpy->ds, &edpy->blit_fb);
     dpy_gfx_update(edpy->dcl.con, x, y, w, h);
 }
 
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index edc53f6d3464..7c530c2825be 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -102,12 +102,12 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
                       GL_COLOR_BUFFER_BIT, GL_LINEAR);
 }
 
-void egl_fb_read(void *dst, egl_fb *src)
+void egl_fb_read(DisplaySurface *dst, egl_fb *src)
 {
     glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
     glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
-    glReadPixels(0, 0, src->width, src->height,
-                 GL_BGRA, GL_UNSIGNED_BYTE, dst);
+    glReadPixels(0, 0, surface_width(dst), surface_height(dst),
+                 GL_BGRA, GL_UNSIGNED_BYTE, surface_data(dst));
 }
 
 void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip)
-- 
2.18.1


