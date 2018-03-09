Received: from eggs.gnu.org ([2001:4830:134:3::10]:41581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euO6p-0003ag-Bg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euO6o-0000lZ-5O
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:55:19 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<20180308184636.178534-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86c81751-e7f8-e609-afe0-efa6fea20354@redhat.com>
Date: Fri, 9 Mar 2018 13:55:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180308184636.178534-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] nbd/server: fix sparse read
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

On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> In case of io error in nbd_co_send_sparse_read we should not
> "goto reply:", as it is fatal error and common behavior is
> disconnect in this case. We should not try to send client an

s/send/send the/

> error reply, representing channel-io error on previous try to
> send a reply.

s/representing .../since we already hit a channel-io error on our 
previous attempt to send a reply/

> 
> Fix this by handle block-status error in nbd_co_send_sparse_read,

s/handle/handling/

> so nbd_co_send_sparse_read fails only on io error. Then just skip
> common "reply:" code path in nbd_trip.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v2: code movement splitted to 01
>      remove error_report
>      fix indent
>      fix commit message subject line
>      add comment to nbd_co_send_sparse_read (be free to adjust it)

Not a problem, I know English is not your native tongue, so I don't mind 
touching it up, and I already admire your efforts at programming in a 
second language (a skill I lack).

> 
>   nbd/server.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index c406b0656d..e0de431e10 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1365,6 +1365,10 @@ static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
>       return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
>   }
>   
> +/* Do sparse read and send structured reply to the client.

s/Do/Do a/

> + * Returns -errno if sending fails. bdrv_block_status_above() fail is not

s/fail/failure/

> + * considered as an error, but reported to the client instead (as a structured
> + * error). */

The comment tail */ usually gets its own line.

Here's what I used:

/* Do a sparse read and send the structured reply to the client.
  * Returns -errno if sending fails. bdrv_block_status_above() failure is
  * reported to the client, at which point this function succeeds.
  */

>   static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>                                                   uint64_t handle,
>                                                   uint64_t offset,
> @@ -1385,8 +1389,13 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>           bool final;
>   
>           if (status < 0) {
> -            error_setg_errno(errp, -status, "unable to check for holes");
> -            return status;
> +            char *msg = g_strdup_printf("unable to check for holes: %s",
> +                                        strerror(-status));

I had to double-check block/io.c, but it looks like 
bdrv_block-status_above() does indeed document a return of negative 
errno on failure.  (My suspicion is that the documentation might be 
wrong, because I did not audit error returns when doing my byte-based 
work; but a quick audit of a couple of random drivers shows that at 
least iscsi.c and qed.c appear to comply.)

> +
> +            ret = nbd_co_send_structured_error(client, handle, -status, msg,
> +                                               errp);
> +            g_free(msg);
> +            return ret;

I wonder if a separate patch should clean this up to let 
nbd_co_send_structured_error() do message formatting (making it varargs) 
- but doesn't affect this patch.

With grammar tweaks,
Reviewed-by: Eric Blake <eblake@redhat.com

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
