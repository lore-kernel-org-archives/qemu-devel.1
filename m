Received: from eggs.gnu.org ([2001:4830:134:3::10]:54624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPAKK-0008Ls-Ng
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPAKI-0006DE-0A
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:00:44 -0500
Date: Tue, 20 Nov 2018 19:00:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181120180029.GD7513@localhost.localdomain>
References: <cover.1542031058.git.berto@igalia.com>
	<ab8395c8926892311948dcfd3f88c598dd74797b.1542031058.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab8395c8926892311948dcfd3f88c598dd74797b.1542031058.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/16] block: Use
 bdrv_reopen_set_read_only() in stream_start/complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 12.11.2018 um 15:00 hat Alberto Garcia geschrieben:
> This patch replaces the bdrv_reopen() calls that set and remove the
> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/stream.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 81a7ec8ece..262d280ccd 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -34,7 +34,7 @@ typedef struct StreamBlockJob {
>      BlockDriverState *base;
>      BlockdevOnError on_error;
>      char *backing_file_str;
> -    int bs_flags;
> +    bool bs_read_only;
>  } StreamBlockJob;
>  
>  static int coroutine_fn stream_populate(BlockBackend *blk,
> @@ -89,10 +89,10 @@ static void stream_clean(Job *job)
>      BlockDriverState *bs = blk_bs(bjob->blk);
>  
>      /* Reopen the image back in read-only mode if necessary */
> -    if (s->bs_flags != bdrv_get_flags(bs)) {
> +    if (s->bs_read_only) {
>          /* Give up write permissions before making it read-only */
>          blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
> -        bdrv_reopen(bs, s->bs_flags, NULL);
> +        bdrv_reopen_set_read_only(bs, true, NULL);
>      }
>  
>      g_free(s->backing_file_str);
> @@ -226,12 +226,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>  {
>      StreamBlockJob *s;
>      BlockDriverState *iter;
> -    int orig_bs_flags;
> +    int bs_read_only;

bool certainly?

Kevin
