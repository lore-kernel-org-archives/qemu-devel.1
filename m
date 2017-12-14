Received: from eggs.gnu.org ([2001:4830:134:3::10]:33421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPDf-0007Ow-AA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPDb-0004Z0-8z
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:50:19 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-6-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <563b01d5-3fdc-93c4-635e-d81f022489ed@redhat.com>
Date: Thu, 14 Dec 2017 09:50:11 +0100
MIME-Version: 1.0
In-Reply-To: <20171214005953.8898-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] block/commit: use block_job_throttle
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
> Depending on the value of `speed` and how fast our backends are,
> delay_ns might be 0 very, very often. This creates some warning
> messages that spook users, but it's also pretty inefficient.
> 
> Use block_job_throttle instead to yield a little more intelligently.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index 873e749d50..567064215b 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -172,7 +172,8 @@ static void coroutine_fn commit_run(void *opaque)
>          /* Note that even when no rate limit is applied we need to yield
>           * with no pending I/O here so that bdrv_drain_all() returns.
>           */
> -        block_job_sleep_ns(&s->common, delay_ns);
> +        block_job_throttle(&s->common, delay_ns);
> +
>          if (block_job_is_cancelled(&s->common)) {
>              break;
>          }
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
