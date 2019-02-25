Received: from eggs.gnu.org ([209.51.188.92]:41066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGLS-0001LC-3k
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGLF-00057E-FN
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:30:54 -0500
References: <20190221110805.28239-1-yuchenlin@synology.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5a1794b6-dcef-9635-3d41-3ea60d520dce@redhat.com>
Date: Mon, 25 Feb 2019 14:30:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190221110805.28239-1-yuchenlin@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H1zg8BkO6qpAuPJPG0mQQUPKKbmMYzknv"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] vmdk: false positive of
 compat6 with hwversion not set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com, qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H1zg8BkO6qpAuPJPG0mQQUPKKbmMYzknv
From: Max Reitz <mreitz@redhat.com>
To: yuchenlin@synology.com, qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5a1794b6-dcef-9635-3d41-3ea60d520dce@redhat.com>
Subject: Re: [Qemu-block] [PATCH] vmdk: false positive of compat6 with
 hwversion not set
References: <20190221110805.28239-1-yuchenlin@synology.com>
In-Reply-To: <20190221110805.28239-1-yuchenlin@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.02.19 12:08, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
>=20
> In vmdk_co_create_opts, when it finds hw_version is undefined, it will
> set it to 4, which misleading the compat6 and hwversion in
> vmdk_co_do_create. Simply set hw_version to NULL after free, let
> the logic in vmdk_co_do_create to decide the value of hw_version.
>=20
> This bug can be reproduced by:
>=20
> $ qemu-img convert -O vmdk -o subformat=3DstreamOptimized,compat6
> /home/yuchenlin/syno.qcow2 /home/yuchenlin/syno.vmdk
>=20
> qemu-img: /home/yuchenlin/syno.vmdk: error while converting vmdk:
> compat6 cannot be enabled with hwversion set
>=20
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
>  block/vmdk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 096e8eb662..e3bbd18803 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2260,7 +2260,7 @@ static int coroutine_fn vmdk_co_create_opts(const=
 char *filename, QemuOpts *opts
>      compat6 =3D qemu_opt_get_bool_del(opts, BLOCK_OPT_COMPAT6, false);=

>      if (strcmp(hw_version, "undefined") =3D=3D 0) {
>          g_free(hw_version);
> -        hw_version =3D g_strdup("4");
> +        hw_version =3D NULL;
>      }
>      fmt =3D qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
>      zeroed_grain =3D qemu_opt_get_bool_del(opts, BLOCK_OPT_ZEROED_GRAI=
N, false);

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--H1zg8BkO6qpAuPJPG0mQQUPKKbmMYzknv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxz7fEACgkQ9AfbAGHV
z0DTjwf/dXuwtwQtlXozyqxdXCpyN33jpzAueI7MKdin7D36Qyy+C7wUHwOUIELF
MRq+f0zGai8c6A0VeSHBAgAZMlreJKYzUsh7PP6wpS1t5zhcrfuxPcdCUVyiIhcI
WRgFMuxg2W1x5QoxrMJeKOy4qAnEDuphPVpWhWl+SalxjQyD2JnlL2Mosp7W7DJc
02T3e/OU4eNysdI0f1Vy+/9VXzBaDXEo3c7g7nRhzAOayu44nhpAm5pWMPk78T9U
1dJv5icn+J4kBPjRWsVHjY5jhbYK/gYFnDehA7bf3D8bxdJ8VoA4h9smQZ21iHic
mpOk0Gy3gvYt1VWTrRaNYaPvgzFQMw==
=T0PC
-----END PGP SIGNATURE-----

--H1zg8BkO6qpAuPJPG0mQQUPKKbmMYzknv--
