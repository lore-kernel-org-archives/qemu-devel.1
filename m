Received: from eggs.gnu.org ([2001:4830:134:3::10]:47386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7GU-0006T0-9S
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7GT-0007fg-3T
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:21:14 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-3-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08bec0bb-c6a4-97d0-bacd-b3c2e4348bd1@redhat.com>
Date: Tue, 25 Jul 2017 16:21:03 -0500
MIME-Version: 1.0
In-Reply-To: <1500993699-19299-3-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OPHpkKMlsXADJukmxSEwwehFrR9allThB"
Subject: Re: [Qemu-devel] [PATCH V5 02/10] qapi/block-core: add
 Qcow2Compress parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OPHpkKMlsXADJukmxSEwwehFrR9allThB
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <08bec0bb-c6a4-97d0-bacd-b3c2e4348bd1@redhat.com>
Subject: Re: [PATCH V5 02/10] qapi/block-core: add Qcow2Compress parameters
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
 <1500993699-19299-3-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-3-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 09:41 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qapi/block-core.json | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 833c602..f652206 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2455,6 +2455,46 @@
>              '*encrypt': 'BlockdevQcow2Encryption' } }
> =20
>  ##
> +# @Qcow2CompressFormat:
> +#
> +# @deflate: standard zlib deflate compression
> +#
> +# Since: 2.11
> +##
> +{ 'enum': 'Qcow2CompressFormat',
> +  'data': [ 'deflate' ] }
> +
> +##
> +# @Qcow2CompressDeflate:
> +#
> +# @level: specifies the compression level. 0 =3D default compression,
> +#         1 =3D fastest compression, 9 =3D best compresion

By putting level here instead of in the common base type, you'll have to
re-implement it for each compression type - but that's also okay since
they (might) have different ranges of valid levels.

s/compresion/compression/

maybe: 0 =3D default compression (same as level 6), 1=3D...


> +# @window-size: specifies the window size used for deflate compression=
=2E
> +#               8...15 =3D window size of 2^8 to 2^15 byte (default)

15 is the new default, but it might be worth an explicit mention that a
window of 12 is required for back-compat to older images.

> +#
> +# Since: 2.11
> +##
> +{ 'struct': 'Qcow2CompressDeflate',
> +  'data': { '*level': 'uint8',
> +            '*window-size': 'uint8' } }
> +
> +##
> +# @Qcow2Compress:
> +#
> +# Specifies the compression format and compression level that should
> +# be used for compressed Qcow2 clusters.
> +#
> +# @format: specifies the compression format to use. (defaults to zlib)=


s/zlib/deflate/

> +#
> +# Since: 2.11
> +##
> +{ 'union': 'Qcow2Compress',
> +  'base': { 'format': 'Qcow2CompressFormat' },
> +  'discriminator': 'format',
> +  'data': { 'deflate': 'Qcow2CompressDeflate' } }
> +
> +
> +##
>  # @BlockdevOptionsSsh:
>  #
>  # @server:              host address
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OPHpkKMlsXADJukmxSEwwehFrR9allThB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3tj8ACgkQp6FrSiUn
Q2rMQgf/bx6Fzu/PX788+Z42PXoQD/pbsSqa016EB3dkghaX2C9Y3jeLjUsWP8zU
hlAEOEs9oMq9HlZUbMHHf3ki/gJeQpaY7BqV40rNCmRTMtsDSoNBogtyzNh/IbMO
kZQaLv4rQLmlJ7vQbt4JuiYccfi+7U/5K4FKQTXHrT4tNyZ0Eub78AJlSe84n6r7
JiQEdKAoMYqJ8MeFWPPvkZwlW36/AiW5vguUWktlvW0m2stKPzyBhcOU2dFLF7dF
/1YXNMplSUte9s70j1ljaLiBICwAjjmqX7KSkc8HNZdaXJReX058uWz9dQyofkrQ
bAEviSRdIB2lDzfuAPAEvSOWyRUv/Q==
=EpEZ
-----END PGP SIGNATURE-----

--OPHpkKMlsXADJukmxSEwwehFrR9allThB--
