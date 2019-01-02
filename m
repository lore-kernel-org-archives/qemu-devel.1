Received: from eggs.gnu.org ([208.118.235.92]:45860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geppK-0001VJ-21
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 18:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geppJ-0006rU-05
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 18:21:29 -0500
References: <20181230180912.14614-1-rjones@redhat.com>
	<20181230180912.14614-2-rjones@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b50836e-ba43-42b0-7cea-6f5736d59ac5@redhat.com>
Date: Wed, 2 Jan 2019 17:21:08 -0600
MIME-Version: 1.0
In-Reply-To: <20181230180912.14614-2-rjones@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="16y5S3FiXvAVS6T4c7XX3GvnKiZtXbKk9"
Subject: Re: [Qemu-devel] [PATCH] qemu-io: Reinitialize optind correctly
 before parsing inner command.
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
--16y5S3FiXvAVS6T4c7XX3GvnKiZtXbKk9
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <5b50836e-ba43-42b0-7cea-6f5736d59ac5@redhat.com>
Subject: Re: [PATCH] qemu-io: Reinitialize optind correctly before parsing
 inner command.
References: <20181230180912.14614-1-rjones@redhat.com>
 <20181230180912.14614-2-rjones@redhat.com>
In-Reply-To: <20181230180912.14614-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/30/18 12:09 PM, Richard W.M. Jones wrote:
> On FreeBSD 11.2:
>=20
>   $ ./qemu-io -f raw -c "aio_write 0 512" "nbd:localhost:10809"
>   Parsing error: non-numeric argument, or extraneous/unrecognized suffi=
x -- aio_write
>=20
> After main option parsing, we reinitialize optind so we can parse each
> command.  The error happens when parsing the aio_write command.  After
> the aio_write getopt loop, optind =3D=3D 0 and argv[optind] points to t=
he
> command name ("aio_write" in this case).  The code fails because it
> tries to parse argv[optind] (which it thinks is the first argument) as
> an integer.
>=20
> In fact optind _starts_ the loop as 0, because we set it to 0.
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
> Unfortunately this conflicts with the glibc man page which says:
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


The glibc manual implies that setting optind =3D 1 is a weak reset
(sufficient if you are NOT using either leading '+' or '-', and if you
do NOT expect POSIXLY_CORRECT to have changed value since the last
time), and that optind =3D 0 is a hard reset needed only when the weak
reset is insufficient.

>=20
> Reinitialize optind to either 0 or 1 depending on whether we're using
> glibc or not.
>=20
> I didn't set optreset - it's not present in glibc and it doesn't seem
> to make any difference on FreeBSD.

BSD has optreset as its way of forcing hard reset (instead of optind=3D0)=
,
but both platforms allow optind=3D1 for soft reset.

>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  qemu-io-cmds.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20

Given that none of our uses of getopt() in qemu-io-cmds.c rely on
leading '+' or '-', and that we don't call setenv() to change
POSIXLY_CORRECT on the fly, I think the simpler patch is to just blindly
set optind =3D 1 when we want a soft reset, as a hard reset is overkill
for our needs.

> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 2c39124036..ca4e258579 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -114,7 +114,11 @@ static int command(BlockBackend *blk, const cmdinf=
o_t *ct, int argc,
>          }
>      }
> =20
> +#ifdef __GNU_LIBRARY__
>      optind =3D 0;
> +#else
> +    optind =3D 1;
> +#endif

and thus we don't need the #ifdef __GNU_LIBRARY__ code, nor the syntax
check violation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--16y5S3FiXvAVS6T4c7XX3GvnKiZtXbKk9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwtR2QACgkQ3g5py3or
ov0xkQf+My5LzvEaJpYQpeos+RRxCUxhnw1lIJOV/yRWOL2+UmTFIDlXFdHhUDf2
0li5Knanp+HTG2UEO+jWqif0y/CjdviW+Ct0xxwbX8M29fPbhEzHWWwK39piauH0
78iOHdQoxB32QgrHgxkSycKbcWlNQW5bqB1kzdJl7yZS6OlFbzq89i5oMeXa4zfR
88Su8SqkWn21eTpeg+8F73YhnCnDMs4nggbKQpY3qwy5kVk5bNLrnqVH7fQhRj65
au/vH+l/A3zTNgS16wg9Y0rGfU111ERDFyn7s7Paex32QQfCKoJqh9N81+37GSiC
/+gv9H6oVNPBuZIeXFsxJNTR+dYIxw==
=4rAW
-----END PGP SIGNATURE-----

--16y5S3FiXvAVS6T4c7XX3GvnKiZtXbKk9--
