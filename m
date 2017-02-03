Received: from eggs.gnu.org ([2001:4830:134:3::10]:55596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZkzg-0002Tf-B3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZkzf-00012y-FR
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:02:08 -0500
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <506e3e55-ef59-ae96-51de-c8c98ef3953e@redhat.com>
Date: Fri, 3 Feb 2017 22:01:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170203120254.15062-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kIQTkkXCvgjjiWCHvRS3e30Lw7I3XR9MQ"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-img: add support for --object
 with 'dd' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kIQTkkXCvgjjiWCHvRS3e30Lw7I3XR9MQ
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <506e3e55-ef59-ae96-51de-c8c98ef3953e@redhat.com>
Subject: Re: [PATCH v2 1/6] qemu-img: add support for --object with 'dd'
 command
References: <20170203120254.15062-1-berrange@redhat.com>
 <20170203120254.15062-2-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-2-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 13:02, Daniel P. Berrange wrote:
> The qemu-img dd command added --image-opts support, but missed
> the corresponding --object support. This prevented passing
> secrets (eg auth passwords) needed by certain disk images.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 74e3362..391a141 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3949,6 +3949,7 @@ static int img_dd(int argc, char **argv)
>      };
>      const struct option long_options[] =3D {
>          { "help", no_argument, 0, 'h'},
> +        { "object", required_argument, 0, OPTION_OBJECT},
>          { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>          { 0, 0, 0, 0 }
>      };
> @@ -3971,6 +3972,14 @@ static int img_dd(int argc, char **argv)
>          case 'h':
>              help();
>              break;
> +        case OPTION_OBJECT: {
> +            QemuOpts *opts;
> +            opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
> +                                           optarg, true);
> +            if (!opts) {
> +                return 1;
> +            }
> +        }   break;
>          case OPTION_IMAGE_OPTS:
>              image_opts =3D true;
>              break;
> @@ -4015,6 +4024,13 @@ static int img_dd(int argc, char **argv)
>          ret =3D -1;
>          goto out;
>      }
> +
> +    if (qemu_opts_foreach(&qemu_object_opts,
> +                          user_creatable_add_opts_foreach,
> +                          NULL, NULL)) {
> +        return 1;

Why not ret =3D -1; goto out; like the other code around this block?

(Same for the case block above.)

Max

> +    }
> +
>      blk1 =3D img_open(image_opts, in.filename, fmt, 0, false, false);
> =20
>      if (!blk1) {
>=20



--kIQTkkXCvgjjiWCHvRS3e30Lw7I3XR9MQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU78ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AL88IAKc8GotaFHASN9xA+C/YMEvNgJcs31vz
kilaU8D+JpAPWdpxPgzOwnQXnDwc5O4P2vJ/UuUQo/bY4Ij0j+elIF4FT+1FAkgb
/sYcNZ/EOjBsrojxbykL2CslO1miHUWAzi4B5UBo5Ttk4dLb/JvZH8f9lIsm7GXF
/6KnNCggbdKIYVCI/CPZMXJNoTgjLDNaMVzgPZ8AC0Uq7LWYV1GQFQdBSJEnaVQi
q082tDNoTElQfs42aBFFejER01JawOaimnIbSsM3S6NovVYPUafo3xrF2jG0JOW0
1pQKPvfdQMYYJghZlH+OyMmTQIMy5Z9ij4CmQLOnJmIpB7aeEnhEqHg=
=G0/v
-----END PGP SIGNATURE-----

--kIQTkkXCvgjjiWCHvRS3e30Lw7I3XR9MQ--
