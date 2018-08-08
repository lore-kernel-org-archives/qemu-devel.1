Received: from eggs.gnu.org ([2001:4830:134:3::10]:35826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fnFRx-0004lW-FW
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fnFRw-000054-Ht
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:47:53 -0400
Date: Tue, 7 Aug 2018 23:47:36 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180808034736.GC755222@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-6-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807043349.27196-6-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/21] block/mirror: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Aug 07, 2018 at 12:33:33AM -0400, John Snow wrote:
> Change the manual deferment to mirror_exit into the implicit
> callback to job_exit and the mirror_exit callback.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/mirror.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 7c2c6ba67e..e3404e2518 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -607,21 +607,17 @@ static void mirror_wait_for_all_io(MirrorBlockJob *s)
>      }
>  }
>  
> -typedef struct {
> -    int ret;
> -} MirrorExitData;
> -
> -static void mirror_exit(Job *job, void *opaque)
> +static void mirror_exit(Job *job)
>  {
>      MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
>      BlockJob *bjob = &s->common;
> -    MirrorExitData *data = opaque;
>      MirrorBDSOpaque *bs_opaque = s->mirror_top_bs->opaque;
>      AioContext *replace_aio_context = NULL;
>      BlockDriverState *src = s->mirror_top_bs->backing->bs;
>      BlockDriverState *target_bs = blk_bs(s->target);
>      BlockDriverState *mirror_top_bs = s->mirror_top_bs;
>      Error *local_err = NULL;
> +    int ret = job->ret;
>  
>      bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
>  
> @@ -652,7 +648,7 @@ static void mirror_exit(Job *job, void *opaque)
>              bdrv_set_backing_hd(target_bs, backing, &local_err);
>              if (local_err) {
>                  error_report_err(local_err);
> -                data->ret = -EPERM;
> +                ret = -EPERM;
>              }
>          }
>      }
> @@ -662,7 +658,7 @@ static void mirror_exit(Job *job, void *opaque)
>          aio_context_acquire(replace_aio_context);
>      }
>  
> -    if (s->should_complete && data->ret == 0) {
> +    if (s->should_complete && ret == 0) {
>          BlockDriverState *to_replace = src;
>          if (s->to_replace) {
>              to_replace = s->to_replace;
> @@ -679,7 +675,7 @@ static void mirror_exit(Job *job, void *opaque)
>          bdrv_drained_end(target_bs);
>          if (local_err) {
>              error_report_err(local_err);
> -            data->ret = -EPERM;
> +            ret = -EPERM;
>          }
>      }
>      if (s->to_replace) {
> @@ -710,12 +706,12 @@ static void mirror_exit(Job *job, void *opaque)
>      blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
>  
>      bs_opaque->job = NULL;
> -    job_completed(job, data->ret);
>  
> -    g_free(data);
>      bdrv_drained_end(src);
>      bdrv_unref(mirror_top_bs);
>      bdrv_unref(src);
> +
> +    job->ret = ret;
>  }
>  
>  static void mirror_throttle(MirrorBlockJob *s)
> @@ -815,7 +811,6 @@ static int mirror_flush(MirrorBlockJob *s)
>  static void coroutine_fn mirror_run(void *opaque)
>  {
>      MirrorBlockJob *s = opaque;
> -    MirrorExitData *data;
>      BlockDriverState *bs = s->mirror_top_bs->backing->bs;
>      BlockDriverState *target_bs = blk_bs(s->target);
>      bool need_drain = true;
> @@ -1035,13 +1030,11 @@ immediate_exit:
>      g_free(s->in_flight_bitmap);
>      bdrv_dirty_iter_free(s->dbi);
>  
> -    data = g_malloc(sizeof(*data));
> -    data->ret = ret;
> -
>      if (need_drain) {
>          bdrv_drained_begin(bs);
>      }
> -    job_defer_to_main_loop(&s->common.job, mirror_exit, data);
> +
> +    s->common.job.ret = ret;
>  }
>  
>  static void mirror_complete(Job *job, Error **errp)
> @@ -1139,6 +1132,7 @@ static const BlockJobDriver mirror_job_driver = {
>          .user_resume            = block_job_user_resume,
>          .drain                  = block_job_drain,
>          .start                  = mirror_run,
> +        .exit                   = mirror_exit,
>          .pause                  = mirror_pause,
>          .complete               = mirror_complete,
>      },
> @@ -1155,6 +1149,7 @@ static const BlockJobDriver commit_active_job_driver = {
>          .user_resume            = block_job_user_resume,
>          .drain                  = block_job_drain,
>          .start                  = mirror_run,
> +        .exit                   = mirror_exit,
>          .pause                  = mirror_pause,
>          .complete               = mirror_complete,
>      },
> -- 
> 2.14.4
> 
