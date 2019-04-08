Received: from eggs.gnu.org ([209.51.188.92]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDWNS-0003xq-ES
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDWNO-00024X-3t
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:40:06 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Mon, 08 Apr 2019 17:39:54 +0200
Message-ID: <w511s2cy08l.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On Fri 05 Apr 2019 06:56:19 PM CEST, Andrey Shinkevich wrote:
> @@ -232,8 +232,13 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>      StreamBlockJob *s;
>      BlockDriverState *iter;
>      bool bs_read_only;
> +    BlockDriverState *bottom = NULL;
> +    int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
> +
> +    /* Find the bottom node that has the base as its backing image */
> +    bottom = bdrv_find_overlay(bs, base);

What happens if bs == base here ??

> +    /*
> +     * Block all intermediate nodes between bs and bottom (inclusive), because
> +     * they will disappear from the chain after this operation. The streaming
> +     * job reads every block only once, assuming that it doesn't change, so
> +     * forbid writes and resizes.
> +     */
> +    for (iter = bs; iter != bottom; iter = backing_bs(iter)) {
> +        block_job_add_bdrv(&s->common, "intermediate node", backing_bs(iter),
> +                           0, basic_flags, &error_abort);
>      }

This stops when iter == bottom, so bottom is not actually blocked.

> diff --git a/block/trace-events b/block/trace-events
> index 7335a42..5366d45 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -20,7 +20,7 @@ bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_of
>  
>  # stream.c
>  stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
> -stream_start(void *bs, void *base, void *s) "bs %p base %p s %p"
> +stream_start(void *bs, void *bottom, void *s) "bs %p bottom %p s %p"

Is this change still correct? We don't pass bottom anymore.

Berto
