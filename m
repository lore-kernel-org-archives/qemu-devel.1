Received: from eggs.gnu.org ([209.51.188.92]:45645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gmUbL-0003Ho-4R
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gmUZV-00025S-7z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:16:50 -0500
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:34935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1gmUZU-00024I-Uy
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:16:49 -0500
From: Chen Zhang <tgfbeta@me.com>
Message-Id: <1A3D7D5F-8D33-4917-B9E5-81B9E215FC43@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Date: Thu, 24 Jan 2019 10:16:41 +0800
In-Reply-To: <ab7146dc-4b21-4193-8f3b-109723fbd877@me.com>
References: <ab7146dc-4b21-4193-8f3b-109723fbd877@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH]gtk-egl: Blend cursor buffer within a
 scaled viewport
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

The patch pasted in previous mail lost some indentations and spaces.
Sorry.

=46rom 7921a69f106233ebc0ff9bdc29d7c6182160fc6f Mon Sep 17 00:00:00 2001
From: Chen Zhang <tgfbeta@me.com>
Date: Thu, 24 Jan 2019 09:16:23 +0800
Subject: [PATCH] DMABuf: Blend cursor buf within a scaled viewport

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 include/ui/egl-helpers.h |  2 ++
 ui/egl-helpers.c         | 18 ++++++++++++++++++
 ui/gtk-egl.c             |  8 +++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 3fc656a..63ffc2d 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -28,6 +28,8 @@ void egl_fb_read(void *dst, egl_fb *src);
 void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool =
flip);
 void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
                        int x, int y);
+void egl_texture_blend2(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
+                        int x, int y, int w, int h);
=20
 #ifdef CONFIG_OPENGL_DMABUF
=20
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 5e115b3..9dddee9 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -137,6 +137,24 @@ void egl_texture_blend(QemuGLShader *gls, egl_fb =
*dst, egl_fb *src, bool flip,
     glDisable(GL_BLEND);
 }
=20
+void egl_texture_blend2(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
+                        int x, int y, int w, int h)
+{
+    glBindFramebuffer(GL_FRAMEBUFFER_EXT, dst->framebuffer);
+    if (flip) {
+        glViewport(x, y, w, h);
+    } else {
+        glViewport(x, dst->height - h - y,
+                   w, h);
+    }
+    glEnable(GL_TEXTURE_2D);
+    glBindTexture(GL_TEXTURE_2D, src->texture);
+    glEnable(GL_BLEND);
+    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
+    qemu_gl_run_texture_blit(gls, flip);
+    glDisable(GL_BLEND);
+}
+
 /* =
---------------------------------------------------------------------- =
*/
=20
 #ifdef CONFIG_OPENGL_DMABUF
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index afd1714..afff0e1 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -276,9 +276,11 @@ void gd_egl_scanout_flush(DisplayChangeListener =
*dcl,
     if (vc->gfx.cursor_fb.texture) {
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, =
&vc->gfx.guest_fb,
                          vc->gfx.y0_top);
-        egl_texture_blend(vc->gfx.gls, &vc->gfx.win_fb, =
&vc->gfx.cursor_fb,
-                          vc->gfx.y0_top,
-                          vc->gfx.cursor_x, vc->gfx.cursor_y);
+        egl_texture_blend2(vc->gfx.gls, &vc->gfx.win_fb, =
&vc->gfx.cursor_fb,
+                           vc->gfx.y0_top,
+                           vc->gfx.cursor_x, vc->gfx.cursor_y,
+                           vc->gfx.scale_x * vc->gfx.cursor_fb.width,
+                           vc->gfx.scale_x * vc->gfx.cursor_fb.height);
     } else {
         egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, =
!vc->gfx.y0_top);
     }
--=20
2.7.4


> On Jan 24, 2019, at 9:31 AM, Chen Zhang <tgfbeta@me.com> wrote:
>=20
> When a gtk-egl window (for gvt-g DMABuf) was zoomed, the cursor plane =
buffer did not zoom covariantly, resulting in a mismatched cursor size. =
In this patch, `egl_texture_blend()` is augmented with two extra =
parameters to convey the size for a scaled viewport, as in =
`egl_texture_blend2()`.=20
>=20
> Signed-off-by: Chen Zhang <tgfbeta@me.com>
> ---
> include/ui/egl-helpers.h | 2 ++
> ui/egl-helpers.c | 18 ++++++++++++++++++
> ui/gtk-egl.c | 8 +++++---
> 3 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 3fc656a..63ffc2d 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -28,6 +28,8 @@ void egl_fb_read(void *dst, egl_fb *src);
> void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip);
> void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
> int x, int y);
> +void egl_texture_blend2(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
> + int x, int y, int w, int h);
>=20
> #ifdef CONFIG_OPENGL_DMABUF
>=20
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 5e115b3..9dddee9 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -137,6 +137,24 @@ void egl_texture_blend(QemuGLShader *gls, egl_fb =
*dst, egl_fb *src, bool flip,
> glDisable(GL_BLEND);
> }
>=20
> +void egl_texture_blend2(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
> + int x, int y, int w, int h)
> +{
> + glBindFramebuffer(GL_FRAMEBUFFER_EXT, dst->framebuffer);
> + if (flip) {
> + glViewport(x, y, w, h);
> + } else {
> + glViewport(x, dst->height - h - y,
> + w, h);
> + }
> + glEnable(GL_TEXTURE_2D);
> + glBindTexture(GL_TEXTURE_2D, src->texture);
> + glEnable(GL_BLEND);
> + glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
> + qemu_gl_run_texture_blit(gls, flip);
> + glDisable(GL_BLEND);
> +}
> +
> /* =
---------------------------------------------------------------------- =
*/
>=20
> #ifdef CONFIG_OPENGL_DMABUF
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index afd1714..afff0e1 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -276,9 +276,11 @@ void gd_egl_scanout_flush(DisplayChangeListener =
*dcl,
> if (vc->gfx.cursor_fb.texture) {
> egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
> vc->gfx.y0_top);
> - egl_texture_blend(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,
> - vc->gfx.y0_top,
> - vc->gfx.cursor_x, vc->gfx.cursor_y);
> + egl_texture_blend2(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,
> + vc->gfx.y0_top,
> + vc->gfx.cursor_x, vc->gfx.cursor_y,
> + vc->gfx.scale_x * vc->gfx.cursor_fb.width,
> + vc->gfx.scale_x * vc->gfx.cursor_fb.height);
> } else {
> egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
> }
> --=20
> 2.7.4
