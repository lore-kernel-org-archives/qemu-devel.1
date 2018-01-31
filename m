Received: from eggs.gnu.org ([2001:4830:134:3::10]:40704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egwEs-00011r-2e
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egwEl-0001WG-6y
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:32:00 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-4-git-send-email-anton.nefedov@virtuozzo.com>
	<ac354ca7-a569-42f4-1aab-0274b269b50b@redhat.com>
	<48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b3fdc845-173f-7d92-c157-4e83eb920af6@redhat.com>
Date: Wed, 31 Jan 2018 18:31:38 +0100
MIME-Version: 1.0
In-Reply-To: <48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DF8ksicN27YO1ZYTkYFfhmjz9KNDRPt3Y"
Subject: Re: [Qemu-devel] [PATCH v7 3/9] block: introduce BDRV_REQ_ALLOCATE
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DF8ksicN27YO1ZYTkYFfhmjz9KNDRPt3Y
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <b3fdc845-173f-7d92-c157-4e83eb920af6@redhat.com>
Subject: Re: [PATCH v7 3/9] block: introduce BDRV_REQ_ALLOCATE flag
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-4-git-send-email-anton.nefedov@virtuozzo.com>
 <ac354ca7-a569-42f4-1aab-0274b269b50b@redhat.com>
 <48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
In-Reply-To: <48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-30 13:34, Anton Nefedov wrote:
>=20
>=20
> On 29/1/2018 10:37 PM, Max Reitz wrote:
>> On 2018-01-18 18:49, Anton Nefedov wrote:
>>> The flag is supposed to indicate that the region of the disk image ha=
s
>>> to be sufficiently allocated so it reads as zeroes.
>>>
>>> The call with the flag set must return -ENOTSUP if allocation cannot
>>> be done efficiently.
>>> This has to be made sure of by both
>>> =C2=A0=C2=A0 - the drivers that support the flag
>>> =C2=A0=C2=A0 - and the common block layer (so it will not fall back t=
o any
>>> slowpath
>>> =C2=A0=C2=A0=C2=A0=C2=A0 (like writing zero buffers) in case the driv=
er does not support
>>> =C2=A0=C2=A0=C2=A0=C2=A0 the flag).
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>> =C2=A0 include/block/block.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++-=

>>> =C2=A0 include/block/block_int.h |=C2=A0 2 +-
>>> =C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 +++++++++++++++++---
>>> =C2=A0 3 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index 9b12774..3e31b89 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>> @@ -65,9 +65,13 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_NO_SERIALISING=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x8,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_FUA=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x10,=

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_WRITE_COMPRESSED=C2=A0=C2=A0 =
=3D 0x20,
>>> +=C2=A0=C2=A0=C2=A0 /* The BDRV_REQ_ALLOCATE flag is used to indicate=
 that the
>>> driver has to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * efficiently allocate the space so it read=
s as zeroes, or
>>> return an error.
>>
>> What happens if you specify this for a normal write operation that doe=
s
>> not write zeroes?
>>
>> (I suppose the answer is "don't do that", but that would need to be
>> documented more clearly here.)
>>
>=20
> I can't quite come up with what a regular write with ALLOCATE flag can
> suppose to mean.

It could mean that when zero detection is active, that zero range will
be allocated.  But considering ALLOCATE explicitly means "do not write
data", it probably doesn't make sense for data writes in general.

> Will document that.

Thanks!

>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 BDRV_REQ_ALLOCATE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x40,
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Mask of valid flags */
>>> -=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3f,
>>> +=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x7f,
>>> =C2=A0 } BdrvRequestFlags;
>>> =C2=A0 =C2=A0 typedef struct BlockSizes {
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 29cafa4..b141710 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -632,7 +632,7 @@ struct BlockDriverState {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Flags honored during pwrite (so far=
: BDRV_REQ_FUA) */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int supported_write_flags;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Flags honored during pwrite_zeroes =
(so far: BDRV_REQ_FUA,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * BDRV_REQ_MAY_UNMAP) */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * BDRV_REQ_MAY_UNMAP, BDRV_REQ_ALLOCATE) */=

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int supported_zero_flags;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* the following member gives a=
 name to every node on the bs
>>> graph. */
>>> diff --git a/block/io.c b/block/io.c
>>> index 7ea4023..cf2f84c 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1424,7 +1424,7 @@ static int coroutine_fn
>>> bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 assert(!bs->supported_zero_flags);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EN=
OTSUP) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOTSUP &=
& !(flags & BDRV_REQ_ALLOCATE)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Fall back to bounce buffer if write zeroes is
>>> unsupported */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BdrvRequestFlags write_flags =3D flags &
>>> ~BDRV_REQ_ZERO_WRITE;
>>> =C2=A0 @@ -1514,8 +1514,8 @@ static int coroutine_fn
>>> bdrv_aligned_pwritev(BdrvChild *child,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D
>>> notifier_with_return_list_notify(&bs->before_write_notifiers, req);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret && bs->detect_zeroes !=
=3D
>>> BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(flags & BDRV_REQ_ZERO_W=
RITE) && drv->bdrv_co_pwrite_zeroes &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_iovec_is_zero(qiov))=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(flags & BDRV_REQ_ZERO_W=
RITE) && !(flags &
>>> BDRV_REQ_ALLOCATE) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drv->bdrv_co_pwrite_zeroe=
s && qemu_iovec_is_zero(qiov)) {
>>
>> Do we really need to add the BDRV_REQ_ALLOCATE check here?=C2=A0 If th=
e
>> caller specifies that flag, then we won't invalidate it by adding the
>> BDRV_REQ_ZERO_WRITE flag (as long as we don't add BDRV_REQ_MAY_UNMAP).=

>>
>=20
> Now !(flags & BDRV_REQ_ALLOCATE) is always true here, as REQ_ALLOCATE
> implies REQ_ZERO_WRITE.
> But conceptually yes I think the check should only forbid setting
> MAY_UNMAP.
>=20
> Offtop: does REQ_ZERO_WRITE override REQ_WRITE_COMPRESSED in this
> function? at least with !REQ_MAY_UNMAP it looks wrong

Looks like zero detection will indeed override compression.  I think
that was intended, but I don't even have an opinion either way.

Of course, it wouldn't be so nice if you tried to compress something and
then, because the zero write failed, you actually write uncompressed
zeroes...  But since zero detection is an optional feature, it might be
your own fault if you enable it when you want compression anyway, and if
you write to some format/protocol combination that doesn't allow zero
writes.

Max


--DF8ksicN27YO1ZYTkYFfhmjz9KNDRPt3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpx/XoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4UUIAL97G9gm+jNisdfwpYgD5dMDunVrKfIE
0FZ0ucolPWMA+T3rQtf/pSQS9W71l8/dGJkCzdQGxaN1AZEhFhFsYIn5nnXZtimK
iw9qA/D0TQMlC4rK8RdzR291XrilyHUx8ZlJYrNe0VXJ6tEjPZwm3kyjkPqzKLx2
2QkmDcaj7Xmf9eZES0voPQbk1uoePKXqbCGJDl/BAp/ee7iYiAp8BCO+Jnt40v8w
k/ueHWJNvl4gffU8lbInhySG00zI9yKj9T5hO6dbSYy+L7sbqvrkInYnN1RtZ7dI
zo32UQ7oIJ3MQIahR7un7C40ggGRc1DIciihXLwD91hfKRp32JN14xo=
=xMty
-----END PGP SIGNATURE-----

--DF8ksicN27YO1ZYTkYFfhmjz9KNDRPt3Y--
