Received: from eggs.gnu.org ([2001:4830:134:3::10]:33618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLYUc-0005OW-RL
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLYUb-00010B-PO
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:28:10 -0400
References: <20180523030436.29097-1-famz@redhat.com>
	<20180523030436.29097-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2c6a98f-693b-8d60-3df5-fe0056c0b712@redhat.com>
Date: Wed, 23 May 2018 13:28:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180523030436.29097-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/10] raw: Check byte range uniformly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 05/22/2018 10:04 PM, Fam Zheng wrote:
> We don't verify the request range against s->size in the I/O callbacks
> except for raw_co_pwritev. This is wrong (especially for
> raw_co_pwrite_zeroes and raw_co_pdiscard), so fix them.

I'd also mention ...

> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block/raw-format.c | 64 +++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 39 insertions(+), 25 deletions(-)

Should this cc: qemu-stable?

Do we have iotests coverage of this?

> 
> diff --git a/block/raw-format.c b/block/raw-format.c
> index fe33693a2d..b69a0674b3 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -167,16 +167,37 @@ static void raw_reopen_abort(BDRVReopenState *state)
>       state->opaque = NULL;
>   }
>   
> +/* Check and adjust the offset, against 'offset' and 'size' options. */
> +static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
> +                                    uint64_t bytes, bool is_write)
> +{
> +    BDRVRawState *s = bs->opaque;
> +
> +    if (s->has_size && (*offset > s->size || bytes > (s->size - *offset))) {
> +        /* There's not enough space for the write, or the read request is
> +         * out-of-range. Don't read/write anything to prevent leaking out of
> +         * the size specified in options. */
> +        return is_write ? -ENOSPC : -EINVAL;;
> +    }
> +
> +    if (*offset > INT64_MAX - s->offset) {
> +        return -EINVAL;

...that this change to a 63-bit check...

> @@ -186,23 +207,11 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,

> -    if (offset > UINT64_MAX - s->offset) {
> -        ret = -EINVAL;
> -        goto fail;
> -    }

...from a previous 64-bit check is intentional.

With improved commit message, and ideally with followup commits that add 
iotest coverage,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
