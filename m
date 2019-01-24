Received: from eggs.gnu.org ([209.51.188.92]:39643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gmTs1-00032V-Vd
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gmTs0-0000El-Dm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:31:53 -0500
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1gmTs0-0000Di-6F
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:31:52 -0500
From: Chen Zhang <tgfbeta@me.com>
Date: Thu, 24 Jan 2019 01:31:45 GMT
Message-id: <ab7146dc-4b21-4193-8f3b-109723fbd877@me.com>
MIME-Version: 1.0
Content-Type: text/plain;
    charset=utf-8;
    format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH]gtk-egl: Blend cursor buffer within a scaled
 viewport
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

When a gtk-egl window (for gvt-g DMABuf) was=C2=A0zoomed, the cursor plane=
 buffer did not zoom covariantly, resulting in a=C2=A0mismatched cursor si=
ze. In this patch, `egl_texture_blend()` is augmented with two extra param=
eters to convey the size for a scaled viewport, as in `egl_texture_blend2(=
)`.=C2=A0=0A=0ASigned-off-by: Chen Zhang <tgfbeta@me.com>=0A---=0Ainclude/=
ui/egl-helpers.h | 2 ++=0Aui/egl-helpers.c | 18 ++++++++++++++++++=0Aui/gt=
k-egl.c | 8 +++++---=0A3 files changed, 25 insertions(+), 3 deletions(-)=0A=
=0Adiff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h=0Ainde=
x 3fc656a..63ffc2d 100644=0A--- a/include/ui/egl-helpers.h=0A+++ b/include=
/ui/egl-helpers.h=0A@@ -28,6 +28,8 @@ void egl_fb_read(void *dst, egl_fb *=
src);=0Avoid egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src,=
 bool flip);=0Avoid egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_=
fb *src, bool flip,=0Aint x, int y);=0A+void egl_texture_blend2(QemuGLShad=
er *gls, egl_fb *dst, egl_fb *src, bool flip,=0A+ int x, int y, int w, int=
 h);=0A=0A#ifdef CONFIG_OPENGL_DMABUF=0A=0Adiff --git a/ui/egl-helpers.c b=
/ui/egl-helpers.c=0Aindex 5e115b3..9dddee9 100644=0A--- a/ui/egl-helpers.c=
=0A+++ b/ui/egl-helpers.c=0A@@ -137,6 +137,24 @@ void egl_texture_blend(Qe=
muGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,=0AglDisable(GL_BLEND=
);=0A}=0A=0A+void egl_texture_blend2(QemuGLShader *gls, egl_fb *dst, egl_f=
b *src, bool flip,=0A+ int x, int y, int w, int h)=0A+{=0A+ glBindFramebuf=
fer(GL_FRAMEBUFFER_EXT, dst->framebuffer);=0A+ if (flip) {=0A+ glViewport(=
x, y, w, h);=0A+ } else {=0A+ glViewport(x, dst->height - h - y,=0A+ w, h)=
;=0A+ }=0A+ glEnable(GL_TEXTURE_2D);=0A+ glBindTexture(GL_TEXTURE_2D, src-=
>texture);=0A+ glEnable(GL_BLEND);=0A+ glBlendFunc(GL_SRC_ALPHA, GL_ONE_MI=
NUS_SRC_ALPHA);=0A+ qemu_gl_run_texture_blit(gls, flip);=0A+ glDisable(GL_=
BLEND);=0A+}=0A+=0A/* ----------------------------------------------------=
------------------ */=0A=0A#ifdef CONFIG_OPENGL_DMABUF=0Adiff --git a/ui/g=
tk-egl.c b/ui/gtk-egl.c=0Aindex afd1714..afff0e1 100644=0A--- a/ui/gtk-egl=
.c=0A+++ b/ui/gtk-egl.c=0A@@ -276,9 +276,11 @@ void gd_egl_scanout_flush(D=
isplayChangeListener *dcl,=0Aif (vc->gfx.cursor_fb.texture) {=0Aegl_textur=
e_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,=0Avc->gfx.y0_top);=
=0A- egl_texture_blend(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,=0A=
- vc->gfx.y0_top,=0A- vc->gfx.cursor_x, vc->gfx.cursor_y);=0A+ egl_texture=
_blend2(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,=0A+ vc->gfx.y0_t=
op,=0A+ vc->gfx.cursor_x, vc->gfx.cursor_y,=0A+ vc->gfx.scale_x * vc->gfx.=
cursor_fb.width,=0A+ vc->gfx.scale_x * vc->gfx.cursor_fb.height);=0A} else=
 {=0Aegl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);=0A}=
=0A-- =0A2.7.4=0A
