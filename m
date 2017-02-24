Received: from eggs.gnu.org ([2001:4830:134:3::10]:52575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chHOh-0003vg-FK
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chHOg-0005G5-1N
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:03:03 -0500
Date: Fri, 24 Feb 2017 16:02:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170224150250.GB4429@noname.redhat.com>
References: <1487680191-13096-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487680191-13096-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com

Am 21.02.2017 um 13:29 hat Peter Lieven geschrieben:
> the convert process is currently completely implemented with sync operations.
> That means it reads one buffer and then writes it. No parallelism and each sync
> request takes as long as it takes until it is completed.
> 
> This can be a big performance hit when the convert process reads and writes
> to devices which do not benefit from kernel readahead or pagecache.
> In our environment we heavily have the following two use cases when using
> qemu-img convert.
> 
> a) reading from NFS and writing to iSCSI for deploying templates
> b) reading from iSCSI and writing to NFS for backups
> 
> In both processes we use libiscsi and libnfs so we have no kernel cache.
> 
> This patch changes the convert process to work with parallel running coroutines
> which can significantly improve performance for network storage devices:
> 
> qemu-img (master)
>  nfs -> iscsi 22.8 secs
>  nfs -> ram   11.7 secs
>  ram -> iscsi 12.3 secs
> 
> qemu-img-async (8 coroutines, in-order write disabled)
>  nfs -> iscsi 11.0 secs
>  nfs -> ram   10.4 secs
>  ram -> iscsi  9.0 secs
> 
> This patches introduces 2 new cmdline parameters. The -m parameter to specify
> the number of coroutines running in parallel (defaults to 8). And the -W paremeter to
> allow qemu-img to write to the target out of order rather than sequential. This improves
> performance as the writes do not have to wait for each other to complete.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>

> @@ -1563,9 +1581,13 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>          blk = s->src[s->src_cur];
>          bs_sectors = s->src_sectors[s->src_cur];
>  
>          n = MIN(nb_sectors, bs_sectors - (sector_num - s->src_cur_offset));

convert_co_read() uses global state here (s->src, s->src_cur,
s->src_cur_offset) while not running under a lock. Are you sure that
this is correct when some coroutines are operating on the first source
image, but others are already working on the second one?

The same variables are used in convert_iteration_sectors(), but I think
there it's okay because we're just starting a new request and are
holding s->lock.

> @@ -1651,12 +1685,122 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>      return 0;
>  }
>  
> -static int convert_do_copy(ImgConvertState *s)
> +static void coroutine_fn convert_co_do_copy(void *opaque)
>  {
> +    ImgConvertState *s = opaque;
>      uint8_t *buf = NULL;
> -    int64_t sector_num, allocated_done;
> -    int ret;
> -    int n;
> +    int ret, i;
> +    int index = -1;
> +
> +    for (i = 0; i < s->num_coroutines; i++) {
> +        if (s->co[i] == qemu_coroutine_self()) {
> +            index = i;
> +            break;
> +        }
> +    }
> +    assert(index >= 0);
> +
> +    s->running_coroutines++;
> +    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
> +
> +    while (1) {
> +        int n;
> +        int64_t sector_num;
> +        enum ImgConvertBlockStatus status;
> +
> +        qemu_co_mutex_lock(&s->lock);
> +        if (s->ret != -EINPROGRESS || s->sector_num >= s->total_sectors) {
> +            qemu_co_mutex_unlock(&s->lock);
> +            goto out;
> +        }
> +        n = convert_iteration_sectors(s, s->sector_num);
> +        if (n < 0) {
> +            qemu_co_mutex_unlock(&s->lock);
> +            s->ret = n;
> +            goto out;
> +        }
> +        /* safe current sector and allocation status to local variables */

s/safe/save/

> +        sector_num = s->sector_num;
> +        status = s->status;
> +        if (!s->min_sparse && s->status == BLK_ZERO) {
> +            n = MIN(n, s->buf_sectors);
> +        }
> +        /* increment global sector counter so that other coroutines can
> +         * already continue reading beyond this request */
> +        s->sector_num += n;
> +        qemu_co_mutex_unlock(&s->lock);

Here we unlock, so after this point we can only access globally valid
values from s, but not request-specific ones like s->status or
s->sector_num...

> +        if (status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO)) {

...but s->status is used here...

> +            s->allocated_done += n;
> +            qemu_progress_print(100.0 * s->allocated_done /
> +                                        s->allocated_sectors, 0);
> +        }
> +
> +        if (status == BLK_DATA) {
> +            ret = convert_co_read(s, sector_num, n, buf);
> +            if (ret < 0) {
> +                error_report("error while reading sector %" PRId64
> +                             ": %s", sector_num, strerror(-ret));
> +                s->ret = ret;
> +                goto out;
> +            }
> +        } else if (!s->min_sparse && s->status == BLK_ZERO) {

...and here.

> +            status = BLK_DATA;
> +            memset(buf, 0x00, n * BDRV_SECTOR_SIZE);
> +        }
> +
> +        if (s->wr_in_order) {
> +            /* keep writes in order */
> +            while (s->wr_offs != sector_num) {
> +                if (s->ret != -EINPROGRESS) {
> +                    goto out;
> +                }
> +                s->wait_sector_num[index] = sector_num;
> +                qemu_coroutine_yield();
> +            }
> +            s->wait_sector_num[index] = -1;
> +        }
> +
> +        ret = convert_co_write(s, sector_num, n, buf, status);
> +        if (ret < 0) {
> +            error_report("error while writing sector %" PRId64
> +                         ": %s", sector_num, strerror(-ret));
> +            s->ret = ret;
> +            goto out;
> +        }
> +
> +        if (s->wr_in_order) {
> +            /* reenter the coroutine that might have waited
> +             * for this write to complete */
> +            s->wr_offs = sector_num + n;
> +            for (i = 0; i < s->num_coroutines; i++) {
> +                if (s->co[i] && s->wait_sector_num[i] == s->wr_offs) {
> +                    /*
> +                     * A -> B -> A cannot occur because A has
> +                     * s->wait_sector_num[i] == -1 during A -> B. Therefore
> +                     * B will never enter A during this time window.
> +                     */
> +                    qemu_coroutine_enter(s->co[i]);
> +                    break;
> +                }
> +            }
> +        }
> +    }
> +
> +out:
> +    qemu_vfree(buf);
> +    s->co[index] = NULL;
> +    s->running_coroutines--;
> +    if (!s->running_coroutines && s->ret == -EINPROGRESS) {
> +        /* the convert job finished successfully */
> +        s->ret = 0;
> +    }
> +}
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 174aae3..6715ff3 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -137,6 +137,12 @@ Parameters to convert subcommand:
>  
>  @item -n
>  Skip the creation of the target volume
> +@item -m
> +Number of parallel coroutines for the convert process
> +@item -W
> +Allow to write out of order to the destination. This is option improves performance,
> +but is only recommened for preallocated devices like host devices or other
> +raw block devices.
>  @end table
>  
>  Parameters to dd subcommand:
> @@ -296,7 +302,7 @@ Error on reading data
>  
>  @end table
>  
> -@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
> +@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-m @var{num_coroutines}] [-W] {[-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}

The extra { before -S causes 'make qemu-doc.html' to fail (as reported
by patchew).

Kevin
