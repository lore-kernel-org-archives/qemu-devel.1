Received: from eggs.gnu.org ([2001:4830:134:3::10]:33976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dp8np-00019H-LB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dp8nk-00056G-NB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:01:45 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:53230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dp8nk-00052V-H3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:01:40 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id BCFD751F7C
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:01:31 +0200 (CEST)
Date: Tue, 5 Sep 2017 10:01:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905100127.4892e02f@bahia>
In-Reply-To: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/uX_=e1jTB.3GULWVEs.aDLT";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

--Sig_/uX_=e1jTB.3GULWVEs.aDLT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  4 Sep 2017 18:19:00 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Nobody has mentioned AIX host support on the mailing list for years,
> and we have no test systems for it so it is most likely broken.
> We've advertised in configure for two releases now that we plan
> to drop support for this host OS, and have had no complaints.
> Drop the AIX host support code.
>=20
> We can also drop the now-unused AIX version of sys_cache_info().
>=20
> Note that the _CALL_AIX define used in the PPC tcg backend is
> also used for Linux PPC64, and so that code should not be removed.
>=20

Yeah this is used by the old big-endian ABI.

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

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


--Sig_/uX_=e1jTB.3GULWVEs.aDLT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa5Z1wAKCRAC/DrrAQHb
wg+WAKCa68tPwDP29b9a95uouGEXMzK3bgCfa1aiynCgpxJN8Go9FsyCXyuVp+0=
=0vWA
-----END PGP SIGNATURE-----

--Sig_/uX_=e1jTB.3GULWVEs.aDLT--
