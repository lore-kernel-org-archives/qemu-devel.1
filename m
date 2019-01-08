Received: from eggs.gnu.org ([209.51.188.92]:55879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggvVJ-0007EW-Ei
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggvVH-0002Ve-6d
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:49:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggvVE-00021T-U9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:49:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so4985507wrw.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 09:49:12 -0800 (PST)
References: <20190108150228.32936-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2164567c-8e63-3b26-761d-a0b84ce09050@redhat.com>
Date: Tue, 8 Jan 2019 18:49:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190108150228.32936-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Li Qiang <liq3ea@163.com>, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org

On 1/8/19 4:02 PM, Li Qiang wrote:
> Currently, pvrdma_qp_send() function leak the 'comp_ctx',
> Since 'comp_ctx' is used after the two checks, just relocate
> the allocation & initialization after the two check.
> 
> Spotted by Coverity: CID 1398595
> 
> Fixes: 2b05705dc8

Suggested-by: Yuval Shaia <yuval.shaia@oracle.com>

> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
>          rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
>                                 (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
>                                 sgid_idx, sgid,
> 
