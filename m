Received: from eggs.gnu.org ([2001:4830:134:3::10]:55266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csnik-000580-0T
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csnij-0003la-5r
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:47:22 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1490693009-10037-1-git-send-email-lidongchen@tencent.com>
	(Lidong Chen's message of "Tue, 28 Mar 2017 17:23:29 +0800")
References: <1490693009-10037-1-git-send-email-lidongchen@tencent.com>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 11:47:09 +0200
Message-ID: <87efxhspgi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Lidong Chen <jemmy858585@gmail.com> wrote:
> when migration with quick speed, mig_save_device_bulk invoke
> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
> this patch limit the time used for bdrv_is_allocated.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/block.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/migration/block.c b/migration/block.c
> index 7734ff7..d3e81ca 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -110,6 +110,7 @@ typedef struct BlkMigState {
>      int transferred;
>      int prev_progress;
>      int bulk_completed;
> +    int time_ns_used;

An int that can only take values 0/1 is called a bool O:-)


>      if (bmds->shared_base) {
>          qemu_mutex_lock_iothread();
>          aio_context_acquire(blk_get_aio_context(bb));
>          /* Skip unallocated sectors; intentionally treats failure as
>           * an allocated sector */
> -        while (cur_sector < total_sectors &&
> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
> -            cur_sector += nr_sectors;
> +        while (cur_sector < total_sectors) {
> +            clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
> +            ret = bdrv_is_allocated(blk_bs(bb), cur_sector,
> +                                    MAX_IS_ALLOCATED_SEARCH, &nr_sectors);
> +            clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);

Do we really want to call clock_gettime each time that
bdrv_is_allocated() is called?  My understanding is that clock_gettime
is expensive, but I don't know how expensive is brdrv_is_allocated()

And while we are at it, .... shouldn't we check since before the while?


> +
> +            block_mig_state.time_ns_used += (ts2.tv_sec - ts1.tv_sec) * BILLION
> +                          + (ts2.tv_nsec - ts1.tv_nsec);
> +
> +            if (!ret) {
> +                cur_sector += nr_sectors;
> +                if (block_mig_state.time_ns_used > 100000) {
> +                    timeout_flag = 1;
> +                    break;
> +                }
> +            } else {
> +                break;
> +            }
>          }
>          aio_context_release(blk_get_aio_context(bb));
>          qemu_mutex_unlock_iothread();
> @@ -292,6 +311,11 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>          return 1;
>      }
>  
> +    if (timeout_flag == 1) {
> +        bmds->cur_sector = bmds->completed_sectors = cur_sector;
> +        return 0;
> +    }
> +
>      bmds->completed_sectors = cur_sector;
>  
>      cur_sector &= ~((int64_t)BDRV_SECTORS_PER_DIRTY_CHUNK - 1);
> @@ -576,9 +600,6 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
>              }
>  
>              bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
> -            sector += nr_sectors;
> -            bmds->cur_dirty = sector;
> -
>              break;
>          }
>          sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
> @@ -756,6 +777,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>      }
>  
>      blk_mig_reset_dirty_cursor();
> +    block_mig_state.time_ns_used = 0;
>  
>      /* control the rate of transfer */
>      blk_mig_lock();
> @@ -764,7 +786,8 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>             qemu_file_get_rate_limit(f) &&
>             (block_mig_state.submitted +
>              block_mig_state.read_done) <
> -           MAX_INFLIGHT_IO) {
> +           MAX_INFLIGHT_IO &&
> +           block_mig_state.time_ns_used <= 100000) {

changed this 10.000 (and the one used previously) to one constant that
says BIG_DELAY, 100MS or whatever you fancy.

Thanks, Juan.
