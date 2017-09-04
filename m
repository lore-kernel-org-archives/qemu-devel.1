Received: from eggs.gnu.org ([2001:4830:134:3::10]:34800)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1doyHv-0007y9-9q
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 16:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1doyHq-0003p2-GZ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 16:48:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:58101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1doyHq-0003oe-4q
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 16:48:02 -0400
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <8d4a3664-0684-cf6e-0cdd-ad699674eebf@gmx.com>
Date: Mon, 4 Sep 2017 22:50:16 +0200
MIME-Version: 1.0
In-Reply-To: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wmGBJ2SVfSBCW1iH1mtUQJtkfgmRecLSD"
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wmGBJ2SVfSBCW1iH1mtUQJtkfgmRecLSD
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <8d4a3664-0684-cf6e-0cdd-ad699674eebf@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 19:19, Peter Maydell wrote:
> Nobody has mentioned AIX host support on the mailing list for years,
> and we have no test systems for it so it is most likely broken.
> We've advertised in configure for two releases now that we plan
> to drop support for this host OS, and have had no complaints.
> Drop the AIX host support code.
>=20

There is AIX support in pkgsrc, but the activity is minimal. It
certainly does not pass perl and the amount of buildable packages is tiny=
=2E

> We can also drop the now-unused AIX version of sys_cache_info().
>=20
> Note that the _CALL_AIX define used in the PPC tcg backend is
> also used for Linux PPC64, and so that code should not be removed.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure        | 13 +------------
>  util/cacheinfo.c | 11 +----------
>  2 files changed, 2 insertions(+), 22 deletions(-)
>=20
> diff --git a/configure b/configure
> index fb7e34a..931b3ba 100755
> --- a/configure
> +++ b/configure
> @@ -350,7 +350,6 @@ cocoa=3D"no"
>  softmmu=3D"yes"
>  linux_user=3D"no"
>  bsd_user=3D"no"
> -aix=3D"no"
>  blobs=3D"yes"
>  pkgversion=3D""
>  pie=3D""
> @@ -554,8 +553,6 @@ elif check_define __NetBSD__; then
>    targetos=3D'NetBSD'
>  elif check_define __APPLE__; then
>    targetos=3D'Darwin'
> -elif check_define _AIX; then
> -  targetos=3D'AIX'
>  else
>    # This is a fatal error, but don't report it yet, because we
>    # might be going to just print the --help text, or it might
> @@ -767,10 +764,6 @@ SunOS)
>    LIBS=3D"$solarisnetlibs $LIBS"
>    libs_qga=3D"$solarisnetlibs $libs_qga"
>  ;;
> -AIX)
> -  aix=3D"yes"
> -  make=3D"${MAKE-gmake}"
> -;;
>  Haiku)
>    haiku=3D"yes"
>    QEMU_CFLAGS=3D"-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
> @@ -4214,7 +4207,7 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
>  fi
> =20
>  if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$solaris" !=3D=
 yes -a \
> -        "$aix" !=3D "yes" -a "$haiku" !=3D "yes" ; then
> +        "$haiku" !=3D "yes" ; then
>      libs_softmmu=3D"-lutil $libs_softmmu"
>  fi
> =20
> @@ -5523,10 +5516,6 @@ if test "$darwin" =3D "yes" ; then
>    echo "CONFIG_DARWIN=3Dy" >> $config_host_mak
>  fi
> =20
> -if test "$aix" =3D "yes" ; then
> -  echo "CONFIG_AIX=3Dy" >> $config_host_mak
> -fi
> -
>  if test "$solaris" =3D "yes" ; then
>    echo "CONFIG_SOLARIS=3Dy" >> $config_host_mak
>  fi
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 593940f..db5172d 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -15,16 +15,7 @@ int qemu_dcache_linesize =3D 0;
>   * Operating system specific detection mechanisms.
>   */
> =20
> -#if defined(_AIX)
> -# include <sys/systemcfg.h>
> -
> -static void sys_cache_info(int *isize, int *dsize)
> -{
> -    *isize =3D _system_configuration.icache_line;
> -    *dsize =3D _system_configuration.dcache_line;
> -}
> -
> -#elif defined(_WIN32)
> +#if defined(_WIN32)
> =20
>  static void sys_cache_info(int *isize, int *dsize)
>  {
>=20



--wmGBJ2SVfSBCW1iH1mtUQJtkfgmRecLSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrbyPAAoJEEuzCOmwLnZsyywP/RCcQJ5JnilZVxkhdbvfkEDx
Pub8JIL/PmBKz7sCYkT9AQpN9yIQBJeUtVCdIEbZJtylc5oV73eg97QvHOujkB+K
uyJ3bq2RW97UOWlqQOM8UAOSRrOUyT1iFRQZRIVIZzM4zQ6rzp52y1Sqn/PgAe0m
k2oJW7p+mJ4JeJD1VmQ4QvBtolr06piDVsJYoNbbY1T05A32am+PBP+rv/sJsUSQ
7VqN8s7AfH74akZwiQMUvpB4tcmNNdIjvkX3yCsA5mQbJJU1QlZ/QGz/oEA3QeNG
sudTCML5LXeyTM4DHu+xZ8AYmIn3TYYI83w5s0CnHWfCWdCN8JXQ5bLyrxJs2tsR
bW+/PGTrUcdMesOyW+uYW9AC3kU5bLrtIb8ayhig5vPU28OYwtyK59w7p0hIkl1Q
VZhmtLHYqNVz8CAg/y4DEp2WOLXlaqgAXBDmR77S96vmL3WNEbVIinbTO9GRwTqL
jXWIQirBrW+e6frW0npt2NjIAACJsnXzFsZK0FbGUKTWQ7W4YU97l1mTW7GErbxA
LHf9/gWpfdmK5YXBKd5Bv0tL+zmmO8yYA0oKfFOyM85ZT68rrH0N6mg3LKzgFH6/
H4gFbbxQPU52Z3vOgdHibJOH1eiFDjQt/bdxzOBH86y537nTtx3Ro17a0BchlU4a
ndpFlyM6DkXGsuFyJVe8
=qmjh
-----END PGP SIGNATURE-----

--wmGBJ2SVfSBCW1iH1mtUQJtkfgmRecLSD--
