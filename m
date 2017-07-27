Received: from eggs.gnu.org ([2001:4830:134:3::10]:38385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1daiE2-0000GN-3V
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1daiE1-0002YS-BU
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:49:10 -0400
Date: Thu, 27 Jul 2017 20:48:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170727124859.GK5117@lemon.lan>
References: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
	<1498728221-23979-7-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498728221-23979-7-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 6/8] vmdk: New functions to assist
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

On Thu, 06/29 14:53, Ashijeet Acharya wrote:
> +/*
> + * vmdk_handle_alloc
> + *
> + * Allocate new clusters for an area that either is yet unallocated or needs a
> + * copy on write.
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
> +                             bool allocate, uint32_t *total_alloc_clusters)

This was renamed "alloc_clusters_counter" in v6, looks like somehow you reverted
the change to v5.

> +{
> +    int l1_index, l2_offset, l2_index;
> +    uint32_t *l2_table;
> +    uint32_t cluster_sector;
> +    uint32_t nb_clusters;
> +    bool zeroed = false;
> +    uint64_t skip_start_bytes, skip_end_bytes;
> +    int ret;

Fam
