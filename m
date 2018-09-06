Received: from eggs.gnu.org ([2001:4830:134:3::10]:56253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxbn-0008AI-PJ
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxbm-0006ws-Lb
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:58:19 -0400
Date: Thu, 6 Sep 2018 12:58:11 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180906165811.GE22117@localhost.localdomain>
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-8-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906130225.5118-8-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/16] block/stream: refactor stream to
 use job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Sep 06, 2018 at 09:02:16AM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/stream.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 700eb239e4..81a7ec8ece 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -54,16 +54,16 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
>      return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
>  }
>  
> -static void stream_exit(Job *job)
> +static int stream_prepare(Job *job)
>  {
>      StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>      BlockJob *bjob = &s->common;
>      BlockDriverState *bs = blk_bs(bjob->blk);
>      BlockDriverState *base = s->base;
>      Error *local_err = NULL;
> -    int ret = job->ret;
> +    int ret = 0;
>  
> -    if (!job_is_cancelled(job) && bs->backing && ret == 0) {
> +    if (bs->backing) {
>          const char *base_id = NULL, *base_fmt = NULL;
>          if (base) {
>              base_id = s->backing_file_str;
> @@ -75,12 +75,19 @@ static void stream_exit(Job *job)
>          bdrv_set_backing_hd(bs, base, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
> -            ret = -EPERM;
> -            goto out;
> +            return -EPERM;
>          }
>      }
>  
> -out:
> +    return ret;
> +}
> +
> +static void stream_clean(Job *job)
> +{
> +    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
> +    BlockJob *bjob = &s->common;
> +    BlockDriverState *bs = blk_bs(bjob->blk);
> +
>      /* Reopen the image back in read-only mode if necessary */
>      if (s->bs_flags != bdrv_get_flags(bs)) {
>          /* Give up write permissions before making it read-only */
> @@ -89,7 +96,6 @@ out:
>      }
>  
>      g_free(s->backing_file_str);
> -    job->ret = ret;
>  }
>  
>  static int coroutine_fn stream_run(Job *job, Error **errp)
> @@ -206,7 +212,8 @@ static const BlockJobDriver stream_job_driver = {
>          .job_type      = JOB_TYPE_STREAM,
>          .free          = block_job_free,
>          .run           = stream_run,
> -        .exit          = stream_exit,
> +        .prepare       = stream_prepare,
> +        .clean         = stream_clean,
>          .user_resume   = block_job_user_resume,
>          .drain         = block_job_drain,
>      },
> -- 
> 2.14.4
> 
