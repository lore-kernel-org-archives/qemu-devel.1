Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAys-0007yC-7N
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAyq-0006oD-Fo
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:06 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etAyq-0006mn-69
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:04 -0500
Received: by mail-wm0-x242.google.com with SMTP id z9so21529924wmb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:42:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306083832.8144-2-kraxel@redhat.com>
References: <20180306083832.8144-1-kraxel@redhat.com>
	<20180306083832.8144-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Mar 2018 12:42:02 +0100
Message-ID: <CAJ+F1CLUxMv6snmfg3jLYtd=JsOGJQMJgZinyd=BuCrJvsDuSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] spice: drop dprint() debug logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Mar 6, 2018 at 9:38 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Some calls are deleted, some are converted into tracepoints.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/spice-display.c | 75 ++++++++++++++++--------------------------------=
------
>  ui/trace-events    |  9 +++++++
>  2 files changed, 31 insertions(+), 53 deletions(-)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 98ccdfb687..f3ae6beb3d 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -26,20 +26,8 @@
>
>  #include "ui/spice-display.h"
>
> -static int debug =3D 0;
>  bool spice_opengl;
>
> -static void GCC_FMT_ATTR(2, 3) dprint(int level, const char *fmt, ...)
> -{
> -    va_list args;
> -
> -    if (level <=3D debug) {
> -        va_start(args, fmt);
> -        vfprintf(stderr, fmt, args);
> -        va_end(args);
> -    }
> -}
> -
>  int qemu_spice_rect_is_empty(const QXLRect* r)
>  {
>      return r->top =3D=3D r->bottom || r->left =3D=3D r->right;
> @@ -322,8 +310,6 @@ void qemu_spice_create_host_memslot(SimpleSpiceDispla=
y *ssd)
>  {
>      QXLDevMemSlot memslot;
>
> -    dprint(1, "%s/%d:\n", __func__, ssd->qxl.id);
> -
>      memset(&memslot, 0, sizeof(memslot));
>      memslot.slot_group_id =3D MEMSLOT_GROUP_HOST;
>      memslot.virt_end =3D ~0;
> @@ -347,10 +333,6 @@ void qemu_spice_create_host_primary(SimpleSpiceDispl=
ay *ssd)
>          ssd->buf =3D g_malloc(ssd->bufsize);
>      }
>
> -    dprint(1, "%s/%d: %ux%u (size %" PRIu64 "/%d)\n", __func__, ssd->qxl=
.id,
> -           surface_width(ssd->ds), surface_height(ssd->ds),
> -           surface_size, ssd->bufsize);
> -
>      surface.format     =3D SPICE_SURFACE_FMT_32_xRGB;
>      surface.width      =3D surface_width(ssd->ds);
>      surface.height     =3D surface_height(ssd->ds);
> @@ -366,8 +348,6 @@ void qemu_spice_create_host_primary(SimpleSpiceDispla=
y *ssd)
>
>  void qemu_spice_destroy_host_primary(SimpleSpiceDisplay *ssd)
>  {
> -    dprint(1, "%s/%d:\n", __func__, ssd->qxl.id);
> -
>      qemu_spice_destroy_primary_surface(ssd, 0, QXL_SYNC);
>  }
>
> @@ -389,8 +369,7 @@ void qemu_spice_display_update(SimpleSpiceDisplay *ss=
d,
>  {
>      QXLRect update_area;
>
> -    dprint(2, "%s/%d: x %d y %d w %d h %d\n", __func__,
> -           ssd->qxl.id, x, y, w, h);
> +    trace_qemu_spice_display_update(ssd->qxl.id, x, y, w, h);
>      update_area.left =3D x,
>      update_area.right =3D x + w;
>      update_area.top =3D y;
> @@ -413,8 +392,10 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *s=
sd,
>          surface_height(surface) =3D=3D pixman_image_get_height(ssd->surf=
ace) &&
>          surface_format(surface) =3D=3D pixman_image_get_format(ssd->surf=
ace)) {
>          /* no-resize fast path: just swap backing store */
> -        dprint(1, "%s/%d: fast (%dx%d)\n", __func__, ssd->qxl.id,
> -               surface_width(surface), surface_height(surface));
> +        trace_qemu_spice_display_surface(ssd->qxl.id,
> +                                         surface_width(surface),
> +                                         surface_height(surface),
> +                                         true);
>          qemu_mutex_lock(&ssd->lock);
>          ssd->ds =3D surface;
>          pixman_image_unref(ssd->surface);
> @@ -427,11 +408,10 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *=
ssd,
>      }
>
>      /* full mode switch */
> -    dprint(1, "%s/%d: full (%dx%d -> %dx%d)\n", __func__, ssd->qxl.id,
> -           ssd->surface ? pixman_image_get_width(ssd->surface)  : 0,
> -           ssd->surface ? pixman_image_get_height(ssd->surface) : 0,
> -           surface ? surface_width(surface)  : 0,
> -           surface ? surface_height(surface) : 0);
> +    trace_qemu_spice_display_surface(ssd->qxl.id,
> +                                     surface_width(surface),
> +                                     surface_height(surface),
> +                                     false);

You are now assuming surface is always !=3D NULL, but
dpy_gfx_replace_surface() for example, has assert( || surface =3D=3D NULL)
before calling dpy_gfx_switch(). If such invariants is added, it would
be nice to document it in DisplayChangeListenerOps declaration.

>
>      memset(&ssd->dirty, 0, sizeof(ssd->dirty));
>      if (ssd->surface) {
> @@ -495,7 +475,6 @@ void qemu_spice_cursor_refresh_bh(void *opaque)
>
>  void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
>  {
> -    dprint(3, "%s/%d:\n", __func__, ssd->qxl.id);
>      graphic_hw_update(ssd->dcl.con);
>
>      qemu_mutex_lock(&ssd->lock);
> @@ -505,10 +484,10 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay =
*ssd)
>      }
>      qemu_mutex_unlock(&ssd->lock);
>
> +    trace_qemu_spice_display_refresh(ssd->qxl.id, ssd->notify);
>      if (ssd->notify) {
>          ssd->notify =3D 0;
>          qemu_spice_wakeup(ssd);
> -        dprint(2, "%s/%d: notify\n", __func__, ssd->qxl.id);
>      }
>  }
>
> @@ -516,21 +495,17 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay =
*ssd)
>
>  static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_wor=
ker)
>  {
> -    SimpleSpiceDisplay *ssd =3D container_of(sin, SimpleSpiceDisplay, qx=
l);
> -
> -    dprint(1, "%s/%d:\n", __func__, ssd->qxl.id);
> +    /* nothing to do */
>  }
>
>  static void interface_set_compression_level(QXLInstance *sin, int level)
>  {
> -    dprint(1, "%s/%d:\n", __func__, sin->id);
>      /* nothing to do */
>  }
>
>  #if SPICE_NEEDS_SET_MM_TIME
>  static void interface_set_mm_time(QXLInstance *sin, uint32_t mm_time)
>  {
> -    dprint(3, "%s/%d:\n", __func__, sin->id);
>      /* nothing to do */
>  }
>  #endif
> @@ -554,8 +529,6 @@ static int interface_get_command(QXLInstance *sin, QX=
LCommandExt *ext)
>      SimpleSpiceUpdate *update;
>      int ret =3D false;
>
> -    dprint(3, "%s/%d:\n", __func__, ssd->qxl.id);
> -
>      qemu_mutex_lock(&ssd->lock);
>      update =3D QTAILQ_FIRST(&ssd->updates);
>      if (update !=3D NULL) {
> @@ -570,7 +543,6 @@ static int interface_get_command(QXLInstance *sin, QX=
LCommandExt *ext)
>
>  static int interface_req_cmd_notification(QXLInstance *sin)
>  {
> -    dprint(2, "%s/%d:\n", __func__, sin->id);
>      return 1;
>  }
>
> @@ -582,7 +554,6 @@ static void interface_release_resource(QXLInstance *s=
in,
>      SimpleSpiceCursor *cursor;
>      QXLCommandExt *ext;
>
> -    dprint(2, "%s/%d:\n", __func__, ssd->qxl.id);
>      ext =3D (void *)(intptr_t)(rext.info->id);
>      switch (ext->cmd.type) {
>      case QXL_CMD_DRAW:
> @@ -603,8 +574,6 @@ static int interface_get_cursor_command(QXLInstance *=
sin, QXLCommandExt *ext)
>      SimpleSpiceDisplay *ssd =3D container_of(sin, SimpleSpiceDisplay, qx=
l);
>      int ret;
>
> -    dprint(3, "%s/%d:\n", __func__, ssd->qxl.id);
> -
>      qemu_mutex_lock(&ssd->lock);
>      if (ssd->ptr_define) {
>          *ext =3D ssd->ptr_define->ext;
> @@ -623,7 +592,6 @@ static int interface_get_cursor_command(QXLInstance *=
sin, QXLCommandExt *ext)
>
>  static int interface_req_cursor_notification(QXLInstance *sin)
>  {
> -    dprint(2, "%s:\n", __func__);
>      return 1;
>  }
>
> @@ -680,7 +648,7 @@ static void interface_set_client_capabilities(QXLInst=
ance *sin,
>                                                uint8_t client_present,
>                                                uint8_t caps[58])
>  {
> -    dprint(3, "%s:\n", __func__);
> +    /* nothing to do */
>  }
>
>  static int interface_client_monitors_config(QXLInstance *sin,
> @@ -705,9 +673,9 @@ static int interface_client_monitors_config(QXLInstan=
ce *sin,
>          info.width  =3D mc->monitors[head].width;
>          info.height =3D mc->monitors[head].height;
>      }
> +
> +    trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
>      dpy_set_ui_info(ssd->dcl.con, &info);
> -    dprint(1, "%s/%d: size %dx%d\n", __func__, ssd->qxl.id,
> -           info.width, info.height);
>      return 1;
>  }
>
> @@ -902,9 +870,10 @@ static void spice_gl_switch(DisplayChangeListener *d=
cl,
>              return;
>          }
>
> -        dprint(1, "%s: %dx%d (stride %d/%d, fourcc 0x%x)\n", __func__,
> -               surface_width(ssd->ds), surface_height(ssd->ds),
> -               surface_stride(ssd->ds), stride, fourcc);
> +        trace_qemu_spice_gl_surface(ssd->qxl.id,
> +                                    surface_width(ssd->ds),
> +                                    surface_height(ssd->ds),
> +                                    fourcc);
>
>          /* note: spice server will close the fd */
>          spice_qxl_gl_scanout(&ssd->qxl, fd,
> @@ -932,7 +901,7 @@ static void qemu_spice_gl_scanout_disable(DisplayChan=
geListener *dcl)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>
> -    dprint(1, "%s: no framebuffer\n", __func__);
> +    trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
>      spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
>      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
>      ssd->have_surface =3D false;
> @@ -957,8 +926,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChan=
geListener *dcl,
>          fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
>          return;
>      }
> -    dprint(1, "%s: %dx%d (stride %d, fourcc 0x%x)\n", __func__,
> -           w, h, stride, fourcc);
> +    trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
>
>      /* note: spice server will close the fd */
>      spice_qxl_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
> @@ -978,7 +946,8 @@ static void qemu_spice_gl_update(DisplayChangeListene=
r *dcl,
>          return;
>      }
>
> -    dprint(2, "%s: %dx%d+%d+%d\n", __func__, w, h, x, y);
> +
> +    trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
>      qemu_spice_gl_block(ssd, true);
>      cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0=
);
>      spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
> diff --git a/ui/trace-events b/ui/trace-events
> index 861b68a305..518e950a01 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -75,6 +75,15 @@ qemu_spice_create_primary_surface(int qid, uint32_t si=
d, void *surface, int asyn
>  qemu_spice_destroy_primary_surface(int qid, uint32_t sid, int async) "%d=
 sid=3D%u async=3D%d"
>  qemu_spice_wakeup(uint32_t qid) "%d"
>  qemu_spice_create_update(uint32_t left, uint32_t right, uint32_t top, ui=
nt32_t bottom) "lr %d -> %d,  tb -> %d -> %d"
> +qemu_spice_display_update(int qid, uint32_t x, uint32_t y, uint32_t w, u=
int32_t h) "%d +%d+%d %dx%d"
> +qemu_spice_display_surface(int qid, uint32_t w, uint32_t h, int fast) "%=
d %dx%d, fast %d"
> +qemu_spice_display_refresh(int qid, int notify) "%d notify %d"
> +qemu_spice_ui_info(int qid, uint32_t width, uint32_t height) "%d %dx%d"
> +
> +qemu_spice_gl_surface(int qid, uint32_t w, uint32_t h, uint32_t fourcc) =
"%d %dx%d, fourcc 0x%x"
> +qemu_spice_gl_scanout_disable(int qid) "%d"
> +qemu_spice_gl_scanout_texture(int qid, uint32_t w, uint32_t h, uint32_t =
fourcc) "%d %dx%d, fourcc 0x%x"
> +qemu_spice_gl_update(int qid, uint32_t x, uint32_t y, uint32_t w, uint32=
_t h) "%d +%d+%d %dx%d"
>
>  # ui/keymaps.c
>  keymap_parse(const char *file) "file %s"
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
