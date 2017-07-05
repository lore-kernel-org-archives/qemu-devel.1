Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSlBZ-0004LM-At
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSlBW-0000in-4n
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:21:45 -0400
Date: Wed, 5 Jul 2017 10:21:37 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2079725542.47180593.1499264497487.JavaMail.zimbra@redhat.com>
In-Reply-To: <4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-9-marcandre.lureau@redhat.com>
	<4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/35] block: all bdrv_aio callbacks are
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



----- Original Message -----
> On 05/07/2017 00:03, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/block/block_int.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 15fa602150..93eb2a9528 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -133,15 +133,15 @@ struct BlockDriver {
> >      void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options=
);
> > =20
> >      /* aio */
> > -    BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
> > +    BlockAIOCB * coroutine_fn (*bdrv_aio_readv)(BlockDriverState *bs,
> >          int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
> >          BlockCompletionFunc *cb, void *opaque);
> > -    BlockAIOCB *(*bdrv_aio_writev)(BlockDriverState *bs,
> > +    BlockAIOCB * coroutine_fn (*bdrv_aio_writev)(BlockDriverState *bs,
> >          int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
> >          BlockCompletionFunc *cb, void *opaque);
> > -    BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
> > +    BlockAIOCB * coroutine_fn (*bdrv_aio_flush)(BlockDriverState *bs,
> >          BlockCompletionFunc *cb, void *opaque);
> > -    BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
> > +    BlockAIOCB * coroutine_fn (*bdrv_aio_pdiscard)(BlockDriverState *b=
s,
> >          int64_t offset, int bytes,
> >          BlockCompletionFunc *cb, void *opaque);
> > =20
> > @@ -247,7 +247,7 @@ struct BlockDriver {
> >      void (*bdrv_lock_medium)(BlockDriverState *bs, bool locked);
> > =20
> >      /* to control generic scsi devices */
> > -    BlockAIOCB *(*bdrv_aio_ioctl)(BlockDriverState *bs,
> > +    BlockAIOCB * coroutine_fn (*bdrv_aio_ioctl)(BlockDriverState *bs,
> >          unsigned long int req, void *buf,
> >          BlockCompletionFunc *cb, void *opaque);
> >      int coroutine_fn (*bdrv_co_ioctl)(BlockDriverState *bs,
> >=20
>=20
>=20
> They are, but it's an implementation detail.  Why is this patch necessary=
?

I didn't think this would be controversial :) well, the checks I added to c=
lang verify function pointer share the coroutine attribute.

The function themself are/need to be coroutine_fn (as they will call corout=
ine_fn too)
