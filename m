Received: from eggs.gnu.org ([2001:4830:134:3::10]:46648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSPwU-0007OP-4b
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSPwT-0004tL-1Y
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:13:02 -0500
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
	<20171212160450.17510-3-vsementsov@virtuozzo.com>
	<20171222133911.GG3763@localhost.localdomain>
	<25bbf12b-e6e8-29be-c28e-1bd10a9dd473@virtuozzo.com>
	<20171222154318.GK3763@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <087696f5-a12b-7e45-7259-886bb1295dda@virtuozzo.com>
Date: Fri, 22 Dec 2017 19:12:49 +0300
MIME-Version: 1.0
In-Reply-To: <20171222154318.GK3763@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qcow2: handle reopening bitmaps on
 bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, den@openvz.org, jsnow@redhat.com

22.12.2017 18:43, Kevin Wolf wrote:
> Am 22.12.2017 um 15:25 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 22.12.2017 16:39, Kevin Wolf wrote:
>>> Am 12.12.2017 um 17:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Consider migration with shared storage. Persistent bitmaps are stored
>>>> on bdrv_inactivate. Then, on destination
>>>> process_incoming_migration_bh() calls bdrv_invalidate_cache_all() whic=
h
>>>> leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
>>>> are already loaded on destination start. In this case we should call
>>>> qcow2_reopen_bitmaps_rw instead.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> qcow2_invalidate_cache() calls qcow2_close() first, so why are there
>>> still any bitmaps loaded? Isn't this a bug? Do we leak bitmaps when a
>>> qcow2 image is closed?
>>>
>>> Kevin
>> Interesting point.
>>
>> Now persistent dirty bitmaps are released at the end of
>> bdrv_inactivate_recurse,
>> which is not called here. It was a separate patch
>>
>> commit 615b5dcf2decbc5f0abb512d13d7e5db2385fa23
>> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Date:=C2=A0=C2=A0 Wed Jun 28 15:05:30 2017 +0300
>>
>>  =C2=A0=C2=A0=C2=A0 block: release persistent bitmaps on inactivate
>>
>> May be it is more correct to release them immediately after storing, in
>> qcow2_inactivete.
> I chose the question form because I'm really not deep enough into the
> bitmap code to have a solid opinion, but I have a feeling that releasing
> the bitmaps from the block driver that provided them would be cleaner
> indeed. I suppose the same is true for .bdrv_close.
>
>> But it will not fix the issue, because qcow2_close will
>> call qcow2_inactivate only if (!(s->flags & BDRV_O_INACTIVE)), but it is
>> not the case.
> Yes, good point.
>
> Is there a reason why bitmaps are already loaded in qcow2_do_open() even
> if the image is inactive? Can bitmaps be meaningfully used on inactive
> images?
>
> Otherwise, we could just make qcow2_load_autoloading_dirty_bitmaps()
> conditional on cleared BDRV_O_INACTIVE.
>
>> or we can do like this, it fixes the new test:
>>  =C2=A0 static void qcow2_close(BlockDriverState *bs)
>> {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>> qemu_vfree(s->l1_table);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* else pre-write overlap checks in cach=
e_destroy may crash */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->l1_table =3D NULL;
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(s->flags & BDRV_O_INACTIVE)) {
>> qcow2_inactivate(bs);
>> }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_persistent_dirty_bitmaps(bs);
>>
>> What do you think?
> Hm, I think I don't like this much.
>
> We just need to decide what the status of inactive images is supposed to
> be. If they should have bitmaps, then your patch is probably right. But
> if inactive images shouldn't have any, we need to change qcow2_do_open()
> and qcow2_inactivate().
>
> Kevin

Does Qemu start in inactive mode when and only when it is incoming=20
migration? In this case I don't
see any reason of early-load the bitmaps. Backup in inactive mode should=20
not be allowed too, yes?

So, it looks like it's ok to just do not autoload bitmaps if we are in=20
inactive mode. The difference
would be that user will not see these bitmaps during migration. And he=20
even may create bitmaps
with same names, which will lead to fault. But it don't look like real=20
problem.

So, if there will not be other thoughts, I'll make another patch.

--=20
Best regards,
Vladimir
