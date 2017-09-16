Received: from eggs.gnu.org ([2001:4830:134:3::10]:39297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFMB-0000sZ-Ty
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 11:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFMB-0002UT-0y
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 11:50:11 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
	<20170817091542.9403-2-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7e407c94-7f3b-621a-7c63-784b25bb8f18@redhat.com>
Date: Sat, 16 Sep 2017 17:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170817091542.9403-2-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O3oVl5eiG9Xjp00v0Xo7wx0uIluW3qo2Q"
Subject: Re: [Qemu-devel] [PATCH v7 1/4] qemu-img: add --shrink flag for
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
--O3oVl5eiG9Xjp00v0Xo7wx0uIluW3qo2Q
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 den@openvz.org
Message-ID: <7e407c94-7f3b-621a-7c63-784b25bb8f18@redhat.com>
Subject: Re: [PATCH v7 1/4] qemu-img: add --shrink flag for resize
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
 <20170817091542.9403-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170817091542.9403-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-17 11:15, Pavel Butsykin wrote:
> The flag is additional precaution against data loss. Perhaps in the fut=
ure the
> operation shrink without this flag will be blocked for all formats, but=
 for now
> we need to maintain compatibility with raw.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img-cmds.hx       |  4 ++--
>  qemu-img.c             | 23 +++++++++++++++++++++++
>  qemu-img.texi          |  6 +++++-
>  tests/qemu-iotests/102 |  4 ++--
>  4 files changed, 32 insertions(+), 5 deletions(-)

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

Sorry, I only just noticed that there's a space missing after the period.=


And I noticed because iotest 106 is failing, which will need to be fixed
just like 102.

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


--O3oVl5eiG9Xjp00v0Xo7wx0uIluW3qo2Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9SCQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/kUH/2JGDACPhnxtYJYCKzX26Kr3wjhLM38X
sa9kBoct7Pka8ScCX/fZqOjknGYF9906uvQtdVhhx0NjYqKhs1wseVHJ4ZTPVa4o
ITfb+Ca2y1D29pung0puv7VY0Gba49D7uXE3AnWBUP37IghhmVhUbMYReX5kd3fU
iiqZZ55GmYDMh+7k+NRh1jfWjia6/KcXEp2gVregIf/Eg0FELA/xECnKs52f4G7U
3Sb56X8mwwrp9AMRpKBzyNk6xnvL5T4B6BLa+eXKSuzZdUInwVFKmc7aDtkrCb0d
VpKIfl9QCBRBn9KHsznIksbW1W8sK+Yi6szPiUXT3m1Lt3QX+Bcp4o8=
=yaKe
-----END PGP SIGNATURE-----

--O3oVl5eiG9Xjp00v0Xo7wx0uIluW3qo2Q--
