Received: from eggs.gnu.org ([209.51.188.92]:45146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQdc-00077H-Ue
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQdb-0003J7-Tu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:09:28 -0400
Date: Tue, 30 Apr 2019 13:09:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430110918.GF5607@linux.fritz.box>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>

Am 30.04.2019 um 12:03 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 30.04.2019 12:24, Stefano Garzarella wrote:
> > On Tue, Apr 23, 2019 at 03:57:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >> This fixes at least one overflow in qcow2_process_discards, which
> >> passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
> >> the past) parameter is int since its introduction in 0b919fae.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   include/block/block.h |  4 ++--
> >>   block/io.c            | 16 ++++++++--------
> >>   2 files changed, 10 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/block/block.h b/include/block/block.h
> >> index c7a26199aa..69fa18867e 100644
> >> --- a/include/block/block.h
> >> +++ b/include/block/block.h
> >> @@ -432,8 +432,8 @@ void bdrv_drain_all(void);
> >>       AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
> >>                      cond); })
> >>   
> >> -int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> >> -int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> >> +int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
> >> +int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
> >>   int bdrv_has_zero_init_1(BlockDriverState *bs);
> >>   int bdrv_has_zero_init(BlockDriverState *bs);
> >>   bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
> >> diff --git a/block/io.c b/block/io.c
> >> index dfc153b8d8..16b6c5d855 100644
> >> --- a/block/io.c
> >> +++ b/block/io.c
> >> @@ -2653,7 +2653,7 @@ int bdrv_flush(BlockDriverState *bs)
> >>   typedef struct DiscardCo {
> >>       BdrvChild *child;
> >>       int64_t offset;
> >> -    int bytes;
> >> +    int64_t bytes;
> >>       int ret;
> >>   } DiscardCo;
> >>   static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
> >> @@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
> >>       aio_wait_kick();
> >>   }
> >>   
> >> -int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> >> +int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
> >> +                                  int64_t bytes)
> >>   {
> >>       BdrvTrackedRequest req;
> >>       int max_pdiscard, ret;
> >>       int head, tail, align;
> >>       BlockDriverState *bs = child->bs;
> >>   
> >> -    if (!bs || !bs->drv) {
> >> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
> > 
> > Should we describe this change in the commit message?
> 
> Honestly, don't want to resend the series for this.

I haven't reviewed the patches yet, but if this remains the only thing
to change, it can be updated while applying the series if we have a
specific proposal for a new commit message.

Kevin
