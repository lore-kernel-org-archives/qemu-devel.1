Received: from eggs.gnu.org ([2001:4830:134:3::10]:43661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evoaP-00024w-2k
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evoaN-0005J0-Sa
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:23:45 -0400
References: <cover.1520952419.git.berto@igalia.com>
	<0b8f83b4f26071753dc409645ad8c6f6e215468a.1520952419.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <979d86bf-f1fa-4049-a811-94d6d8b9c667@redhat.com>
Date: Tue, 13 Mar 2018 13:23:36 -0500
MIME-Version: 1.0
In-Reply-To: <0b8f83b4f26071753dc409645ad8c6f6e215468a.1520952419.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: Give the refcount cache the
 minimum possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/13/2018 10:02 AM, Alberto Garcia wrote:
> The L2 and refcount caches have default sizes that can be overriden
> using the l2-cache-size and refcount-cache-size (an additional
> parameter named cache-size sets the combined size of both caches).
> 
> Unless forced by one of the aforementioned parameters, QEMU will set
> the unspecified sizes so that the L2 cache is 4 times larger than the
> refcount cache.
> 

> 
> However this patch takes a completely different approach and instead
> of keeping a ratio between both cache sizes it assigns as much as
> possible to the L2 cache and the remainder to the refcount cache.
> 
> The reason is that L2 tables are used for every single I/O request
> from the guest and the effect of increasing the cache is significant
> and clearly measurable. Refcount blocks are however only used for
> cluster allocation and internal snapshots and in practice are accessed
> sequentially in most cases, so the effect of increasing the cache is
> negligible (even when doing random writes from the guest).
> 
> So, make the refcount cache as small as possible unless the user
> explicitly asks for a larger one.

I like the reasoning given here.

I'd count this as a bugfix, safe even during freeze (but it's ultimately 
the maintainer's call)

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.c              | 31 +++++++++++++++++++------------
>   block/qcow2.h              |  4 ----
>   tests/qemu-iotests/137.out |  2 +-
>   3 files changed, 20 insertions(+), 17 deletions(-)

> +++ b/block/qcow2.c
> @@ -802,23 +802,30 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>           } else if (refcount_cache_size_set) {
>               *l2_cache_size = combined_cache_size - *refcount_cache_size;
>           } else {
> -            *refcount_cache_size = combined_cache_size
> -                                 / (DEFAULT_L2_REFCOUNT_SIZE_RATIO + 1);
> -            *l2_cache_size = combined_cache_size - *refcount_cache_size;

In the old code, refcount_cache_size and l2_cache_size are both set to 
fractions of the combined size, so both are positive (even if 
combined_cache_size is too small for the minimums required)

> +            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
> +            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
> +            uint64_t min_refcount_cache =
> +                (uint64_t) MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
> +
> +            /* Assign as much memory as possible to the L2 cache, and
> +             * use the remainder for the refcount cache */
> +            if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
> +                *l2_cache_size = max_l2_cache;
> +                *refcount_cache_size = combined_cache_size - *l2_cache_size;
> +            } else {
> +                *refcount_cache_size =
> +                    MIN(combined_cache_size, min_refcount_cache);

but here, if combined_cache_size is smaller than min_refcount_cache,

> +                *l2_cache_size = combined_cache_size - *refcount_cache_size;

then l2_cache_size is set to a negative value.

I think you're missing bounds validations that the combined cache size 
is large enough for the minimums required.  Or maybe a slight tweak, if 
it is okay for one of the two caches to be sized at 0 (that is, if 
combined_cache_size is too small for refcount, can it instead be given 
100% to the l2 cache and let refcount be uncached)?

> +            }
>           }
>       } else {
> -        if (!l2_cache_size_set && !refcount_cache_size_set) {
> +        if (!l2_cache_size_set) {
>               *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
>                                    (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
>                                    * s->cluster_size);
> -            *refcount_cache_size = *l2_cache_size
> -                                 / DEFAULT_L2_REFCOUNT_SIZE_RATIO;
> -        } else if (!l2_cache_size_set) {
> -            *l2_cache_size = *refcount_cache_size
> -                           * DEFAULT_L2_REFCOUNT_SIZE_RATIO;
> -        } else if (!refcount_cache_size_set) {
> -            *refcount_cache_size = *l2_cache_size
> -                                 / DEFAULT_L2_REFCOUNT_SIZE_RATIO;
> +        }
> +        if (!refcount_cache_size_set) {
> +            *refcount_cache_size = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
>           }
>       }
>   
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
