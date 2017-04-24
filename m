Received: from eggs.gnu.org ([2001:4830:134:3::10]:54383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2fD6-0005Pd-0C
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2fD4-0006xI-OM
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:43:28 -0400
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
Date: Mon, 24 Apr 2017 09:43:18 -0500
MIME-Version: 1.0
In-Reply-To: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vgV4mM5eac9GHCfSX6jLbcWVAm8NBfGDi"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Lidong Chen <lidongchen@tencent.com>, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vgV4mM5eac9GHCfSX6jLbcWVAm8NBfGDi
From: Eric Blake <eblake@redhat.com>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Lidong Chen <lidongchen@tencent.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/23/2017 09:33 AM, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> is_allocated_sectors_min don't guarantee to contain the
> consecutive number of zero bytes. this patch fixes this bug.

This message was sent without an 'In-Reply-To' header pointing to a 0/2
cover letter.  When sending a series, please always thread things to a
cover letter; you may find 'git config format.coverletter auto' to be
helpful.

>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  qemu-img.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index b220cf7..df6d165 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1060,9 +1060,9 @@ static int is_allocated_sectors(const uint8_t *bu=
f, int n, int *pnum)
>  }
> =20
>  /*
> - * Like is_allocated_sectors, but if the buffer starts with a used sec=
tor,
> - * up to 'min' consecutive sectors containing zeros are ignored. This =
avoids
> - * breaking up write requests for only small sparse areas.
> + * Like is_allocated_sectors, but up to 'min' consecutive sectors
> + * containing zeros are ignored. This avoids breaking up write request=
s
> + * for only small sparse areas.
>   */
>  static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pn=
um,
>      int min)
> @@ -1071,11 +1071,12 @@ static int is_allocated_sectors_min(const uint8=
_t *buf, int n, int *pnum,
>      int num_checked, num_used;
> =20
>      if (n < min) {
> -        min =3D n;
> +        *pnum =3D n;
> +        return 1;
>      }
> =20
>      ret =3D is_allocated_sectors(buf, n, pnum);
> -    if (!ret) {
> +    if (!ret && *pnum >=3D min) {

I seem to recall past attempts to try and patch this function, which
were then turned down, although I haven't scrubbed the archives for a
quick URL to point to. I'm worried that there are more subtleties here
than what you realize.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vgV4mM5eac9GHCfSX6jLbcWVAm8NBfGDi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/g8HAAoJEKeha0olJ0NqQyMH/1UKAWZGrwvAbqHDoQkB1YZ7
+oFJ8hsiYDE42byzkyBidX8lYBlAt6Vc/lvjGDq3WOlteF2iXkmfu3rpmJc0CG9m
tqnSPHHcAx6ywcQhSJdH7FLXvJqSxARIYMPeSYgcIicFAholzz5NGWJ6GNM53tLf
78Ctp8uLiZTah6P/PYQdJVJC0459xBzZpBjqIvY6kwOERyb3SVo6AWo/RUVfkk/U
AjWnpLaLG3st6acRMN8KPLV9/d5JbKp8zj6qABFDrFiSrIS1M9ipjoFwkB+oRYJG
QB4pBRjeg9m2iWFO2th/Q50MFGxawmGEFWd+j7KFSDn8ztThSozYbUzkV66V0+I=
=6s21
-----END PGP SIGNATURE-----

--vgV4mM5eac9GHCfSX6jLbcWVAm8NBfGDi--
