Received: from eggs.gnu.org ([2001:4830:134:3::10]:46216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHBum-0006ox-3U
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHBuk-00010D-WE
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:33:08 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-5-mreitz@redhat.com>
	<20180510075854.GC23581@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bb486618-d6f5-4a26-9d32-3a69c2de36a3@redhat.com>
Date: Fri, 11 May 2018 19:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180510075854.GC23581@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uRS7l6E4omWwSagzUxVbNUJUXFiFAbnVb"
Subject: Re: [Qemu-devel] [PATCH 04/13] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uRS7l6E4omWwSagzUxVbNUJUXFiFAbnVb
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <bb486618-d6f5-4a26-9d32-3a69c2de36a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/13] qapi: Formalize qcow2 encryption
 probing
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-5-mreitz@redhat.com>
 <20180510075854.GC23581@redhat.com>
In-Reply-To: <20180510075854.GC23581@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-10 09:58, Daniel P. Berrang=C3=A9 wrote:
> On Wed, May 09, 2018 at 06:55:21PM +0200, Max Reitz wrote:
>> Currently, you can give no encryption format for a qcow2 file while
>> still passing a key-secret.  That does not conform to the schema, so
>> this patch changes the schema to allow it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-core.json | 44 ++++++++++++++++++++++++++++++++++++++++---=
-
>>  1 file changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 71c9ab8538..092a1aba2d 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -43,6 +43,19 @@
>>  { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
>>    'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
>> =20
>> +##
>> +# @ImageInfoSpecificQCow2EncryptionNoInfo:
>> +#
>> +# Only used for the qcow2 encryption format "from-image" in which the=

>> +# actual encryption format is determined from the image header.
>> +# Therefore, this encryption format will never be reported in
>> +# ImageInfoSpecificQCow2Encryption.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct': 'ImageInfoSpecificQCow2EncryptionNoInfo',
>> +  'data': { } }
>> +
>>  ##
>>  # @ImageInfoSpecificQCow2Encryption:
>>  #
>> @@ -52,7 +65,8 @@
>>    'base': 'ImageInfoSpecificQCow2EncryptionBase',
>>    'discriminator': 'format',
>>    'data': { 'aes': 'QCryptoBlockInfoQCow',
>> -            'luks': 'QCryptoBlockInfoLUKS' } }
>> +            'luks': 'QCryptoBlockInfoLUKS',
>> +            'from-image': 'ImageInfoSpecificQCow2EncryptionNoInfo' } =
}
>> =20
>>  ##
>>  # @ImageInfoSpecificQCow2:
>> @@ -2739,10 +2753,30 @@
>>  # @BlockdevQcow2EncryptionFormat:
>>  # @aes: AES-CBC with plain64 initialization venctors
>>  #
>> +# @from-image:      Determine the encryption format from the image
>> +#                   header.  This only allows the use of the
>> +#                   key-secret option.  (Since: 2.13)
>> +#
>>  # Since: 2.10
>>  ##
>>  { 'enum': 'BlockdevQcow2EncryptionFormat',
>> -  'data': [ 'aes', 'luks' ] }
>> +  'data': [ 'aes', 'luks', 'from-image' ] }
>> +
>> +##
>> +# @BlockdevQcow2EncryptionSecret:
>> +#
>> +# Allows specifying a key-secret without specifying the exact
>> +# encryption format, which is determined automatically from the image=

>> +# header.
>> +#
>> +# @key-secret:      The ID of a QCryptoSecret object providing the
>> +#                   decryption key.  Mandatory except when probing
>> +#                   image for metadata only.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct': 'BlockdevQcow2EncryptionSecret',
>> +  'data': { '*key-secret': 'str' } }
>> =20
>>  ##
>>  # @BlockdevQcow2Encryption:
>> @@ -2750,10 +2784,12 @@
>>  # Since: 2.10
>>  ##
>>  { 'union': 'BlockdevQcow2Encryption',
>> -  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
>> +  'base': { '*format': 'BlockdevQcow2EncryptionFormat' },
>>    'discriminator': 'format',
>> +  'default-variant': 'from-image',
>>    'data': { 'aes': 'QCryptoBlockOptionsQCow',
>> -            'luks': 'QCryptoBlockOptionsLUKS'} }
>> +            'luks': 'QCryptoBlockOptionsLUKS',
>> +            'from-image': 'BlockdevQcow2EncryptionSecret' } }
>=20
> Bike-shedding on name, how about "auto" or "probe" ?

Sure.  I like "probe" a bit better than "auto", although "auto" is what
we usually have...  But I think "probe" is still a bit better.

>=20
> IIUC, this schema addition means the QAPI parser now allows
>=20
>    encrypt.format=3Dfrom-image,encrypt.key-secret=3Dsec0,...other opts.=
=2E.
>=20
> but the code will not accept "from-image" as a valid string.

Ah, right, I forgot that.  Will fix.

Thanks for reviewing!

Max

> eg qcow2_update_options_prepare() will do
>=20
>     case QCOW_CRYPT_AES:
>         if (encryptfmt && !g_str_equal(encryptfmt, "aes")) {
>             error_setg(errp,
>                        "Header reported 'aes' encryption format but "
>                        "options specify '%s'", encryptfmt);
>             ret =3D -EINVAL;
>             goto fail;
>         }
>=20
>        ...snip....
>=20
>     case QCOW_CRYPT_LUKS:
>         if (encryptfmt && !g_str_equal(encryptfmt, "luks")) {
>             error_setg(errp,
>                        "Header reported 'luks' encryption format but "
>                        "options specify '%s'", encryptfmt);
>             ret =3D -EINVAL;
>             goto fail;
>         }
>=20
>=20
> Regards,
> Daniel
>=20



--uRS7l6E4omWwSagzUxVbNUJUXFiFAbnVb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr108oACgkQ9AfbAGHV
z0B4tgf/eDYvVLOWpLb3eCcj2ytpKZsrvntVuMzmSRtyN6upDeS8eL+khWzFebPe
H9UhV9edn8ZC15Qft3WRfoJr2wgLfy9NM/dF1puTioABgfNlaz2x2G2GMYhYlNAD
Wacy72Dfl0mg6u7zq2E5mxstlOHwf6z7TjyMoaGZxC5ofQIP+XFt+mBFiIqVVbZy
dd3aiTeE4Q5ANje7ehdELGBCBvn7jX6SOkkPDCVRzocTGzzn7H13Et6aWOKUTrCx
0EQn1njeWF4mkN1km06kWpJtagP3EyvSjAMXc2Du3dbPOUXfHUIEns8wecBYkTbc
jGq9xJmZGKFXT/nfKtP8IMU2EwZS9Q==
=5qvN
-----END PGP SIGNATURE-----

--uRS7l6E4omWwSagzUxVbNUJUXFiFAbnVb--
