Received: from eggs.gnu.org ([2001:4830:134:3::10]:50742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIeuy-00022D-O0
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIeux-0001Kn-Lb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:38:52 -0400
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-20-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8e56eb6a-6e2e-41fa-80fd-59060fca6e51@redhat.com>
Date: Wed, 7 Jun 2017 19:38:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170601172734.9039-20-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sJHWT84aJjAmgVAL63rgpRCS1VWjfXeDm"
Subject: Re: [Qemu-devel] [PATCH v8 19/20] qcow2: report encryption specific
 image information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sJHWT84aJjAmgVAL63rgpRCS1VWjfXeDm
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <8e56eb6a-6e2e-41fa-80fd-59060fca6e51@redhat.com>
Subject: Re: [PATCH v8 19/20] qcow2: report encryption specific image
 information
References: <20170601172734.9039-1-berrange@redhat.com>
 <20170601172734.9039-20-berrange@redhat.com>
In-Reply-To: <20170601172734.9039-20-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-01 19:27, Daniel P. Berrange wrote:
> Currently 'qemu-img info' reports a simple "encrypted: yes"
> field. This is not very useful now that qcow2 can support
> multiple encryption formats. Users want to know which format
> is in use and some data related to it.
>=20
> Wire up usage of the qcrypto_block_get_info() method so that
> 'qemu-img info' can report about the encryption format
> and parameters in use
>=20
>   $ qemu-img create \
>       --object secret,id=3Dsec0,data=3D123456 \
>       -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0 \
>       -f qcow2 demo.qcow2 1G
>   Formatting 'demo.qcow2', fmt=3Dqcow2 size=3D1073741824 \
>   encryption=3Doff encrypt.format=3Dluks encrypt.key-secret=3Dsec0 \
>   cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>=20
>   $ qemu-img info demo.qcow2
>   image: demo.qcow2
>   file format: qcow2
>   virtual size: 1.0G (1073741824 bytes)
>   disk size: 480K
>   encrypted: yes
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
>       lazy refcounts: false
>       refcount bits: 16
>       encrypt:
>           ivgen alg: plain64
>           hash alg: sha256
>           cipher alg: aes-256
>           uuid: 3fa930c4-58c8-4ef7-b3c5-314bb5af21f3
>           format: luks
>           cipher mode: xts
>           slots:
>               [0]:
>                   active: true
>                   iters: 1839058
>                   key offset: 4096
>                   stripes: 4000
>               [1]:
>                   active: false
>                   key offset: 262144
>               [2]:
>                   active: false
>                   key offset: 520192
>               [3]:
>                   active: false
>                   key offset: 778240
>               [4]:
>                   active: false
>                   key offset: 1036288
>               [5]:
>                   active: false
>                   key offset: 1294336
>               [6]:
>                   active: false
>                   key offset: 1552384
>               [7]:
>                   active: false
>                   key offset: 1810432
>           payload offset: 2068480
>           master key iters: 438487
>       corrupt: false
>=20
> With the legacy "AES" encryption we just report the format
> name
>=20
>   $ qemu-img create \
>       --object secret,id=3Dsec0,data=3D123456 \
>       -o encrypt.format=3Daes,encrypt.key-secret=3Dsec0 \
>       -f qcow2 demo.qcow2 1G
>   Formatting 'demo.qcow2', fmt=3Dqcow2 size=3D1073741824 \
>   encryption=3Doff encrypt.format=3Daes encrypt.key-secret=3Dsec0 \
>   cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>=20
>   $ ./qemu-img info demo.qcow2
>   image: demo.qcow2
>   file format: qcow2
>   virtual size: 1.0G (1073741824 bytes)
>   disk size: 196K
>   encrypted: yes
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
>       lazy refcounts: false
>       refcount bits: 16
>       encrypt:
>           format: aes
>       corrupt: false
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2.c        | 32 +++++++++++++++++++++++++++++++-
>  qapi/block-core.json | 27 ++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 58da658..a8a23af 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -3224,6 +3230,30 @@ static ImageInfoSpecific *qcow2_get_specific_inf=
o(BlockDriverState *bs)
>          assert(false);
>      }
> =20
> +    if (encrypt_info) {
> +        ImageInfoSpecificQCow2Encryption *qencrypt =3D
> +            g_new(ImageInfoSpecificQCow2Encryption, 1);
> +        switch (encrypt_info->format) {
> +        case Q_CRYPTO_BLOCK_FORMAT_QCOW:
> +            qencrypt->format =3D BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_AES;=

> +            qencrypt->u.aes =3D encrypt_info->u.qcow;
> +            break;
> +        case Q_CRYPTO_BLOCK_FORMAT_LUKS:
> +            qencrypt->format =3D BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_LUKS=
;
> +            qencrypt->u.luks =3D encrypt_info->u.luks;
> +            break;
> +        default:
> +            assert(false);

I'd rather like this to be either a plain abort() or a
g_asert_not_reached(); the latter is more expressive, and the former
will work even with NDEBUG.

I know we already have an assert(false) in this function, but I'd assert
this is just wrong.

With this changed (or with me convinced that we should just use
assert(false)):

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        }
> +        /* Since we did shallow copy above, erase any pointers
> +         * in the original info */
> +        memset(&encrypt_info->u, 0, sizeof(encrypt_info->u));
> +        qapi_free_QCryptoBlockInfo(encrypt_info);
> +
> +        spec_info->u.qcow2.data->has_encrypt =3D true;
> +        spec_info->u.qcow2.data->encrypt =3D qencrypt;
> +    }
> +
>      return spec_info;
>  }



--sJHWT84aJjAmgVAL63rgpRCS1VWjfXeDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZODokEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKyF
CACYInxHJOlXQDaofhEx2oDYnIWmmcNECnJMIYg9H/UB/KZcl5lye5bvzWMeRths
lskoiCqQy4qFPkZHGnieUEjDVLuThAIG/10oaeHEuRYtglE97zJatmO5kv9WocLO
edkdU/Soy8VOaouGJlpbxYazxy+rEpbBwwTCVlPxJZkj9/GvbMfe4mA/cZvLSA5j
SPF8KHHvqzMkISAFTDD5paf3BQ8p0hQ31xfrVEcKbFeMw/HZCyp7M2PrnFwDhm+4
8NPnEhe4a/AANv8jrRS8vV9Lx6n2Zgzy7DGNPyjVMWoPRTmVmXvEi0jYCc1BnFZH
7GGdAvBTwUw8HTFZdgBVd471
=rr3z
-----END PGP SIGNATURE-----

--sJHWT84aJjAmgVAL63rgpRCS1VWjfXeDm--
