Received: from eggs.gnu.org ([2001:4830:134:3::10]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zEM-0006dy-BU
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zEK-0001I2-UU
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:42:30 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ceabb3f0-9123-2c6d-1238-3706c9343fbe@redhat.com>
Date: Wed, 3 May 2017 20:42:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170429191419.30051-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f43hS7kkWqdLwfrCiFI5Ge7H7IRGW8Umq"
Subject: Re: [Qemu-devel] [PATCH v11 1/9] qemu-io: Improve alignment checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f43hS7kkWqdLwfrCiFI5Ge7H7IRGW8Umq
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <ceabb3f0-9123-2c6d-1238-3706c9343fbe@redhat.com>
Subject: Re: [PATCH v11 1/9] qemu-io: Improve alignment checks
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-2-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.2017 21:14, Eric Blake wrote:
> Several copy-and-pasted alignment checks exist in qemu-io, which
> could use some minor improvements:
>=20
> - Manual comparison against 0x1ff is not as clean as using our
> alignment macros (QEMU_IS_ALIGNED) from osdep.h.
>=20
> - The error messages aren't quite grammatically correct.

Well, yes, s/sector aligned/sector-aligned/, but the rest was largely
correct, and I have to admit I liked them better how they were before --
if only because they were shorter. (Longer explanation: These are error
messages for an interface to be used by humans, and I as a human don't
like it very much if my programs are overly technical and cold to me. "X
is an invalid value for 'Y'" is very technical. "X is wrong for Y" or "X
Y does not work" sounds more familiar and nicer. I like my programs nice.=
)

But just a matter of taste, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v11: retitle [was "qemu-io: Don't open-code QEMU_IS_ALIGNED"], improve
> error messages
> v10: new patch
> ---
>  qemu-io-cmds.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 21af9e6..6a0024b 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -740,13 +740,13 @@ static int read_f(BlockBackend *blk, int argc, ch=
ar **argv)
>      }
>=20
>      if (bflag) {
> -        if (offset & 0x1ff) {
> -            printf("offset %" PRId64 " is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> +            printf("%" PRId64 " is not a sector-aligned value for 'off=
set'\n",
>                     offset);
>              return 0;
>          }
> -        if (count & 0x1ff) {
> -            printf("count %"PRId64" is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
> +            printf("%"PRId64" is not a sector-aligned value for 'count=
'\n",
>                     count);
>              return 0;
>          }
> @@ -1050,14 +1050,14 @@ static int write_f(BlockBackend *blk, int argc,=
 char **argv)
>      }
>=20
>      if (bflag || cflag) {
> -        if (offset & 0x1ff) {
> -            printf("offset %" PRId64 " is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> +            printf("%" PRId64 " is not a sector-aligned value for 'off=
set'\n",
>                     offset);
>              return 0;
>          }
>=20
> -        if (count & 0x1ff) {
> -            printf("count %"PRId64" is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
> +            printf("%"PRId64" is not a sector-aligned value for 'count=
'\n",
>                     count);
>              return 0;
>          }
> @@ -1769,8 +1769,8 @@ static int alloc_f(BlockBackend *blk, int argc, c=
har **argv)
>      if (offset < 0) {
>          print_cvtnum_err(offset, argv[1]);
>          return 0;
> -    } else if (offset & 0x1ff) {
> -        printf("offset %" PRId64 " is not sector aligned\n",
> +    } else if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> +        printf("%" PRId64 " is not a sector-aligned value for 'offset'=
\n",
>                 offset);
>          return 0;
>      }
>=20



--f43hS7kkWqdLwfrCiFI5Ge7H7IRGW8Umq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKJIsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Av5kH/j0aqf2fsWuOfkFwY2eaF3/+kohTqMpq
lKMKxHA9Vu+1xWyJLtbTMLmqQFAiPpUP1Kpc5moF+4y96T3vmg6VUkNx14IriCLC
txn0hjsQZ5q8DHlJNimMsbjgvifbq1ERE9GnFIBFn5fr0tCMycrpgPvQPfbbgEFX
c4zb7k7f7lHD0Cs7bi+Px9RuCmJcxyVmUh/JzVwnt1ZG0pFPABrGqGKpdwyc/ioV
ymPNlFQTMT3pR0GKkIqaOBDB6LdatdrjeGAyfZj9J/752b0+FP0UaH4nkjXaellA
J3TEKy5hpII9xVIudyGpjiaKapTCLU/oqzZBhnfyGWM0dWK/KkJDR0g=
=fdOR
-----END PGP SIGNATURE-----

--f43hS7kkWqdLwfrCiFI5Ge7H7IRGW8Umq--
