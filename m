Received: from eggs.gnu.org ([2001:4830:134:3::10]:38673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUjWi-0008UG-5x
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 20:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUjWg-0000V2-VP
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 20:31:59 -0500
Date: Fri, 29 Dec 2017 09:31:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229013140.GA13004@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
	<20171228052418.GC9192@lemon>
	<f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 03/13] block/dirty-bitmap: add _locked
 version of bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com

On Thu, 12/28 14:16, Vladimir Sementsov-Ogievskiy wrote:
> 28.12.2017 08:24, Fam Zheng wrote:
> > On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
> > > ---
> > >   include/block/dirty-bitmap.h |  3 +++
> > >   block/dirty-bitmap.c         | 25 ++++++++++++++++---------
> > >   2 files changed, 19 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bit=
map.h
> > > index 93d4336505..caf1f3d861 100644
> > > --- a/include/block/dirty-bitmap.h
> > > +++ b/include/block/dirty-bitmap.h
> > > @@ -92,5 +92,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDri=
verState *bs);
> > >   BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
> > >                                           BdrvDirtyBitmap *bitmap);
> > >   char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Err=
or **errp);
> > > +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState=
 *bs,
> > > +                                                  BdrvDirtyBitmap =
*bitmap,
> > > +                                                  Error **errp);
> > >   #endif
> > > diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> > > index d83da077d5..fe27ddfb83 100644
> > > --- a/block/dirty-bitmap.c
> > > +++ b/block/dirty-bitmap.c
> > > @@ -327,15 +327,11 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(B=
lockDriverState *bs,
> > >    * The merged parent will be un-frozen, but not explicitly re-ena=
bled.
> > >    * Called with BQL taken.
> > Maybe update the comment as
> >=20
> > s/Called with BQL taken/Called within bdrv_dirty_bitmap_lock..unlock/
> >=20
> > and ...
>=20
> we have the following comment:
>=20
> =A0=A0=A0 /* Writing to the list requires the BQL _and_ the dirty_bitma=
p_mutex.
> =A0=A0=A0=A0 * Reading from the list can be done with either the BQL or=
 the
> =A0=A0=A0=A0 * dirty_bitmap_mutex.=A0 Modifying a bitmap only requires
> =A0=A0=A0=A0 * dirty_bitmap_mutex. */
> =A0=A0=A0 QemuMutex dirty_bitmap_mutex;
>=20
> (I don't understand well the logic, why is it so. Paolo introduced the =
lock,
> but didn't update some functions..)
>=20
> so, actually, here we need both BQL and mutex.

Yes, because of that comment my interpretion has been both "BQL and the m=
utex"
whereever we say "within bdrv_dirty_bitmap_lock..unlock", as to some othe=
r
places in this file.

Fam
