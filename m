Received: from eggs.gnu.org ([2001:4830:134:3::10]:51871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1csnU7-0000DS-52
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1csnU0-0005bA-HX
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:32:15 -0400
MIME-Version: 1.0
In-Reply-To: <1490693009-10037-1-git-send-email-lidongchen@tencent.com>
References: <1490693009-10037-1-git-send-email-lidongchen@tencent.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 28 Mar 2017 17:32:07 +0800
Message-ID: <CAOGPPbewZ1bghfHtJ1vQn-TBmhAL-7=vHP-S++fhkJCt5MHCkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

when migrate the vm with quick speed, i find vnc response slowly.

the bug can be reproduce by this command:
virsh migrate-setspeed 165cf436-312f-47e7-90f2-f8aa63f34893 900
virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
--copy-storage-inc qemu+ssh://10.59.163.38/system

and --copy-storage-all have no problem.
virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
--copy-storage-all qemu+ssh://10.59.163.38/system

mig_save_device_bulk invoke bdrv_is_allocated, but bdrv_is_allocated maybe
wait for a long time.
so cause the main thread wait for a long time.

this patch limit the time wait for bdrv_is_allocated.

i do not find a better way to solve this bug, Any suggestion?

Thanks.

On Tue, Mar 28, 2017 at 5:23 PM, Lidong Chen <jemmy858585@gmail.com> wrote:

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
>
>      /* Lock must be taken _inside_ the iothread lock and any
> AioContexts.  */
>      QemuMutex lock;
> @@ -263,6 +264,7 @@ static void blk_mig_read_cb(void *opaque, int ret)
>      blk_mig_unlock();
>  }
>
> +#define BILLION 1000000000L
>  /* Called with no lock taken.  */
>
>  static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
> @@ -272,16 +274,33 @@ static int mig_save_device_bulk(QEMUFile *f,
> BlkMigDevState *bmds)
>      BlockBackend *bb = bmds->blk;
>      BlkMigBlock *blk;
>      int nr_sectors;
> +    struct timespec ts1, ts2;
> +    int ret = 0;
> +    int timeout_flag = 0;
>
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
> +
> +            block_mig_state.time_ns_used += (ts2.tv_sec - ts1.tv_sec) *
> BILLION
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
> @@ -292,6 +311,11 @@ static int mig_save_device_bulk(QEMUFile *f,
> BlkMigDevState *bmds)
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
> @@ -576,9 +600,6 @@ static int mig_save_device_dirty(QEMUFile *f,
> BlkMigDevState *bmds,
>              }
>
>              bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector,
> nr_sectors);
> -            sector += nr_sectors;
> -            bmds->cur_dirty = sector;
> -
>              break;
>          }
>          sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
> @@ -756,6 +777,7 @@ static int block_save_iterate(QEMUFile *f, void
> *opaque)
>      }
>
>      blk_mig_reset_dirty_cursor();
> +    block_mig_state.time_ns_used = 0;
>
>      /* control the rate of transfer */
>      blk_mig_lock();
> @@ -764,7 +786,8 @@ static int block_save_iterate(QEMUFile *f, void
> *opaque)
>             qemu_file_get_rate_limit(f) &&
>             (block_mig_state.submitted +
>              block_mig_state.read_done) <
> -           MAX_INFLIGHT_IO) {
> +           MAX_INFLIGHT_IO &&
> +           block_mig_state.time_ns_used <= 100000) {
>          blk_mig_unlock();
>          if (block_mig_state.bulk_completed == 0) {
>              /* first finish the bulk phase */
> --
> 1.8.3.1
>
>
