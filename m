Received: from eggs.gnu.org ([2001:4830:134:3::10]:36191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZMqM-0000jc-3N
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZMqK-0003ZY-V7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:23:57 -0500
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
	<20181102151152.288399-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48002129-16ef-f0ad-2701-893fc88ecdd0@redhat.com>
Date: Tue, 18 Dec 2018 15:23:48 -0600
MIME-Version: 1.0
In-Reply-To: <20181102151152.288399-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] block/nbd-client: use traces instead
 of noisy error_report_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 11/2/18 10:11 AM, Vladimir Sementsov-Ogievskiy wrote:
> Reduce extra noise of nbd-client, change 083 correspondingly.

This says what, but not why. The details from the cover letter are 
important to include here, namely:

> It was discussed, that error messages, produced by error_reprt_err's,
> added in f140e300 are
> 1. not really needed
> 2. subject to race conditions
> 
> And it was decided to drop them (switch to trace-points), look thread
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00833.html
> 
> So, I've also dropped error_report_err, added earlier in be41c100c0d
> and later in 78a33ab5878.


> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd-client.c         | 27 +++++++++++++++++++++++----
>   block/trace-events         |  4 ++++
>   tests/qemu-iotests/083.out | 28 ----------------------------
>   3 files changed, 27 insertions(+), 32 deletions(-)
> 
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 9686ecbd5e..9b1dab6e5d 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -28,6 +28,8 @@
>    */
>   
>   #include "qemu/osdep.h"
> +
> +#include "trace.h"

There are probably other things worth tracing, but this is a decent 
start.  In particular, note the comment in nbd_parse_error_payload():

     /* TODO: Add a trace point to mention the server complaint */

> @@ -79,7 +81,9 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>           assert(s->reply.handle == 0);
>           ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
>           if (local_err) {
> -            error_report_err(local_err);
> +            trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_err),
> +                                            error_get_hint(local_err) ?: "");

I'm not sold on the error hint being useful in the trace message.  For 
that matter, even error_get_pretty() seems like it might be rather verbose.

I do see why you are trying it, though: in nbd/client.c, 
nbd_handle_reply_err(), we have:


     case NBD_REP_ERR_BLOCK_SIZE_REQD:
         error_setg(errp, "Server requires INFO_BLOCK_SIZE for option %" 
PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;

     default:
         error_setg(errp, "Unknown error code when asking for option %" 
PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
     }

     if (msg) {
         error_append_hint(errp, "server reported: %s\n", msg);

That is, we are reporting our own error no matter what (because we don't 
trust the server to always give us something useful, especially since 
many non-qemu servers still don't take advantage of the free-form error 
message slot in the protocol), and append the server's message if 
present as a hint (as most times a server that uses it actually manages 
to report something that the end user may benefit from seeing).

But instead of trying to make all the tracepoints in block/nbd-client.c 
extract this information, we could just improve nbd/client.c to have a 
tracepoint for any server-received error message at the same point where 
it calls error_append_hint().

The end result will be the same: if you enable all nbd_* traces, you'll 
still get the server's error message.  At the same time, doing it as two 
separate traces in the two separate files means that you can have 
finer-grained selection of which traces to view, and that the code in 
nbd-client.c doesn't have to extract the hint, which means patch 1/3 
isn't important after all.

I'll post a counter-proposal patch along those lines.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
