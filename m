Received: from eggs.gnu.org ([2001:4830:134:3::10]:55182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebUYH-0000rV-Mo
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebUYG-0007Y6-Tl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:57:33 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <67060769-70fc-e6d4-673c-81f1382fe735@virtuozzo.com>
Date: Tue, 16 Jan 2018 19:57:22 +0300
MIME-Version: 1.0
In-Reply-To: <8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 31/32] qcow2: Allow configuring the L2
 slice size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 15/12/2017 3:53 PM, Alberto Garcia wrote:
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index 2fcecbd7a8..fe58d1ec70 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
[..]
> @@ -879,9 +896,13 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
>           }
>       }
>   
> -    r->l2_slice_size = s->cluster_size / sizeof(uint64_t);
> -    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size);
> -    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size);
> +    l2_cache_size *= s->cluster_size / l2_cache_entry_size;
> +

A bit confusing; l2_cache_size first means the size in bytes, then the
size in clusters and now the size in entries.

Maybe in the comparison with MIN_L2_CACHE_SIZE, we should multiply
MIN_L2_CACHE_SIZE to cluster_size instead.
And perhaps MIN_L2_CACHE_CLUSTERS is a better name. Or should it even be
MIN_L2_CACHE_ENTRIES instead, taking into account its motivation to make
it possible to handle COW.

Also, I guess the final size-in-entries needs to be compared with
INT_MAX, not the size-in-clusters.

> +    r->l2_slice_size = l2_cache_entry_size / sizeof(uint64_t);
> +    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size,
> +                                           l2_cache_entry_size);

my gcc thinks l2_cache_entry_size may be used uninitialized here.
can't quite see how that may happen though..
