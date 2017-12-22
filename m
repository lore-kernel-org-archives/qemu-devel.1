Received: from eggs.gnu.org ([2001:4830:134:3::10]:41926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSPUX-0002Q4-Sy
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSPUM-0007dx-Ly
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:44:09 -0500
Date: Fri, 22 Dec 2017 16:43:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222154318.GK3763@localhost.localdomain>
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
	<20171212160450.17510-3-vsementsov@virtuozzo.com>
	<20171222133911.GG3763@localhost.localdomain>
	<25bbf12b-e6e8-29be-c28e-1bd10a9dd473@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <25bbf12b-e6e8-29be-c28e-1bd10a9dd473@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, den@openvz.org, jsnow@redhat.com

Am 22.12.2017 um 15:25 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 22.12.2017 16:39, Kevin Wolf wrote:
> > Am 12.12.2017 um 17:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Consider migration with shared storage. Persistent bitmaps are stor=
ed
> > > on bdrv_inactivate. Then, on destination
> > > process_incoming_migration_bh() calls bdrv_invalidate_cache_all() w=
hich
> > > leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitm=
aps
> > > are already loaded on destination start. In this case we should cal=
l
> > > qcow2_reopen_bitmaps_rw instead.
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
> > > Reviewed-by: John Snow <jsnow@redhat.com>
> > qcow2_invalidate_cache() calls qcow2_close() first, so why are there
> > still any bitmaps loaded? Isn't this a bug? Do we leak bitmaps when a
> > qcow2 image is closed?
> >=20
> > Kevin
>=20
> Interesting point.
>=20
> Now persistent dirty bitmaps are released at the end of
> bdrv_inactivate_recurse,
> which is not called here. It was a separate patch
>=20
> commit 615b5dcf2decbc5f0abb512d13d7e5db2385fa23
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:=A0=A0 Wed Jun 28 15:05:30 2017 +0300
>=20
> =A0=A0=A0 block: release persistent bitmaps on inactivate
>=20
> May be it is more correct to release them immediately after storing, in
> qcow2_inactivete.

I chose the question form because I'm really not deep enough into the
bitmap code to have a solid opinion, but I have a feeling that releasing
the bitmaps from the block driver that provided them would be cleaner
indeed. I suppose the same is true for .bdrv_close.

> But it will not fix the issue, because qcow2_close will
> call qcow2_inactivate only if (!(s->flags & BDRV_O_INACTIVE)), but it i=
s
> not the case.

Yes, good point.

Is there a reason why bitmaps are already loaded in qcow2_do_open() even
if the image is inactive? Can bitmaps be meaningfully used on inactive
images?

Otherwise, we could just make qcow2_load_autoloading_dirty_bitmaps()
conditional on cleared BDRV_O_INACTIVE.

> or we can do like this, it fixes the new test:
> =A0 static void qcow2_close(BlockDriverState *bs)
> {
> =A0=A0=A0=A0=A0 BDRVQcow2State *s =3D bs->opaque;
> qemu_vfree(s->l1_table);
> =A0=A0=A0=A0=A0 /* else pre-write overlap checks in cache_destroy may c=
rash */
> =A0=A0=A0=A0=A0 s->l1_table =3D NULL;
>=20
> =A0=A0=A0=A0=A0 if (!(s->flags & BDRV_O_INACTIVE)) {
> qcow2_inactivate(bs);
> }
> +=A0=A0=A0=A0 bdrv_release_persistent_dirty_bitmaps(bs);
>=20
> What do you think?

Hm, I think I don't like this much.

We just need to decide what the status of inactive images is supposed to
be. If they should have bitmaps, then your patch is probably right. But
if inactive images shouldn't have any, we need to change qcow2_do_open()
and qcow2_inactivate().

Kevin
