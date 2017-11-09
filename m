Received: from eggs.gnu.org ([2001:4830:134:3::10]:49164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCjHp-0000Z3-Ju
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCjHj-0007yk-Ns
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:38:13 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <22a7af7d-6ce4-c73d-1559-58a30ba2115d@virtuozzo.com>
Date: Thu, 9 Nov 2017 12:37:51 +0300
MIME-Version: 1.0
In-Reply-To: <20171108215703.9295-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 6/7] nbd-client: Stricter enforcing of
 structured reply spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

09.11.2017 00:57, Eric Blake wrote:
> Ensure that the server is not sending unexpected chunk lengths
> for either the NONE or the OFFSET_DATA chunk, nor unexpected
> hole length for OFFSET_HOLE.  This will flag any server that
> responds to a zero-length read with an OFFSET_DATA as broken,

or OFFSET_HOLE

> even though we previously fixed our client to never be able to
> send such a request over the wire.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/nbd-client.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 0a675d0fab..73c9fe0905 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -216,7 +216,7 @@ static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
>       offset = payload_advance64(&payload);
>       hole_size = payload_advance32(&payload);
>
> -    if (offset < orig_offset || hole_size > qiov->size ||
> +    if (!hole_size || offset < orig_offset || hole_size > qiov->size ||
>           offset > orig_offset + qiov->size - hole_size) {
>           error_setg(errp, "Protocol error: server sent chunk exceeding requested"
>                            " region");
> @@ -281,7 +281,8 @@ static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
>
>       assert(nbd_reply_is_structured(&s->reply));
>
> -    if (chunk->length < sizeof(offset)) {
> +    /* The NBD spec requires at least one byte of payload */
> +    if (chunk->length <= sizeof(offset)) {
>           error_setg(errp, "Protocol error: invalid payload for "
>                            "NBD_REPLY_TYPE_OFFSET_DATA");
>           return -EINVAL;
> @@ -293,7 +294,7 @@ static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
>       be64_to_cpus(&offset);
>
>       data_size = chunk->length - sizeof(offset);
> -    if (offset < orig_offset || data_size > qiov->size ||
> +    if (!data_size || offset < orig_offset || data_size > qiov->size ||

!data_size - always false here (because of previous check), and even if it could be zero it
isn't correspond to error message.

without this, or with an assert instead:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


>           offset > orig_offset + qiov->size - data_size) {
>           error_setg(errp, "Protocol error: server sent chunk exceeding requested"
>                            " region");
> @@ -411,6 +412,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
>                          " NBD_REPLY_FLAG_DONE flag set");
>               return -EINVAL;
>           }
> +        if (chunk->length) {
> +            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk with"
> +                       " nonzero length");
> +            return -EINVAL;
> +        }
>           return 0;
>       }
>


-- 
Best regards,
Vladimir
