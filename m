Received: from eggs.gnu.org ([2001:4830:134:3::10]:50529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cE29V-00054j-2t
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 17:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cE29Q-0002VI-Tx
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 17:54:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cE29Q-0002Ue-L5
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 17:54:24 -0500
Date: Mon, 5 Dec 2016 15:54:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20161205155421.075bbec5@t450s.home>
In-Reply-To: <1480972081-773-1-git-send-email-kwankhede@nvidia.com>
References: <1480972081-773-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] vfio iommu type1: set size to
 PAGE_SIZE while looking for iova in dma list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Dec 2016 02:38:01 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> In the functions of pin_pages/unpin_pages from mdev vendor driver,
> vfio_find_dma() should be called with size as PAGE_SIZE instead of 0.
> vfio_find_dma() searches for the range in dma_list.
> 
> In vfio_dma_do_unmap(), vfio_find_dma() when used to look for start
> address of unmap->iova, size should be 1, not 0. Otherwise vfio_find_dma()
> returns NULL.

Hi Kirti,

I'd prefer to fix the preexisting case of this issue as a separate
patch, we might want to backport it for stable trees separately from the
new cases introduced with mdev.  It would also be great if we could go
into some detail about why size=0 doesn't work in these cases, ie.
vfio_find_dma() accounting for the end address of the range makes it
fall through at the wrong branch point.  For the case of the
preexisting issue, it would also be useful to mention that the other
case of passing size=0 works correctly due to the -1 in the start
address calculation.  Finally, I think I agree with your choice to use
PAGE_SIZE in one case and 1 in the preexisting case, but perhaps we
could spell that out as one is related to a page size interface and the
other is trying to test boundary conditions.  Thanks,

Alex

> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Signed-off-by: Neo Jia <cjia@nvidia.com>
> Change-Id: Iee6fd45441c342b5e8626087046b2e0075d19a08
> ---
>  drivers/vfio/vfio_iommu_type1.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index a28fbddb505c..023fba7b8d5a 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -581,7 +581,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>  		struct vfio_pfn *vpfn;
>  
>  		iova = user_pfn[i] << PAGE_SHIFT;
> -		dma = vfio_find_dma(iommu, iova, 0);
> +		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
>  		if (!dma) {
>  			ret = -EINVAL;
>  			goto pin_unwind;
> @@ -622,7 +622,7 @@ pin_unwind:
>  		dma_addr_t iova;
>  
>  		iova = user_pfn[j] << PAGE_SHIFT;
> -		dma = vfio_find_dma(iommu, iova, 0);
> +		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
>  		vfio_unpin_page_external(dma, iova, do_accounting);
>  		phys_pfn[j] = 0;
>  	}
> @@ -659,7 +659,7 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>  		dma_addr_t iova;
>  
>  		iova = user_pfn[i] << PAGE_SHIFT;
> -		dma = vfio_find_dma(iommu, iova, 0);
> +		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
>  		if (!dma)
>  			goto unpin_exit;
>  		vfio_unpin_page_external(dma, iova, do_accounting);
> @@ -826,7 +826,7 @@ again:
>  	 * mappings within the range.
>  	 */
>  	if (iommu->v2) {
> -		dma = vfio_find_dma(iommu, unmap->iova, 0);
> +		dma = vfio_find_dma(iommu, unmap->iova, 1);
>  		if (dma && dma->iova != unmap->iova) {
>  			ret = -EINVAL;
>  			goto unlock;
