Received: from eggs.gnu.org ([2001:4830:134:3::10]:42732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fQsJ6-00021G-73
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fQsJ4-0001zK-P2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:38:16 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fQsJ4-0001yW-Dh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:38:14 -0400
Received: by mail-wr0-x243.google.com with SMTP id x4-v6so1384802wro.11
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 03:38:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010135453.6704-2-kraxel@redhat.com>
References: <20171010135453.6704-1-kraxel@redhat.com>
	<20171010135453.6704-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Jun 2018 12:38:12 +0200
Message-ID: <CAJ+F1C+cJ5q7+OMPENg44A8kE8qOj0b0MOnqXLWoHMwo41yDdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] console: add support for dmabufs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, intel-gvt-dev@lists.freedesktop.org, Tina Zhang <tina.zhang@intel.com>

Hi Gerd

On Tue, Oct 10, 2017 at 3:54 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> This patch adds support for dma-bufs to the qemu console interfaces.
> It adds a new "struct QemuDmaBuf" to represent a dmabuf with accociated
> metatdata (size, format).  It adds three functions (and
> DisplayChangeListenerOps operations) to set a dma-buf as display
> scanout, as cursor and to release a dmabuf.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qemu/typedefs.h |  1 +
>  include/ui/console.h    | 25 +++++++++++++++++++++++++
>  ui/console.c            | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 980d2b330e..3dbc69b1e9 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -83,6 +83,7 @@ typedef struct PropertyInfo PropertyInfo;
>  typedef struct PS2State PS2State;
>  typedef struct QEMUBH QEMUBH;
>  typedef struct QemuConsole QemuConsole;
> +typedef struct QemuDmaBuf QemuDmaBuf;
>  typedef struct QEMUFile QEMUFile;
>  typedef struct QemuOpt QemuOpt;
>  typedef struct QemuOpts QemuOpts;
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 6966e4bd9d..158969f978 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -5,6 +5,7 @@
>  #include "qom/object.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qemu/notify.h"
> +#include "qemu/typedefs.h"
>  #include "qapi-types.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -180,6 +181,15 @@ struct QEMUGLParams {
>      int minor_ver;
>  };
>
> +struct QemuDmaBuf {
> +    int       fd;
> +    uint32_t  width;
> +    uint32_t  height;
> +    uint32_t  stride;
> +    uint32_t  fourcc;
> +    uint32_t  texture;
> +};
> +
>  typedef struct DisplayChangeListenerOps {
>      const char *dpy_name;
>
> @@ -220,6 +230,13 @@ typedef struct DisplayChangeListenerOps {
>                                     uint32_t backing_height,
>                                     uint32_t x, uint32_t y,
>                                     uint32_t w, uint32_t h);
> +    void (*dpy_gl_scanout_dmabuf)(DisplayChangeListener *dcl,
> +                                  QemuDmaBuf *dmabuf);
> +    void (*dpy_gl_cursor_dmabuf)(DisplayChangeListener *dcl,
> +                                 QemuDmaBuf *dmabuf,
> +                                 uint32_t pos_x, uint32_t pos_y);
> +    void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
> +                                  QemuDmaBuf *dmabuf);
>      void (*dpy_gl_update)(DisplayChangeListener *dcl,
>                            uint32_t x, uint32_t y, uint32_t w, uint32_t h=
);
>
> @@ -288,6 +305,13 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                              uint32_t backing_id, bool backing_y_0_top,
>                              uint32_t backing_width, uint32_t backing_hei=
ght,
>                              uint32_t x, uint32_t y, uint32_t w, uint32_t=
 h);
> +void dpy_gl_scanout_dmabuf(QemuConsole *con,
> +                           QemuDmaBuf *dmabuf);
> +void dpy_gl_cursor_dmabuf(QemuConsole *con,
> +                          QemuDmaBuf *dmabuf,
> +                          uint32_t pos_x, uint32_t pos_y);
> +void dpy_gl_release_dmabuf(QemuConsole *con,
> +                           QemuDmaBuf *dmabuf);
>  void dpy_gl_update(QemuConsole *con,
>                     uint32_t x, uint32_t y, uint32_t w, uint32_t h);
>
> @@ -298,6 +322,7 @@ int dpy_gl_ctx_make_current(QemuConsole *con, QEMUGLC=
ontext ctx);
>  QEMUGLContext dpy_gl_ctx_get_current(QemuConsole *con);
>
>  bool console_has_gl(QemuConsole *con);
> +bool console_has_gl_dmabuf(QemuConsole *con);
>
>  static inline int surface_stride(DisplaySurface *s)
>  {
> diff --git a/ui/console.c b/ui/console.c
> index b82c27960a..eca854cbd5 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1404,6 +1404,11 @@ bool console_has_gl(QemuConsole *con)
>      return con->gl !=3D NULL;
>  }
>
> +bool console_has_gl_dmabuf(QemuConsole *con)
> +{
> +    return con->gl !=3D NULL && con->gl->ops->dpy_gl_scanout_dmabuf !=3D=
 NULL;
> +}

You added this function, but it is not being used. Somewhere it should
be used to prevent crashes of dpy_gl_scanout_dmabuf()  though. I don't
have a good idea where to atm.

> +
>  void register_displaychangelistener(DisplayChangeListener *dcl)
>  {
>      static const char nodev[] =3D
> @@ -1745,6 +1750,34 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                                           x, y, width, height);
>  }
>
> +void dpy_gl_scanout_dmabuf(QemuConsole *con,
> +                           QemuDmaBuf *dmabuf)
> +{
> +    assert(con->gl);
> +    con->gl->ops->dpy_gl_scanout_dmabuf(con->gl, dmabuf);
> +}
> +
> +void dpy_gl_cursor_dmabuf(QemuConsole *con,
> +                          QemuDmaBuf *dmabuf,
> +                          uint32_t pos_x, uint32_t pos_y)
> +{
> +    assert(con->gl);
> +
> +    if (con->gl->ops->dpy_gl_cursor_dmabuf) {
> +        con->gl->ops->dpy_gl_cursor_dmabuf(con->gl, dmabuf, pos_x, pos_y=
);
> +    }
> +}
> +
> +void dpy_gl_release_dmabuf(QemuConsole *con,
> +                          QemuDmaBuf *dmabuf)
> +{
> +    assert(con->gl);
> +
> +    if (con->gl->ops->dpy_gl_release_dmabuf) {
> +        con->gl->ops->dpy_gl_release_dmabuf(con->gl, dmabuf);
> +    }
> +}
> +
>  void dpy_gl_update(QemuConsole *con,
>                     uint32_t x, uint32_t y, uint32_t w, uint32_t h)
>  {
> --
> 2.9.3
>
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev



--=20
Marc-Andr=C3=A9 Lureau
