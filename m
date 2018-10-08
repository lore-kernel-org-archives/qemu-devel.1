Received: from eggs.gnu.org ([2001:4830:134:3::10]:42746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9dhb-00039D-BJ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9dha-00021p-Hj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:08:35 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-8-vsementsov@virtuozzo.com>
	<d78f37ac-343d-20bf-a2ce-16ff2fa12677@redhat.com>
	<a02a1caf-53f5-e20a-93a4-67233032d76e@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b78b66f6-018d-0ec9-a33a-3b8263867b8b@redhat.com>
Date: Tue, 9 Oct 2018 00:08:15 +0200
MIME-Version: 1.0
In-Reply-To: <a02a1caf-53f5-e20a-93a4-67233032d76e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oXWysTUyYo3106EXLoYq1OZ3vVR2XkPKH"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/qcow2-refcount: fix
 out-of-file L2 entries to be read-as-zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oXWysTUyYo3106EXLoYq1OZ3vVR2XkPKH
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <b78b66f6-018d-0ec9-a33a-3b8263867b8b@redhat.com>
Subject: Re: [PATCH v2 7/7] block/qcow2-refcount: fix out-of-file L2 entries
 to be read-as-zero
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-8-vsementsov@virtuozzo.com>
 <d78f37ac-343d-20bf-a2ce-16ff2fa12677@redhat.com>
 <a02a1caf-53f5-e20a-93a4-67233032d76e@virtuozzo.com>
In-Reply-To: <a02a1caf-53f5-e20a-93a4-67233032d76e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.10.18 00:02, Vladimir Sementsov-Ogievskiy wrote:
>=20
>=20
> On 10/08/2018 11:51 PM, Max Reitz wrote:
>> On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
>>> Rewrite corrupted L2 table entry, which reference space out of
>>> underlying file.
>>>
>>> Make this L2 table entry read-as-all-zeros without any allocation.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/qcow2-refcount.c | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 3c004e5bfe..3de3768a3c 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>> @@ -1720,8 +1720,30 @@ static int check_refcounts_l2(BlockDriverState=
 *bs, BdrvCheckResult *res,
>>>               /* Mark cluster as used */
>>>               csize =3D (((l2_entry >> s->csize_shift) & s->csize_mas=
k) + 1) *
>>>                       BDRV_SECTOR_SIZE;
>>> +            if (csize > s->cluster_size) {
>>> +                ret =3D fix_l2_entry_to_zero(
>>> +                        bs, res, fix, l2_offset, i, active,
>>> +                        "compressed cluster larger than cluster: siz=
e 0x%"
>>> +                        PRIx64, csize);
>>> +                if (ret < 0) {
>>> +                    goto fail;
>>> +                }
>>> +                continue;
>>> +            }
>>> +
>>
>> This seems recoverable, isn't it?  Can we not try to just limit the
>> csize, or decompress the cluster with the given csize from the given
>> offset, disregarding the cluster limit?
>=20
> Hm, you want to assume that csize is corrupted but coffset may be=20
> correct? Unlikely, I think.

Better to reconstruct probably garbage data than to definitely garbage
data (all zeroes) is what I think.

> So, to carefully repair csize, we should decompress one cluster (or one=
=20
> cluster - 1 byte) of data, trying to get one cluster of decompressed=20
> data. If we succeed, we know csize, or we can safely set it to one clus=
ter.

Yes.

> Or we can just set csize =3D 1 cluster, if it is larger. And leave=20
> problems to real execution which will lead to EIO in worst case.

Or this, yes.

>>>               coffset =3D l2_entry & s->cluster_offset_mask &
>>>                         ~(BDRV_SECTOR_SIZE - 1);
>>> +            if (coffset >=3D bdrv_getlength(bs->file->bs)) {
>>> +                ret =3D fix_l2_entry_to_zero(
>>> +                        bs, res, fix, l2_offset, i, active,
>>> +                        "compressed cluster out of file: offset 0x%"=
 PRIx64,
>>> +                        coffset);
>>> +                if (ret < 0) {
>>> +                    goto fail;
>>> +                }
>>> +                continue;
>>> +            }
>>> +
>>>               ret =3D qcow2_inc_refcounts_imrt(bs, res,
>>>                                              refcount_table, refcount=
_table_size,
>>>                                              coffset, csize);
>>> @@ -1748,6 +1770,16 @@ static int check_refcounts_l2(BlockDriverState=
 *bs, BdrvCheckResult *res,
>>>           {
>>>               uint64_t offset =3D l2_entry & L2E_OFFSET_MASK;
>>>  =20
>>> +            if (offset >=3D bdrv_getlength(bs->file->bs)) {
>>> +                ret =3D fix_l2_entry_to_zero(
>>> +                        bs, res, fix, l2_offset, i, active,
>>> +                        "cluster out of file: offset 0x%" PRIx64, of=
fset);
>>> +                if (ret < 0) {
>>> +                    goto fail;
>>> +                }
>>> +                continue;
>>> +            }
>>> +
>>
>> These other two look OK, but they have another issue:  If this is a v2=

>> image, you cannot create zero clusters; so you'll have to unallocate t=
he
>> cluster in that case.
>=20
>=20
> Oho, it's a problem. It may be unsafe to discard clusters, making=20
> backing image available through the holes. What discard do on v2?=20
> Zeroing or holes?

Oh, right!  discard on v2 punches a hole.  So I see three ways:
(1) You can do the same and point to that bit of code, or
(2) You allocate a data cluster full of zeroes in case of v2, or
(3) You just error out.

(3) doesn't seem like the worst option.  Amending the image to be v3 is
always possible and trivial.  Maybe point the user to that option.

Max


--oXWysTUyYo3106EXLoYq1OZ3vVR2XkPKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu71U8ACgkQ9AfbAGHV
z0CxDgf9HubOfnEIqsIzvD2sp84logPxYeynD++rdIiZmozZPipBhYnLGRYckJZa
h3BLGacORc5ilGSpcCMybV7feej5Ml0gu3bgpKUmZSySEwXgo6wfZyWVN+iw2gEz
uhc2E1ktL8STd9lIpOPrN1CgyQZq+8VXVi5jombscl9bSNCQKu0teBlJJQcYhcQ0
8g0LhLxInG5sXMGYb9MI7Ry7FmkeALoMeceQHnawLdAberMVtknqiuBRmVINr+Bu
72UGaIK1WAkBQvhm7lDb7gUjrd4jiLIzRY5l1r2HR+IeFsdzqtlC2S8hsXRLPD+u
fm3+PZ8Zr6Nb3VLTsHhO//tZVanI7A==
=G0ah
-----END PGP SIGNATURE-----

--oXWysTUyYo3106EXLoYq1OZ3vVR2XkPKH--
