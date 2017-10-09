Received: from eggs.gnu.org ([2001:4830:134:3::10]:40842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1hpu-00022Z-OR
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 19:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1hpt-0000Oq-QQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 19:51:50 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-6-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5c764041-da10-7946-86fb-d3be36f76cd9@redhat.com>
Date: Mon, 9 Oct 2017 19:51:38 -0400
MIME-Version: 1.0
In-Reply-To: <20171002143919.207741-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] backup: use copy_bitmap in incremental
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 10/02/2017 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> We can use copy_bitmap instead of sync_bitmap. copy_bitmap is
> initialized from sync_bitmap and it is more informative: we will not try
> to process data, that is already in progress (by write notifier).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/backup.c | 55 +++++++++++++++++--------------------------------------

Lookin' good.

>  1 file changed, 17 insertions(+), 38 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 52df7bb19e..c933cfafc3 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -362,49 +362,28 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
>  
>  static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
>  {
> +    int ret;
>      bool error_is_read;
> -    int ret = 0;
> -    int clusters_per_iter;
> -    uint32_t granularity;
> -    int64_t offset;
>      int64_t cluster;
> -    int64_t end;
> -    BdrvDirtyBitmapIter *dbi;
> -
> -    granularity = bdrv_dirty_bitmap_granularity(job->sync_bitmap);
> -    clusters_per_iter = MAX((granularity / job->cluster_size), 1);
> -    dbi = bdrv_dirty_iter_new(job->sync_bitmap);
> -
> -    /* Find the next dirty sector(s) */
> -    while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
> -        cluster = offset / job->cluster_size;
> -
> -        for (end = cluster + clusters_per_iter; cluster < end; cluster++) {
> -            do {
> -                if (yield_and_check(job)) {
> -                    goto out;
> -                }
> -                ret = backup_do_cow(job, cluster * job->cluster_size,
> -                                    job->cluster_size, &error_is_read,
> -                                    false);
> -                if ((ret < 0) &&
> -                    backup_error_action(job, error_is_read, -ret) ==
> -                    BLOCK_ERROR_ACTION_REPORT) {
> -                    goto out;
> -                }
> -            } while (ret < 0);
> -        }
> +    HBitmapIter hbi;
>  
> -        /* If the bitmap granularity is smaller than the backup granularity,
> -         * we need to advance the iterator pointer to the next cluster. */
> -        if (granularity < job->cluster_size) {
> -            bdrv_set_dirty_iter(dbi, cluster * job->cluster_size);
> -        }
> +    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
> +    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
> +        do {
> +            if (yield_and_check(job)) {
> +                return 0;
> +            }
> +            ret = backup_do_cow(job, cluster * job->cluster_size,
> +                                job->cluster_size, &error_is_read, false);
> +            if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
> +                           BLOCK_ERROR_ACTION_REPORT)
> +            {
> +                return ret;
> +            }
> +        } while (ret < 0);
>      }
>  
> -out:
> -    bdrv_dirty_iter_free(dbi);
> -    return ret;
> +    return 0;
>  }
>  
>  /* init copy_bitmap from sync_bitmap */
> 

Impressive, you really cleaned this function up considerably.

Reviewed-by: John Snow <jsnow@redhat.com>
