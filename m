Received: from eggs.gnu.org ([2001:4830:134:3::10]:60363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cdC8T-0006q2-0A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cdC8R-0008Kb-4r
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:37:25 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cdC8Q-0008JL-O4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:37:23 -0500
Received: by mail-lf0-x244.google.com with SMTP id h65so7662724lfi.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 00:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20170212112118.16044-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170212112118.16044-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Feb 2017 08:37:08 +0000
Message-ID: <CAJ+F1CJBwjp70CgzTCwXYQzcpn6X0r9ka80rc6DmqnJbgHZNUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice: allow to specify drm rendernode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hi Gerd,

Rendernode are not stable across reboots, it depends on module order.

I have further patches to specify a pci address instead:
rendernode=3D<file|pciaddr>. Does that seem fine?

Do you want me to squash and resend?

The current branch: https://github.com/elmarco/qemu/commits/spice

thanks

On Sun, Feb 12, 2017 at 3:23 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> When multiple GPU are available, picking the first one isn't always the
> best choice. Learn to specify a device rendernode.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/egl-helpers.h |  3 +--
>  ui/egl-helpers.c         | 10 +++++++---
>  ui/spice-core.c          |  5 ++++-
>  qemu-options.hx          |  6 +++++-
>  4 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 03fcf4bba2..88a13e827b 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -14,8 +14,7 @@ extern int qemu_egl_rn_fd;
>  extern struct gbm_device *qemu_egl_rn_gbm_dev;
>  extern EGLContext qemu_egl_rn_ctx;
>
> -int qemu_egl_rendernode_open(void);
> -int egl_rendernode_init(void);
> +int egl_rendernode_init(const char *rendernode);
>  int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint
> *fourcc);
>
>  #endif
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index cd24568a5e..417462b76d 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -44,13 +44,17 @@ int qemu_egl_rn_fd;
>  struct gbm_device *qemu_egl_rn_gbm_dev;
>  EGLContext qemu_egl_rn_ctx;
>
> -int qemu_egl_rendernode_open(void)
> +static int qemu_egl_rendernode_open(const char *rendernode)
>  {
>      DIR *dir;
>      struct dirent *e;
>      int r, fd;
>      char *p;
>
> +    if (rendernode) {
> +        return open(rendernode, O_RDWR | O_CLOEXEC | O_NOCTTY |
> O_NONBLOCK);
> +    }
> +
>      dir =3D opendir("/dev/dri");
>      if (!dir) {
>          return -1;
> @@ -85,11 +89,11 @@ int qemu_egl_rendernode_open(void)
>      return fd;
>  }
>
> -int egl_rendernode_init(void)
> +int egl_rendernode_init(const char *rendernode)
>  {
>      qemu_egl_rn_fd =3D -1;
>
> -    qemu_egl_rn_fd =3D qemu_egl_rendernode_open();
> +    qemu_egl_rn_fd =3D qemu_egl_rendernode_open(rendernode);
>      if (qemu_egl_rn_fd =3D=3D -1) {
>          error_report("egl: no drm render node available");
>          goto err;
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 1452e77fd1..39ccab7561 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -501,6 +501,9 @@ static QemuOptsList qemu_spice_opts =3D {
>          },{
>              .name =3D "gl",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "rendernode",
> +            .type =3D QEMU_OPT_STRING,
>  #endif
>          },
>          { /* end of list */ }
> @@ -833,7 +836,7 @@ void qemu_spice_init(void)
>                           "incompatible with -spice port/tls-port");
>              exit(1);
>          }
> -        if (egl_rendernode_init() !=3D 0) {
> +        if (egl_rendernode_init(qemu_opt_get(opts, "rendernode")) !=3D 0=
) {
>              error_report("Failed to initialize EGL render node for SPICE
> GL");
>              exit(1);
>          }
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ac036b4cbd..b64087d934 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1066,7 +1066,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
>      "       [,streaming-video=3D[off|all|filter]][,disable-copy-paste]\n=
"
>      "       [,disable-agent-file-xfer][,agent-mouse=3D[on|off]]\n"
>      "
>  [,playback-compression=3D[on|off]][,seamless-migration=3D[on|off]]\n"
> -    "       [,gl=3D[on|off]]\n"
> +    "       [,gl=3D[on|off]][,rendernode=3D<file>]\n"
>      "   enable spice\n"
>      "   at least one of {port, tls-port} is mandatory\n",
>      QEMU_ARCH_ALL)
> @@ -1161,6 +1161,10 @@ Enable/disable spice seamless migration. Default i=
s
> off.
>  @item gl=3D[on|off]
>  Enable/disable OpenGL context. Default is off.
>
> +@item rendernode=3D<file>
> +DRM render node for OpenGL rendering. If not specified, it will pick
> +the first available. (Since 2.9)
> +
>  @end table
>  ETEXI
>
> --
> 2.11.0.295.gd7dffce1c.dirty
>
>
> --
Marc-Andr=C3=A9 Lureau
