Received: from eggs.gnu.org ([209.51.188.92]:54214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjUrH-0003f5-SI
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjUrD-0006BJ-Rz
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:58:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjUr9-00062J-CQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:58:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so4565671wmc.5
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:58:35 -0800 (PST)
References: <20190115115047.39326-1-alex.kanavin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bde5dc1a-2ec3-98fa-1b4c-9147ddbadd86@redhat.com>
Date: Tue, 15 Jan 2019 20:58:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190115115047.39326-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: add a missing X11 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Kanavin <alex.kanavin@gmail.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi Alexander,

Cc'ing Gerd (the maintainer) and Marc-André.

On 1/15/19 12:50 PM, Alexander Kanavin wrote:
> Otherwise these errors occur, when qemu is built in the Yocto project:
> | In file included from /home/alexander/development/poky/build-virgl-gtk-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3.1.0/include/ui/egl-context.h:5,
> |                  from /home/alexander/development/poky/build-virgl-gtk-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3.1.0/ui/egl-context.c:3:
> | /home/alexander/development/poky/build-virgl-gtk-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3.1.0/include/ui/egl-helpers.h:46:55: error: unknown type name 'Window'; did you mean 'minor'?
> |  EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
> |                                                        ^~~~~~
> |                                                        minor

Can you provide more information to reproduce this failure?

It seems some dependency is missing in your build setup. Missing headers
would trigger the definition of MESA_EGL_NO_X11_HEADERS and this error.

<epoxy/egl.h> includes <EGL/eglplatform.h> which contains:

  #if defined(MESA_EGL_NO_X11_HEADERS)
  typedef void            *EGLNativeDisplayType;
  typedef khronos_uintptr_t EGLNativePixmapType;
  typedef khronos_uintptr_t EGLNativeWindowType;
  #else
  /* X11 (tentative)  */
  #include <X11/Xlib.h>

So Window should already be declared.

Thanks,

Phil.

> 
> Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
> ---
>  include/ui/egl-helpers.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 9db7293bdb..2c32d77e7a 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -4,6 +4,7 @@
>  #include <epoxy/gl.h>
>  #include <epoxy/egl.h>
>  #include <gbm.h>
> +#include <X11/Xlib.h>
>  
>  extern EGLDisplay *qemu_egl_display;
>  extern EGLConfig qemu_egl_config;
> 
