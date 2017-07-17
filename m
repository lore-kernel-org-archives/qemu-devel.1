Received: from eggs.gnu.org ([2001:4830:134:3::10]:57429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dX8OH-00031W-Rn
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dX8OG-0007eC-Vq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:57 -0400
References: <20170711170821.24669-1-ppandit@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
Date: Mon, 17 Jul 2017 11:56:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170711170821.24669-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: check BlockDriverState
 object before dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Kieron Shorrock <kshorrock@paloaltonetworks.com>, qemu-block@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>



On 07/11/2017 01:08 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When processing ATA_CACHE_FLUSH ide controller command,
> BlockDriverState object could be null. Add check to avoid
> null pointer dereference.
> 

This happens through 0xE7, what QEMU calls WIN_CACHE_FLUSH and described
in ATA8 ACS3 as "FLUSH CACHE"

The core of the matter here is that any ATA device associated with a
BlockBackend that has no media inserted will accept the command and call
blk_aio_flush, which will later fail because blk_aio_prwv assumes that
the BlockBackend it was given definitely has a BlockDriverState attached.

The associated bdrv_inc_in_flight causes the null pointer dereference.

It's not immediately clear to me what the right fix is here:

(1) Should blk_ functions not assume they will have a BlockDriverState?
(i.e. should an attempted blk_flush on an empty blk just succeed
quietly, or is that inherently an error?)

(2) Should ATA reject such commands entirely?

(3) Both?

ATA says that CDROM drives /may/ accept flush cache, but it doesn't
really say what it has to do about if there's no media. This is for
flushing write cache, after all, and our media are RO for CDROMs.

We could possibly make flush cache a NOP for CDROMs entirely, or I can
remove our support for the command, as it is "optional" and I can't find
any information on what, if anything, it should actually do.

Grumble Grumble, ATA specs.

> Reported-by: Kieron Shorrock <kshorrock@paloaltonetworks.com>

Thank you for your report.

> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  block/block-backend.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 0df3457..6a543a4 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1168,8 +1168,13 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
>  {
>      BlkAioEmAIOCB *acb;
>      Coroutine *co;
> +    BlockDriverState *bs = blk_bs(blk);
>  
> -    bdrv_inc_in_flight(blk_bs(blk));
> +    if (!bs) {
> +        return NULL;
> +    }
> +

This hotfix as posted is inappropriate I think, because this path has
never been able to return NULL previously and many callers don't check
to see if their command was registered successfully, and rely on the
callback to be executed.

> +    bdrv_inc_in_flight(bs);
>      acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
>      acb->rwco = (BlkRwCo) {
>          .blk    = blk,
> @@ -1182,7 +1187,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
>      acb->has_returned = false;
>  
>      co = qemu_coroutine_create(co_entry, acb);
> -    bdrv_coroutine_enter(blk_bs(blk), co);
> +    bdrv_coroutine_enter(bs, co);
>  
>      acb->has_returned = true;
>      if (acb->rwco.ret != NOT_DONE) {
> 
