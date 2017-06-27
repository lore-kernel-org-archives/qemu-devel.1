Received: from eggs.gnu.org ([2001:4830:134:3::10]:38998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPlS6-0005Hs-F1
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPlS5-0007Fi-4c
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:02:26 -0400
Date: Tue, 27 Jun 2017 16:02:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170627080210.GB14166@lemon.lan>
References: <1496649172-26982-1-git-send-email-ashijeetacharya@gmail.com>
	<1496649172-26982-7-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496649172-26982-7-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 6/8] vmdk: New functions to assist
 allocating multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 06/05 13:22, Ashijeet Acharya wrote:
> +/*
> + * vmdk_handle_alloc
> + *
> + * Allocate new clusters for an area that either is yet unallocated or needs a
> + * copy on write. If *cluster_offset is non_zero, clusters are only allocated if
> + * the new allocation can match the specified host offset.

I don't think this matches the function body, the passed in *cluster_offset
value is ignored.

> + *
> + * Returns:
> + *   VMDK_OK:       if new clusters were allocated, *bytes may be decreased if
> + *                  the new allocation doesn't cover all of the requested area.
> + *                  *cluster_offset is updated to contain the offset of the
> + *                  first newly allocated cluster.
> + *
> + *   VMDK_UNALLOC:  if no clusters could be allocated. *cluster_offset is left
> + *                  unchanged.
> + *
> + *   VMDK_ERROR:    in error cases
> + */
> +static int vmdk_handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
> +                             uint64_t offset, uint64_t *cluster_offset,
> +                             int64_t *bytes, VmdkMetaData *m_data,
> +                             bool allocate, uint32_t *alloc_clusters_counter)
> +{
> +    int l1_index, l2_offset, l2_index;
> +    uint32_t *l2_table;
> +    uint32_t cluster_sector;
> +    uint32_t nb_clusters;
> +    bool zeroed = false;
> +    uint64_t skip_start_bytes, skip_end_bytes;
> +    int ret;
> +
> +    ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
> +                            &l2_index, &l2_table);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    cluster_sector = le32_to_cpu(l2_table[l2_index]);
> +
> +    skip_start_bytes = vmdk_find_offset_in_cluster(extent, offset);
> +    /* Calculate the number of clusters to look for. Here we truncate the last
> +     * cluster, i.e. 1 less than the actual value calculated as we may need to
> +     * perform COW for the last one. */
> +    nb_clusters = DIV_ROUND_UP(skip_start_bytes + *bytes,
> +                               extent->cluster_sectors << BDRV_SECTOR_BITS) - 1;
> +
> +    nb_clusters = MIN(nb_clusters, extent->l2_size - l2_index);
> +    assert(nb_clusters <= INT_MAX);
> +
> +    /* update bytes according to final nb_clusters value */
> +    if (nb_clusters != 0) {
> +        *bytes = ((nb_clusters * extent->cluster_sectors) << BDRV_SECTOR_BITS)
> +                 - skip_start_bytes;
> +    } else {
> +        nb_clusters = 1;
> +    }
> +    *alloc_clusters_counter += nb_clusters;
> +    skip_end_bytes = skip_start_bytes + MIN(*bytes,
> +                     extent->cluster_sectors * BDRV_SECTOR_SIZE
> +                                    - skip_start_bytes);

I don't understand the MIN part, shouldn't skip_end_bytes simply be
skip_start_bytes + *bytes?

> +
> +    if (extent->has_zero_grain && cluster_sector == VMDK_GTE_ZEROED) {
> +        zeroed = true;
> +    }
> +
> +    if (!cluster_sector || zeroed) {
> +        if (!allocate) {
> +            return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
> +        }
> +
> +        cluster_sector = extent->next_cluster_sector;
> +        extent->next_cluster_sector += extent->cluster_sectors
> +                                                * nb_clusters;
> +
> +        ret = vmdk_perform_cow(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
> +                               offset, skip_start_bytes,
> +                               skip_end_bytes);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        if (m_data) {
> +            m_data->valid = 1;
> +            m_data->l1_index = l1_index;
> +            m_data->l2_index = l2_index;
> +            m_data->l2_offset = l2_offset;
> +            m_data->l2_cache_entry = &l2_table[l2_index];
> +            m_data->nb_clusters = nb_clusters;
> +        }
> +    }
> +    *cluster_offset = cluster_sector << BDRV_SECTOR_BITS;
> +    return VMDK_OK;
> +}
> +
> +/*
> + * vmdk_alloc_clusters
> + *
> + * For a given offset on the virtual disk, find the cluster offset in vmdk
> + * file. If the offset is not found, allocate a new cluster.
> + *
> + * If the cluster is newly allocated, m_data->nb_clusters is set to the number
> + * of contiguous clusters that have been allocated. In this case, the other
> + * fields of m_data are valid and contain information about the first allocated
> + * cluster.
> + *
> + * Returns:
> + *
> + *   VMDK_OK:           on success and @cluster_offset was set
> + *
> + *   VMDK_UNALLOC:      if no clusters were allocated and @cluster_offset is
> + *                      set to zero
> + *
> + *   VMDK_ERROR:        in error cases
> + */
> +static int vmdk_alloc_clusters(BlockDriverState *bs,
> +                               VmdkExtent *extent,
> +                               VmdkMetaData *m_data, uint64_t offset,
> +                               bool allocate, uint64_t *cluster_offset,
> +                               int64_t bytes,
> +                               uint32_t *total_alloc_clusters)
> +{
> +    uint64_t start, remaining;
> +    uint64_t new_cluster_offset;
> +    int64_t n_bytes;
> +    int ret;
> +
> +    if (extent->flat) {
> +        *cluster_offset = extent->flat_start_offset;
> +        return VMDK_OK;
> +    }
> +
> +    start = offset;
> +    remaining = bytes;
> +    new_cluster_offset = 0;
> +    *cluster_offset = 0;
> +    n_bytes = 0;
> +    if (m_data) {
> +        m_data->valid = 0;
> +    }
> +
> +    /* due to L2 table margins all bytes may not get allocated at once */
> +    while (true) {
> +
> +        if (!*cluster_offset) {
> +            *cluster_offset = new_cluster_offset;
> +        }
> +
> +        start              += n_bytes;
> +        remaining          -= n_bytes;
> +        new_cluster_offset += n_bytes;

Like said above, even though you increment new_cluster_offset by n_bytes, it has
no effect inside vmdk_handle_alloc. Is this intended?

> +
> +        if (remaining == 0) {
> +            break;
> +        }
> +
> +        n_bytes = remaining;
> +
> +        ret = vmdk_handle_alloc(bs, extent, start, &new_cluster_offset, &n_bytes,
> +                                m_data, allocate, total_alloc_clusters);
> +
> +        if (ret < 0) {
> +            return ret;
> +
> +        }
> +    }
> +
> +    return VMDK_OK;
> +}
> +
>  /**
>   * vmdk_get_cluster_offset
>   *
> @@ -1625,6 +1794,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>      uint64_t bytes_done = 0;
>      VmdkMetaData m_data;
>      uint64_t extent_end;
> +    uint32_t total_alloc_clusters = 0;
>  
>      if (DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) > bs->total_sectors) {
>          error_report("Wrong offset: offset=0x%" PRIx64
> @@ -1650,10 +1820,10 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>              n_bytes = MIN(bytes, extent_end - offset);
>          }
>  
> -        ret = vmdk_get_cluster_offset(bs, extent, &m_data, offset,
> -                                      !(extent->compressed || zeroed),
> -                                      &cluster_offset, offset_in_cluster,
> -                                      offset_in_cluster + n_bytes);
> +        ret = vmdk_alloc_clusters(bs, extent, &m_data, offset,
> +                                  !(extent->compressed || zeroed),
> +                                  &cluster_offset, n_bytes,
> +                                  &total_alloc_clusters);
>          if (extent->compressed) {
>              if (ret == VMDK_OK) {
>                  /* Refuse write to allocated cluster for streamOptimized */
> @@ -1662,8 +1832,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>                  return -EIO;
>              } else {
>                  /* allocate */
> -                ret = vmdk_get_cluster_offset(bs, extent, &m_data, offset,
> -                                              true, &cluster_offset, 0, 0);
> +                ret = vmdk_alloc_clusters(bs, extent, &m_data, offset,
> +                                          true, &cluster_offset, n_bytes,
> +                                          &total_alloc_clusters);
>              }
>          }
>          if (ret == VMDK_ERROR) {
> @@ -1671,10 +1842,11 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>          }
>          if (zeroed) {
>              /* Do zeroed write, buf is ignored */
> -            if (extent->has_zero_grain &&
> -                    offset_in_cluster == 0 &&
> -                    n_bytes >= extent->cluster_sectors * BDRV_SECTOR_SIZE) {
> -                n_bytes = extent->cluster_sectors * BDRV_SECTOR_SIZE;
> +            if (extent->has_zero_grain && offset_in_cluster == 0 &&
> +                    n_bytes >= extent->cluster_sectors * BDRV_SECTOR_SIZE *
> +                        total_alloc_clusters) {
> +                n_bytes = extent->cluster_sectors * BDRV_SECTOR_SIZE *
> +                                        total_alloc_clusters;
>                  if (!zero_dry_run) {
>                      /* update L2 tables */
>                      if (vmdk_L2update(extent, &m_data, VMDK_GTE_ZEROED)
> -- 
> 2.6.2
> 

Fam
