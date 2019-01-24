Received: from eggs.gnu.org ([209.51.188.92]:43340)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmUIx-0000OU-QI
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmUIt-0007KW-CZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:59:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:45649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmUIp-00076I-07
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:59:36 -0500
References: <20190124013625.27239-1-philmd@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <48ad7886-5e8a-fc84-77ec-c76628fb6603@gmx.com>
Date: Thu, 24 Jan 2019 03:00:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190124013625.27239-1-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BcqKC9d1tcqf3QQIbxhGlGeRmsv8qp0XX"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcqKC9d1tcqf3QQIbxhGlGeRmsv8qp0XX
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Message-ID: <48ad7886-5e8a-fc84-77ec-c76628fb6603@gmx.com>
Subject: Re: [Qemu-devel] [RFC PATCH] ui/egl: Silent '__HAIKU__ undefined'
 warnings on OpenBSD 6.1
References: <20190124013625.27239-1-philmd@redhat.com>
In-Reply-To: <20190124013625.27239-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.01.2019 02:36, Philippe Mathieu-Daud=C3=A9 wrote:
> OpenBSD display various warnings about the use of an undefined __HAIKU_=
_:
>=20

Please report it to OpenBSD and/or 3rd party libs. It's just a warning
in public headers, not an issue on the qemu side.

>     CC      ui/egl-context.o
>   In file included from /usr/X11R6/include/epoxy/egl_generated.h:10:0,
>                    from /usr/X11R6/include/epoxy/egl.h:46,
>                    from include/ui/egl-helpers.h:5,
>                    from include/ui/egl-context.h:5,
>                    from ui/egl-context.c:3:
>   /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is n=
ot defined [-Wundef]
>    #elif __HAIKU__
>          ^
>   CC      ui/egl-helpers.o
> /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is not=
 defined [-Wundef]
>   CC      ui/egl-headless.o
> /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is not=
 defined [-Wundef]
>=20
> This is due to a old <epoxy/egl_generated.h>:
>=20
>      70 #if defined(_WIN32) || defined(__VC32__) && !defined(__CYGWIN__=
) && !defined(__SCITECH_SNAP__) /* Win32 and WinCE */
>         ...
>     108 #elif defined(__unix__) || defined(__APPLE__)
>     128 #elif __HAIKU__
>     134 #else
>     135 #error "Platform not recognized"
>     136 #endif
>=20
> Kludge this by adding a check to ./configure: if this warning occurs,
> define __HAIKU__ from the CFLAGS.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This is ugly, hopefully someone can come with a clever idea :)
>=20
>  configure | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/configure b/configure
> index 8f312ac3e2..7c7eee44da 100755
> --- a/configure
> +++ b/configure
> @@ -4036,6 +4036,17 @@ EOF
>    if compile_prog "" "" ; then
>      opengl_dmabuf=3Dyes
>    fi
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
>  fi
> =20
>  ##########################################
>=20



--BcqKC9d1tcqf3QQIbxhGlGeRmsv8qp0XX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxJHDYMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsjtQQAKTFF0RB08EVyYC3SaO4PouzbJAsYxv5eDJSTjyU
dj5R/FVMnQg1JRwyKp14Z6ZW+TEBhieZ9SrzTD7sUAEeyfuokmOt3zWHFaansDpK
4MmjCrLtMBo9kt4m+BqY+MJNRM0xq2M31QSd1pAiCw98aOdP6eCozQ0dgvItEJHn
hK5wcRIotuzJa8Dvxpg2z5M4SF+/G3naht5DYtdmesKZSAid9h/LWuD9koZNFJ5J
/s5RBZYFvOoZTd7oXfL3RCCDCIgha5jv0TjtomzOfZ56EKc7z1eP8oZVbQ0hz/7A
h9DwJAdZ3QN5QpwwXIT0vO1lNnw4PxrfnjwNzXzOb7PUFNie8yBB+BR8lT0XtJXI
HLdVXPl19XU65hZBGu90998GOBc+vHhATvMK9WbUu2iXIGH1oihF8gjK1ele3xs6
6m7nBvMoyBjaI3om1dZdwz9XjfMPRE2sIoorRTaLOvEGOZmkFkfwmpSj6wUn/lup
a/oeKZmgeExXMRE6ZdacK+c1PMDZx1ZJkxelqWR8QQyUwEL4wiErf+J3ZmXN6mza
oL7/Cw23a7yQBtRaupdgtUQbSe4Chj1jg88IJUaKE44tI5QBLB3/oCKjQvwYD1TX
NT03Q1X8w/x4X5DbMzVvQ/0RedGcTIqY38tFsEHFyZxiuYfDG3KoDffgOpsana3J
ZJfY
=rqFF
-----END PGP SIGNATURE-----

--BcqKC9d1tcqf3QQIbxhGlGeRmsv8qp0XX--
