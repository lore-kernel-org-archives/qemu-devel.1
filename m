Received: from eggs.gnu.org ([2001:4830:134:3::10]:59052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gX3xP-00081R-38
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gX3xM-00008r-PR
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:49:43 -0500
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-8-vsementsov@virtuozzo.com>
	<873684d4-5219-fa89-f393-2cea8b291dc6@virtuozzo.com>
	<0a9f5768-1fb1-8ce3-4ace-e02589e261c0@virtuozzo.com>
	<ceab5ff6-85c5-c938-3cf7-abafcd08dc35@virtuozzo.com>
	<978aa0de-fee6-98d5-dd0d-8814e3c455de@redhat.com>
	<24a32495-08b7-5bb4-0489-b5eeaaceaec3@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b5022a5f-2ebd-4c2d-c5fa-1cf5514db653@redhat.com>
Date: Wed, 12 Dec 2018 13:49:30 +0100
MIME-Version: 1.0
In-Reply-To: <24a32495-08b7-5bb4-0489-b5eeaaceaec3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jcJQRY9lJ2pldBxJnSggP9aejnqS3iKSu"
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
--jcJQRY9lJ2pldBxJnSggP9aejnqS3iKSu
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <b5022a5f-2ebd-4c2d-c5fa-1cf5514db653@redhat.com>
Subject: Re: [PATCH v2 7/7] block/qcow2-refcount: fix out-of-file L2 entries
 to be read-as-zero
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-8-vsementsov@virtuozzo.com>
 <873684d4-5219-fa89-f393-2cea8b291dc6@virtuozzo.com>
 <0a9f5768-1fb1-8ce3-4ace-e02589e261c0@virtuozzo.com>
 <ceab5ff6-85c5-c938-3cf7-abafcd08dc35@virtuozzo.com>
 <978aa0de-fee6-98d5-dd0d-8814e3c455de@redhat.com>
 <24a32495-08b7-5bb4-0489-b5eeaaceaec3@virtuozzo.com>
In-Reply-To: <24a32495-08b7-5bb4-0489-b5eeaaceaec3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.12.18 09:36, Vladimir Sementsov-Ogievskiy wrote:
> 13.10.2018 15:58, Max Reitz wrote:
>> On 10.10.18 18:59, Vladimir Sementsov-Ogievskiy wrote:
>>> 10.10.2018 19:55, Vladimir Sementsov-Ogievskiy wrote:
>>>> 10.10.2018 19:39, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 17.08.2018 15:22, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Rewrite corrupted L2 table entry, which reference space out of
>>>>>> underlying file.
>>>>>>
>>>>>> Make this L2 table entry read-as-all-zeros without any allocation.=

>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.=
com>
>>>>>> ---
>>>>>>  =C2=A0 block/qcow2-refcount.c | 32 ++++++++++++++++++++++++++++++=
++
>>>>>>  =C2=A0 1 file changed, 32 insertions(+)
>>>>>>
>>>>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>>>>> index 3c004e5bfe..3de3768a3c 100644
>>>>>> --- a/block/qcow2-refcount.c
>>>>>> +++ b/block/qcow2-refcount.c
>>>>>> @@ -1720,8 +1720,30 @@ static int
>>>>>> check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Mark cluster as used */
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 csize =3D (((l2_entry >> s->csize_shift) &
>>>>>> s->csize_mask) + 1) *
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_SECTOR_=
SIZE;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (csize > s->cluster_size) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fix_l2_entry_to_zero(
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
bs, res, fix, l2_offset, i, active,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"compressed cluster larger than cluster:
>>>>>> size 0x%"
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
PRIx64, csize);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
>>>>>> +
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 coffset =3D l2_entry & s->cluster_offset_mask &
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
~(BDRV_SECTOR_SIZE - 1);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (coffset >=3D bdrv_getlength(bs->file->bs)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fix_l2_entry_to_zero(
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
bs, res, fix, l2_offset, i, active,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"compressed cluster out of file: offset
>>>>>> 0x%" PRIx64,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
coffset);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
>>>>>> +
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D qcow2_inc_refcounts_imrt(bs, res,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_table,
>>>>>> refcount_table_size,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coffset, csize);
>>>>>> @@ -1748,6 +1770,16 @@ static int
>>>>>> check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint64_t offset =3D l2_entry & L2E_OFFSET_MASK;
>>>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (offset >=3D bdrv_getlength(bs->file->bs)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fix_l2_entry_to_zero(
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
bs, res, fix, l2_offset, i, active,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"cluster out of file: offset 0x%" PRIx64,
>>>>>> offset);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
>>>>>> +
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (flags & CHECK_FRAG_INFO) {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res->bfi.allocated_clusters++;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next_contiguous_offset &&
>>>>>
>>>>> hmm, interesting question here: in case of misaligned l2 entry, we
>>>>> zero it out only for QCOW2_CLUSTER_ZERO_ALLOC, but not for normal
>>>>> clusters? Why? I think it is ok to mark as zero misaligned normal
>>>>> cluster l2 entry, otherwise we'll have fatal corruption on any
>>>>> operation to this cluster.
>>
>> Because for zero clusters the solution is clear.  We just throw away t=
he
>> obviously wrong preallocation information, but the cluster data stays
>> the same (zero).  So there is no data loss.
>>
>> For normal clusters, you definitely destroy the data by zeroing them o=
ut.
>>
>>>> or we can just align them down.
>>
>> Which would destroy the data as well.
>>
>> You can argue that if the value is misaligned, it is extremely likely =
to
>> be just garbage as a whole, though.  But in any case, it is not obviou=
s
>> what to do and always means data loss (which is different from zero
>> clusters, where you can just keep them zero).
>>
>> The clearest and most obvious solution would be to allocate a new
>> cluster and copy the unaligned data there.  Maybe that doesn't make
>> sense because the data is probably garbage anyway, but it definitely
>> won't harm.
>=20
>=20
> but what to copy? I think, it is mostly impossible that there is a misa=
ligned
> data cluster. More probable is just partly wrong l2 entry.

What do you mean by "partly"?  I think having eight bytes "partly" wrong
is not very probable either.

I do agree that it's more likely that the L2 information is just garbage
than that the cluster base really is misaligned.  But I think it would
be garbage as a whole.

> So, in your way we will lose this data (as we lose l2 entry, our last h=
ope).

So you think we should set the zero bit and leave the rest of the
cluster as it is?  But the resulting image would not be correct (because
the preallocation offset is wrong), so I don't see that as a good way of
repairing.

On one hand I think we want some repair option to explicitly acknowledge
data loss.  Like invalid bitmaps being removed or invalid L2 entries
being set to some value that is valid.

On the other, I would imagine that one usually runs qemu-img check
without -r on a broken image first to see what's up; at least if they
intent to have a deep look into it at all.  I think people should be
aware that -r all may destroy these kinds of leads.

But in any case, since I think the chances of the L2 entry only being
partly wrong are very small, I think it doesn't bring much to keep that
data around anyway.  I only find it useful in finding out why the
corruption occurred in the first place (by seeing what kind of data it
was overwritten with).

> Finally, what to do with
> misaligned cluster on check? We definitely should do something, as tryi=
ng to
> access such cluster corrupts qcow2 in qemu.

Well, I gave a description of what I think should be done; which is to
allocate a new cluster, copy the unaligned data there, and then make the
entry point to that new cluster.

> What about an additional flag like "-align-misaligned-clusters-down"?

It would probably make more sense to add flags to the qemu-img check
infrastructure than adding a new -r mode, yes.

Max


--jcJQRY9lJ2pldBxJnSggP9aejnqS3iKSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwRA9oACgkQ9AfbAGHV
z0AFGwf+IckMJuawqFDH6iVl/fXpTL+Tj/IvSXkWNOUxe95PN474YsplNefTV2lk
Typ1OqhrbKu996FYnhfwVa6rRGrJ1bAxDgrduDMAZmddidFMv6gJ0E9rl4X4USYR
sNo/8KsFHW1ZTN/0NplUuuTifmUmiEs6ByviSKZNL/QP9xHIPuHvwxQOOPCNx/ZF
mcmTXEahLKVO/a+/5TRv4CpUz5wJakPm9pu0m8KrT8cRaZ59sjlyRSYCzenYAcEt
qgY1s2X3kWKwJICzNaghAKfOJFGeYNIUvQ1O7wrsOnCrVqhfgyPcbcKLlg0qQMjp
LaBI1Nt6hM8fAh3DT/DWR8rMHJxMnA==
=DThk
-----END PGP SIGNATURE-----

--jcJQRY9lJ2pldBxJnSggP9aejnqS3iKSu--
