Received: from eggs.gnu.org ([2001:4830:134:3::10]:38605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxb4B-0003V4-S1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxb4A-00063l-LZ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:17:19 -0400
References: <20170410075451.21329-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <24011a9e-eab2-60b4-48a2-0e5ec1f4cf12@redhat.com>
Date: Mon, 10 Apr 2017 17:17:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170410075451.21329-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2nNGhEuqlEEw4sH1Cgvqv6f2svrM2tmio"
Subject: Re: [Qemu-devel] [PATCH for-2.9] iscsi: Fix iscsi_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2nNGhEuqlEEw4sH1Cgvqv6f2svrM2tmio
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <24011a9e-eab2-60b4-48a2-0e5ec1f4cf12@redhat.com>
Subject: Re: [PATCH for-2.9] iscsi: Fix iscsi_create
References: <20170410075451.21329-1-famz@redhat.com>
In-Reply-To: <20170410075451.21329-1-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 10.04.2017 09:54, Fam Zheng wrote:
> Since d5895fcb (iscsi: Split URL into individual options), creating
> qcow2 image on an iscsi LUN fails:
>=20
>     qemu-img create -f qcow2 iscsi://$SERVER/$IQN/0 1G
>     qemu-img: iscsi://$SERVER/$IQN/0: Could not create image: Invalid
>         argument
>=20
> The problem is iscsi_open now expects that transport_name, portal and
> target are already parsed into structured options by
> iscsi_parse_filename, but it is not called in iscsi_create.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/iscsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 716e74a..07596b5 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2092,6 +2092,7 @@ static int iscsi_create(const char *filename, Qem=
uOpts *opts, Error **errp)
>      BlockDriverState *bs;
>      IscsiLun *iscsilun =3D NULL;
>      QDict *bs_options;
> +    Error *local_err =3D NULL;
> =20
>      bs =3D bdrv_new();
> =20
> @@ -2103,7 +2104,13 @@ static int iscsi_create(const char *filename, Qe=
muOpts *opts, Error **errp)
> =20
>      bs_options =3D qdict_new();
>      qdict_put(bs_options, "filename", qstring_from_str(filename));

Doesn't the below change make this qdict_put() superfluous?

Max

> -    ret =3D iscsi_open(bs, bs_options, 0, NULL);
> +    iscsi_parse_filename(filename, bs_options, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret =3D -EINVAL;
> +    } else {
> +        ret =3D iscsi_open(bs, bs_options, 0, NULL);
> +    }
>      QDECREF(bs_options);
> =20
>      if (ret !=3D 0) {
>=20



--2nNGhEuqlEEw4sH1Cgvqv6f2svrM2tmio
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljrofMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvekH/30OPTT9mThknBxybO2R7JZI7Ft4G1oB
ssQ/zR43hNFwvpgTAnZkWRgqEIT/pLsgzaYxG+GRK96N8WtuI7Dc9uAWkMWYxmun
qeKihEoWcDG0651gx+A4V2USweasY2Qyf3lSOVKijq7YL7q5v3Tp9VBV5iY7tYOx
WSJT/EK2NAUGwsSs8jEIojyLxC6eORy0dKF4h8/vs16KgxGb8RdctSXUN/K0F/3W
9OauTsYn+3Lc6rlrpXvMVN99cIc7O65wox/aQpO8t8IV5ytsb8/s9sd1RmW08xsO
UUs9zHNuvE2iMfP+WWwRsMn6QeKox43tqeRThgApR4VY/jYbjlz16zA=
=EhSS
-----END PGP SIGNATURE-----

--2nNGhEuqlEEw4sH1Cgvqv6f2svrM2tmio--
