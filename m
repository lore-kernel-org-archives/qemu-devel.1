Received: from eggs.gnu.org ([2001:4830:134:3::10]:47544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAtop-00042L-8F
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAtom-0006IZ-1c
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:56:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dAtol-0006IL-OW
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 890AE19CF90
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 07:56:17 +0000 (UTC)
References: <20170505104101.30589-1-kraxel@redhat.com>
	<20170505104101.30589-7-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <771ae379-6c38-5545-e861-deccce3d0a89@redhat.com>
Date: Wed, 17 May 2017 09:56:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170505104101.30589-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] QEMU master is broken (was: [PATCH 6/6] opengl: add
 egl-headless display)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


 Hi,

I can not compile git master anymore on my RHEL 7.3 installation ...
I think it is due to this patch here. I now get:

  CC      ui/egl-headless.o
/home/thuth/devel/qemu/ui/egl-headless.c: In function =E2=80=98egl_headle=
ss_init=E2=80=99:
/home/thuth/devel/qemu/ui/egl-headless.c:142:5: error: implicit declarati=
on of function =E2=80=98egl_rendernode_init=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
     if (egl_rendernode_init(NULL) < 0) {
     ^
/home/thuth/devel/qemu/ui/egl-headless.c:142:5: error: nested extern decl=
aration of =E2=80=98egl_rendernode_init=E2=80=99 [-Werror=3Dnested-extern=
s]
cc1: all warnings being treated as errors
make: *** [ui/egl-headless.o] Error 1

The problem is likely that the prototype in egl-helpers.h is
protected with some "#ifdef CONFIG_OPENGL_DMABUF" ... so should
the code in egl-headless.c put into such conditionals, too?

 Thomas


On 05.05.2017 12:41, Gerd Hoffmann wrote:
> Add egl-headless user interface.  It doesn't provide a real user
> interface, it only provides opengl support using drm render nodes.
> It will copy back the bits rendered by the guest using virgl back
> to a DisplaySurface and kick the usual display update code paths,
> so spice and vnc and screendump can pick it up.
>=20
> Use it this way:
>   qemu -display egl-headless -vnc $display
>   qemu -display egl-headless -spice gl=3Doff,$args
>=20
> Note that you should prefer native spice opengl support (-spice
> gl=3Don) if possible because that delivers better performance.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h |   3 +
>  ui/egl-headless.c    | 158 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  vl.c                 |  16 ++++++
>  ui/Makefile.objs     |   1 +
>  4 files changed, 178 insertions(+)
>  create mode 100644 ui/egl-headless.c
>=20
> diff --git a/include/ui/console.h b/include/ui/console.h
> index d759338816..7262bef6d3 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -527,4 +527,7 @@ static inline void early_gtk_display_init(int openg=
l)
>  }
>  #endif
> =20
> +/* egl-headless.c */
> +void egl_headless_init(void);
> +
>  #endif
> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> new file mode 100644
> index 0000000000..d8d800f8a6
> --- /dev/null
> +++ b/ui/egl-headless.c
> @@ -0,0 +1,158 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "sysemu/sysemu.h"
> +#include "ui/console.h"
> +#include "ui/egl-helpers.h"
> +#include "ui/egl-context.h"
> +
> +typedef struct egl_dpy {
> +    DisplayChangeListener dcl;
> +    DisplaySurface *ds;
> +    int width, height;
> +    GLuint texture;
> +    GLuint framebuffer;
> +    GLuint blit_texture;
> +    GLuint blit_framebuffer;
> +    bool y_0_top;
> +} egl_dpy;
> +
> +static void egl_refresh(DisplayChangeListener *dcl)
> +{
> +    graphic_hw_update(dcl->con);
> +}
> +
> +static void egl_gfx_update(DisplayChangeListener *dcl,
> +                           int x, int y, int w, int h)
> +{
> +}
> +
> +static void egl_gfx_switch(DisplayChangeListener *dcl,
> +                           struct DisplaySurface *new_surface)
> +{
> +    egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> +
> +    edpy->ds =3D new_surface;
> +}
> +
> +static void egl_scanout_disable(DisplayChangeListener *dcl)
> +{
> +    egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> +
> +    edpy->texture =3D 0;
> +    /* XXX: delete framebuffers here ??? */
> +}
> +
> +static void egl_scanout_texture(DisplayChangeListener *dcl,
> +                                uint32_t backing_id,
> +                                bool backing_y_0_top,
> +                                uint32_t backing_width,
> +                                uint32_t backing_height,
> +                                uint32_t x, uint32_t y,
> +                                uint32_t w, uint32_t h)
> +{
> +    egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> +
> +    edpy->texture =3D backing_id;
> +    edpy->y_0_top =3D backing_y_0_top;
> +
> +    /* source framebuffer */
> +    if (!edpy->framebuffer) {
> +        glGenFramebuffers(1, &edpy->framebuffer);
> +    }
> +    glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->framebuffer);
> +    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0=
_EXT,
> +                              GL_TEXTURE_2D, edpy->texture, 0);
> +
> +    /* dest framebuffer */
> +    if (!edpy->blit_framebuffer) {
> +        glGenFramebuffers(1, &edpy->blit_framebuffer);
> +        glGenTextures(1, &edpy->blit_texture);
> +        edpy->width =3D 0;
> +        edpy->height =3D 0;
> +    }
> +    if (edpy->width !=3D backing_width || edpy->height !=3D backing_he=
ight) {
> +        edpy->width   =3D backing_width;
> +        edpy->height  =3D backing_height;
> +        glBindTexture(GL_TEXTURE_2D, edpy->blit_texture);
> +        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB,
> +                     edpy->width, edpy->height,
> +                     0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
> +        glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->blit_framebuffer);
> +        glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHM=
ENT0_EXT,
> +                                  GL_TEXTURE_2D, edpy->blit_texture, 0=
);
> +    }
> +}
> +
> +static void egl_scanout_flush(DisplayChangeListener *dcl,
> +                              uint32_t x, uint32_t y,
> +                              uint32_t w, uint32_t h)
> +{
> +    egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> +    GLuint y1, y2;
> +
> +    if (!edpy->texture || !edpy->ds) {
> +        return;
> +    }
> +    assert(surface_width(edpy->ds)  =3D=3D edpy->width);
> +    assert(surface_height(edpy->ds) =3D=3D edpy->height);
> +    assert(surface_format(edpy->ds) =3D=3D PIXMAN_x8r8g8b8);
> +
> +    /* blit framebuffer, flip if needed */
> +    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->framebuffer);
> +    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, edpy->blit_framebuffer);
> +    glViewport(0, 0, edpy->width, edpy->height);
> +    y1 =3D edpy->y_0_top ? edpy->height : 0;
> +    y2 =3D edpy->y_0_top ? 0 : edpy->height;
> +    glBlitFramebuffer(0, y1, edpy->width, y2,
> +                      0, 0, edpy->width, edpy->height,
> +                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
> +
> +    /* read pixels to surface */
> +    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->blit_framebuffer);
> +    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
> +    glReadPixels(0, 0, edpy->width, edpy->height,
> +                 GL_BGRA, GL_UNSIGNED_BYTE, surface_data(edpy->ds));
> +
> +    /* notify about updates */
> +    dpy_gfx_update(edpy->dcl.con, x, y, w, h);
> +}
> +
> +static const DisplayChangeListenerOps egl_ops =3D {
> +    .dpy_name                =3D "egl-headless",
> +    .dpy_refresh             =3D egl_refresh,
> +    .dpy_gfx_update          =3D egl_gfx_update,
> +    .dpy_gfx_switch          =3D egl_gfx_switch,
> +
> +    .dpy_gl_ctx_create       =3D qemu_egl_create_context,
> +    .dpy_gl_ctx_destroy      =3D qemu_egl_destroy_context,
> +    .dpy_gl_ctx_make_current =3D qemu_egl_make_context_current,
> +    .dpy_gl_ctx_get_current  =3D qemu_egl_get_current_context,
> +
> +    .dpy_gl_scanout_disable  =3D egl_scanout_disable,
> +    .dpy_gl_scanout_texture  =3D egl_scanout_texture,
> +    .dpy_gl_update           =3D egl_scanout_flush,
> +};
> +
> +void egl_headless_init(void)
> +{
> +    QemuConsole *con;
> +    egl_dpy *edpy;
> +    int idx;
> +
> +    if (egl_rendernode_init(NULL) < 0) {
> +        error_report("egl: render node init failed");
> +        exit(1);
> +    }
> +
> +    for (idx =3D 0;; idx++) {
> +        con =3D qemu_console_lookup_by_index(idx);
> +        if (!con || !qemu_console_is_graphic(con)) {
> +            break;
> +        }
> +
> +        edpy =3D g_new0(egl_dpy, 1);
> +        edpy->dcl.con =3D con;
> +        edpy->dcl.ops =3D &egl_ops;
> +        register_displaychangelistener(&edpy->dcl);
> +    }
> +}
> diff --git a/vl.c b/vl.c
> index f46e070e0d..4e76e0ceb4 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2050,6 +2050,7 @@ typedef enum DisplayType {
>      DT_SDL,
>      DT_COCOA,
>      DT_GTK,
> +    DT_EGL,
>      DT_NONE,
>  } DisplayType;
> =20
> @@ -2127,6 +2128,15 @@ static DisplayType select_display(const char *p)
>              error_report("VNC requires a display argument vnc=3D<displ=
ay>");
>              exit(1);
>          }
> +    } else if (strstart(p, "egl-headless", &opts)) {
> +#ifdef CONFIG_OPENGL
> +        request_opengl =3D 1;
> +        display_opengl =3D 1;
> +        display =3D DT_EGL;
> +#else
> +        fprintf(stderr, "egl support is disabled\n");
> +        exit(1);
> +#endif
>      } else if (strstart(p, "curses", &opts)) {
>  #ifdef CONFIG_CURSES
>          display =3D DT_CURSES;
> @@ -4662,6 +4672,12 @@ int main(int argc, char **argv, char **envp)
>          qemu_spice_display_init();
>      }
> =20
> +#ifdef CONFIG_OPENGL
> +    if (display_type =3D=3D DT_EGL) {
> +        egl_headless_init();
> +    }
> +#endif
> +
>      if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
>          exit(1);
>      }
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index 27566b32f1..aac6ae8bef 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -33,6 +33,7 @@ common-obj-y +=3D shader.o
>  common-obj-y +=3D console-gl.o
>  common-obj-y +=3D egl-helpers.o
>  common-obj-y +=3D egl-context.o
> +common-obj-y +=3D egl-headless.o
>  ifeq ($(CONFIG_GTK_GL),y)
>  common-obj-$(CONFIG_GTK) +=3D gtk-gl-area.o
>  else
>=20
