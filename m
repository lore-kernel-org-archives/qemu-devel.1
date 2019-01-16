Received: from eggs.gnu.org ([209.51.188.92]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjjuY-0000BZ-Lo
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjjuT-0005nL-0S
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:03:10 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjjuS-0005gl-QH
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:03:04 -0500
Received: by mail-wr1-f52.google.com with SMTP id t27so6624242wra.6
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 04:03:03 -0800 (PST)
References: <20190116113751.17177-1-alex.kanavin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f9b334b5-1c05-9ff2-5666-f37e5e1b1807@redhat.com>
Date: Wed, 16 Jan 2019 13:03:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190116113751.17177-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: do not depend on X11 Window
 type, use EGLNativeWindowType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Kanavin <alex.kanavin@gmail.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Cc'ing Gerd again.

$ ./scripts/get_maintainer.pl -f include/ui/egl-helpers.h
Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
qemu-devel@nongnu.org (open list:All patches CC here)

On 1/16/19 12:37 PM, Alexander Kanavin wrote:
> It was assumed that mesa provides the necessary X11 includes,
> but it is not always the case, as it can be configured without x11 support.
> 
> Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/ui/egl-helpers.h | 2 +-
>  ui/egl-helpers.c         | 4 ++--
>  ui/gtk-egl.c             | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 9db7293bdb..3fc656a7ba 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -43,7 +43,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
>  
>  #endif
>  
> -EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
> +EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowType win);
>  
>  int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode);
>  int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode);
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 4f475142fc..5e115b3fb4 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -273,14 +273,14 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
>  
>  /* ---------------------------------------------------------------------- */
>  
> -EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win)
> +EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowType win)
>  {
>      EGLSurface esurface;
>      EGLBoolean b;
>  
>      esurface = eglCreateWindowSurface(qemu_egl_display,
>                                        qemu_egl_config,
> -                                      (EGLNativeWindowType)win, NULL);
> +                                      win, NULL);
>      if (esurface == EGL_NO_SURFACE) {
>          error_report("egl: eglCreateWindowSurface failed");
>          return NULL;
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 5420c2362b..1f9411626a 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -54,7 +54,7 @@ void gd_egl_init(VirtualConsole *vc)
>      }
>  
>      vc->gfx.ectx = qemu_egl_init_ctx();
> -    vc->gfx.esurface = qemu_egl_init_surface_x11(vc->gfx.ectx, x11_window);
> +    vc->gfx.esurface = qemu_egl_init_surface_x11(vc->gfx.ectx, (EGLNativeWindowType)x11_window);
>  
>      assert(vc->gfx.esurface);
>  }
> 
