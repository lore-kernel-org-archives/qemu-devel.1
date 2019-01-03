Received: from eggs.gnu.org ([208.118.235.92]:55308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf8x7-0006dI-P2
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 14:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf8x6-0006sM-VG
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 14:46:49 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73d061a2-18d0-e696-2ebf-d78f9e763a13@redhat.com>
Date: Thu, 3 Jan 2019 13:46:29 -0600
MIME-Version: 1.0
In-Reply-To: <20190103094728.31747-2-rjones@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bTH2YQvhwjGWAusdcuG5VlzKX2qlKtHFK"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not
 0) before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bTH2YQvhwjGWAusdcuG5VlzKX2qlKtHFK
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <73d061a2-18d0-e696-2ebf-d78f9e763a13@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
In-Reply-To: <20190103094728.31747-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/3/19 3:47 AM, Richard W.M. Jones wrote:
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
> Note I didn't set optreset.  It's not present in glibc and the "hard
> reset" is not necessary in this context.
>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  qemu-io-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--bTH2YQvhwjGWAusdcuG5VlzKX2qlKtHFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwuZpUACgkQ3g5py3or
ov0KxQf/R0uvQUyIVJ5bZoBDuys31H1KxUT83F2jqHFDmD3dNu5zc9YyozKGO7W3
7op28BQ3csj0gYmCf1lCjLUtgxkwRe1PXAvk/Tr8X96Otu18cFcheWhe5OuU/U1C
3DrTI44kBvkYRcEDBAaw7mhm7w8ewVkkQ9E+ydqQFScKD8ekFtOqK3ejOveqITAW
+Scw7ktBhEU/bvNHPf6vHPauk++vwpcM/nxvKEd6NUJMb0Tx6ChbBxwasEYdtNDF
wCLBRjQZwxjWODEqqZJ3jIHI2fdYXNg6RZHleA7SZZqdLByPlt5if0ExzXJx8j4K
VY/iKn7KP9QxZREqLMK3YxWdSUsb7A==
=321C
-----END PGP SIGNATURE-----

--bTH2YQvhwjGWAusdcuG5VlzKX2qlKtHFK--
