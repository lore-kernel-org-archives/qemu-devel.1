Received: from eggs.gnu.org ([2001:4830:134:3::10]:37321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1hVM-0006cY-Go
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 19:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1hVL-0006Bv-Fp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 19:30:36 -0400
Date: Mon, 9 Oct 2017 19:30:26 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171009233026.GC5170@localhost.localdomain>
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009215533.12530-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] qcow2: Always execute
 preallocate() in a coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Oct 09, 2017 at 11:55:32PM +0200, Max Reitz wrote:
> Some qcow2 functions (at least perform_cow()) expect s->lock to be
> taken.  Therefore, if we want to make use of them, we should execute
> preallocate() (as "preallocate_co") in a coroutine so that we can use
> the qemu_co_mutex_* functions.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/qcow2.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c3b312cdef..cc75a5167f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2460,6 +2460,14 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
>  }
>  
>  
> +typedef struct PreallocCo {
> +    BlockDriverState *bs;
> +    uint64_t offset;
> +    uint64_t new_length;
> +
> +    int ret;
> +} PreallocCo;
> +
>  /**
>   * Preallocates metadata structures for data clusters between @offset (in the
>   * guest disk) and @new_length (which is thus generally the new guest disk
> @@ -2467,9 +2475,12 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
>   *
>   * Returns: 0 on success, -errno on failure.
>   */
> -static int preallocate(BlockDriverState *bs,
> -                       uint64_t offset, uint64_t new_length)
> +static void coroutine_fn preallocate_co(void *opaque)
>  {
> +    struct PreallocCo *params = opaque;
> +    BlockDriverState *bs = params->bs;
> +    uint64_t offset = params->offset;
> +    uint64_t new_length = params->new_length;
>      BDRVQcow2State *s = bs->opaque;
>      uint64_t bytes;
>      uint64_t host_offset = 0;
> @@ -2477,9 +2488,7 @@ static int preallocate(BlockDriverState *bs,
>      int ret;
>      QCowL2Meta *meta;
>  
> -    if (qemu_in_coroutine()) {
> -        qemu_co_mutex_lock(&s->lock);
> -    }
> +    qemu_co_mutex_lock(&s->lock);
>  
>      assert(offset <= new_length);
>      bytes = new_length - offset;
> @@ -2533,10 +2542,28 @@ static int preallocate(BlockDriverState *bs,
>      ret = 0;
>  
>  done:
> +    qemu_co_mutex_unlock(&s->lock);
> +    params->ret = ret;
> +}
> +
> +static int preallocate(BlockDriverState *bs,
> +                       uint64_t offset, uint64_t new_length)
> +{
> +    PreallocCo params = {
> +        .bs         = bs,
> +        .offset     = offset,
> +        .new_length = new_length,
> +        .ret        = -EINPROGRESS,
> +    };
> +
>      if (qemu_in_coroutine()) {
> -        qemu_co_mutex_unlock(&s->lock);
> +        preallocate_co(&params);
> +    } else {
> +        Coroutine *co = qemu_coroutine_create(preallocate_co, &params);
> +        bdrv_coroutine_enter(bs, co);
> +        BDRV_POLL_WHILE(bs, params.ret == -EINPROGRESS);
>      }
> -    return ret;
> +    return params.ret;
>  }
>  
>  /* qcow2_refcount_metadata_size:
> -- 
> 2.13.6
> 
> 
