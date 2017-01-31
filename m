Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhPq-0000yv-W3
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhPp-0003aI-Vc
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:00:47 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-23-vsementsov@virtuozzo.com>
	<b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
	<aaf5add3-f612-b504-5589-442ec432366f@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66c726b0-3ee4-36fa-9842-b2729733172b@redhat.com>
Date: Wed, 1 Feb 2017 00:00:33 +0100
MIME-Version: 1.0
In-Reply-To: <aaf5add3-f612-b504-5589-442ec432366f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JSOOJR4JJOgiAvBClfxv25VwnjaLfs0Nv"
Subject: Re: [Qemu-devel] [PATCH 22/24] block/dirty-bitmap: deep release
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JSOOJR4JJOgiAvBClfxv25VwnjaLfs0Nv
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <66c726b0-3ee4-36fa-9842-b2729733172b@redhat.com>
Subject: Re: [PATCH 22/24] block/dirty-bitmap: deep release dirty bitmaps
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-23-vsementsov@virtuozzo.com>
 <b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
 <aaf5add3-f612-b504-5589-442ec432366f@virtuozzo.com>
In-Reply-To: <aaf5add3-f612-b504-5589-442ec432366f@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 17:03, Vladimir Sementsov-Ogievskiy wrote:
> 29.01.2017 19:54, Max Reitz wrote:
>> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>>> Remove persistent bitmap from its storage on bdrv_release_dirty_bitma=
p.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/dirty-bitmap.c      | 21 ++++++++++++++++++---
>>>   include/block/block_int.h |  3 +++
>>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>> index 775181c9ab..0977df6309 100644
>>> --- a/block/dirty-bitmap.c
>>> +++ b/block/dirty-bitmap.c
>>> @@ -297,7 +297,8 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState
>>> *bs)
>>>     static void
>>> bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
>>>                                                     BdrvDirtyBitmap
>>> *bitmap,
>>> -                                                  bool only_named)
>>> +                                                  bool only_named,
>>> +                                                  bool deep)
>> I'd rather call it "remove_persistent" or something, which is bad
>> grammar, but it's better at getting the point across.
>>
>>>   {
>>>       BdrvDirtyBitmap *bm, *next;
>>>       QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
>>> @@ -305,6 +306,19 @@ static void
>>> bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
>>>               assert(!bm->active_iterators);
>>>               assert(!bdrv_dirty_bitmap_frozen(bm));
>>>               assert(!bm->meta);
>>> +
>>> +            if (deep && bm->persistent && bs->drv &&
>>> +                bs->drv->bdrv_remove_persistent_dirty_bitmap)
>>> +            {
>>> +                Error *local_err =3D NULL;
>>> +                bs->drv->bdrv_remove_persistent_dirty_bitmap(bs,
>>> bm->name,
>>> +                                                           =20
>>> &local_err);
>>> +                if (local_err !=3D NULL) {
>>> +                    error_report_err(local_err);
>> This looks like maybe it's the wrong thing to do... I do agree that
>> sometimes it may not be fatal, but sometimes it probably is.
>>
>>> +                }
>>> +            }
>>> +
>>> +
>>>               QLIST_REMOVE(bm, list);
>>>               hbitmap_free(bm->bitmap);
>>>               g_free(bm->name);
>>> @@ -322,16 +336,17 @@ static void
>>> bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
>>>     void bdrv_release_dirty_bitmap(BlockDriverState *bs,
>>> BdrvDirtyBitmap *bitmap)
>>>   {
>>> -    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false);
>>> +    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false, true);
>> The @deep parameter (or however you decide to call it) should be
>> available to this function's caller, too. I don't believe qcow2's
>> load_bitmap() wants to delete the persistent bitmap in the error path;=

>> and block-dirty-bitmap-remove should probably allow the user to decide=

>> what to do.
>>
>> Which brings me to the error thing above: If the user (or management
>> tool) decides that block-dirty-bitmap-remove should remove the
>> persistent bitmap, I believe that the operation should be aborted if t=
he
>> persistent bitmap cannot be removed. It should not just go on and
>> release the in-memory bitmap but abort altogether. If the user just
>> wants to release that in-memory bitmap then, they can still go on an
>> call block-dirty-bitmap-remove with deep=3Dfalse.
>=20
> I've started to rewrite it in that way and it seems like deep almost
> always will be false. What about just move call to
> bs->drv->bdrv_remove_persistent_dirty_bitmap() directly to
> qmp_block_dirty_bitmap_remove and add parameter
> 'remove_persistent' (or 'remove_from_storage', to make it maximum
> descriptive) only to this qmp command?

Or you could add an explicit bdrv_remove_persistent_dirty_bitmap() which
just wraps the bs->drv function.

> Or even without that parameter, as leaving inconsistent version of
> bitmap in the storage doesn't seem useful.

Hm, right, the bitmap will be automatically removed from the image once
it's closed, right?

Max


--JSOOJR4JJOgiAvBClfxv25VwnjaLfs0Nv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRFxESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaugIAKzy7HIIZHJfOKTPW/bRkyFbVtCJEgDG
DQHaDP8IreBs37XgaLrQhuvIDsXWwKDiW0SkPWqzJkKHH0MgA+KF1UwzH/qef3LQ
68Bg3fAW0j6+5Go3wJPPPdqrLj1veoSd7aTNqEK99nAG4syliTue0Ksbwv63Fol8
jMmYgFs9gZxgGJBhRGVXOE2Z+cdVZYnhzU/N9rqpJlLl+p4d0ZJQBn02MpP5mEle
V97zyBNmZwgN90vCQm5F38gOuP4Pgea595xsAys4ymu0EU4PbcnvfnDRNEDPF6sN
8/cqFyaY8AuT7zhpMex0ihP+FVq1gTZvoOr5dX0DD8HzhpxYEhnJmKc=
=d2xQ
-----END PGP SIGNATURE-----

--JSOOJR4JJOgiAvBClfxv25VwnjaLfs0Nv--
