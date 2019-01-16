Received: from eggs.gnu.org ([209.51.188.92]:50714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjld8-0005JR-23
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjld7-0007JY-7h
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:53:17 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190108170655.29766-7-vsementsov@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
	<20190108170655.29766-7-vsementsov@virtuozzo.com>
Date: Wed, 16 Jan 2019 14:53:13 +0100
Message-ID: <w51sgxswvxy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 6/9] qcow2: qcow2_co_preadv: improve
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, den@openvz.org, pbonzini@redhat.com

On Tue 08 Jan 2019 06:06:52 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> @@ -1891,39 +1892,38 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>          qemu_iovec_reset(&hd_qiov);
>          qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
>  
> +        if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
> +            ret == QCOW2_CLUSTER_ZERO_ALLOC ||
> +            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
> +        {
> +            /* No sense in releasing the lock */
> +
> +            qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
> +
> +            bytes -= cur_bytes;
> +            offset += cur_bytes;
> +            bytes_done += cur_bytes;
> +            continue;
> +        }

Maybe that was just me, but I got confused by the "No sense in releasing
the lock" thinking that it referred to the memset() call.

What you're trying to say is that it doesn't make sense to release the
lock while you only get zero / unallocated clusters only to lock it
again at the next iteration of the loop.

I think that comment may make sense when you think about the code
changes that you are doing, but when you read the actual resulting code
it's fairly obvious that you don't need to touch the lock there.

So I'd rather remove that comment.

Else the patch looks good.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
