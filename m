Received: from eggs.gnu.org ([2001:4830:134:3::10]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcikE-0006Pd-R8
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcikD-0003OH-GK
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:51:14 -0400
Date: Tue, 10 Jul 2018 10:51:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710025101.GH17581@lemon.usersys.redhat.com>
References: <20180709163719.87107-1-vsementsov@virtuozzo.com>
	<20180709163719.87107-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709163719.87107-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] block: add BDRV_REQ_SERIALISING flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org

On Mon, 07/09 19:37, Vladimir Sementsov-Ogievskiy wrote:
> Serialized writes should be used in copy-on-write of backup(sync=none)
> for image fleecing scheme.
> 
> We need to change an assert in bdrv_aligned_pwritev, added in
> 28de2dcd88de. The assert may fail now, because call to
> wait_serialising_requests here may become first call to it for this
> request with serializing flag set.
> It occurs if the request is aligned
> (otherwise, we should already set serializing flag before calling
> bdrv_aligned_pwritev and correspondingly waited for all intersecting
> requests). However, for aligned requests, we should not care about
> outdating of previously read data, as there no such data. Therefore,
> let's just update an assert to not care about aligned requests.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block.h | 13 ++++++++++++-
>  block/io.c            | 26 +++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 57a96d4988..6623d15432 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -69,8 +69,19 @@ typedef enum {
>       * content. */
>      BDRV_REQ_WRITE_UNCHANGED    = 0x40,
>  
> +    /* BDRV_REQ_SERIALISING forces request serialisation for writes.
> +     * It is used to ensure that writes to the backing file of a backup process
> +     * target cannot race with a read of the backup target that defers to the
> +     * backing file.
> +     *
> +     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
> +     * BDRV_REQ_NO_SERIALISING. A more descriptive name for the latter might be
> +     * _DO_NOT_WAIT_FOR_SERIALISING, except that is too long.
> +     */
> +    BDRV_REQ_SERIALISING        = 0x80,
> +
>      /* Mask of valid flags */
> -    BDRV_REQ_MASK               = 0x7f,
> +    BDRV_REQ_MASK               = 0xff,
>  } BdrvRequestFlags;
>  
>  typedef struct BlockSizes {
> diff --git a/block/io.c b/block/io.c
> index 5d5651ad84..102cb0e1ba 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -623,6 +623,16 @@ static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
>      req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
>  }
>  
> +static bool is_request_serialising_and_aligned(BdrvTrackedRequest *req)
> +{
> +    /* if request is serialising, overlap_offset and overlap_bytes are set, so
> +     * we can check is request aligned. Otherwise don't care and return false

"if the request is aligned".

> +     */
> +
> +    return req->serialising && (req->offset == req->overlap_offset) &&
> +           (req->bytes == req->overlap_bytes);
> +}
> +
>  /**
>   * Round a region to cluster boundaries
>   */
> @@ -1291,6 +1301,9 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>          mark_request_serialising(req, bdrv_get_cluster_size(bs));
>      }
>  
> +    /* BDRV_REQ_SERIALISING is only for write operation */
> +    assert(!(flags & BDRV_REQ_SERIALISING));
> +
>      if (!(flags & BDRV_REQ_NO_SERIALISING)) {
>          wait_serialising_requests(req);
>      }
> @@ -1574,8 +1587,14 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>  
>      /* BDRV_REQ_NO_SERIALISING is only for read operation */
>      assert(!(flags & BDRV_REQ_NO_SERIALISING));
> +
> +    if (flags & BDRV_REQ_SERIALISING) {
> +        mark_request_serialising(req, bdrv_get_cluster_size(bs));
> +    }
> +
>      waited = wait_serialising_requests(req);
> -    assert(!waited || !req->serialising);
> +    assert(!waited || !req->serialising ||
> +           is_request_serialising_and_aligned(req));

Note to myself: what can happen is when we have a CoR request in flight which
was marked serialising, this aligned write overlaps with it. In this case, we
will wait (waited == true), and req->serialising == true as set by
BDRV_REQ_SERIALISING.  (Previously we must have called
wait_serialising_requests() in bdrv_co_pwritev() or bdrv_co_do_zero_pwritev()
before reaching here, if req->serialising, in which case no wait should happen.)

>      assert(req->overlap_offset <= offset);
>      assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
>      if (flags & BDRV_REQ_WRITE_UNCHANGED) {
> @@ -2929,6 +2948,8 @@ static int coroutine_fn bdrv_co_copy_range_internal(
>          tracked_request_begin(&req, src->bs, src_offset, bytes,
>                                BDRV_TRACKED_READ);
>  
> +        /* BDRV_REQ_SERIALISING is only for write operation */
> +        assert(!(read_flags & BDRV_REQ_SERIALISING));
>          if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
>              wait_serialising_requests(&req);
>          }
> @@ -2948,6 +2969,9 @@ static int coroutine_fn bdrv_co_copy_range_internal(
>  
>          /* BDRV_REQ_NO_SERIALISING is only for read operation */
>          assert(!(write_flags & BDRV_REQ_NO_SERIALISING));
> +        if (write_flags & BDRV_REQ_SERIALISING) {
> +            mark_request_serialising(&req, bdrv_get_cluster_size(dst->bs));
> +        }
>          wait_serialising_requests(&req);
>  
>          ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
> -- 
> 2.11.1
> 

Reviewed-by: Fam Zheng <famz@redhat.com>

Fam
