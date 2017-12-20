Received: from eggs.gnu.org ([2001:4830:134:3::10]:41801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eReUe-0007gb-2a
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eReUa-0004Zo-If
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:33:08 -0500
Date: Wed, 20 Dec 2017 21:32:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171220133254.GF10812@lemon>
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-19-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220103412.13048-19-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/19] commit: Simplify reopen of base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, 12/20 11:34, Kevin Wolf wrote:
> Since commit bde70715, base is the only node that is reopened in
> commit_start(). This means that the code, which still involves an
> explicit BlockReopenQueue, can now be simplified by using bdrv_reopen().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index c5327551ce..bb6c904704 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -277,7 +277,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>                    const char *filter_node_name, Error **errp)
>  {
>      CommitBlockJob *s;
> -    BlockReopenQueue *reopen_queue = NULL;
>      int orig_base_flags;
>      BlockDriverState *iter;
>      BlockDriverState *commit_top_bs = NULL;
> @@ -299,12 +298,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>      /* convert base to r/w, if necessary */
>      orig_base_flags = bdrv_get_flags(base);
>      if (!(orig_base_flags & BDRV_O_RDWR)) {
> -        reopen_queue = bdrv_reopen_queue(reopen_queue, base, NULL,
> -                                         orig_base_flags | BDRV_O_RDWR);
> -    }
> -
> -    if (reopen_queue) {
> -        bdrv_reopen_multiple(bdrv_get_aio_context(bs), reopen_queue, &local_err);
> +        bdrv_reopen(base, orig_base_flags | BDRV_O_RDWR, &local_err);
>          if (local_err != NULL) {
>              error_propagate(errp, local_err);
>              goto fail;
> -- 
> 2.13.6
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
