Received: from eggs.gnu.org ([2001:4830:134:3::10]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPEN-0007sc-2z
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPEM-0005GH-AW
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:51:03 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-8-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce84f3ff-7496-1668-c515-d81f1218f30e@redhat.com>
Date: Thu, 14 Dec 2017 09:50:58 +0100
MIME-Version: 1.0
In-Reply-To: <20171214005953.8898-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] block/backup: use block_job_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On 14/12/2017 01:59, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index d71b25c017..a5ede5f643 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -334,6 +334,8 @@ static void backup_complete(BlockJob *job, void *opaque)
>  
>  static bool coroutine_fn yield_and_check(BackupBlockJob *job)
>  {
> +    uint64_t delay_ns = 0;
> +
>      if (block_job_is_cancelled(&job->common)) {
>          return true;
>      }
> @@ -342,14 +344,13 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
>       * (without, VM does not reboot)
>       */
>      if (job->common.speed) {
> -        uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
> -                                                      job->bytes_read);
> +        delay_ns = ratelimit_calculate_delay(&job->limit,
> +                                             job->bytes_read);
>          job->bytes_read = 0;
> -        block_job_sleep_ns(&job->common, delay_ns);
> -    } else {
> -        block_job_sleep_ns(&job->common, 0);
>      }
>  
> +    block_job_throttle(&job->common, delay_ns);
> +
>      if (block_job_is_cancelled(&job->common)) {
>          return true;
>      }
> 

This one is. :)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
