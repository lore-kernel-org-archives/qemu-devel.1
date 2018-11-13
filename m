Received: from eggs.gnu.org ([2001:4830:134:3::10]:41785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMhuP-00059X-Mz
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMhfY-0002Jo-3s
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:00:33 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <488f96b7-268d-c3e2-f482-477ee1fe062d@redhat.com>
Date: Tue, 13 Nov 2018 18:00:15 -0500
MIME-Version: 1.0
In-Reply-To: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] blkdebug: fix one shot rule
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 11/12/18 2:06 AM, Marc Olson via Qemu-devel wrote:
> If 'once' is specified, the rule should execute just once, regardless if
> it is supposed to return an error or not. Take the example where you
> want the first IO to an LBA to succeed, but subsequent IOs to fail. You
> could either use state transitions, or create two rules, one with
> error = 0 and once set to true, and one with a non-zero error.
> 
> Signed-off-by: Marc Olson <marcolso@amazon.com>
> ---
>  block/blkdebug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 0759452..327049b 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -488,7 +488,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
>          }
>      }
>  
> -    if (!rule || !rule->options.inject.error) {
> +    if (!rule) {
>          return 0;
>      }
>  

This gets rid of the early return so that later we check to see if
'once' was set and remove the rule, regardless of if it did anything or not,

> @@ -500,7 +500,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
>          remove_rule(rule);
>      }
>  
> -    if (!immediately) {
> +    if (error && !immediately) {

And then we modify this to only trigger if we have an error to inject.

>          aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
>          qemu_coroutine_yield();
>      }
> 

[down here, we return -error, but that should still be zero.]


This changes the mechanism of 'once' slightly, but only when errno was
set to zero. I'm not sure we make use of that anywhere, so I think this
should be a safe change. Certainly we don't stipulate that we only
respect once if you bothered to set errno to a non-zero value.

I thiink this is probably fine.

Reviewed-by: John Snow <jsnow@redhat.com>
