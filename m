Received: from eggs.gnu.org ([2001:4830:134:3::10]:49829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXtS-0000i7-9y
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXtO-0000TJ-F1
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:22:02 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gLXtO-0000QM-3P
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:21:58 -0500
Received: by mail-wr1-x443.google.com with SMTP id b13so5111165wrx.6
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 10:21:56 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-10-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <128a90af-156f-fb25-2616-1bc8c2096df8@gmail.com>
Date: Sat, 10 Nov 2018 20:21:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181108160818.5485-10-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 09/22] hw/pvrdma: Set the correct opcode
 for send completion
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
> opcode for WC should be set by the device and not taken from work
> element.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_qp_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 7b0f440fda..3388be1926 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -154,7 +154,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>           comp_ctx->cq_handle = qp->send_cq_handle;
>           comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
>           comp_ctx->cqe.qp = qp_handle;
> -        comp_ctx->cqe.opcode = wqe->hdr.opcode;
> +        comp_ctx->cqe.opcode = IBV_WC_SEND;

That is interesting, what should happen if the opcode in hdr is different?
Maybe fail the operation?

Thanks,
Marcel

>   
>           rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
>                                  (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
