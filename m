Received: from eggs.gnu.org ([2001:4830:134:3::10]:44012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cP8iy-0007jt-5Z
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cP8iw-00015A-Vl
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:09:00 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161129113334.605-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7bd41b3e-f9e3-b508-219c-f79d47fe1b56@redhat.com>
Date: Thu, 5 Jan 2017 15:08:52 +0100
MIME-Version: 1.0
In-Reply-To: <20161129113334.605-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: get rid of
 bdrv_io_unplugged_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>



On 29/11/2016 12:33, Paolo Bonzini wrote:
> bdrv_io_plug and bdrv_io_unplug are only called (via their
> BlockBackend equivalents) after starting asynchronous I/O.
> bdrv_drain is not going to be called while they are running,
> because---even if a coroutine runs for some reason---it will
> only drain in the next iteration of the event loop through
> bdrv_co_yield_to_drain.
> 
> So this mechanism is unnecessary, get rid of it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                | 41 ++---------------------------------------
>  include/block/block.h     |  2 --
>  include/block/block_int.h |  3 +--
>  3 files changed, 3 insertions(+), 43 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 4f00562..c42b34a 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -228,9 +228,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
>          bdrv_parent_drained_begin(bs);
>      }
>  
> -    bdrv_io_unplugged_begin(bs);
>      bdrv_drain_recurse(bs);
> -    bdrv_io_unplugged_end(bs);
>  }
>  
>  void bdrv_drained_end(BlockDriverState *bs)
> @@ -302,7 +300,6 @@ void bdrv_drain_all_begin(void)
>  
>          aio_context_acquire(aio_context);
>          bdrv_parent_drained_begin(bs);
> -        bdrv_io_unplugged_begin(bs);
>          aio_disable_external(aio_context);
>          aio_context_release(aio_context);
>  
> @@ -347,7 +344,6 @@ void bdrv_drain_all_end(void)
>  
>          aio_context_acquire(aio_context);
>          aio_enable_external(aio_context);
> -        bdrv_io_unplugged_end(bs);
>          bdrv_parent_drained_end(bs);
>          aio_context_release(aio_context);
>      }
> @@ -2650,7 +2646,7 @@ void bdrv_io_plug(BlockDriverState *bs)
>          bdrv_io_plug(child->bs);
>      }
>  
> -    if (bs->io_plugged++ == 0 && bs->io_plug_disabled == 0) {
> +    if (bs->io_plugged++ == 0) {
>          BlockDriver *drv = bs->drv;
>          if (drv && drv->bdrv_io_plug) {
>              drv->bdrv_io_plug(bs);
> @@ -2663,7 +2659,7 @@ void bdrv_io_unplug(BlockDriverState *bs)
>      BdrvChild *child;
>  
>      assert(bs->io_plugged);
> -    if (--bs->io_plugged == 0 && bs->io_plug_disabled == 0) {
> +    if (--bs->io_plugged == 0) {
>          BlockDriver *drv = bs->drv;
>          if (drv && drv->bdrv_io_unplug) {
>              drv->bdrv_io_unplug(bs);
> @@ -2674,36 +2670,3 @@ void bdrv_io_unplug(BlockDriverState *bs)
>          bdrv_io_unplug(child->bs);
>      }
>  }
> -
> -void bdrv_io_unplugged_begin(BlockDriverState *bs)
> -{
> -    BdrvChild *child;
> -
> -    if (bs->io_plug_disabled++ == 0 && bs->io_plugged > 0) {
> -        BlockDriver *drv = bs->drv;
> -        if (drv && drv->bdrv_io_unplug) {
> -            drv->bdrv_io_unplug(bs);
> -        }
> -    }
> -
> -    QLIST_FOREACH(child, &bs->children, next) {
> -        bdrv_io_unplugged_begin(child->bs);
> -    }
> -}
> -
> -void bdrv_io_unplugged_end(BlockDriverState *bs)
> -{
> -    BdrvChild *child;
> -
> -    assert(bs->io_plug_disabled);
> -    QLIST_FOREACH(child, &bs->children, next) {
> -        bdrv_io_unplugged_end(child->bs);
> -    }
> -
> -    if (--bs->io_plug_disabled == 0 && bs->io_plugged > 0) {
> -        BlockDriver *drv = bs->drv;
> -        if (drv && drv->bdrv_io_plug) {
> -            drv->bdrv_io_plug(bs);
> -        }
> -    }
> -}
> diff --git a/include/block/block.h b/include/block/block.h
> index 49bb0b2..8b0dcda 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -526,8 +526,6 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
>  
>  void bdrv_io_plug(BlockDriverState *bs);
>  void bdrv_io_unplug(BlockDriverState *bs);
> -void bdrv_io_unplugged_begin(BlockDriverState *bs);
> -void bdrv_io_unplugged_end(BlockDriverState *bs);
>  
>  /**
>   * bdrv_drained_begin:
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 83a423c..15aa718 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -526,9 +526,8 @@ struct BlockDriverState {
>      uint64_t write_threshold_offset;
>      NotifierWithReturn write_threshold_notifier;
>  
> -    /* counters for nested bdrv_io_plug and bdrv_io_unplugged_begin */
> +    /* counter for nested bdrv_io_plug */
>      unsigned io_plugged;
> -    unsigned io_plug_disabled;
>  
>      int quiesce_counter;
>  };
> 

Ping?

Paolo
