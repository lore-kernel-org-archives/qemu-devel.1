Received: from eggs.gnu.org ([2001:4830:134:3::10]:45421)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drUyz-0005zR-LN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drUyv-00004y-MO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:07:01 -0400
References: <20170903164952.26760-1-n54@gmx.com>
	<20170911171639.22005-1-n54@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <aae5b3ae-f158-a7a6-fb8c-7726c2a18cd0@gmx.com>
Date: Mon, 11 Sep 2017 22:09:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170911171639.22005-1-n54@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iVnRK52EjSv8F66TTJwmnqoEGJS6hHnGC"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] Discover openpty(3)
 dynamically in configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, jperkin@joyent.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iVnRK52EjSv8F66TTJwmnqoEGJS6hHnGC
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, jperkin@joyent.com, qemu-devel@nongnu.org
Message-ID: <aae5b3ae-f158-a7a6-fb8c-7726c2a18cd0@gmx.com>
Subject: Re: [Qemu-trivial] [PATCH v2] Discover openpty(3) dynamically in
 configure
References: <20170903164952.26760-1-n54@gmx.com>
 <20170911171639.22005-1-n54@gmx.com>
In-Reply-To: <20170911171639.22005-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.2017 19:16, Kamil Rytarowski wrote:
> openpty(3) might:
>  - exists in libc (OSX)
>  - exists in libutil (GNU, BSD)
>  - does not exist (SmartOS)
>=20
> Add a function to discover this function in the ./configure script.
> Add new config types: CONFIG_OPENPTY_LIBC and CONFIG_OPENPTY_LIBUTIL,
> respectively defined when openpts(3) links with -lc or -lutil.
>=20
> Replace the condition adding -lutil in tests (for openpty(3)) from
> CONFIG_POSIX to CONFIG_OPENPTY_LIBUTIL.
>=20
> Replace the fallback openpty(3) impelementation comment from Solaris
> to SmartOS. Solaris is EOL'ed and it's confirmed that it does not work
> on Oracle Solaris.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>

> ---
>  configure              | 25 +++++++++++++++++++++++++
>  tests/Makefile.include |  2 +-
>  util/qemu-openpty.c    |  4 ++--
>  3 files changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index fd7e3a5e81..a614adcd29 100755
> --- a/configure
> +++ b/configure
> @@ -3819,6 +3819,25 @@ EOF
>    fi
>  fi
> =20
> +##########################################
> +# openpty probe
> +openpty_libc=3Dno
> +openpty_libutil=3Dno
> +cat > $TMPC << EOF
> +extern int openpty(int *amaster, int *aslave, char *name, void *termp,=
 void *winp);
> +
> +int main(void)
> +{
> +    int master_fd, slave_fd;
> +    return openpty(&master_fd, &slave_fd, 0, 0, 0) =3D=3D 0;
> +}
> +EOF
> +if compile_prog "" "" ; then
> +  openpty_libc=3Dyes
> +elif compile_prog "" "-lutil" ; then
> +  openpty_libutil=3Dyes
> +fi
> +
>  ##########################################
>  # signalfd probe
>  signalfd=3D"no"
> @@ -5788,6 +5807,12 @@ fi
>  if test "$fdt" =3D "yes" ; then
>    echo "CONFIG_FDT=3Dy" >> $config_host_mak
>  fi
> +if test "$openpty_libc" =3D "yes" ; then
> +  echo "CONFIG_OPENPTY_LIBC=3Dy" >> $config_host_mak
> +fi
> +if test "$openpty_libutil" =3D "yes" ; then
> +  echo "CONFIG_OPENPTY_LIBUTIL=3Dy" >> $config_host_mak
> +fi
>  if test "$signalfd" =3D "yes" ; then
>    echo "CONFIG_SIGNALFD=3Dy" >> $config_host_mak
>  fi
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fae5715e9c..e7e0bc2724 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -814,7 +814,7 @@ tests/migration/initrd-stress.img: tests/migration/=
stress$(EXESUF)
>  	rm $(INITRD_WORK_DIR)/init
>  	rmdir $(INITRD_WORK_DIR)
> =20
> -ifeq ($(CONFIG_POSIX),y)
> +ifeq ($(CONFIG_OPENPTY_LIBUTIL),y)
>  LIBS +=3D -lutil
>  endif
> =20
> diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
> index 2e8b43bdf5..62c87e5563 100644
> --- a/util/qemu-openpty.c
> +++ b/util/qemu-openpty.c
> @@ -51,8 +51,8 @@
>  # include <termios.h>
>  #endif
> =20
> -#ifdef __sun__
> -/* Once Solaris has openpty(), this is going to be removed. */
> +/* The fallback implementation is needed at least on SmartOS. */
> +#if !defined(CONFIG_OPENPTY_LIBC) && !defined(CONFIG_OPENPTY_LIBUTIL)
>  static int openpty(int *amaster, int *aslave, char *name,
>                     struct termios *termp, struct winsize *winp)
>  {
>=20



--iVnRK52EjSv8F66TTJwmnqoEGJS6hHnGC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZtu1yAAoJEEuzCOmwLnZsEWkP+gNA/9sasN51UEVeVd/KkEYM
F7eDI4iA/v5i2rLepFCIs02huwE4xxttlZ+bOV1VOgjJT+MA75kDA62qy0nHrtEk
bUIM1XmODbS65E6Z4HwvYE6OTbiXx9YjUzrygUfG8e71szIRN75i/q3igqmbg9wH
/Sql+PdPfie4/VTyZAb392bZrWrrMxFjdlfuCmLIQS5TE1W5UmDBsyo1QWrEar4C
urgMbksWD64rlsOJ6YX1kogA22HuhrC7g6XrwJAOvwac6+p2t91vOVU9n0uj76OK
P6zUrgU1PeLuazJSckvpxEeqBMxlYtv9HlBrXeqO+UXgijP4BSnU91zT1gFGgWK3
iel13Vb1/jeMDnCxEOeV0b3RSVz9CghkDUd+35xNMJ5JaRIm4p9QVY3wWJifYezV
vsAKm40i4jEZe40FLUuPaIzBKORYMImPC7JOE9laN858wO887UMVssbN6AeyX20P
YVoUlPBJijS4cAWtjQlJJs67g2/FylXisx87KSv6dnamxfb6Nz8xjBMmksdhJ7A1
hwToem49i3U9V3MqF3XSmKwVcdZxrVC1q5B7CP3t4vof6GritJ4ooflCIKZVijoe
8yL3jMH5PDEh1X5kItnGsYXnZl9Znp52bG47bFceBgKNsqKxL4Ln3Vz64MrhdHK6
GbvxtCB3ApRNsL3cZdla
=I9fU
-----END PGP SIGNATURE-----

--iVnRK52EjSv8F66TTJwmnqoEGJS6hHnGC--
