Received: from eggs.gnu.org ([2001:4830:134:3::10]:53543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJGn-0002c2-0Q
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJGm-0005oS-50
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:36:29 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-6-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b04399ee-1b79-5a34-e53e-fabb28a7e462@redhat.com>
Date: Mon, 14 May 2018 15:36:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/42] blockjob: Introduce
 block_job_ratelimit_get_delay()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> This gets us rid of more direct accesses to BlockJob fields from the
> job drivers.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  include/block/blockjob_int.h |  8 ++++++++
>  block/backup.c               | 18 +++++++-----------
>  block/commit.c               |  4 ++--
>  block/mirror.c               |  5 +----
>  block/stream.c               |  4 ++--
>  blockjob.c                   |  9 +++++++++
>  6 files changed, 29 insertions(+), 19 deletions(-)
> 

[...]

> diff --git a/block/backup.c b/block/backup.c
> index 8468fd9f94..cfdb6ecdf5 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -325,21 +325,17 @@ static void backup_complete(BlockJob *job, void *opaque)
>  
>  static bool coroutine_fn yield_and_check(BackupBlockJob *job)
>  {
> +    uint64_t delay_ns;
> +
>      if (block_job_is_cancelled(&job->common)) {
>          return true;
>      }
>  
> -    /* we need to yield so that bdrv_drain_all() returns.
> -     * (without, VM does not reboot)
> -     */

I'll kind of miss this terse comment. "without, VM does not reboot" is
very direct and to the point. :)

> -    if (job->common.speed) {
> -        uint64_t delay_ns = ratelimit_calculate_delay(&job->common.limit,
> -                                                      job->bytes_read);
> -        job->bytes_read = 0;
> -        block_job_sleep_ns(&job->common, delay_ns);
> -    } else {
> -        block_job_sleep_ns(&job->common, 0);
> -    }
> +    /* We need to yield even for delay_ns = 0 so that bdrv_drain_all() can
> +     * return. Without a yield, the VM would not reboot. */
> +    delay_ns = block_job_ratelimit_get_delay(&job->common, job->bytes_read);
> +    job->bytes_read = 0;
> +    block_job_sleep_ns(&job->common, delay_ns);
>  
>      if (block_job_is_cancelled(&job->common)) {
>          return true;
