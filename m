Received: from eggs.gnu.org ([2001:4830:134:3::10]:57745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0pF1-0007YN-BS
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0pEg-0004zu-IZ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:01:51 -0400
Date: Wed, 19 Apr 2017 21:00:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170419130044.GB12781@lemon.lan>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-6-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491057878-27868-6-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/6] vmdk: Set maximum bytes allocated
 in one cycle
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

On Sat, 04/01 20:14, Ashijeet Acharya wrote:
> Set the maximum bytes allowed to get allocated at once to be not more
> than the extent size boundary to handle writes at two separate extents
> appropriately.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  block/vmdk.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index a8babd7..9456ddd 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1767,6 +1767,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>      int64_t offset_in_cluster, n_bytes;
>      uint64_t cluster_offset;
>      uint64_t bytes_done = 0;
> +    uint64_t extent_size;
>      VmdkMetaData m_data;
>      uint32_t total_alloc_clusters = 0;
>  
> @@ -1782,9 +1783,17 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>          if (!extent) {
>              return -EIO;
>          }
> +        extent_size = extent->end_sector * BDRV_SECTOR_SIZE;

Maybe extent_end to be more accurate?

> +
>          offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
> -        n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
> -                             - offset_in_cluster);
> +
> +        /* truncate n_bytes to first cluster because we need to perform COW */

Makes sense, but shouldn't this be squashed into patch patch 3? Because it looks
like it is fixing an intermediate bug.

> +        if (offset_in_cluster > 0) {
> +            n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
> +                                 - offset_in_cluster);
> +        } else {
> +            n_bytes = MIN(bytes, extent_size - offset);
> +        }
>  
>          ret = vmdk_alloc_cluster_offset(bs, extent, &m_data, offset,
>                                          !(extent->compressed || zeroed),
> -- 
> 2.6.2
> 

Fam
