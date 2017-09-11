Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1drRvV-0000r1-EP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1drRvP-000345-IY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:51:13 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ce76e902-f048-1110-15cf-0dc7251322b2@virtuozzo.com>
Date: Mon, 11 Sep 2017 19:51:00 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] loading bitmaps in invalidate_cache fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>

Hi Kevin!

I'm confused with relations of permissions and invalidation, can you=20
please help?

Now dirty bitmaps are loaded in invalidate_cache. Here is a problem with=20
migration:

1. destination starts (inactive)

2. load bitmaps readonly

...

3. invalidate_cache: here we should make our loaded bitmaps RW, ie set=20
BdrvDirtyBitmap->readonly

 =C2=A0 to false and set IN_USE bit in the image. But the latter goes int=
o=20
"bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed",

 =C2=A0 because in bdrv_invalidate_cache we call bdrv_set_perm after=20
drv->bdrv_invalidate_cache.


What is the true way of fixing this?


PS: actually current code calls qcow2_load_autoloading_dirty_bitmaps in=20
(3.) instead of qcow2_reopen_bitmaps_rw, which leads to

"Bitmap already exists" error - it's a bug which I am now fixing.


--=20
Best regards,
Vladimir
