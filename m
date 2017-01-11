Received: from eggs.gnu.org ([2001:4830:134:3::10]:33691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRMT5-0003Gy-BY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRMT1-0007xA-Ae
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:13:47 -0500
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-23-mreitz@redhat.com>
	<75808f28-d7c0-122d-9046-d5bbed2b4ce2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <06c71464-f451-e26f-03a9-d84d45547353@redhat.com>
Date: Wed, 11 Jan 2017 18:13:33 +0100
MIME-Version: 1.0
In-Reply-To: <75808f28-d7c0-122d-9046-d5bbed2b4ce2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FbAb5PGHsixLMRElurru436L2GLtbgcXX"
Subject: Re: [Qemu-devel] [PATCH v3 22/25] block: Do not copy exact_filename
 from format file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FbAb5PGHsixLMRElurru436L2GLtbgcXX
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>
Message-ID: <06c71464-f451-e26f-03a9-d84d45547353@redhat.com>
Subject: Re: [PATCH v3 22/25] block: Do not copy exact_filename from format
 file
References: <20161130011851.24696-1-mreitz@redhat.com>
 <20161130011851.24696-23-mreitz@redhat.com>
 <75808f28-d7c0-122d-9046-d5bbed2b4ce2@redhat.com>
In-Reply-To: <75808f28-d7c0-122d-9046-d5bbed2b4ce2@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 11.01.2017 17:29, Max Reitz wrote:
> On 30.11.2016 02:18, Max Reitz wrote:
>> If the a format BDS's file BDS is in turn a format BDS, we cannot simp=
ly
>> use the same filename, because when opening a BDS tree based on a
>> filename alone, qemu will create only one format node on top of one
>> protocol node (disregarding a potential backing file).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index ec25cbf..71c14f4 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4095,9 +4095,20 @@ void bdrv_refresh_filename(BlockDriverState *bs=
)
>> =20
>>          bs->exact_filename[0] =3D '\0';
>> =20
>> -        /* If no specific options have been given for this BDS, the f=
ilename of
>> -         * the underlying file should suffice for this one as well */=

>> -        if (bs->file->bs->exact_filename[0] && !generate_json_filenam=
e) {
>> +        /* We can use the underlying file's filename if:
>> +         * - it has a filename,
>> +         * - the file is a protocol BDS, and
>> +         * - opening that file (as this BDS's format) will automatica=
lly create
>> +         *   the BDS tree we have right now, that is:
>> +         *   - the user did not significantly change this BDS's behav=
ior with
>> +         *     some explicit options
>> +         *   - no non-file child of this BDS has been overridden by t=
he user
>> +         *   Both of these conditions are represented by generate_jso=
n_filename.
>> +         */
>> +        if (bs->file->bs->exact_filename[0] &&
>> +            (bs->file->bs->open_flags & BDRV_O_PROTOCOL) &&
>=20
> This was a nice try, but as it turns out, this flag does not have to
> always set for protocol BDSs. A more reliable test is:
>=20
> !bs->file->bs->file
>=20
> This test may also be a bit more intuitive: We can copy exact_filename
> in one layer from bs->file, but not through two layers.

And now it turns out that it's again more complicated...

blkdebug is a protocol block driver that has a bs->file. So when using
blkdebug, bs->file->bs->file is set on the format layer.

So I guess I'll have to resort to testing
bs->file->bs->drv->bdrv_file_open...

Max


--FbAb5PGHsixLMRElurru436L2GLtbgcXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh2Z70SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApeYIAJ91WGOsKo5903GuPv+Ttrsdj0JqvExd
vjo5oXt33tqZwm3MA4FsCwb3IYhKSc+dJXr7CdzY5H+QEKTyrPZzfevOA/5bsZil
ykDr4kEm+mJWElo4KyLvK6aorN6REsSMEecu9eA57JMk+9Nc1LsFiHix8wM8NjOt
od/EXcRYWt6b3UWRJbSDU2Sur8/qx0/c0YmmIsKvqwe8vwaRChbPqUt+lFHZyYEB
LQx9ZRoeZKU6LP5ffcxOcjMuKs4RyvygeE5SWFmjKv4PNGpdfWHU1qxiL6bpkf9e
K0u8nmiGBBDtGM2okpRKXDWszxkYu9SJkr9CIRZngzHp05ozF3UWL7Y=
=PGlb
-----END PGP SIGNATURE-----

--FbAb5PGHsixLMRElurru436L2GLtbgcXX--
