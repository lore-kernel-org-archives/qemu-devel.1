Received: from eggs.gnu.org ([2001:4830:134:3::10]:46846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftElB-0006IS-DM
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftEl6-00043b-JZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:16:29 -0400
References: <1535087186-9643-1-git-send-email-marcolso@amazon.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <837facae-ff38-e995-ca2e-9c16efb7c209@redhat.com>
Date: Fri, 24 Aug 2018 11:11:12 -0500
MIME-Version: 1.0
In-Reply-To: <1535087186-9643-1-git-send-email-marcolso@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blkdebug: Add support for latency rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/24/2018 12:06 AM, Marc Olson via Qemu-devel wrote:
> Allow rules to be created to inject latency into I/O operations.
> 
> Signed-off-by: Marc Olson <marcolso@amazon.com>
> ---
>   block/blkdebug.c        | 101 ++++++++++++++++++++++++++++++++++++++----------
>   docs/devel/blkdebug.txt |  30 ++++++++++----
>   2 files changed, 103 insertions(+), 28 deletions(-)

The commit message could usefully summarize some of the doc additions 
(so you can learn more about it without having to read the patch itself) 
- but the doc additions are appreciated.

Missing: you should enhance an existing (or add a new) iotests usage of 
blkdebug to specify a latency operation. One possible test would be 
forcing a read to take longer than a write - then issue an aio read, a 
write immediately after, and verify that the write completes first and 
then the read (whether the read sees the old or the new data just 
written would then depend on whether the delay is acted on before or 
after blkdebug forwards the read on to the real block layer).

> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index e216699..762e438 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -65,6 +65,7 @@ typedef struct BlkdebugSuspendedReq {
>   
>   enum {
>       ACTION_INJECT_ERROR,
> +    ACTION_DELAY,
>       ACTION_SET_STATE,
>       ACTION_SUSPEND,
>   };

Does any of this need to be accessible via QMP?  (If QMP can't already 
fine-tune what blkdebug can do, I'm not proposing that you have to make 
it do so - but if QMP can specify error injections, it should also be 
able to specify delays).  Even if it doesn't need to be in QMP, should 
we specify this enum and related types in our qapi/*.json files?


> @@ -123,6 +127,33 @@ static QemuOptsList inject_error_opts = {
>       },
>   };
>   
> +static QemuOptsList delay_opts = {

One reason for suggesting that this be done with QAPI types is that 
QemuOpts is already proving to be painfully hard to extend, where in 
general we are trying to move towards using QAPI types rather than yet 
more QemuOpts munging.

> @@ -182,16 +214,21 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
>           .state  = qemu_opt_get_number(opts, "state", 0),
>       };
>   
> +    rule->once  = qemu_opt_get_bool(opts, "once", 0);
> +    sector = qemu_opt_get_number(opts, "sector", -1);
> +    rule->offset = sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;

I really wish we could spend time moving blkdebug to be byte-based 
instead of sector-based.

> +++ b/docs/devel/blkdebug.txt
> @@ -24,7 +24,7 @@ This way, all error paths can be tested to make sure they are correct.
>   Rules
>   -----
>   The blkdebug block driver takes a list of "rules" that tell the error injection
> -engine when to fail an I/O request.
> +engine when to fail (inject-error) or add latency to (delay) an I/O request.
>   
>   Each I/O request is evaluated against the rules.  If a rule matches the request
>   then its "action" is executed.
> @@ -33,17 +33,25 @@ Rules can be placed in a configuration file; the configuration file
>   follows the same .ini-like format used by QEMU's -readconfig option, and
>   each section of the file represents a rule.
>   
> -The following configuration file defines a single rule:
> +The following configuration file defines multiple rules:
>   
>     $ cat blkdebug.conf
>     [inject-error]
>     event = "read_aio"
>     errno = "28"
>   
> -This rule fails all aio read requests with ENOSPC (28).  Note that the errno
> -value depends on the host.  On Linux, see
> +  [delay]
> +  event = "read_aio"
> +  sector = "2048"
> +  latency = "500000"
> +
> +The error rule fails all aio read requests with ENOSPC (28).  Note that the
> +errno value depends on the host.  On Linux, see
>   /usr/include/asm-generic/errno-base.h for errno values.
>   
> +The delay rule adds 500 ms of latency to a read I/O request containing sector
> +2048.

So in this example, you get a failure no matter what, but that one 
sector takes even longer to fail?

Overall, I like the idea.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
