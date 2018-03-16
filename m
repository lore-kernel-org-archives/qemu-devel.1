Received: from eggs.gnu.org ([2001:4830:134:3::10]:55387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewpsu-00076n-SU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewpsr-0001Hq-RP
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:59:04 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1520849818-6915-9-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1520849818-6915-9-git-send-email-anton.nefedov@virtuozzo.com>
Date: Fri, 16 Mar 2018 14:58:58 +0100
Message-ID: <w51d104p1el.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 8/9] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Mon 12 Mar 2018 11:16:57 AM CET, Anton Nefedov wrote:
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2584,6 +2584,8 @@
>  #
>  # @cor_write: a write due to copy-on-read (since 2.11)
>  #
> +# @cluster_alloc_space: an allocation of a cluster file space (since 2.12)

That doesn't sound like correct English to me.

> +static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t bytes)
> +{
> +    int64_t nr;
> +    return !bytes ||
> +        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr == bytes);
> +}
> +

Is this really more efficient than the previous is_zero() call ?

It seems that in both cases the code ends up calling
bdrv_common_block_status_above().

> +static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
> +{
> +    /* content with false negatives, giving is_allocated() is faster than
> +     * a proper zero detection with possible actual image seeks, which is
> +     * performed by is_zero() */

It took me a bit to understand this sentence, maybe some native English
speaker can suggest an alternate wording?

  "is_allocated() is not as accurate as is_zero() and can give us some
   false negatives, but it is much more efficient so let's use it here"

> +    return is_unallocated(bs, m->offset + m->cow_start.offset,
> +                          m->cow_start.nb_bytes) &&
> +           is_unallocated(bs, m->offset + m->cow_end.offset,
> +                          m->cow_end.nb_bytes);
> +}

Berto
