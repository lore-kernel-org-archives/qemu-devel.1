Received: from eggs.gnu.org ([2001:4830:134:3::10]:35781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMGF6-0004Lp-Hj
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMGF5-0005kA-A7
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:11:04 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMGF5-0005jg-1B
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:11:03 -0400
Received: by mail-oi0-x243.google.com with SMTP id l1-v6so5189804oii.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 10:11:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515154033.19899-21-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
	<20180515154033.19899-21-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 18:10:41 +0100
Message-ID: <CAFEAcA-FhMC0LqkYcRh3fV864wNSAJnHbT3657Y55MN9=RO72Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 20/37] qcow2: Give the refcount cache the
 minimum possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 May 2018 at 16:40, Kevin Wolf <kwolf@redhat.com> wrote:
> From: Alberto Garcia <berto@igalia.com>
>
> The L2 and refcount caches have default sizes that can be overridden
> using the l2-cache-size and refcount-cache-size (an additional
> parameter named cache-size sets the combined size of both caches).

Hi; Coverity raises a nit about this patch (CID 1391229):


> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2f36e632f9..6d532470a8 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -802,23 +802,30 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>          } else if (refcount_cache_size_set) {
>              *l2_cache_size = combined_cache_size - *refcount_cache_size;
>          } else {
> -            *refcount_cache_size = combined_cache_size
> -                                 / (DEFAULT_L2_REFCOUNT_SIZE_RATIO + 1);
> -            *l2_cache_size = combined_cache_size - *refcount_cache_size;
> +            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
> +            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
> +            uint64_t min_refcount_cache =
> +                (uint64_t) MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;

Here we have a (uint64_t) cast that ensures we're doing a 64x64 multiply
rather than a 32x32 one...

> +
> +            /* Assign as much memory as possible to the L2 cache, and
> +             * use the remainder for the refcount cache */
> +            if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
> +                *l2_cache_size = max_l2_cache;
> +                *refcount_cache_size = combined_cache_size - *l2_cache_size;
> +            } else {
> +                *refcount_cache_size =
> +                    MIN(combined_cache_size, min_refcount_cache);
> +                *l2_cache_size = combined_cache_size - *refcount_cache_size;
> +            }
>          }
>      } else {
> -        if (!l2_cache_size_set && !refcount_cache_size_set) {
> +        if (!l2_cache_size_set) {
>              *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
>                                   (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
>                                   * s->cluster_size);
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

...but in the else clause down here, we don't have the cast, and
Coverity complains that we evaluate a 32-bit result and then
put it in a 64-bit variable. Should this have the (uint64_t)
cast as well ?

>          }
>      }
>

thanks
-- PMM
