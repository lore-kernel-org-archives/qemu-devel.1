Received: from eggs.gnu.org ([2001:4830:134:3::10]:57515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyy7-00056F-4h
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyy6-0005yt-1z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:11:35 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-5-mreitz@redhat.com>
	<20170320110023.GH17887@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a51da640-ce10-1a8c-2e07-195e900e1147@redhat.com>
Date: Mon, 20 Mar 2017 16:11:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170320110023.GH17887@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oBDQHB6VPSLw2mtRk21L8L0f6IGBrlkg5"
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/16] block/file-posix:
 Generalize raw_regular_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oBDQHB6VPSLw2mtRk21L8L0f6IGBrlkg5
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <a51da640-ce10-1a8c-2e07-195e900e1147@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/16] block/file-posix: Generalize
 raw_regular_truncate
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214045.26857-5-mreitz@redhat.com>
 <20170320110023.GH17887@stefanha-x1.localdomain>
In-Reply-To: <20170320110023.GH17887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 12:00, Stefan Hajnoczi wrote:
> On Mon, Mar 13, 2017 at 10:40:36PM +0100, Max Reitz wrote:
>> Currently, raw_regular_truncate() is intended for setting the size of =
a
>> newly created file. However, we also want to use it for truncating an
>> existing file in which case only the newly added space (when growing)
>> should be preallocated.
>>
>> This also means that if resizing failed, we should try to restore the
>> original file size. This is important when using preallocation.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/file-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++-=
---------
>>  1 file changed, 60 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 35a9e43f3e..cd229324ba 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -1384,11 +1384,39 @@ static void raw_close(BlockDriverState *bs)
>>      }
>>  }
>> =20
>> -static int raw_regular_truncate(int fd, int64_t offset, PreallocMode =
prealloc,
>> +/**
>> + * Truncates the given regular file @fd to @offset and, when growing,=
 fills the
>> + * new space according to @prealloc.
>> + *
>> + * @create must be true iff the file is new. In that case, @bs is ign=
ored. If
>> + * @create is false, @bs must be valid and correspond to the same fil=
e as @fd.
>=20
> Returns: 0 on success, -errno on failure.

Yep, will add.

>> + */
>> +static int raw_regular_truncate(int fd, BlockDriverState *bs, int64_t=
 offset,
>=20
> The presence of both a file descriptor and a BlockDriverState (actually=

> it must be a BDRVRawState) arguments is unusual.  It seems bs is needed=

> for bdrv_getlength().
>=20
> How about using fstat(fd, &st) and then dropping bs and create?

Well, I could do that, but bdrv_getlength() is a bit simpler and I don't
see much of an issue with specifying both an fd and a bs.

>> +                                PreallocMode prealloc, bool create,
>>                                  Error **errp)
>>  {
>>      int result =3D 0;
>> -    char *buf;
>> +    int64_t current_length =3D 0;
>> +    char *buf =3D NULL;
>> +
>> +    assert(create || bs);
>> +    if (!create) {
>> +        BDRVRawState *s =3D bs->opaque;
>> +        assert(s->fd =3D=3D fd);
>> +    }
>> +
>> +    if (!create) {
>> +        current_length =3D bdrv_getlength(bs);
>> +        if (current_length < 0) {
>> +            error_setg_errno(errp, -current_length,
>> +                             "Could not inquire current length");
>> +            return -current_length;
>> +        }
>> +
>> +        if (current_length > offset && prealloc !=3D PREALLOC_MODE_OF=
F) {
>> +            return -ENOTSUP;
>> +        }
>=20
> Missing error_setg().

Indeed! Will fix.

Max



--oBDQHB6VPSLw2mtRk21L8L0f6IGBrlkg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljP8RwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+xkH+gMqHiXE11Kwg5rhJ+Ztr2Yie3UinD5t
10JJH5ApM/ZnkOzYkcYwg5yu3eqfBV2Ug3aGpRAH8BU8EXzrDLrFen4vQ4mPcAgF
Wzc5+zapLEpKc4j9cf0REy8gwwajuqNG5JW71K582OTh+5zeefQZpbFD/mErpbG+
WW3yXa7ueWWbkgt0BWa6Pyd+9Vl3CXKhSwk/uwjTD2M3LYBln+zn86DG39KrsV35
TLfqJRWTMpUZ9hjN6nC9vBsV/eCrRUwbd+JvNajSHn5Wm0wbCDmbpgq1A+0zeTF7
gF2QL+IrRWzyNMmwdBGcO436pbB6iV6dn1cmS7f9iKf1dN1dRKTMG+o=
=ZLc+
-----END PGP SIGNATURE-----

--oBDQHB6VPSLw2mtRk21L8L0f6IGBrlkg5--
