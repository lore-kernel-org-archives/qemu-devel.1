Received: from eggs.gnu.org ([2001:4830:134:3::10]:55490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0wqX-0006Sh-PM
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0wqX-0007i0-0W
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:13:37 -0400
References: <20180327210517.1804242-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de1ab785-e32b-80b2-93e3-631bb756a42d@redhat.com>
Date: Wed, 28 Mar 2018 00:13:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180327210517.1804242-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] nbd: Fix 32-bit compilation on
 BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 27/03/2018 23:05, Eric Blake wrote:
> iotests 123 and 209 fail on 32-bit platforms.  The culprit:
> sizeof(extent) is wrong; we want sizeof(*extent).  But since
> the struct is 8 bytes, it happened to work on 64-bit platforms
> where the pointer is also 8 bytes (nasty).
> 
> Fixes: 78a33ab58
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/nbd-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index e64e346d690..e7caf49fbb4 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -239,7 +239,7 @@ static int nbd_parse_blockstatus_payload(NBDClientSession *client,
>  {
>      uint32_t context_id;
> 
> -    if (chunk->length != sizeof(context_id) + sizeof(extent)) {
> +    if (chunk->length != sizeof(context_id) + sizeof(*extent)) {
>          error_setg(errp, "Protocol error: invalid payload for "
>                           "NBD_REPLY_TYPE_BLOCK_STATUS");
>          return -EINVAL;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
