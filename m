Received: from eggs.gnu.org ([2001:4830:134:3::10]:37571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biK-0000yv-FD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biJ-00076L-CL
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:48:00 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biJ-00076D-7L
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:47:59 -0400
Received: by mail-qk0-x242.google.com with SMTP id k74so442501qke.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 04:47:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505104101.30589-1-kraxel@redhat.com>
	<20170505104101.30589-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <61d9cc26-29e8-285d-8e62-b33c45184139@amsat.org>
Date: Fri, 5 May 2017 08:47:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170505104101.30589-3-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] egl-helpers: drop support for gles and
 debug logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 05/05/2017 07:40 AM, Gerd Hoffmann wrote:
> Leftover from the early opengl days.
> Unused now, so delete the dead code.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/ui/egl-helpers.h |  2 +-
>  ui/egl-helpers.c         | 52 +++++-------------------------------------------
>  ui/gtk-egl.c             |  2 +-
>  3 files changed, 7 insertions(+), 49 deletions(-)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 88a13e827b..fec7da14a5 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -21,7 +21,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc);
>
>  EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
>
> -int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug);
> +int qemu_egl_init_dpy(EGLNativeDisplayType dpy);
>  EGLContext qemu_egl_init_ctx(void);
>
>  #endif /* EGL_HELPERS_H */
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index b7b6b2e3cc..a3d7c3d7f5 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -26,18 +26,6 @@ EGLConfig qemu_egl_config;
>
>  /* ---------------------------------------------------------------------- */
>
> -static bool egl_gles;
> -static int egl_debug;
> -
> -#define egl_dbg(_x ...)                          \
> -    do {                                         \
> -        if (egl_debug) {                         \
> -            fprintf(stderr, "egl: " _x);         \
> -        }                                        \
> -    } while (0);
> -
> -/* ---------------------------------------------------------------------- */
> -
>  #ifdef CONFIG_OPENGL_DMABUF
>
>  int qemu_egl_rn_fd;
> @@ -105,7 +93,7 @@ int egl_rendernode_init(const char *rendernode)
>          goto err;
>      }
>
> -    qemu_egl_init_dpy((EGLNativeDisplayType)qemu_egl_rn_gbm_dev, false, false);
> +    qemu_egl_init_dpy((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
>
>      if (!epoxy_has_egl_extension(qemu_egl_display,
>                                   "EGL_KHR_surfaceless_context")) {
> @@ -171,8 +159,6 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win)
>      EGLSurface esurface;
>      EGLBoolean b;
>
> -    egl_dbg("eglCreateWindowSurface (x11 win id 0x%lx) ...\n",
> -            (unsigned long) win);
>      esurface = eglCreateWindowSurface(qemu_egl_display,
>                                        qemu_egl_config,
>                                        (EGLNativeWindowType)win, NULL);
> @@ -242,7 +228,7 @@ static EGLDisplay qemu_egl_get_display(void *native)
>      return dpy;
>  }
>
> -int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
> +int qemu_egl_init_dpy(EGLNativeDisplayType dpy)
>  {
>      static const EGLint conf_att_gl[] = {
>          EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
> @@ -253,56 +239,34 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
>          EGL_ALPHA_SIZE, 0,
>          EGL_NONE,
>      };
> -    static const EGLint conf_att_gles[] = {
> -        EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
> -        EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
> -        EGL_RED_SIZE,   5,
> -        EGL_GREEN_SIZE, 5,
> -        EGL_BLUE_SIZE,  5,
> -        EGL_ALPHA_SIZE, 0,
> -        EGL_NONE,
> -    };
>      EGLint major, minor;
>      EGLBoolean b;
>      EGLint n;
>
> -    if (debug) {
> -        egl_debug = 1;
> -        setenv("EGL_LOG_LEVEL", "debug", true);
> -        setenv("LIBGL_DEBUG", "verbose", true);
> -    }
> -
> -    egl_dbg("qemu_egl_get_display (dpy %p) ...\n", dpy);
>      qemu_egl_display = qemu_egl_get_display(dpy);
>      if (qemu_egl_display == EGL_NO_DISPLAY) {
>          error_report("egl: eglGetDisplay failed");
>          return -1;
>      }
>
> -    egl_dbg("eglInitialize ...\n");
>      b = eglInitialize(qemu_egl_display, &major, &minor);
>      if (b == EGL_FALSE) {
>          error_report("egl: eglInitialize failed");
>          return -1;
>      }
>
> -    egl_dbg("eglBindAPI ...\n");
> -    b = eglBindAPI(gles ? EGL_OPENGL_ES_API : EGL_OPENGL_API);
> +    b = eglBindAPI(EGL_OPENGL_API);
>      if (b == EGL_FALSE) {
>          error_report("egl: eglBindAPI failed");
>          return -1;
>      }
>
> -    egl_dbg("eglChooseConfig ...\n");
> -    b = eglChooseConfig(qemu_egl_display,
> -                        gles ? conf_att_gles : conf_att_gl,
> +    b = eglChooseConfig(qemu_egl_display, conf_att_gl,
>                          &qemu_egl_config, 1, &n);
>      if (b == EGL_FALSE || n != 1) {
>          error_report("egl: eglChooseConfig failed");
>          return -1;
>      }
> -
> -    egl_gles = gles;
>      return 0;
>  }
>
> @@ -311,17 +275,11 @@ EGLContext qemu_egl_init_ctx(void)
>      static const EGLint ctx_att_gl[] = {
>          EGL_NONE
>      };
> -    static const EGLint ctx_att_gles[] = {
> -        EGL_CONTEXT_CLIENT_VERSION, 2,
> -        EGL_NONE
> -    };
> -
>      EGLContext ectx;
>      EGLBoolean b;
>
> -    egl_dbg("eglCreateContext ...\n");
>      ectx = eglCreateContext(qemu_egl_display, qemu_egl_config, EGL_NO_CONTEXT,
> -                            egl_gles ? ctx_att_gles : ctx_att_gl);
> +                            ctx_att_gl);
>      if (ectx == EGL_NO_CONTEXT) {
>          error_report("egl: eglCreateContext failed");
>          return NULL;
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index d53288f027..89492c0e02 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -246,7 +246,7 @@ void gtk_egl_init(void)
>      GdkDisplay *gdk_display = gdk_display_get_default();
>      Display *x11_display = gdk_x11_display_get_xdisplay(gdk_display);
>
> -    if (qemu_egl_init_dpy(x11_display, false, false) < 0) {
> +    if (qemu_egl_init_dpy(x11_display) < 0) {
>          return;
>      }
>
>
