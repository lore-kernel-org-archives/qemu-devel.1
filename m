Received: from eggs.gnu.org ([2001:4830:134:3::10]:40648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0CAZ-00052v-8z
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0CAY-0006eW-2g
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:18:39 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3a8a742d-9a12-732c-7094-03c079befcfe@redhat.com>
Date: Mon, 17 Apr 2017 15:18:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170411222945.11741-2-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/17] blockjob: Track job
 ratelimits via bytes, not sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 04/11/2017 06:29 PM, Eric Blake wrote:
> The user interface specifies job rate limits in bytes/second.
> It's pointless to have our internal representation track things
> in sectors/second, particularly since we want to move away from
> sector-based interfaces.
> 
> Fix up a doc typo found while verifying that the ratelimit
> code handles the scaling difference.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qemu/ratelimit.h |  3 ++-
>  block/backup.c           |  5 +++--
>  block/commit.c           |  5 +++--
>  block/mirror.c           | 13 +++++++------
>  block/stream.c           |  5 +++--
>  5 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
> index 8da1232..8dece48 100644
> --- a/include/qemu/ratelimit.h
> +++ b/include/qemu/ratelimit.h
> @@ -24,7 +24,8 @@ typedef struct {
> 
>  /** Calculate and return delay for next request in ns
>   *
> - * Record that we sent @p n data units. If we may send more data units
> + * Record that we sent @n data units (where @n matches the scale chosen
> + * during ratelimit_set_speed). If we may send more data units
>   * in the current time slice, return 0 (i.e. no delay). Otherwise
>   * return the amount of time (in ns) until the start of the next time
>   * slice that will permit sending the next chunk of data.
> diff --git a/block/backup.c b/block/backup.c
> index a4fb288..bcfa321 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -208,7 +208,7 @@ static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
>          error_setg(errp, QERR_INVALID_PARAMETER, "speed");
>          return;
>      }
> -    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
> +    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
>  }
> 
>  static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
> @@ -359,7 +359,8 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
>       */
>      if (job->common.speed) {
>          uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
> -                                                      job->sectors_read);
> +                                                      job->sectors_read *
> +                                                      BDRV_SECTOR_SIZE);
>          job->sectors_read = 0;
>          block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
>      } else {
> diff --git a/block/commit.c b/block/commit.c
> index 76a0d98..8b684e0 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -195,7 +195,8 @@ static void coroutine_fn commit_run(void *opaque)
>          s->common.offset += n * BDRV_SECTOR_SIZE;
> 
>          if (copy && s->common.speed) {
> -            delay_ns = ratelimit_calculate_delay(&s->limit, n);
> +            delay_ns = ratelimit_calculate_delay(&s->limit,
> +                                                 n * BDRV_SECTOR_SIZE);

You could probably factor out this calculation in conjunction with the
offset update above, but no matter.

>          }
>      }
> 
> @@ -217,7 +218,7 @@ static void commit_set_speed(BlockJob *job, int64_t speed, Error **errp)
>          error_setg(errp, QERR_INVALID_PARAMETER, "speed");
>          return;
>      }
> -    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
> +    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
>  }
> 
>  static const BlockJobDriver commit_job_driver = {
> diff --git a/block/mirror.c b/block/mirror.c
> index 2173a2f..a7d0960 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -391,7 +391,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>      bitmap_set(s->in_flight_bitmap, sector_num / sectors_per_chunk, nb_chunks);
>      while (nb_chunks > 0 && sector_num < end) {
>          int64_t ret;
> -        int io_sectors, io_sectors_acct;
> +        int io_sectors;
> +        int64_t io_bytes_acct;
>          BlockDriverState *file;
>          enum MirrorMethod {
>              MIRROR_METHOD_COPY,
> @@ -439,16 +440,16 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          switch (mirror_method) {
>          case MIRROR_METHOD_COPY:
>              io_sectors = mirror_do_read(s, sector_num, io_sectors);
> -            io_sectors_acct = io_sectors;
> +            io_bytes_acct = io_sectors * BDRV_SECTOR_SIZE;
>              break;
>          case MIRROR_METHOD_ZERO:
>          case MIRROR_METHOD_DISCARD:
>              mirror_do_zero_or_discard(s, sector_num, io_sectors,
>                                        mirror_method == MIRROR_METHOD_DISCARD);
>              if (write_zeroes_ok) {
> -                io_sectors_acct = 0;
> +                io_bytes_acct = 0;
>              } else {
> -                io_sectors_acct = io_sectors;
> +                io_bytes_acct = io_sectors * BDRV_SECTOR_SIZE;
>              }
>              break;
>          default:
> @@ -458,7 +459,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          sector_num += io_sectors;
>          nb_chunks -= DIV_ROUND_UP(io_sectors, sectors_per_chunk);
>          if (s->common.speed) {
> -            delay_ns = ratelimit_calculate_delay(&s->limit, io_sectors_acct);
> +            delay_ns = ratelimit_calculate_delay(&s->limit, io_bytes_acct);
>          }
>      }
>      return delay_ns;
> @@ -918,7 +919,7 @@ static void mirror_set_speed(BlockJob *job, int64_t speed, Error **errp)
>          error_setg(errp, QERR_INVALID_PARAMETER, "speed");
>          return;
>      }
> -    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
> +    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
>  }
> 
>  static void mirror_complete(BlockJob *job, Error **errp)
> diff --git a/block/stream.c b/block/stream.c
> index 0113710..11c5cf1 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -191,7 +191,8 @@ static void coroutine_fn stream_run(void *opaque)
>          /* Publish progress */
>          s->common.offset += n * BDRV_SECTOR_SIZE;
>          if (copy && s->common.speed) {
> -            delay_ns = ratelimit_calculate_delay(&s->limit, n);
> +            delay_ns = ratelimit_calculate_delay(&s->limit,
> +                                                 n * BDRV_SECTOR_SIZE);

Same kind of comment here.

>          }
>      }
> 
> @@ -220,7 +221,7 @@ static void stream_set_speed(BlockJob *job, int64_t speed, Error **errp)
>          error_setg(errp, QERR_INVALID_PARAMETER, "speed");
>          return;
>      }
> -    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
> +    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
>  }
> 
>  static const BlockJobDriver stream_job_driver = {
> 

Reviewed-by: John Snow <jsnow@redhat.com>
