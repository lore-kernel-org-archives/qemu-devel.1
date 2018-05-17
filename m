Received: from eggs.gnu.org ([2001:4830:134:3::10]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fJFaM-0003Vn-0E
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fJFaK-0003Te-Vt
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:52:34 -0400
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8003bc90-1b11-3d1b-07a3-dca4d49fb79b@virtuozzo.com>
Date: Thu, 17 May 2018 12:52:20 +0300
MIME-Version: 1.0
In-Reply-To: <20180413143156.11409-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/server: introduce NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com, eblake@redhat.com

Finally, what about this?

13.04.2018 17:31, Vladimir Sementsov-Ogievskiy wrote:
> Handle nbd CACHE command. Just do read, without sending read data back.
> Cache mechanism should be done by exported node driver chain.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/nbd.h |  3 ++-
>   nbd/server.c        | 10 ++++++----
>   2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index fcdcd54502..b4793d0a29 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -135,6 +135,7 @@ typedef struct NBDExtent {
>   #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
>   #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
>   #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
> +#define NBD_FLAG_SEND_CACHE        (1 << 8) /* Send CACHE (prefetch) */
>   
>   /* New-style handshake (global) flags, sent from server to client, and
>      control what will happen during handshake phase. */
> @@ -195,7 +196,7 @@ enum {
>       NBD_CMD_DISC = 2,
>       NBD_CMD_FLUSH = 3,
>       NBD_CMD_TRIM = 4,
> -    /* 5 reserved for failed experiment NBD_CMD_CACHE */
> +    NBD_CMD_CACHE = 5,
>       NBD_CMD_WRITE_ZEROES = 6,
>       NBD_CMD_BLOCK_STATUS = 7,
>   };
> diff --git a/nbd/server.c b/nbd/server.c
> index 9e1f227178..30d7d3f444 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1134,7 +1134,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
>       int ret;
>       const uint16_t myflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TRIM |
>                                 NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA |
> -                              NBD_FLAG_SEND_WRITE_ZEROES);
> +                              NBD_FLAG_SEND_WRITE_ZEROES | NBD_FLAG_SEND_CACHE);
>       bool oldStyle;
>   
>       /* Old style negotiation header, no room for options
> @@ -1826,7 +1826,9 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
>           return -EIO;
>       }
>   
> -    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE) {
> +    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
> +        request->type == NBD_CMD_CACHE)
> +    {
>           if (request->len > NBD_MAX_BUFFER_SIZE) {
>               error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
>                          request->len, NBD_MAX_BUFFER_SIZE);
> @@ -1911,7 +1913,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
>       int ret;
>       NBDExport *exp = client->exp;
>   
> -    assert(request->type == NBD_CMD_READ);
> +    assert(request->type == NBD_CMD_READ || request->type == NBD_CMD_CACHE);
>   
>       /* XXX: NBD Protocol only documents use of FUA with WRITE */
>       if (request->flags & NBD_CMD_FLAG_FUA) {
> @@ -1930,7 +1932,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
>   
>       ret = blk_pread(exp->blk, request->from + exp->dev_offset, data,
>                       request->len);
> -    if (ret < 0) {
> +    if (ret < 0 || request->type == NBD_CMD_CACHE) {
>           return nbd_send_generic_reply(client, request->handle, ret,
>                                         "reading from file failed", errp);
>       }


-- 
Best regards,
Vladimir
