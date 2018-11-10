Received: from eggs.gnu.org ([208.118.235.92]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXrd-0007e8-Uw
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXqY-0006Kf-TA
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:19:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gLXqY-0006Jq-LM
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:19:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id 74-v6so5109367wrb.13
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 10:19:02 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-9-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <58b12b20-39ae-233b-0a23-10ceed0e8c79@gmail.com>
Date: Sat, 10 Nov 2018 20:18:58 +0200
MIME-Version: 1.0
In-Reply-To: <20181108160818.5485-9-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 08/22] hw/pvrdma: Set the correct opcode
 for recv completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com



On 11/8/18 6:08 PM, Yuval Shaia wrote:
> The function pvrdma_post_cqe populates CQE entry with opcode from the
> given completion element. For receive operation value was not set. Fix
> it by setting it to IBV_WC_RECV.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_qp_ops.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 762700a205..7b0f440fda 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -196,8 +196,9 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
>           comp_ctx = g_malloc(sizeof(CompHandlerCtx));
>           comp_ctx->dev = dev;
>           comp_ctx->cq_handle = qp->recv_cq_handle;
> -        comp_ctx->cqe.qp = qp_handle;
>           comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
> +        comp_ctx->cqe.qp = qp_handle;

Not sure the above chunk is needed.

> +        comp_ctx->cqe.opcode = IBV_WC_RECV;
>   

Anyway

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel

>           rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
>                                  &qp->backend_qp, qp->qp_type,
