Received: from eggs.gnu.org ([2001:4830:134:3::10]:56299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1esw5E-0002du-RT
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1esw5D-00030u-M0
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:47:40 -0500
References: <20180305180433.106408-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8324efe-7fd4-3c44-faac-a7a9e9e1ad3e@redhat.com>
Date: Mon, 5 Mar 2018 13:47:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180305180433.106408-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix space read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/05/2018 12:04 PM, Vladimir Sementsov-Ogievskiy wrote:
> In case of io error in nbd_co_send_sparse_read we should not
> "goto reply:", as it is fatal error and common behavior is
> disconnect in this case. We should not try to send client an
> error reply, representing channel-io error on previous try to
> send a reply.

Good catch.

> 
> Fix this by handle block-status error in nbd_co_send_sparse_read,
> so nbd_co_send_sparse_read fails only on io error. Then just skip
> common "reply:" code path in nbd_trip.
> 
> Note: nbd_co_send_structured_error is moved without changes to be
> called from nbd_co_send_sparse_read.

Might be easier to read as two patches, one for the code motion, the 
other for using the new code.  But I'm not going to insist on a split.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> PS: this all shows that nbd_trip is tooo complex (and yes, I remember,
> that its final semantics was made by myself :(.. It should be
> refactored into several smaller parts. Do you have any ideas?
> 
> The complexity here is that we should handle channel errors (fatal) and
> export errors(non fatal) in different ways, and both of error types may
> have errp, which should be handled differently too..
> 
> May be, the best way is to make separate functions for each command,
> avoiding code duplication by using helper-functions instead of common code
> in nbd_trip.

Yes, splitting nbd_trip into smaller helper functions may be worthwhile.

> 
>   nbd/server.c | 64 +++++++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 4990a5826e..ea6b9467e4 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -21,6 +21,7 @@
>   #include "qapi/error.h"
>   #include "trace.h"
>   #include "nbd-internal.h"
> +#include "qemu/error-report.h"

I'm a bit worried about this one.  The server has previously not needed 
this, so it may be the wrong thing to pull it in now.


> +
>   static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>                                                   uint64_t handle,
>                                                   uint64_t offset,

It doesn't help that we are lacking comments on the contract of this 
function.

> @@ -1361,8 +1386,15 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>           bool final;
>   
>           if (status < 0) {
> -            error_setg_errno(errp, -status, "unable to check for holes");
> -            return status;
> +            char *msg = g_strdup_printf("unable to check for holes: %s",
> +                                              strerror(-status));

Indentation looks off.

> +
> +            error_report("%s", msg);

Do we really need to report this on the server's stderr, or is sending 
the reply to the client good enough?

> +
> +            ret = nbd_co_send_structured_error(client, handle, -status, msg,
> +                                               errp);
> +            g_free(msg);
> +            return ret;

So if we have an early return here, then pre-patch, we were 
unconditionally setting errp and returning -1 (even if the client is 
still alive); post-patch errp is only set if we failed to do I/O with 
the client.  That change is right, but harder to see without comments 
giving a function contract.

> @@ -1567,7 +1575,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>                                             request.from, req->data, request.len,
>                                             &local_err);
>               if (ret < 0) {
> -                goto reply;
> +                goto replied;
>               }
>               goto done;
>           }
> @@ -1664,6 +1672,8 @@ reply:
>                                          req->data, reply_data_len, &local_err);
>       }
>       g_free(msg);
> +
> +replied:

This part makes sense.

>       if (ret < 0) {
>           error_prepend(&local_err, "Failed to send reply: ");
>           goto disconnect;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
