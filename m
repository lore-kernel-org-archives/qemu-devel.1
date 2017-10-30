Received: from eggs.gnu.org ([2001:4830:134:3::10]:44715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9BTe-0002jK-1D
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9BTc-0004tL-Ti
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:55:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <ce76e902-f048-1110-15cf-0dc7251322b2@virtuozzo.com>
	<20170912094622.GC29136@localhost.localdomain>
	<4eebe41a-ddb3-a078-04eb-409fd305dd7c@virtuozzo.com>
Message-ID: <bb0b814c-c48d-4b15-8f02-a62731ade72e@virtuozzo.com>
Date: Mon, 30 Oct 2017 17:55:29 +0300
MIME-Version: 1.0
In-Reply-To: <4eebe41a-ddb3-a078-04eb-409fd305dd7c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] ping Re: loading bitmaps in invalidate_cache fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Hi!

Any ideas?

05.10.2017 12:41, Vladimir Sementsov-Ogievskiy wrote:
> 12.09.2017 12:46, Kevin Wolf wrote:
>> Am 11.09.2017 um 18:51 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> Hi Kevin!
>>>
>>> I'm confused with relations of permissions and invalidation, can you=20
>>> please
>>> help?
>>>
>>> Now dirty bitmaps are loaded in invalidate_cache. Here is a problem=20
>>> with
>>> migration:
>>>
>>> 1. destination starts (inactive)
>>>
>>> 2. load bitmaps readonly
>>>
>>> ...
>>>
>>> 3. invalidate_cache: here we should make our loaded bitmaps RW, ie set
>>> BdrvDirtyBitmap->readonly
>>>
>>> =C2=A0=C2=A0 to false and set IN_USE bit in the image. But the latter g=
oes into
>>> "bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE'=20
>>> failed",
>>>
>>> =C2=A0=C2=A0 because in bdrv_invalidate_cache we call bdrv_set_perm aft=
er
>>> drv->bdrv_invalidate_cache.
>>>
>>>
>>> What is the true way of fixing this?
>> It's all still a bit of a mess. :-(
>>
>> I think it makes a lot of sense that we should activate the lower layers
>> first, so the order in bdrv_invalidate_cache() looks wrong. It should be
>> something like this:
>>
>> 1. invalidate_cache() for the children
>> 2. Update permissions for non-BDRV_O_INACTIVE
>> 3. Call drv->bdrv_invalidate_cache()
>>
>> I'm currently working on some fixes related to bdrv_reopen() where
>> things become tricky because the updated permissions shouldn't depend on
>> the current state, but on the state after the operation has finished.
>>
>> You get something similar here, but I think just making sure that we
>> clear BDRV_O_INACTIVE before updating the permissions is enough here.
>> The only thing to be careful is that in error cases, we need to revert
>> both the flag and the permissions then.
>>
>> Kevin
>
> I have experimented a bit. Permission for qcow2 bs is actually set in=20
> "parent->role->activate(parent, &local_err);",
>
> so a patch like this fixes the bug (of course, some roll back of=20
> set_perm and activate should be added to error path)
>
> @@ -4126,21 +4129,6 @@ void bdrv_invalidate_cache(BlockDriverState=20
> *bs, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0 bs->open_flags &=3D ~BDRV_O_INACTIVE;
> -=C2=A0=C2=A0=C2=A0 if (bs->drv->bdrv_invalidate_cache) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->drv->bdrv_invalidate_cach=
e(bs, &local_err);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->o=
pen_flags |=3D BDRV_O_INACTIVE;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error=
_propagate(errp, local_err);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 ret =3D refresh_total_sectors(bs, bs->total_sectors);
> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->open_flags |=3D BDRV_O_IN=
ACTIVE;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -ret, =
"Could not refresh total sector=20
> count");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Update permissions, they may differ for inact=
ive nodes */
> =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_get_cumulative_perm(bs, &perm, &shared_perm=
);
> @@ -4161,6 +4149,22 @@ void bdrv_invalidate_cache(BlockDriverState=20
> *bs, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 if (bs->drv->bdrv_invalidate_cache) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->drv->bdrv_invalidate_cach=
e(bs, &local_err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->o=
pen_flags |=3D BDRV_O_INACTIVE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error=
_propagate(errp, local_err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D refresh_total_sectors(bs, bs->total_sectors);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->open_flags |=3D BDRV_O_IN=
ACTIVE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -ret, =
"Could not refresh total sector=20
> count");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
>
>
> however, I doubt that it is safe to call ->activate before=20
> invalidate_cache... I have no more ideas, just a patch that shows a=20
> regression :(
>


--=20
Best regards,
Vladimir
