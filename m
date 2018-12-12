Received: from eggs.gnu.org ([2001:4830:134:3::10]:56310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX7yO-0005Pv-Ly
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX7yL-0005u7-G4
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:07:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gX7yL-0005r6-4N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:06:57 -0500
Date: Wed, 12 Dec 2018 19:06:36 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181212170635.GB5747@lap1>
References: <20181212114726.24060-1-ppandit@redhat.com>
	<20181212114726.24060-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212114726.24060-4-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] pvrdma: check number of pages when
 creating rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>, yuval.shaia@oracle.com

On Wed, Dec 12, 2018 at 05:17:23PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When creating CQ/QP rings, an object can have up to
> PVRDMA_MAX_FAST_REG_PAGES=128 pages. Check 'npages' parameter
> to avoid excessive memory allocation or a null dereference.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Update v1: move check before page dir/tbl map
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02257.html
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 4f616d4177..e37fb18280 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -259,6 +259,11 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
>      int rc = -EINVAL;
>      char ring_name[MAX_RING_NAME_SZ];
>  
> +    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
> +        pr_dbg("invalid nchunks: %d\n", nchunks);
> +        return rc;
> +    }
> +
>      pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
>      dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {
> @@ -371,6 +376,12 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>      char ring_name[MAX_RING_NAME_SZ];
>      uint32_t wqe_sz;
>  
> +    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
> +        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
> +        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
> +        return rc;
> +    }
> +
>      pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
>      dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {

Thanks.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> -- 
> 2.19.2
> 
