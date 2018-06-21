Received: from eggs.gnu.org ([2001:4830:134:3::10]:43638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW7EW-0005d4-31
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW7EV-0006Fj-9x
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:35:12 -0400
References: <20180621124937.166549-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3f0ee8b0-3159-df19-8a74-c10f8e87ec62@redhat.com>
Date: Thu, 21 Jun 2018 17:35:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180621124937.166549-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Reject 0-length block status
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-stable@nongnu.org, qemu-block@nongnu.org



On 06/21/2018 08:49 AM, Eric Blake wrote:
> The NBD spec says that behavior is unspecified if the client
> requests 0 length for block status; but since the structured
> reply is documenting as returning a non-zero length, it's
> easier to just diagnose this with an EINVAL error than to
> figure out what to return.
> 

Relevant section:

REQUEST TYPES / NBD_CMD_BLOCK_STATUS (7)

"A block status query request. Length and offset define the range of
interest. The client SHOULD NOT request a status length of 0; the
behavior of a server on such a request is unspecified although the
server SHOULD NOT disconnect."

Leave a little breadcrumb in the commit message because it's headed to
-stable.

> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 9e1f2271784..493a926e063 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2007,6 +2007,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                        "discard failed", errp);
> 
>      case NBD_CMD_BLOCK_STATUS:
> +        if (!request->len) {
> +            return nbd_send_generic_reply(client, request->handle, -EINVAL,
> +                                          "need non-zero length", errp);
> +        }
>          if (client->export_meta.valid && client->export_meta.base_allocation) {
>              return nbd_co_send_block_status(client, request->handle,
>                                              blk_bs(exp->blk), request->from,
> 

Looks correct assuming spec agrees.

Reviewed-by: John Snow <jsnow@redhat.com>
