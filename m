Received: from eggs.gnu.org ([2001:4830:134:3::10]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSOGO-0006JF-2c
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSOGM-0007tu-SD
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:25:27 -0500
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
	<20171212160450.17510-3-vsementsov@virtuozzo.com>
	<20171222133911.GG3763@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <25bbf12b-e6e8-29be-c28e-1bd10a9dd473@virtuozzo.com>
Date: Fri, 22 Dec 2017 17:25:11 +0300
MIME-Version: 1.0
In-Reply-To: <20171222133911.GG3763@localhost.localdomain>
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

22.12.2017 16:39, Kevin Wolf wrote:
> Am 12.12.2017 um 17:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Consider migration with shared storage. Persistent bitmaps are stored
>> on bdrv_inactivate. Then, on destination
>> process_incoming_migration_bh() calls bdrv_invalidate_cache_all() which
>> leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
>> are already loaded on destination start. In this case we should call
>> qcow2_reopen_bitmaps_rw instead.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
> qcow2_invalidate_cache() calls qcow2_close() first, so why are there
> still any bitmaps loaded? Isn't this a bug? Do we leak bitmaps when a
> qcow2 image is closed?
>
> Kevin

Interesting point.

Now persistent dirty bitmaps are released at the end of=20
bdrv_inactivate_recurse,
which is not called here. It was a separate patch

commit 615b5dcf2decbc5f0abb512d13d7e5db2385fa23
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:=C2=A0=C2=A0 Wed Jun 28 15:05:30 2017 +0300

 =C2=A0=C2=A0=C2=A0 block: release persistent bitmaps on inactivate


May be it is more correct to release them immediately after storing, in
qcow2_inactivete. But it will not fix the issue, because qcow2_close will
call qcow2_inactivate only if (!(s->flags & BDRV_O_INACTIVE)), but it is
not the case.

or we can do like this, it fixes the new test:
 =C2=A0 static void qcow2_close(BlockDriverState *bs)
{
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
qemu_vfree(s->l1_table);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* else pre-write overlap checks in cache_d=
estroy may crash */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->l1_table =3D NULL;

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(s->flags & BDRV_O_INACTIVE)) {
qcow2_inactivate(bs);
}
+=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_persistent_dirty_bitmaps(bs);


What do you think?

--=20
Best regards,
Vladimir
