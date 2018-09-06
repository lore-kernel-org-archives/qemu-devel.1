Received: from eggs.gnu.org ([2001:4830:134:3::10]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxbF-0007uJ-Tk
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxbE-0005o0-Vd
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:57:45 -0400
Date: Thu, 6 Sep 2018 12:57:20 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180906165720.GD22117@localhost.localdomain>
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-7-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906130225.5118-7-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 06/16] block/mirror: conservative
 mirror_exit refactor
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

On Thu, Sep 06, 2018 at 09:02:15AM -0400, John Snow wrote:
> For purposes of minimum code movement, refactor the mirror_exit
> callback to use the post-finalization callbacks in a trivial way.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index bd3e908710..a92b4702c5 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -79,6 +79,7 @@ typedef struct MirrorBlockJob {
>      int max_iov;
>      bool initial_zeroing_ongoing;
>      int in_active_write_counter;
> +    bool prepared;
>  } MirrorBlockJob;
>  
>  typedef struct MirrorBDSOpaque {
> @@ -607,7 +608,7 @@ static void mirror_wait_for_all_io(MirrorBlockJob *s)
>      }
>  }
>  
> -static void mirror_exit(Job *job)
> +static int mirror_exit_common(Job *job)
>  {
>      MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
>      BlockJob *bjob = &s->common;
> @@ -617,7 +618,13 @@ static void mirror_exit(Job *job)
>      BlockDriverState *target_bs = blk_bs(s->target);
>      BlockDriverState *mirror_top_bs = s->mirror_top_bs;
>      Error *local_err = NULL;
> -    int ret = job->ret;
> +    bool abort = job->ret < 0;
> +    int ret = 0;
> +
> +    if (s->prepared) {
> +        return 0;
> +    }
> +    s->prepared = true;
>  
>      bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
>  
> @@ -642,7 +649,7 @@ static void mirror_exit(Job *job)
>       * required before it could become a backing file of target_bs. */
>      bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
>                              &error_abort);
> -    if (ret == 0 && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
> +    if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>          BlockDriverState *backing = s->is_none_mode ? src : s->base;
>          if (backing_bs(target_bs) != backing) {
>              bdrv_set_backing_hd(target_bs, backing, &local_err);
> @@ -658,11 +665,8 @@ static void mirror_exit(Job *job)
>          aio_context_acquire(replace_aio_context);
>      }
>  
> -    if (s->should_complete && ret == 0) {
> -        BlockDriverState *to_replace = src;
> -        if (s->to_replace) {
> -            to_replace = s->to_replace;
> -        }
> +    if (s->should_complete && !abort) {
> +        BlockDriverState *to_replace = s->to_replace ?: src;
>  
>          if (bdrv_get_flags(target_bs) != bdrv_get_flags(to_replace)) {
>              bdrv_reopen(target_bs, bdrv_get_flags(to_replace), NULL);
> @@ -711,7 +715,18 @@ static void mirror_exit(Job *job)
>      bdrv_unref(mirror_top_bs);
>      bdrv_unref(src);
>  
> -    job->ret = ret;
> +    return ret;
> +}
> +
> +static int mirror_prepare(Job *job)
> +{
> +    return mirror_exit_common(job);
> +}
> +
> +static void mirror_abort(Job *job)
> +{
> +    int ret = mirror_exit_common(job);
> +    assert(ret == 0);

Not something to hold the series up, but in case a v6 is called for due to
other changes: I think it may be worth a comment in mirror_exit_common()
that if abort is true, and we don't return success, QEMU will hit an assert.
Mainly to prevent someone from including a call with a potential error
return in the abort path in the future.

Reviewed-by: Jeff Cody <jcody@redhat.com>


>  }
>  
>  static void mirror_throttle(MirrorBlockJob *s)
> @@ -1132,7 +1147,8 @@ static const BlockJobDriver mirror_job_driver = {
>          .user_resume            = block_job_user_resume,
>          .drain                  = block_job_drain,
>          .run                    = mirror_run,
> -        .exit                   = mirror_exit,
> +        .prepare                = mirror_prepare,
> +        .abort                  = mirror_abort,
>          .pause                  = mirror_pause,
>          .complete               = mirror_complete,
>      },
> @@ -1149,7 +1165,8 @@ static const BlockJobDriver commit_active_job_driver = {
>          .user_resume            = block_job_user_resume,
>          .drain                  = block_job_drain,
>          .run                    = mirror_run,
> -        .exit                   = mirror_exit,
> +        .prepare                = mirror_prepare,
> +        .abort                  = mirror_abort,
>          .pause                  = mirror_pause,
>          .complete               = mirror_complete,
>      },
> -- 
> 2.14.4
> 
