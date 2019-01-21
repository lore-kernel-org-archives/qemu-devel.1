Received: from eggs.gnu.org ([209.51.188.92]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glZJh-0003qk-Il
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glZJf-000867-SV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:08:41 -0500
References: <20190115111007.27159-1-stefanha@redhat.com>
	<20190115111007.27159-2-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
Date: Mon, 21 Jan 2019 14:08:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190115111007.27159-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D19dDso03lVt3XPzad61fdPH3hldKTfyR"
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: include LUKS payload overhead
 in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D19dDso03lVt3XPzad61fdPH3hldKTfyR
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: include LUKS payload overhead in qemu-img
 measure
References: <20190115111007.27159-1-stefanha@redhat.com>
 <20190115111007.27159-2-stefanha@redhat.com>
In-Reply-To: <20190115111007.27159-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.01.19 12:10, Stefan Hajnoczi wrote:
> LUKS encryption reserves clusters for its own payload data.  The size o=
f
> this area must be included in the qemu-img measure calculation so that
> we arrive at the correct minimum required image size.
>=20
> (Ab)use the qcrypto_block_create() API to determine the payload
> overhead.  We discard the payload data that qcrypto thinks will be
> written to the image.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/qcow2.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-=

>  1 file changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4897abae5e..7ab93a5d2f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4274,6 +4294,35 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts =
*opts, BlockDriverState *in_bs,
>      has_backing_file =3D !!optstr;
>      g_free(optstr);
> =20
> +    optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
> +    has_luks =3D optstr && strcmp(optstr, "luks") =3D=3D 0;
> +    g_free(optstr);
> +
> +    if (has_luks) {
> +        QCryptoBlockCreateOptions cryptoopts =3D {
> +            .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
> +        };
> +        QCryptoBlock *crypto;
> +        size_t headerlen;
> +
> +        optstr =3D qemu_opt_get_del(opts, "encrypt.key-secret");
> +        cryptoopts.u.luks.has_key_secret =3D !!optstr;
> +        cryptoopts.u.luks.key_secret =3D optstr;

I wonder if you couldn't just make some secret up here (if the user
doesn't specify anything).  Its content shouldn't matter, right?

Max

> +
> +        crypto =3D qcrypto_block_create(&cryptoopts, "encrypt.",
> +                                      qcow2_measure_crypto_hdr_init_fu=
nc,
> +                                      qcow2_measure_crypto_hdr_write_f=
unc,
> +                                      &headerlen, &local_err);
> +
> +        g_free(optstr);
> +        if (!crypto) {
> +            goto err;
> +        }
> +        qcrypto_block_free(crypto);
> +
> +        luks_payload_size =3D ROUND_UP(headerlen, cluster_size);
> +    }
> +
>      virtual_size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
>      virtual_size =3D ROUND_UP(virtual_size, cluster_size);


--D19dDso03lVt3XPzad61fdPH3hldKTfyR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxFxDIACgkQ9AfbAGHV
z0AhVQf/eWqZX8KgKqPGpAL7/c08ZSIkUZ6HMwHqIp0th9Vji0lt0ZSniEx/kB1L
yRAPWk4gOV3Mp4qwHNoO43XFwS0u4MskjHiZyJ7/ypj/lWC7u85LRoP1hHulQqvV
cXVbYbE7VKIwvGOR3svCETFV67HLEQhr6MPv5y8AgGQPWXGDnw8Gf2UXeiF7zLST
u3KEpO9otZVcaZXThZ4ySALh05uR3yOow4eE9anPnicqfLywxNJ93x2NsZWFRlMH
50BWga8M9dSm1OLeTgRMjuP73XTcZwZRIFeKPt76N7Kjig8NR601om2Re3mWcx4j
5ICLfOs6z/ofmlV6FqiKBpcl8j/IxQ==
=VWlb
-----END PGP SIGNATURE-----

--D19dDso03lVt3XPzad61fdPH3hldKTfyR--
