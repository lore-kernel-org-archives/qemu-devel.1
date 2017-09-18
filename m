Received: from eggs.gnu.org ([2001:4830:134:3::10]:56250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du0Wz-0003s9-Qn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du0Wy-0008Lh-P4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:12:29 -0400
References: <20170918124230.8152-1-pbutsykin@virtuozzo.com>
	<20170918124230.8152-2-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <79cf9910-e76e-7c6d-f7c8-a81d84db0dd0@redhat.com>
Date: Mon, 18 Sep 2017 20:12:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170918124230.8152-2-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Fu5qeLNmrU7iR7qcnNSdARBfHchIRe73B"
Subject: Re: [Qemu-devel] [PATCH v8 1/4] qemu-img: add --shrink flag for
 resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fu5qeLNmrU7iR7qcnNSdARBfHchIRe73B
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 den@openvz.org
Message-ID: <79cf9910-e76e-7c6d-f7c8-a81d84db0dd0@redhat.com>
Subject: Re: [PATCH v8 1/4] qemu-img: add --shrink flag for resize
References: <20170918124230.8152-1-pbutsykin@virtuozzo.com>
 <20170918124230.8152-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170918124230.8152-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 14:42, Pavel Butsykin wrote:
> The flag is additional precaution against data loss. Perhaps in the fut=
ure the
> operation shrink without this flag will be blocked for all formats, but=
 for now
> we need to maintain compatibility with raw.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-img-cmds.hx       |  4 ++--
>  qemu-img.c             | 23 +++++++++++++++++++++++
>  qemu-img.texi          |  6 +++++-
>  tests/qemu-iotests/102 |  4 ++--
>  tests/qemu-iotests/106 |  2 +-
>  5 files changed, 33 insertions(+), 6 deletions(-)

[...]

> diff --git a/qemu-img.c b/qemu-img.c
> index 56ef49e214..b7b2386cbd 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -3571,6 +3577,23 @@ static int img_resize(int argc, char **argv)
>          goto out;
>      }
> =20
> +    if (total_size < current_size && !shrink) {
> +        warn_report("Shrinking an image will delete all data beyond th=
e "
> +                    "shrunken image's end. Before performing such an "=

> +                    "operation, make sure there is no important data t=
here.");
> +
> +        if (g_strcmp0(bdrv_get_format_name(blk_bs(blk)), "raw") !=3D 0=
) {
> +            error_report(
> +              "Use the --shrink option to perform a shrink operation."=
);
> +            ret =3D -1;
> +            goto out;
> +        } else {
> +            warn_report("Using the --shrink option will suppress this =
message."

Still missing a space here.

Max

> +                        "Note that future versions of qemu-img may ref=
use to "
> +                        "shrink images without this option.");
> +        }
> +    }
> +
>      ret =3D blk_truncate(blk, total_size, prealloc, &err);
>      if (!ret) {
>          qprintf(quiet, "Image resized.\n");


--Fu5qeLNmrU7iR7qcnNSdARBfHchIRe73B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnADH8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlzkH/RvhqHufhdKmcqYRBlJTesjpJuOQlT1a
qE4kzquJMMUN2Q4onZg2192nowuRQwd/SnBdqgS05Sa+8aZmuoOLCQwPcNShBvNI
OszTWXBFGmCZbHXwmocEqF8FKonx73lM1v/3yZ78OrtTdvjeOMRnNmUf6M6p4jNO
9aR0a2jxrND0eyIYfRz3M3rvgQziHOx+kPo0yChWSS+oN2HZoQC2iNcdyMUs2hP3
2xAX5CxlFUN+oO3L/pD1+PDkURUHq8oGJ8eTmzY95N4OTvfIUQX7az865dtghi9V
1kxIp8w5kIGWEtmuZ+MGeAkI2BhhilvtQsYExsoImhiajocToL+EwG4=
=Gkyq
-----END PGP SIGNATURE-----

--Fu5qeLNmrU7iR7qcnNSdARBfHchIRe73B--
