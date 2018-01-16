Received: from eggs.gnu.org ([2001:4830:134:3::10]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebUVv-0007mv-Nr
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebUVp-0005sR-QM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:55:07 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<1fb1816d471d712f2001ca3ce42c6682273c7daf.1513342045.git.berto@igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <aa9e5a1b-56f5-d34b-d2e4-1f4496de09ea@virtuozzo.com>
Date: Tue, 16 Jan 2018 19:54:45 +0300
MIME-Version: 1.0
In-Reply-To: <1fb1816d471d712f2001ca3ce42c6682273c7daf.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 25/32] qcow2: Update
 expand_zero_clusters_in_l1() to support L2 slices
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
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 8f7a04ba7d..ab840a449f 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
[..]
> @@ -1907,124 +1911,133 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
>               goto fail;
>           }
>   
> -        if (is_active_l1) {
> -            /* get active L2 tables from cache */
> -            ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
> -                    (void **)&l2_table);
> -        } else {
> -            /* load inactive L2 tables from disk */
> -            ret = bdrv_read(bs->file, l2_offset / BDRV_SECTOR_SIZE,
> -                            (void *)l2_table, s->cluster_sectors);
> -        }
> -        if (ret < 0) {
> -            goto fail;
> -        }
> -
>           ret = qcow2_get_refcount(bs, l2_offset >> s->cluster_bits,
>                                    &l2_refcount);
>           if (ret < 0) {
>               goto fail;
>           }
>   
> -        for (j = 0; j < s->l2_size; j++) {
> -            uint64_t l2_entry = be64_to_cpu(l2_table[j]);
> -            int64_t offset = l2_entry & L2E_OFFSET_MASK;
> -            QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
> -
> -            if (cluster_type != QCOW2_CLUSTER_ZERO_PLAIN &&
> -                cluster_type != QCOW2_CLUSTER_ZERO_ALLOC) {
> -                continue;
> +        for (slice = 0; slice < n_slices; slice++) {
> +            uint64_t slice_offset = l2_offset + slice * slice_size;

Seems like 'bool l2_dirty = false;' needs to be moved here.
