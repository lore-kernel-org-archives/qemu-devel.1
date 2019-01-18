Received: from eggs.gnu.org ([209.51.188.92]:54235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkUcY-0005Wd-6F
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkUcX-0005Ww-74
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:55:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gkUcX-00055i-0W
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:55:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id 96so15192779wrb.2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:55:23 -0800 (PST)
References: <20190109201559.3906-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9cde91d0-ec6a-d66c-c699-1d35f8dd84a5@gmail.com>
Date: Fri, 18 Jan 2019 15:55:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190109201559.3906-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: Post CQE when receive invalid
 gid index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org

Hi Yuval,

On 1/9/19 10:15 PM, Yuval Shaia wrote:
> This error should propagate back to guest.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.h      | 1 +
>   hw/rdma/vmw/pvrdma_qp_ops.c | 6 ++++--
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> index a9ba40ae48..5114c90e67 100644
> --- a/hw/rdma/rdma_backend.h
> +++ b/hw/rdma/rdma_backend.h
> @@ -32,6 +32,7 @@
>   #define VENDOR_ERR_INVLKEY          0x207
>   #define VENDOR_ERR_MR_SMALL         0x208
>   #define VENDOR_ERR_INV_MAD_BUFF     0x209
> +#define VENDOR_ERR_INV_GID_IDX      0x210
>   
>   /* Add definition for QP0 and QP1 as there is no userspace enums for them */
>   enum ibv_special_qp_type {
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 465bee8641..0565eba981 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -178,7 +178,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>           sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
>           if (!sgid) {
>               pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
> -            return -EIO;
> +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);

There may be a problem here, comp_ctx may be uninitialized at this point.
I see that comp_ctx gets initalized after this call:

          /* Prepare CQE */
         comp_ctx = g_malloc(sizeof(CompHandlerCtx));
         comp_ctx->dev = dev;


What do you think?

Thanks,
Marcel

> +            continue;
>           }
>           pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
>                  sgid->global.interface_id);
> @@ -189,7 +190,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>           if (sgid_idx <= 0) {
>               pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
>                      wqe->hdr.wr.ud.av.gid_index);
> -            return -EIO;
> +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
> +            continue;
>           }
>   
>           if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
