Received: from eggs.gnu.org ([209.51.188.92]:44714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ghBcI-00017K-1M
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ghBcC-0003DQ-1s
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:01:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1ghBcB-00037L-NZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:01:39 -0500
Date: Wed, 9 Jan 2019 13:01:13 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190109110112.GC4012@lap1>
References: <20190108150228.32936-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108150228.32936-1-liq3ea@163.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw: pvrdma: fix memory leak in error
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: marcel.apfelbaum@gmail.com, philmd@redhat.com, qemu-devel@nongnu.org

On Tue, Jan 08, 2019 at 07:02:28AM -0800, Li Qiang wrote:
> Currently, pvrdma_qp_send() function leak the 'comp_ctx',
> Since 'comp_ctx' is used after the two checks, just relocate
> the allocation & initialization after the two check.
> 
> Spotted by Coverity: CID 1398595
> 
> Fixes: 2b05705dc8
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/rdma/vmw/pvrdma_qp_ops.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 300471a4c9..471bdbaaa0 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -157,14 +157,6 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>  
>          pr_dbg("wr_id=%" PRIx64 "\n", wqe->hdr.wr_id);
>  
> -        /* Prepare CQE */
> -        comp_ctx = g_malloc(sizeof(CompHandlerCtx));
> -        comp_ctx->dev = dev;
> -        comp_ctx->cq_handle = qp->send_cq_handle;
> -        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
> -        comp_ctx->cqe.qp = qp_handle;
> -        comp_ctx->cqe.opcode = IBV_WC_SEND;
> -
>          sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
>          if (!sgid) {
>              pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
> @@ -182,6 +174,14 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>              return -EIO;
>          }
>  
> +        /* Prepare CQE */
> +        comp_ctx = g_malloc(sizeof(CompHandlerCtx));
> +        comp_ctx->dev = dev;
> +        comp_ctx->cq_handle = qp->send_cq_handle;
> +        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
> +        comp_ctx->cqe.qp = qp_handle;
> +        comp_ctx->cqe.opcode = IBV_WC_SEND;
> +

This fix lgtm,
Thanks.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>          rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
>                                 (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
>                                 sgid_idx, sgid,
> -- 
> 2.17.1
> 
> 
> 
