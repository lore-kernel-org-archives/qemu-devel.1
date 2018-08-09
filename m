Received: from eggs.gnu.org ([2001:4830:134:3::10]:35271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnjql-00067R-Mp
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnjqg-00005V-Hv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:15:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180808221138.5770-3-lbloch@janustech.com>
References: <20180808221138.5770-1-lbloch@janustech.com>
	<20180808221138.5770-3-lbloch@janustech.com>
Date: Thu, 09 Aug 2018 14:14:47 +0200
Message-ID: <w51r2j7butk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2: Assign the L2 cache
 relatively to image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 12:11:35 AM CEST, Leonid Bloch wrote:
> Sufficient L2 cache can noticeably improve the performance when using
> large images with frequent I/O. The memory overhead is not significant
> in most cases, as the cache size is only 1 MB for each 8 GB of virtual
> image size (with the default cluster size of 64 KB).
>
> Previously, the L2 cache was allocated without considering the image
> size, and an option existed to manually determine this size. Thus to
> achieve full coverage of the image by the L2 cache (i.e. use more than
> the default value of MAX(1 MB, 8 clusters)), a user needed to calculate
> the required size manually or using a script, and passs this value to
> the 'l2-cache-size' option.

s/passs/pass/

> diff --git a/block/qcow2.c b/block/qcow2.c
> index ec9e6238a0..98cb96aaca 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -777,29 +777,35 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>                               uint64_t *refcount_cache_size, Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
> -    uint64_t combined_cache_size;
> +    uint64_t combined_cache_size, l2_cache_max_setting;
>      bool l2_cache_size_set, refcount_cache_size_set, combined_cache_size_set;
> -    int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
> +    uint64_t min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;

Why do you need to change this data type here? min_refcount_cache is
guaranteed to fit in an int.

> +    uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
> +    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
> +    *l2_cache_size = MIN(max_l2_cache, l2_cache_max_setting);
> +

You need to declare virtual_disk_size and max_l2_cache at the beginning.

>              } else {
> -                *refcount_cache_size =
> -                    MIN(combined_cache_size, min_refcount_cache);
> +                *refcount_cache_size = MIN(combined_cache_size,
> +                                           min_refcount_cache);

There are no functional changes, why do you need to change the
indentation here?

> -    } else {
> -        if (!l2_cache_size_set) {
> -            *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
> -                                 (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
> -                                 * s->cluster_size);
> -        }
> -        if (!refcount_cache_size_set) {
> -            *refcount_cache_size = min_refcount_cache;
> -        }
>      }

It's not obvious why you are removing the *refcount_cache_size
assignment here. I see that if you leave this out then the caller
qcow2_update_options_prepare() ensures that refcount_cache_size has the
minimum size, but that's not directly related to the rest of the changes
in this patch.

So either mention in explicitly in the commit message or remove those
lines in a separate patch.

> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 5bf2a8ad29..c7625cdeb3 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -97,12 +97,14 @@ need:
>     l2_cache_size = disk_size_GB * 131072
>     refcount_cache_size = disk_size_GB * 32768
>  
> -QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
> -cache of 256KB (262144 bytes), so using the formulas we've just seen
> -we have
> +QEMU will use a default L2 cache sufficient to cover the entire virtual
> +size of an image, which with the default cluster size will result in 1 MB
> +of cache for every 8 GB of virtual image size:

This is not true. QEMU will use a default size of 32MB, which may or may
not cover the entire image.

> -   1048576 / 131072 = 8 GB of virtual disk covered by that cache
> -    262144 /  32768 = 8 GB
> +   65536 / 8 = 8192 = 8 GB / 1 MB

And those formulas still apply, but with the new values.

> + - The default L2 cache size will cover the entire virtual size of an
> +   image, but is capped at 32 MB (enough for image sizes of up to 256 GB
> +   with the default cluster size).

Again, this is misleading. A constant in this series is that "The L2
cache now covers the entire image", but that's not the case at all :-)

I would prefer if you would say "we increased the default cache size so
now we cover larger images" instead of "the default cache size will now
cover the entire image", because the latter is not true.

>   - If the L2 cache is big enough to hold all of the image's L2 tables
> -   (as explained in the "Choosing the right cache sizes" section
> -   earlier in this document) then none of this is necessary and you
> -   can omit the "l2-cache-entry-size" parameter altogether.
> +   (the default behavior) then none of this is necessary and you can
> +   omit the "l2-cache-entry-size" parameter altogether.

And once more. In the previous paragraph you say that the default is
enough for images <= 256GB, and in this one you say that it's enough to
hold all L2 tables.

The previous text was accurate, you don't need to change this paragraph.

Berto
