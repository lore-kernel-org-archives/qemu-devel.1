Received: from eggs.gnu.org ([209.51.188.92]:40254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glMps-0008Ch-A4
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 18:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glMpr-0007ib-9j
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 18:49:04 -0500
References: <20190118101114.11759-1-rjones@redhat.com>
	<20190118101114.11759-2-rjones@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <58797614-1e73-8793-1444-f8177b4bb15e@redhat.com>
Date: Mon, 21 Jan 2019 00:48:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190118101114.11759-2-rjones@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RwwJ74GsCeHEgCEtd36D50fTHrRXDlOmd"
Subject: Re: [Qemu-devel] [PATCH v4] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RwwJ74GsCeHEgCEtd36D50fTHrRXDlOmd
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com,
 berrange@redhat.com
Message-ID: <58797614-1e73-8793-1444-f8177b4bb15e@redhat.com>
Subject: Re: [PATCH v4] qemu-io: Add generic function for reinitializing
 optind.
References: <20190118101114.11759-1-rjones@redhat.com>
 <20190118101114.11759-2-rjones@redhat.com>
In-Reply-To: <20190118101114.11759-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.01.19 11:11, Richard W.M. Jones wrote:
> On FreeBSD 11.2:
>=20
>   $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 512=
" $nbd'
>   Parsing error: non-numeric argument, or extraneous/unrecognized suffi=
x -- aio_write
>=20
> After main option parsing, we reinitialize optind so we can parse each
> command.  However reinitializing optind to 0 does not work on FreeBSD.
> What happens when you do this is optind remains 0 after the option
> parsing loop, and the result is we try to parse argv[optind] =3D=3D
> argv[0] =3D=3D "aio_write" as if it was the first parameter.
>=20
> The FreeBSD manual page says:
>=20
>   In order to use getopt() to evaluate multiple sets of arguments, or t=
o
>   evaluate a single set of arguments multiple times, the variable optre=
set
>   must be set to 1 before the second and each additional set of calls t=
o
>   getopt(), and the variable optind must be reinitialized.
>=20
> (From the rest of the man page it is clear that optind must be
> reinitialized to 1).
>=20
> The glibc man page says:
>=20
>   A program that scans multiple argument vectors,  or  rescans  the  sa=
me
>   vector  more than once, and wants to make use of GNU extensions such =
as
>   '+' and '-' at  the  start  of  optstring,  or  changes  the  value  =
of
>   POSIXLY_CORRECT  between scans, must reinitialize getopt() by resetti=
ng
>   optind to 0, rather than the traditional value of 1.  (Resetting  to =
 0
>   forces  the  invocation  of  an  internal  initialization  routine th=
at
>   rechecks POSIXLY_CORRECT and checks for GNU extensions in optstring.)=

>=20
> This commit introduces an OS-portability function called
> qemu_reset_optind which provides a way of resetting optind that works
> on FreeBSD and platforms that use optreset, while keeping it the same
> as now on other platforms.
>=20
> Note that the qemu codebase sets optind in many other places, but in
> those other places it's setting a local variable and not using getopt.
> This change is only needed in places where we are using getopt and the
> associated global variable optind.
>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  configure            | 14 ++++++++++++++
>  include/qemu/osdep.h | 16 ++++++++++++++++
>  qemu-img.c           |  2 +-
>  qemu-io-cmds.c       |  2 +-
>  4 files changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/configure b/configure
> index 3eee3fcf70..3d46df1517 100755

(I'm not quite sure where along the way just using a weak optreset was
discarded, but, oh well, this does make the code less ugly.)

[...]

> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 80df7253db..840af09cb0 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -109,6 +109,7 @@ extern int daemon(int, int);
>  #include <ctype.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <getopt.h>
>  #include <sys/stat.h>
>  #include <sys/time.h>
>  #include <assert.h>
> @@ -604,4 +605,19 @@ extern int qemu_icache_linesize_log;
>  extern int qemu_dcache_linesize;
>  extern int qemu_dcache_linesize_log;
> =20
> +/*
> + * After using getopt or getopt_long, if you need to parse another set=

> + * of options, then you must reset optind.  Unfortunately the way to
> + * do this varies between implementations of getopt.
> + */
> +static inline void qemu_reset_optind(void)
> +{
> +#ifdef HAVE_OPTRESET
> +    optind =3D 1;
> +    optreset =3D 1;
> +#else
> +    optind =3D 0;

So I take it this is supposed to always do a hard reset -- because if it
isn't, it might have been better to just always set optind =3D 1 as Eric
suggested.  But googling suggests OpenBSD and NetBSD both have optreset
as well, and newlib accepts optind =3D 0 (and apparently did not accept
optind =3D 1 in the past?), so I think this is good for that purpose.


So thanks a lot (and sorry about me being so stupid about
everything...), I've applied the patch to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max

> +#endif
> +}
> +
>  #endif


--RwwJ74GsCeHEgCEtd36D50fTHrRXDlOmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxFCOgACgkQ9AfbAGHV
z0CMqQgAnOCrRt8jFDdDKOHcCV9S/rkCrAZhHcak9TVfDcuhYhM2bweFmh2wMf23
5pQrjgo2JuKs0C7agZSoeSeLW/APuE6qGImUTeUpbSKiI3W5PB/PkiOC353f+E7S
l0SBkYIvTJNfMKZ5IgZohfau1iU/CfHWBDlVy5M9yQI3SFsKPBNxFHfMIv0bxUho
6m83zJT76pNcwS/Pk3vhTdrjMdeMvy8vfP5njkQLPkm+YmaRihsW+GclgRh9jlW5
XfcQJkzL85OXk5n2PmfljZBBUXui3eoHIkLTVJ6nO5YuwsKUP74Xr9IjLVDmUmhh
MhimQH10gIOjdPh7dS1omWQj52MqQQ==
=cWA8
-----END PGP SIGNATURE-----

--RwwJ74GsCeHEgCEtd36D50fTHrRXDlOmd--
