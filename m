Received: from eggs.gnu.org ([209.51.188.92]:45788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gmUbW-0003Lv-WA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gmUMe-0005Bl-2u
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:03:32 -0500
Received: from speedy.comstyle.com ([206.51.28.2]:30028 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gmUMd-0005BZ-PP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:03:32 -0500
References: <20190124013625.27239-1-philmd@redhat.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <777d8a79-39b8-d287-f09d-d0e2e1769536@comstyle.com>
Date: Wed, 23 Jan 2019 21:03:27 -0500
MIME-Version: 1.0
In-Reply-To: <20190124013625.27239-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] ui/egl: Silent '__HAIKU__ undefined'
 warnings on OpenBSD 6.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

https://cgit.freedesktop.org/mesa/mesa/commit/include/EGL/eglplatform.h?i=
d=3Df744c6c1e28fe363474550b94af42a8b7fc1c755

Unfortunately that issue has only been fixed very recently.

There is a possibility of us updating from Mesa 17.3.9 to 18.3.x which
would bring in this header fix, but I don't know how long that will be
and it's currently held up on us switching i386 from bfd ld to lld.

So this header exists as is from 6.0 to the latest, most likely next rele=
ase
(6.5) too.

Honestly I think it would be better to just ignore this particular=20
issue. It's
an issue with a header outside of QEMU and it will go away in time when
Mesa is eventually updated.

On 1/23/2019 8:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> OpenBSD display various warnings about the use of an undefined __HAIKU_=
_:
>
>      CC      ui/egl-context.o
>    In file included from /usr/X11R6/include/epoxy/egl_generated.h:10:0,
>                     from /usr/X11R6/include/epoxy/egl.h:46,
>                     from include/ui/egl-helpers.h:5,
>                     from include/ui/egl-context.h:5,
>                     from ui/egl-context.c:3:
>    /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is =
not defined [-Wundef]
>     #elif __HAIKU__
>           ^
>    CC      ui/egl-helpers.o
> /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is not=
 defined [-Wundef]
>    CC      ui/egl-headless.o
> /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is not=
 defined [-Wundef]
>
> This is due to a old <epoxy/egl_generated.h>:
>
>       70 #if defined(_WIN32) || defined(__VC32__) && !defined(__CYGWIN_=
_) && !defined(__SCITECH_SNAP__) /* Win32 and WinCE */
>          ...
>      108 #elif defined(__unix__) || defined(__APPLE__)
>      128 #elif __HAIKU__
>      134 #else
>      135 #error "Platform not recognized"
>      136 #endif
>
> Kludge this by adding a check to ./configure: if this warning occurs,
> define __HAIKU__ from the CFLAGS.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This is ugly, hopefully someone can come with a clever idea :)
>
>   configure | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/configure b/configure
> index 8f312ac3e2..7c7eee44da 100755
> --- a/configure
> +++ b/configure
> @@ -4036,6 +4036,17 @@ EOF
>     if compile_prog "" "" ; then
>       opengl_dmabuf=3Dyes
>     fi
> +  cat > $TMPC << EOF
> +#include <epoxy/egl.h>
> +int main(void) { return 0; }
> +EOF
> +  if test "$targetos" =3D "OpenBSD" ; then
> +    if ! compile_prog "-Wundef -Werror" "" ; then
> +      if compile_prog "-Wundef -Werror -D__HAIKU__=3D0" "" ; then
> +        QEMU_CFLAGS=3D"$QEMU_CFLAGS -D__HAIKU__=3D0"
> +      fi
> +    fi
> +  fi
>   fi
>  =20
>   ##########################################
