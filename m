Received: from eggs.gnu.org ([2001:4830:134:3::10]:58195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhyfq-0003Re-D4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhyfp-0004RX-J8
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:52:26 -0400
References: <20180724121753.5753-1-lbloch@janustech.com>
	<20180724121753.5753-2-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8966138a-1663-fdcf-e49e-df7e9c802c3e@redhat.com>
Date: Tue, 24 Jul 2018 09:52:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180724121753.5753-2-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

On 07/24/2018 07:17 AM, Leonid Bloch wrote:
> An option "l2-cache-full" is introduced to automatically set the qcow2
> L2 cache to a sufficient value for covering the entire image. The memory
> overhead when using this option is not big (1 MB for each 8 GB of
> virtual image size with the default cluster size) and it can noticeably
> improve performance when using large images with frequent I/O.
> Previously, for this functionality the correct L2 cache size needed to
> be calculated manually or with a script, and then this size needed to be
> passed to the "l2-cache-size" option. Now it is sufficient to just pass
> the boolean "l2-cache-full" option.
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---

> @@ -793,15 +800,32 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>       *l2_cache_entry_size = qemu_opt_get_size(
>           opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
>   
> +    uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
> +    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
> +
> +    if (l2_cache_size_set && l2_cache_full_set) {
> +        error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " and "
> +                   QCOW2_OPT_L2_CACHE_FULL " may not be set at the same time");
> +        return;
> +    } else if (l2_cache_full_set) {
> +        *l2_cache_size = max_l2_cache;
> +    }

Since this makes the options mutually exclusive...

> +++ b/qapi/block-core.json
> @@ -2814,6 +2814,9 @@
>   # @l2-cache-size:         the maximum size of the L2 table cache in
>   #                         bytes (since 2.2)
>   #
> +# @l2-cache-full:         make the L2 table cache large enough to cover the
> +#                         entire image (since 3.1)
> +#

...you should probably document that fact here.

> +++ b/qemu-options.hx
> @@ -758,6 +758,10 @@ The maximum total size of the L2 table and refcount block caches in bytes
>   The maximum size of the L2 table cache in bytes
>   (default: 4/5 of the total cache size)
>   
> +@item l2-cache-full
> +Make the L2 table cache large enough to cover the entire image
> +(on/off; default: off)

Likewise.

> +
>   @item refcount-cache-size
>   The maximum size of the refcount block cache in bytes
>   (default: 1/5 of the total cache size)

Alberto, looks like we missed this documentation in your changes to the 
defaults.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
