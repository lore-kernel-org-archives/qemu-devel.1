Received: from eggs.gnu.org ([2001:4830:134:3::10]:46360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cVXH2-0004Jo-Eb
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cVXH1-0000Ra-Hg
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:34:36 -0500
Date: Mon, 23 Jan 2017 00:34:26 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170123053426.GA2814@localhost.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-2-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482503344-6424-2-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 01/21] backup: move from done_bitmap to
 copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

On Fri, Dec 23, 2016 at 05:28:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Use HBitmap copy_bitmap instead of done_bitmap. This is needed to unify
> backup loop for full/incremental modes in future patches.
> 
> We reset bit of the copy_bitmap immediately after checking it in
> backup_do_cow(). It is safe, because all other intersecting requests
> will wait for our request finish anyway.
> 
> The other difference is that in case of error we will have zeroed bit in
> copy_bitmap, when in done_bitmap we have not set bit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index ea38733..6b27e55 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -39,11 +39,12 @@ typedef struct BackupBlockJob {
>      BlockdevOnError on_target_error;
>      CoRwlock flush_rwlock;
>      uint64_t sectors_read;
> -    unsigned long *done_bitmap;
>      int64_t cluster_size;
>      bool compress;
>      NotifierWithReturn before_write;
>      QLIST_HEAD(, CowRequest) inflight_reqs;
> +
> +    HBitmap *copy_bitmap;
>  } BackupBlockJob;
>  
>  /* Size of a cluster in sectors, instead of bytes. */
> @@ -115,10 +116,11 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
>      cow_request_begin(&cow_request, job, start, end);
>  
>      for (; start < end; start++) {
> -        if (test_bit(start, job->done_bitmap)) {
> +        if (!hbitmap_get(job->copy_bitmap, start)) {
>              trace_backup_do_cow_skip(job, start);
>              continue; /* already copied */
>          }
> +        hbitmap_reset(job->copy_bitmap, start, 1);
>  
>          trace_backup_do_cow_process(job, start);
>  
> @@ -141,6 +143,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
>              if (error_is_read) {
>                  *error_is_read = true;
>              }
> +            hbitmap_set(job->copy_bitmap, start, 1);
>              goto out;
>          }
>  
> @@ -157,11 +160,10 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
>              if (error_is_read) {
>                  *error_is_read = false;
>              }
> +            hbitmap_set(job->copy_bitmap, start, 1);
>              goto out;
>          }
>  
> -        set_bit(start, job->done_bitmap);
> -
>          /* Publish progress, guest I/O counts as progress too.  Note that the
>           * offset field is an opaque progress value, it is not a disk offset.
>           */
> @@ -271,7 +273,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
>      }
>  
>      len = DIV_ROUND_UP(backup_job->common.len, backup_job->cluster_size);
> -    bitmap_zero(backup_job->done_bitmap, len);
> +    hbitmap_set(backup_job->copy_bitmap, 0, len);
>  }
>  
>  void backup_wait_for_overlapping_requests(BlockJob *job, int64_t sector_num,
> @@ -450,7 +452,8 @@ static void coroutine_fn backup_run(void *opaque)
>      start = 0;
>      end = DIV_ROUND_UP(job->common.len, job->cluster_size);
>  
> -    job->done_bitmap = bitmap_new(end);
> +    job->copy_bitmap = hbitmap_alloc(end, 0);
> +    hbitmap_set(job->copy_bitmap, 0, end);
>  
>      job->before_write.notify = backup_before_write_notify;
>      bdrv_add_before_write_notifier(bs, &job->before_write);
> @@ -524,7 +527,7 @@ static void coroutine_fn backup_run(void *opaque)
>      /* wait until pending backup_do_cow() calls have completed */
>      qemu_co_rwlock_wrlock(&job->flush_rwlock);
>      qemu_co_rwlock_unlock(&job->flush_rwlock);
> -    g_free(job->done_bitmap);
> +    hbitmap_free(job->copy_bitmap);
>  
>      data = g_malloc(sizeof(*data));
>      data->ret = ret;
> -- 
> 1.8.3.1
>

Reviewed-by: Jeff Cody <jcody@redhat.com>
