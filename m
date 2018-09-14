Received: from eggs.gnu.org ([2001:4830:134:3::10]:42959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0rvG-0007fo-1A
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0rvE-0001dh-Vc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:30:25 -0400
References: <20180914165116.23182-1-vsementsov@virtuozzo.com>
	<05b6e954-744f-d52c-1f5e-51d52062e195@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ce8e83a8-40c1-1fa9-3d83-c5f84796d514@virtuozzo.com>
Date: Fri, 14 Sep 2018 20:30:06 +0300
MIME-Version: 1.0
In-Reply-To: <05b6e954-744f-d52c-1f5e-51d52062e195@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>

14.09.2018 20:24, Eric Blake wrote:
> On 9/14/18 11:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> bitmap_to_extents function is broken: it switches dirty variable after
>> every iteration, however it can process only part of dirty (or zero)
>> area during one iteration in case when this area is too large for one
>> extent.
>>
>> Fortunately, the bug don't produce wrong extents: it just inserts
>> zero-length extents between sequential extents representing large dirty
>> (or zero) area. However, zero-length extents are abandoned by NBD
>
> s/abandoned by/forbidden by the/
>
>> protocol. So, careful client should consider such replay as server
>
> s/replay/reply/
>
>> fault and not-careful will likely ignore zero-length extents.
>
> Which camp is qemu 3.0 as client in? Does it tolerate the zero-length=20
> extent, and still manage to see correct information overall, or does=20
> it crash?
>
> Hmm - I think we're "safe" with qemu as client - right now, the only=20
> way qemu 3.0 accesses the qemu dirty bitmap over NBD is with my=20
> x-dirty-bitmap hack (commit 216ee3657), which uses=20
> block/nbd-client.c:nbd_client_co_block_status() to read the bitmap,=20
> and that always passes NBD_CMD_FLAG_REQ_ONE.=C2=A0 qemu will assert() if=
=20
> nbd_client_co_block_status() doesn't make any progress, but from what=20
> I'm reading of your bug report, qemu as client never permits the=20
> server to answer with more than one extent, and the bug of a=20
> zero-length extent is triggered only after the first extent has been=20
> sent.
>
> Thus, the primary reason to accept this patch is not because of qemu=20
> 3.0 as client, but for interoperability with other clients. I'm=20
> planning on updating the commit message to add these additional details.
>
>>
>> Fix this by more careful handling of dirty variable.
>>
>> Bug was introduced in 3d068aff16
>> =C2=A0 "nbd/server: implement dirty bitmap export", with the whole funct=
ion.
>> and presents in v3.0.0 release.
>
> s/presents/present/
>
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> CC: qemu-stable@nongnu.org
>
>> ---
>> =C2=A0 nbd/server.c | 5 ++++-
>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index ea5fe0eb33..12f721482d 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -1951,6 +1951,8 @@ static unsigned int=20
>> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(begin < overall_end && nb_e=
xtents);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (begin < overall_end && i < nb_exte=
nts) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool next_dirty =3D !dirty;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dirty) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 end =3D bdrv_dirty_bitmap_next_zero(bitmap, begin);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> @@ -1962,6 +1964,7 @@ static unsigned int=20
>> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 end =3D MIN(bdrv_dirty_bitmap_size(bitmap),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 begin + =
UINT32_MAX + 1 -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dir=
ty_bitmap_granularity(bitmap));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next=
_dirty =3D dirty;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> Rather than introducing next_dirty, couldn't you just make this:
>
> if (end =3D=3D -1 || end - begin > UINT32_MAX) {
> =C2=A0=C2=A0=C2=A0 /* Cap ... */
> =C2=A0=C2=A0=C2=A0 end =3D MIN(...);
> } else {
> =C2=A0=C2=A0=C2=A0 dirty =3D !dirty;
> }

no, dirty variable is used after it, we can't change it here.

>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dont_fragment=
 && end > overall_end) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 end =3D overall_end;
>> @@ -1971,7 +1974,7 @@ static unsigned int=20
>> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].flags =
=3D cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 begin =3D end;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty =3D !dirty;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty =3D next_dirty;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> and then you merely delete the assignment to 'dirty' here.
>
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_iter_free(it);
>>
>
> At any rate, the fix makes sense to me.=C2=A0 Should I go ahead and=20
> incorporate the changes I've suggested and turn it into a pull request=20
> through my NBD tree, or would you like to send a v2?
>


--=20
Best regards,
Vladimir
