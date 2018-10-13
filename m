Received: from eggs.gnu.org ([2001:4830:134:3::10]:60046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBJVO-0000rU-UN
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 08:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBJVN-00050B-Q6
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 08:58:54 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-8-vsementsov@virtuozzo.com>
	<873684d4-5219-fa89-f393-2cea8b291dc6@virtuozzo.com>
	<0a9f5768-1fb1-8ce3-4ace-e02589e261c0@virtuozzo.com>
	<ceab5ff6-85c5-c938-3cf7-abafcd08dc35@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <978aa0de-fee6-98d5-dd0d-8814e3c455de@redhat.com>
Date: Sat, 13 Oct 2018 14:58:44 +0200
MIME-Version: 1.0
In-Reply-To: <ceab5ff6-85c5-c938-3cf7-abafcd08dc35@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qLHywNpbbiOIBvEKnklIsO1lthoGjwWSs"
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
--qLHywNpbbiOIBvEKnklIsO1lthoGjwWSs
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <978aa0de-fee6-98d5-dd0d-8814e3c455de@redhat.com>
Subject: Re: [PATCH v2 7/7] block/qcow2-refcount: fix out-of-file L2 entries
 to be read-as-zero
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-8-vsementsov@virtuozzo.com>
 <873684d4-5219-fa89-f393-2cea8b291dc6@virtuozzo.com>
 <0a9f5768-1fb1-8ce3-4ace-e02589e261c0@virtuozzo.com>
 <ceab5ff6-85c5-c938-3cf7-abafcd08dc35@virtuozzo.com>
In-Reply-To: <ceab5ff6-85c5-c938-3cf7-abafcd08dc35@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.18 18:59, Vladimir Sementsov-Ogievskiy wrote:
> 10.10.2018 19:55, Vladimir Sementsov-Ogievskiy wrote:
>> 10.10.2018 19:39, Vladimir Sementsov-Ogievskiy wrote:
>>> 17.08.2018 15:22, Vladimir Sementsov-Ogievskiy wrote:
>>>> Rewrite corrupted L2 table entry, which reference space out of
>>>> underlying file.
>>>>
>>>> Make this L2 table entry read-as-all-zeros without any allocation.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>> =C2=A0 block/qcow2-refcount.c | 32 ++++++++++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>>> index 3c004e5bfe..3de3768a3c 100644
>>>> --- a/block/qcow2-refcount.c
>>>> +++ b/block/qcow2-refcount.c
>>>> @@ -1720,8 +1720,30 @@ static int=20
>>>> check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Mark cluster as used */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 csize =3D (((l2_entry >> s->csize_shift) &=20
>>>> s->csize_mask) + 1) *
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_SECTOR_SIZ=
E;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (csize > s->cluster_size) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D fix_l2_entry_to_zero(
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs,=
 res, fix, l2_offset, i, active,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "co=
mpressed cluster larger than cluster:=20
>>>> size 0x%"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PRI=
x64, csize);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 coffset =3D l2_entry & s->cluster_offset_mask &
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~(B=
DRV_SECTOR_SIZE - 1);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (coffset >=3D bdrv_getlength(bs->file->bs)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D fix_l2_entry_to_zero(
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs,=
 res, fix, l2_offset, i, active,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "co=
mpressed cluster out of file: offset=20
>>>> 0x%" PRIx64,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cof=
fset);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D qcow2_inc_refcounts_imrt(bs, res,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_table,=20
>>>> refcount_table_size,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coffset, csize);
>>>> @@ -1748,6 +1770,16 @@ static int=20
>>>> check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uint64_t offset =3D l2_entry & L2E_OFFSET_MASK;
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (offset >=3D bdrv_getlength(bs->file->bs)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D fix_l2_entry_to_zero(
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs,=
 res, fix, l2_offset, i, active,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "cl=
uster out of file: offset 0x%" PRIx64,=20
>>>> offset);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (flags & CHECK_FRAG_INFO) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res->bfi.allocated_clusters++;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next_contiguous_offset &&
>>>
>>> hmm, interesting question here: in case of misaligned l2 entry, we=20
>>> zero it out only for QCOW2_CLUSTER_ZERO_ALLOC, but not for normal=20
>>> clusters? Why? I think it is ok to mark as zero misaligned normal=20
>>> cluster l2 entry, otherwise we'll have fatal corruption on any=20
>>> operation to this cluster.

Because for zero clusters the solution is clear.  We just throw away the
obviously wrong preallocation information, but the cluster data stays
the same (zero).  So there is no data loss.

For normal clusters, you definitely destroy the data by zeroing them out.=


>> or we can just align them down.

Which would destroy the data as well.

You can argue that if the value is misaligned, it is extremely likely to
be just garbage as a whole, though.  But in any case, it is not obvious
what to do and always means data loss (which is different from zero
clusters, where you can just keep them zero).

The clearest and most obvious solution would be to allocate a new
cluster and copy the unaligned data there.  Maybe that doesn't make
sense because the data is probably garbage anyway, but it definitely
won't harm.

> and why do we calculate refcounts for corrupted l2 entry? Is it correct=
,=20
> to consider data range referenced by this entry, if we'll never success=
=20
> in writing or reading this data?

It's definitely better to mark something wrongly as referenced than
wrongly as free.

The only difference it makes is that maybe we could save some space, but
if there are any such corruptions, saving space really is the least of
the users issues.

MAx


--qLHywNpbbiOIBvEKnklIsO1lthoGjwWSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvB7AQACgkQ9AfbAGHV
z0CCIwgAsI53q3LubZfUX9U9yDaU/QG7HUtpu0nXTdQDmeB1k5Uz/IiMSkWqunKw
unZgwWG73ZMXnkfe1RUsXkWWTep10a7vREOtZZZcGh8z9Lj+lntF3zn/VEdvFKVA
NGN7ZODxf32V+Sp/X/xZqAqXPJn4azTNYwRui/Y6UOm6wQch7kWHuV6h90YJ2gRK
CLoLbFRjsJXoNpAxf7JRttwkY3NLr+yyDDWqRoPEP3aLZL0Nnf/bq1j/mvPwrEb8
oLCktE6hyEpE7z3vc3eJ1PvWJ61FRVwE0kXuXn8NdY2KBgdFhlyGoiwB5lWQutX5
fbA8lWFPRH6T2fRFlx0q9pB//mk43Q==
=04NL
-----END PGP SIGNATURE-----

--qLHywNpbbiOIBvEKnklIsO1lthoGjwWSs--
