Received: from eggs.gnu.org ([2001:4830:134:3::10]:55819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dMyRi-0007rt-V3
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dMyRi-0006ze-4J
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:18:30 -0400
References: <20170619150002.3033-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <117743be-2351-7fe0-c777-c630bb850447@redhat.com>
Date: Mon, 19 Jun 2017 17:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170619150002.3033-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mK2BMgAQmvhE3cNEBPIpVDhC3lXFwhK5Q"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: don't shadow opts variable in
 img_dd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Reda Sallahi <fullmanet@gmail.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mK2BMgAQmvhE3cNEBPIpVDhC3lXFwhK5Q
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Reda Sallahi <fullmanet@gmail.com>,
 qemu-block@nongnu.org
Message-ID: <117743be-2351-7fe0-c777-c630bb850447@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: don't shadow opts variable in
 img_dd()
References: <20170619150002.3033-1-stefanha@redhat.com>
In-Reply-To: <20170619150002.3033-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-19 17:00, Stefan Hajnoczi wrote:
> It's confusing when two different variables have the same name in one
> function.
>=20
> Cc: Reda Sallahi <fullmanet@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-img.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 0ad698d..c285c2f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4249,15 +4249,12 @@ static int img_dd(int argc, char **argv)
>          case 'U':
>              force_share =3D true;
>              break;
> -        case OPTION_OBJECT: {
> -            QemuOpts *opts;
> -            opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
> -                                           optarg, true);
> -            if (!opts) {
> +        case OPTION_OBJECT:
> +            if (!qemu_opts_parse_noisily(&qemu_object_opts, optarg, tr=
ue)) {
>                  ret =3D -1;
>                  goto out;
>              }
> -        }   break;
> +            break;
>          case OPTION_IMAGE_OPTS:
>              image_opts =3D true;
>              break;

Hm, I basically reverted such a style in commit
3258b91141090b05edcaab8f1d1dd355ca91b49a. I find it confusing to use the
same variable for two different things.

I agree that shadowing is bad, though. How about just renaming this
variable here?

Max


--mK2BMgAQmvhE3cNEBPIpVDhC3lXFwhK5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZR+s7EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQIj1
CACLSFGx8EbRdnSc/vtQ5oat2VtoOyhiBI4xcHsmG2hmtriFBErhJ2hqc8KAJtEC
R/4AZJK3ocDraq9yVPCo/dxWd2LGY2OkzFidMyRFxnTw2F9pbxLD+yue3P0F0udW
LIQ1yIhSa7r/E25QEsGHglCRvOUESsiKfp7Pv0fvBsFQaKtv/Vzj0K/tu0oIV7RO
nm0fzK/ZRQQmseloOvvaJWgWXW/ps+J16UOp/YpqHmzkxhnARUBU6KO1aZkjhb14
AQ7JBmsvF40SxSSb6AHbcpgygYlFiXDeJwFlec+xHMNrQmpZH0hP/u1cJ4Dxz52r
2aC5e70c2pRf2HBys541cb2K
=bw4j
-----END PGP SIGNATURE-----

--mK2BMgAQmvhE3cNEBPIpVDhC3lXFwhK5Q--
