Received: from eggs.gnu.org ([209.51.188.92]:39811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjVix-0004bU-Dr
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjVcJ-00056M-GJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:47:25 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.kanavin@gmail.com>)
	id 1gjVcJ-00054F-63
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:47:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id s13so3840154otq.4
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 12:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20190115115047.39326-1-alex.kanavin@gmail.com>
	<bde5dc1a-2ec3-98fa-1b4c-9147ddbadd86@redhat.com>
In-Reply-To: <bde5dc1a-2ec3-98fa-1b4c-9147ddbadd86@redhat.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 15 Jan 2019 21:47:08 +0100
Message-ID: <CANNYZj8RLr0ZQJjgXD065WzuYUHbi-dCN1-j_gQNq+28U9h6Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: add a missing X11 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Tue, 15 Jan 2019 at 20:58, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Cc'ing Gerd (the maintainer) and Marc-Andr=C3=A9.
>
> On 1/15/19 12:50 PM, Alexander Kanavin wrote:
> > Otherwise these errors occur, when qemu is built in the Yocto project:
> > | In file included from /home/alexander/development/poky/build-virgl-gt=
k-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3=
.1.0/include/ui/egl-context.h:5,
> > |                  from /home/alexander/development/poky/build-virgl-gt=
k-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3=
.1.0/ui/egl-context.c:3:
> > | /home/alexander/development/poky/build-virgl-gtk-64/tmp/work/x86_64-n=
ativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3.1.0/include/ui/egl-he=
lpers.h:46:55: error: unknown type name 'Window'; did you mean 'minor'?
> > |  EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
> > |                                                        ^~~~~~
> > |                                                        minor
>
> Can you provide more information to reproduce this failure?
>
> It seems some dependency is missing in your build setup. Missing headers
> would trigger the definition of MESA_EGL_NO_X11_HEADERS and this error.
>
> <epoxy/egl.h> includes <EGL/eglplatform.h> which contains:
>
>   #if defined(MESA_EGL_NO_X11_HEADERS)
>   typedef void            *EGLNativeDisplayType;
>   typedef khronos_uintptr_t EGLNativePixmapType;
>   typedef khronos_uintptr_t EGLNativeWindowType;
>   #else
>   /* X11 (tentative)  */
>   #include <X11/Xlib.h>
>
> So Window should already be declared.

Hello Philippe,

we build mesa explicitly using "--with-platforms=3D'drm surfaceless'"
(x11 is not in the list), which means MESA_EGL_NO_X11_HEADERS is
indeed defined according to [1]. We also enable opengl and gtk in
qemu.
I believe this is a valid configuration, and so should not lead to
compile errors (we're fine if it will cause run-time errors for some
combinations of qemu options). A header should not rely on a
conditional include happening somewhere else.

[1] https://cgit.freedesktop.org/mesa/mesa/tree/configure.ac#n2533

Thanks,
Alex
