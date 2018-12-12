Received: from eggs.gnu.org ([2001:4830:134:3::10]:58607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX85B-00008k-OI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX858-0004g1-IS
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:14:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gX858-0004f6-8K
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:13:58 -0500
Date: Wed, 12 Dec 2018 19:13:34 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181212171333.GC5747@lap1>
References: <20181212114726.24060-1-ppandit@redhat.com>
	<20181212114726.24060-5-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212114726.24060-5-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/6] pvrdma: release ring object in case
 of an error
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

On Wed, Dec 12, 2018 at 05:17:24PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> create_cq and create_qp routines allocate ring object, but it's
> not released in case of an error, leading to memory leakage.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> Update v1: define new function to free PvrdmaRing object
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02328.html
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index e37fb18280..7e29607d2f 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -313,6 +313,14 @@ out:
>      return rc;
>  }
>  
> +static void destroy_cq_ring(PvrdmaRing *ring)
> +{
> +    pvrdma_ring_free(ring);
> +    /* ring_state was in slot 1, not 0 so need to jump back */
> +    rdma_pci_dma_unmap(ring->dev, --ring->ring_state, TARGET_PAGE_SIZE);
> +    g_free(ring);
> +}
> +
>  static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>                       union pvrdma_cmd_resp *rsp)
>  {
> @@ -335,6 +343,9 @@ static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  
>      rc = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev, cmd->cqe,
>                            &resp->cq_handle, ring);
> +    if (rc) {
> +        destroy_cq_ring(ring);
> +    }
>  
>      return rc;
>  }
> @@ -355,10 +366,7 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      }
>  
>      ring = (PvrdmaRing *)cq->opaque;
> -    pvrdma_ring_free(ring);
> -    /* ring_state was in slot 1, not 0 so need to jump back */
> -    rdma_pci_dma_unmap(PCI_DEVICE(dev), --ring->ring_state, TARGET_PAGE_SIZE);
> -    g_free(ring);
> +    destroy_cq_ring(ring);
>  
>      rdma_rm_dealloc_cq(&dev->rdma_dev_res, cmd->cq_handle);
>  
> @@ -456,6 +464,17 @@ out:
>      return rc;
>  }
>  
> +static void destroy_qp_rings(PvrdmaRing *ring)
> +{
> +    pr_dbg("sring=%p\n", &ring[0]);
> +    pvrdma_ring_free(&ring[0]);
> +    pr_dbg("rring=%p\n", &ring[1]);
> +    pvrdma_ring_free(&ring[1]);
> +
> +    rdma_pci_dma_unmap(ring->dev, ring->ring_state, TARGET_PAGE_SIZE);
> +    g_free(ring);
> +}
> +
>  static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>                       union pvrdma_cmd_resp *rsp)
>  {
> @@ -485,6 +504,7 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>                            cmd->max_recv_sge, cmd->recv_cq_handle, rings,
>                            &resp->qpn);
>      if (rc) {
> +        destroy_qp_rings(rings);
>          return rc;
>      }
>  
> @@ -557,13 +577,7 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
>  
>      ring = (PvrdmaRing *)qp->opaque;
> -    pr_dbg("sring=%p\n", &ring[0]);
> -    pvrdma_ring_free(&ring[0]);
> -    pr_dbg("rring=%p\n", &ring[1]);
> -    pvrdma_ring_free(&ring[1]);
> -
> -    rdma_pci_dma_unmap(PCI_DEVICE(dev), ring->ring_state, TARGET_PAGE_SIZE);
> -    g_free(ring);
> +    destroy_qp_rings(ring);
>  

Thanks.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>      return 0;
>  }
> -- 
> 2.19.2
> 
