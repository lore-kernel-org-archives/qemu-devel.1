Received: from eggs.gnu.org ([209.51.188.92]:44726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glZQ3-00062p-I4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glZQ2-0003Xp-Ox
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:15:15 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20190115111007.27159-1-stefanha@redhat.com>
	<20190115111007.27159-2-stefanha@redhat.com>
	<7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
Message-ID: <5786786a-1389-81a3-2c9a-fbeca0be10a9@redhat.com>
Date: Mon, 21 Jan 2019 14:15:03 +0100
MIME-Version: 1.0
In-Reply-To: <7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cKh40oP0HckxZ2OZ5k9ZyWARahYiV5mJk"
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
--cKh40oP0HckxZ2OZ5k9ZyWARahYiV5mJk
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <5786786a-1389-81a3-2c9a-fbeca0be10a9@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: include LUKS payload overhead in qemu-img
 measure
References: <20190115111007.27159-1-stefanha@redhat.com>
 <20190115111007.27159-2-stefanha@redhat.com>
 <7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
In-Reply-To: <7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.01.19 14:08, Max Reitz wrote:
> On 15.01.19 12:10, Stefan Hajnoczi wrote:
>> LUKS encryption reserves clusters for its own payload data.  The size =
of
>> this area must be included in the qemu-img measure calculation so that=

>> we arrive at the correct minimum required image size.
>>
>> (Ab)use the qcrypto_block_create() API to determine the payload
>> overhead.  We discard the payload data that qcrypto thinks will be
>> written to the image.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  block/qcow2.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++=
-
>>  1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 4897abae5e..7ab93a5d2f 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>=20
> [...]
>=20
>> @@ -4274,6 +4294,35 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts=
 *opts, BlockDriverState *in_bs,
>>      has_backing_file =3D !!optstr;
>>      g_free(optstr);
>> =20
>> +    optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
>> +    has_luks =3D optstr && strcmp(optstr, "luks") =3D=3D 0;
>> +    g_free(optstr);
>> +
>> +    if (has_luks) {
>> +        QCryptoBlockCreateOptions cryptoopts =3D {
>> +            .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
>> +        };
>> +        QCryptoBlock *crypto;
>> +        size_t headerlen;
>> +
>> +        optstr =3D qemu_opt_get_del(opts, "encrypt.key-secret");
>> +        cryptoopts.u.luks.has_key_secret =3D !!optstr;
>> +        cryptoopts.u.luks.key_secret =3D optstr;
>=20
> I wonder if you couldn't just make some secret up here (if the user
> doesn't specify anything).  Its content shouldn't matter, right?

And now I wonder whether other options may not have actual influence on
the crypto header size.  I suppose in theory the cipher algorithm may
cause a difference, although it's probably not enough to warrant another
cluster...

Max


--cKh40oP0HckxZ2OZ5k9ZyWARahYiV5mJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxFxdcACgkQ9AfbAGHV
z0DtfQf+P0cRalDCJSGgoXSBeLQ2/63BAUFgC+ElAP8gnAPmzmkUxSxxg+uB6DVQ
kCvLlyU4rcDFWGhNUGO6mESQfVYLgmLnDozm2du/WVkVngG16GaBTthFqNoCq2Mp
c5P8E0bq3mxL0X1vMU3/D6OZ0aONO1FF4wfZdXmr9nEfzQmifPdcdhktnQ0i5te/
u41/R3WaqQGKKfXxiyNifjvG/3q2InDie+1iWvxbuZnCEP2NAgGwcKMEOyzVqo8S
NRUr4QfFSnHm2ELQ6J1SUGnQpicYv3ZxGMVIExSTPtpkYn0uw7cVPI3t9FKC8gdq
yImC6IHxncK6MNLRha6M2Tv0ekAJww==
=hI1X
-----END PGP SIGNATURE-----

--cKh40oP0HckxZ2OZ5k9ZyWARahYiV5mJk--
