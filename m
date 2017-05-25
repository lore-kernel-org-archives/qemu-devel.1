Received: from eggs.gnu.org ([2001:4830:134:3::10]:40911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDyoS-0006OS-Ft
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDyoR-0007fE-E2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:52:48 -0400
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-20-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1acec55c-fd89-ee9d-0082-372a6e967036@redhat.com>
Date: Thu, 25 May 2017 14:52:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170525163851.8047-20-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ogUxFnpF7Uj0cAeM26oO48wFVid7Tl4ik"
Subject: Re: [Qemu-devel] [PATCH v7 19/20] qcow2: report encryption specific
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ogUxFnpF7Uj0cAeM26oO48wFVid7Tl4ik
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <1acec55c-fd89-ee9d-0082-372a6e967036@redhat.com>
Subject: Re: [PATCH v7 19/20] qcow2: report encryption specific image
 information
References: <20170525163851.8047-1-berrange@redhat.com>
 <20170525163851.8047-20-berrange@redhat.com>
In-Reply-To: <20170525163851.8047-20-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 11:38 AM, Daniel P. Berrange wrote:
> Currently 'qemu-img info' reports a simple "encrypted: yes"
> field. This is not very useful now that qcow2 can support
> multiple encryption formats. Users want to know which format
> is in use and some data related to it.
>=20
> Wire up usage of the qcrypto_block_get_info() method so that
> 'qemu-img info' can report about the encryption format
> and parameters in use
>=20

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2.c        | 35 ++++++++++++++++++++++++++++++++++-
>  qapi/block-core.json | 24 +++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 38f9eb5..cb321a2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3196,8 +3196,17 @@ static int qcow2_get_info(BlockDriverState *bs, =
BlockDriverInfo *bdi)
>  static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs=
)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> -    ImageInfoSpecific *spec_info =3D g_new(ImageInfoSpecific, 1);
> +    ImageInfoSpecific *spec_info;
> +    QCryptoBlockInfo *encrypt_info =3D NULL;
> =20
> +    if (s->crypto !=3D NULL) {
> +        encrypt_info =3D qcrypto_block_get_info(s->crypto, NULL);

Worth using &error_abort instead of silently ignoring the error?  Is an
error even possible in our output visitor [adding Markus for reference]?

> +        if (!encrypt_info) {
> +            return NULL;
> +        }

If you use &error_abort, this is a dead check.

> +    }
> +
> +    spec_info =3D g_new(ImageInfoSpecific, 1);
>      *spec_info =3D (ImageInfoSpecific){
>          .type  =3D IMAGE_INFO_SPECIFIC_KIND_QCOW2,
>          .u.qcow2.data =3D g_new(ImageInfoSpecificQCow2, 1),
> @@ -3224,6 +3233,30 @@ static ImageInfoSpecific *qcow2_get_specific_inf=
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
> +        }
> +        /* Since we did shallow copy above, erase any pointers
> +         * in the original info */
> +        memset(&encrypt_info->u, 0, sizeof(encrypt_info->u));
> +        qapi_free_QCryptoBlockInfo(encrypt_info);

Does QAPI_CLONE_MEMBERS (commit 4626a19c) make this code any easier to
write?  Then again, malloc'ing duplicates to then free the unchanged
original is a bit slower than stealing references from the original then
making sure the original can be freed without problem.

>  # @ImageInfoSpecificQCow2:
>  #
>  # @compat: compatibility level
> @@ -51,7 +72,8 @@
>        'compat': 'str',
>        '*lazy-refcounts': 'bool',
>        '*corrupt': 'bool',
> -      'refcount-bits': 'int'
> +      'refcount-bits': 'int',
> +      '*encrypt': 'ImageInfoSpecificQCow2Encryption'

Missing documentation of the @encrypt field.

Close!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ogUxFnpF7Uj0cAeM26oO48wFVid7Tl4ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJzX+AAoJEKeha0olJ0NqWVoH/jQqkY34FB1DxACxWejC1zbq
a1JKMReER2EtRoNJVBfLu5oVBuOY3/6TTxeho+BZjPs6+0RxyBfDGHUV7edD++m0
vzrKjXYDC4lBly0Pbld0XWqdYBR7T6r0xLCOBSuFa/3Wr33as3FV7LzfR2JfajMW
UJwBeLh3Rz9ky4CBwQqMqfi3YspBxBiV6R4qdibMIIAF/zcLX+ZE9gNOzd/TOJw/
Anes83slBEvEyXYKHdMCea1OUqACUt9++2+HKqEd56VYmBXqzrmblGZphkGvf0ds
BDNBYOKLTqQwn5RRu2sLvwUKKooiDq5UEH0rTwd1iKa/R4V15bu/kCW31ogZFlw=
=DCix
-----END PGP SIGNATURE-----

--ogUxFnpF7Uj0cAeM26oO48wFVid7Tl4ik--
