Received: from eggs.gnu.org ([2001:4830:134:3::10]:48223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswuK-00052Q-37
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswuJ-0002gJ-5j
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:35:56 -0400
References: <20170308191434.2413-1-mreitz@redhat.com>
	<20170308191544.3025-2-mreitz@redhat.com>
	<20170323180346.GE5344@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <97cd6a73-d174-4a83-8288-2f5b7af348f4@redhat.com>
Date: Tue, 28 Mar 2017 21:35:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170323180346.GE5344@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c0197qT6mqHwnuVeRIDEVpKsqp8vaXdbo"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 4/4] block: Add some
 bdrv_truncate() error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c0197qT6mqHwnuVeRIDEVpKsqp8vaXdbo
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Message-ID: <97cd6a73-d174-4a83-8288-2f5b7af348f4@redhat.com>
Subject: Re: [PATCH v2 for-2.10 4/4] block: Add some bdrv_truncate() error
 messages
References: <20170308191434.2413-1-mreitz@redhat.com>
 <20170308191544.3025-2-mreitz@redhat.com>
 <20170323180346.GE5344@noname.redhat.com>
In-Reply-To: <20170323180346.GE5344@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23.03.2017 19:03, Kevin Wolf wrote:
> Am 08.03.2017 um 20:15 hat Max Reitz geschrieben:
>> Add missing error messages for the drivers I am comfortable to do this=

>> in.
>>
>> Since one of these changes touches a mis-indented block in
>> block/file-posix.c, this patch fixes that coding style issue along the=

>> way.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 17585fbb89..53b0bd61a7 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2550,6 +2550,7 @@ static int qcow2_truncate(BlockDriverState *bs, =
int64_t offset, Error **errp)
>>      new_l1_size =3D size_to_l1(s, offset);
>>      ret =3D qcow2_grow_l1_table(bs, new_l1_size, true);
>>      if (ret < 0) {
>> +        error_setg(errp, "Failed to grow the L1 table");
>=20
> Let's not throw away error codes, error_setg_errno() is your friend.

:-)

Will do. Not sure why I haven't.

Max

>>          return ret;
>>      }
>> =20
>> @@ -2558,6 +2559,7 @@ static int qcow2_truncate(BlockDriverState *bs, =
int64_t offset, Error **errp)
>>      ret =3D bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
>>                             &offset, sizeof(uint64_t));
>>      if (ret < 0) {
>> +        error_setg(errp, "Failed to update the image size");
>=20
> Here, too.
>=20
>>          return ret;
>>      }
>> =20
>> diff --git a/block/qed.c b/block/qed.c
>> index fa2aeee471..eb346d645b 100644
>> --- a/block/qed.c
>> +++ b/block/qed.c
>> @@ -1526,11 +1526,12 @@ static int bdrv_qed_truncate(BlockDriverState =
*bs, int64_t offset, Error **errp)
>> =20
>>      if (!qed_is_image_size_valid(offset, s->header.cluster_size,
>>                                   s->header.table_size)) {
>> +        error_setg(errp, "Invalid image size specified");
>>          return -EINVAL;
>>      }
>> =20
>> -    /* Shrinking is currently not supported */
>>      if ((uint64_t)offset < s->header.image_size) {
>> +        error_setg(errp, "Shrinking images is currently not supported=
");
>>          return -ENOTSUP;
>>      }
>> =20
>> @@ -1539,6 +1540,7 @@ static int bdrv_qed_truncate(BlockDriverState *b=
s, int64_t offset, Error **errp)
>>      ret =3D qed_write_header_sync(s);
>>      if (ret < 0) {
>>          s->header.image_size =3D old_image_size;
>> +        error_setg(errp, "Failed to update the image size");
>=20
> As well as here.
>=20
>>      }
>>      return ret;
>>  }
>=20
> Kevin
>=20



--c0197qT6mqHwnuVeRIDEVpKsqp8vaXdbo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljauxMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ak5UH/i/rnox8N2p0sX+GlbXOfSccuoC/098h
NfQG19qv9CnlgqXLxMD9dAQYVmEYoxMikgXbxioNCYvj8YioFd/4L668uuSzxgkz
e8JSojEfaShMTp4mPyuuMWT+MwzvgYpGrZT99n1WLLng7dz4hcq04kKPhDgvCanQ
OpnzSibwpUvmlZQ+Og/aCyOdnsKIunpy6ty93bnYvHcaiwMX98k8uopHYpsl1FJ+
VePfAyBTP45AhKBdNwEgJgNxNz5U80iiIpY48NkOxxtOcAbJQFQgBVVnVZ6PEoBJ
s2DsoBSqgSriWGIYuNDqmRagFX9mxrMrU8WDXx36Ipdqh/im0TyFV3g=
=ceGx
-----END PGP SIGNATURE-----

--c0197qT6mqHwnuVeRIDEVpKsqp8vaXdbo--
