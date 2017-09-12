Received: from eggs.gnu.org ([2001:4830:134:3::10]:52175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drhm7-0006Dd-GU
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drhm6-0007F2-Js
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:46:35 -0400
Date: Tue, 12 Sep 2017 11:46:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170912094622.GC29136@localhost.localdomain>
References: <ce76e902-f048-1110-15cf-0dc7251322b2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ce76e902-f048-1110-15cf-0dc7251322b2@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] loading bitmaps in invalidate_cache fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 11.09.2017 um 18:51 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi Kevin!
>=20
> I'm confused with relations of permissions and invalidation, can you pl=
ease
> help?
>=20
> Now dirty bitmaps are loaded in invalidate_cache. Here is a problem wit=
h
> migration:
>=20
> 1. destination starts (inactive)
>=20
> 2. load bitmaps readonly
>=20
> ...
>=20
> 3. invalidate_cache: here we should make our loaded bitmaps RW, ie set
> BdrvDirtyBitmap->readonly
>=20
> =A0 to false and set IN_USE bit in the image. But the latter goes into
> "bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed"=
,
>=20
> =A0 because in bdrv_invalidate_cache we call bdrv_set_perm after
> drv->bdrv_invalidate_cache.
>=20
>=20
> What is the true way of fixing this?

It's all still a bit of a mess. :-(

I think it makes a lot of sense that we should activate the lower layers
first, so the order in bdrv_invalidate_cache() looks wrong. It should be
something like this:

1. invalidate_cache() for the children
2. Update permissions for non-BDRV_O_INACTIVE
3. Call drv->bdrv_invalidate_cache()

I'm currently working on some fixes related to bdrv_reopen() where
things become tricky because the updated permissions shouldn't depend on
the current state, but on the state after the operation has finished.

You get something similar here, but I think just making sure that we
clear BDRV_O_INACTIVE before updating the permissions is enough here.
The only thing to be careful is that in error cases, we need to revert
both the flag and the permissions then.

Kevin
