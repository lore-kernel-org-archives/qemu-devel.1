Received: from eggs.gnu.org ([2001:4830:134:3::10]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cv45k-0002sb-1X
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cv45f-0001cR-3Q
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:40:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cv45e-0001bS-R0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:40:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B48967709
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 15:40:20 +0000 (UTC)
Date: Mon, 3 Apr 2017 09:40:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170403094015.57368766@t450s.home>
In-Reply-To: <20170403085822.13863-1-slp@redhat.com>
References: <20170403085822.13863-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio: If DMA map returns ENOMEM wait and
 try again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon,  3 Apr 2017 10:58:22 +0200
Sergio Lopez <slp@redhat.com> wrote:

> When quickly unmapping and mapping memory regions (as may happen in
> address_space_update_topology), if running with a non-unlimited
> RLIMIT_MEMLOCK, the kernel may return ENOMEM for a map request
> because the previous unmap has been processed, but accounted yet.
> 
> Probably this should be fixed in the kernel ensuring a deterministic
> behavior for VFIO map and unmap operations. Until then, this works
> around the issue, waiting 10ms and trying again.

I think we need to know what that kernel fix is before adding arbitrary
delays and retries in userspace code (Do we know why 10ms works?  Is
it too long/short?).  I think I have a test program that reproduces
this, I setup vfio and allocate two 4k buffers, one for mapping through
vfio and one for mlocking.  I clone(2) the process with CLONE_VM and the
clone loops doing mlock/munlock while the main thread does map/unmap.
This fails in a fraction of a second while running either independently
works well. Still investigating. Thanks,

Alex
 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  hw/vfio/common.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f3ba9b9..db41fa5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -228,17 +228,32 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>          map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
>      }
>  
> -    /*
> -     * Try the mapping, if it fails with EBUSY, unmap the region and try
> -     * again.  This shouldn't be necessary, but we sometimes see it in
> -     * the VGA ROM space.
> -     */
> -    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> -        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
> -         ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
> +    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0) {
>          return 0;
>      }
>  
> +    if (errno == ENOMEM) {
> +        /*
> +         * When quickly unmapping and mapping ranges, the kernel may
> +         * return ENOMEM for a map request because the previous unmap
> +         * has not been accounted yet. Wait a bit and try again.
> +         */
> +        usleep(10 * 1000);
> +        if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0) {
> +            return 0;
> +        }
> +    } else if (errno == EBUSY) {
> +        /*
> +         * If mapping fails with EBUSY, unmap the region and try again.
> +         * This shouldn't be necessary, but we sometimes see it in the
> +         * VGA ROM space.
> +         */
> +        if (vfio_dma_unmap(container, iova, size) == 0 &&
> +            ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0) {
> +            return 0;
> +        }
> +    }
> +
>      error_report("VFIO_MAP_DMA: %d", -errno);
>      return -errno;
>  }
