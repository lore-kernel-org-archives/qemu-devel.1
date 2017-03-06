Received: from eggs.gnu.org ([2001:4830:134:3::10]:34485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvmx-0004ga-1o
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvmw-0008WM-2l
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:47:11 -0500
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa13b45a-8d8a-5bb8-e17a-608159270733@redhat.com>
Date: Mon, 6 Mar 2017 10:46:57 -0600
MIME-Version: 1.0
In-Reply-To: <1488288927-4607-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kmOqa1UD763lXLuqxMdlMF53ggMiKCCjS"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kmOqa1UD763lXLuqxMdlMF53ggMiKCCjS
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com,
 ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com
Message-ID: <aa13b45a-8d8a-5bb8-e17a-608159270733@redhat.com>
Subject: Re: [PATCH] qemu-img: simplify img_convert
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
In-Reply-To: <1488288927-4607-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 07:35 AM, Peter Lieven wrote:
> img_convert has been around before there was an ImgConvertState or
> a block backend, but it has never been modified to directly use
> these structs. Change this by parsing parameters directly into
> the ImgConvertState and directly use BlockBackend where possible.
> Futhermore variable initalization has been reworked and sorted.

s/Futhermore/Furthermore/
s/initalization/initialization/

I almost wonder if this should be split into multiple patches for ease
of review.  But since you've already submitted it, I'll review it as-is.

>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.c | 197 +++++++++++++++++++++++++----------------------------=
--------
>  1 file changed, 81 insertions(+), 116 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index caa76a7..f271167 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1488,7 +1488,7 @@ typedef struct ImgConvertState {
>      int min_sparse;
>      size_t cluster_sectors;
>      size_t buf_sectors;
> -    int num_coroutines;
> +    long num_coroutines;

Why is this change needed? A hint in the commit message may be
appropriate (I'm especially wary of 'long', as it differs between 32-
and 64-bit platforms).

> @@ -2012,19 +2002,18 @@ static int img_convert(int argc, char **argv)
>              quiet =3D true;
>              break;
>          case 'n':
> -            skip_create =3D 1;
> +            skip_create =3D true;
>              break;
>          case 'm':
> -            if (qemu_strtol(optarg, NULL, 0, &num_coroutines) ||
> -                num_coroutines < 1 || num_coroutines > MAX_COROUTINES)=
 {
> +            if (qemu_strtol(optarg, NULL, 0, &s.num_coroutines) ||
> +                s.num_coroutines < 1 || s.num_coroutines > MAX_COROUTI=
NES) {

At any rate, it looks like you clamp it, so the change in type doesn't
matter too much.

I didn't spot any problems in the conversion, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kmOqa1UD763lXLuqxMdlMF53ggMiKCCjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvZKBAAoJEKeha0olJ0NqhF0H/RDgfjsXBvDqfp0l7cCXsVi0
rzrMe4Tl9PjG2+Ld3tzSEWAFFabPZbQRAmoeT0zVPGG6q1iRZWnZrPqP2KTtNVc6
/IlDbE7BgsEyhaIbXwLpyG9h+bKb2o2bOBu6ZJEyEut8ULVnT4cmTTjYeBq5HVy7
PrmdtQxoX6yIdyvZgcqranrjuzIvTMCwmo3dNiS69YMDpThsdRtUiDuUurNsnsYe
cS2mjE5nCWGrf7NCTMv+xOnkRQYUvthRf6svvPrDfvr6Dsm2orHfUYcxPXDGFbof
p2TGGs8nD2B0K1wDDFMM3FsaWRQhBTgOK1kmY5mZGxwvugu4ZJG/hONOUO6EjHI=
=nqDT
-----END PGP SIGNATURE-----

--kmOqa1UD763lXLuqxMdlMF53ggMiKCCjS--
