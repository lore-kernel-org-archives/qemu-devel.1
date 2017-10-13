Received: from eggs.gnu.org ([2001:4830:134:3::10]:41393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2zSL-000274-Oj
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 08:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2zSJ-00082O-3G
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 08:52:49 -0400
Date: Fri, 13 Oct 2017 14:52:43 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20171013125243.GA15500@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
	<65c2b2b32a686d3084a1579583334a85b706edcb.1507813391.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c2b2b32a686d3084a1579583334a85b706edcb.1507813391.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 18/31] qcow2: Update
 qcow2_get_cluster_offset() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

On Thu, Oct 12, 2017 at 04:05:32PM +0300, Alberto Garcia wrote:
> @@ -522,8 +522,8 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>  {
>      BDRVQcow2State *s = bs->opaque;
>      unsigned int l2_index;
> -    uint64_t l1_index, l2_offset, *l2_table;
> -    int l1_bits, c;
> +    uint64_t l1_index, l2_offset, *l2_slice;
> +    int c;
>      unsigned int offset_in_cluster;
>      uint64_t bytes_available, bytes_needed, nb_clusters;
>      QCow2ClusterType type;
> @@ -532,12 +532,11 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>      offset_in_cluster = offset_into_cluster(s, offset);
>      bytes_needed = (uint64_t) *bytes + offset_in_cluster;
>  
> -    l1_bits = s->l2_bits + s->cluster_bits;
> -
>      /* compute how many bytes there are between the start of the cluster
> -     * containing offset and the end of the l1 entry */
> -    bytes_available = (1ULL << l1_bits) - (offset & ((1ULL << l1_bits) - 1))
> -                    + offset_in_cluster;
> +     * containing offset and the end of the l2 slice that contains
> +     * the entry pointing to it */
> +    bytes_available = (s->l2_slice_size - offset_to_l2_slice_index(s, offset))
> +        << s->cluster_bits;

There's a mistake here, this should be cast to uint64_t before doing
the shift, else it overflows if the cluster size is large:

    bytes_available =
        ((uint64_t) (s->l2_slice_size - offset_to_l2_slice_index(s, offset)))
        << s->cluster_bits;

The next revision will have this correction, but I'm not sending it
now, so if you want to test/review this one please go ahead.

Berto
