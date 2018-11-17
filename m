Received: from eggs.gnu.org ([2001:4830:134:3::10]:34036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzcZ-0003F2-04
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzcT-0006kM-7m
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:22:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNzcR-0006cw-Kt
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:22:37 -0500
Received: by mail-wr1-x441.google.com with SMTP id z13-v6so27466856wrs.3
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:22:35 -0800 (PST)
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-18-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0770c06d-b482-c0bf-0d6a-efe31984b31e@gmail.com>
Date: Sat, 17 Nov 2018 14:22:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181113071336.6242-18-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 17/23] hw/pvrdma: Fill error code in
 command's response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com



On 11/13/18 9:13 AM, Yuval Shaia wrote:
> Driver checks error code let's set it.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_cmd.c | 67 ++++++++++++++++++++++++++++------------
>   1 file changed, 48 insertions(+), 19 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 0d3c818c20..a326c5d470 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -131,7 +131,8 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
>   
>       if (rdma_backend_query_port(&dev->backend_dev,
>                                   (struct ibv_port_attr *)&attrs)) {
> -        return -ENOMEM;
> +        resp->hdr.err = -ENOMEM;
> +        goto out;
>       }
>   
>       memset(resp, 0, sizeof(*resp));
> @@ -150,7 +151,9 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       resp->attrs.active_width = 1;
>       resp->attrs.active_speed = 1;
>   
> -    return 0;
> +out:
> +    pr_dbg("ret=%d\n", resp->hdr.err);
> +    return resp->hdr.err;
>   }
>   
>   static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
> @@ -170,7 +173,7 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       resp->pkey = PVRDMA_PKEY;
>       pr_dbg("pkey=0x%x\n", resp->pkey);
>   
> -    return 0;
> +    return resp->hdr.err;
>   }
>   
>   static int create_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
> @@ -200,7 +203,9 @@ static int destroy_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
>   
>       rdma_rm_dealloc_pd(&dev->rdma_dev_res, cmd->pd_handle);
>   
> -    return 0;
> +    rsp->hdr.err = 0;

Is it possible to ensure err is 0 by default during hdr creation
instead of manually setting it every time?

Thanks,
Marcel

> +
> +    return rsp->hdr.err;
>   }
>   
>   static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
> @@ -251,7 +256,9 @@ static int destroy_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
>   
>       rdma_rm_dealloc_mr(&dev->rdma_dev_res, cmd->mr_handle);
>   
> -    return 0;
> +    rsp->hdr.err = 0;
> +
> +    return rsp->hdr.err;
>   }
>   
>   static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
> @@ -353,7 +360,8 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       cq = rdma_rm_get_cq(&dev->rdma_dev_res, cmd->cq_handle);
>       if (!cq) {
>           pr_dbg("Invalid CQ handle\n");
> -        return -EINVAL;
> +        rsp->hdr.err = -EINVAL;
> +        goto out;
>       }
>   
>       ring = (PvrdmaRing *)cq->opaque;
> @@ -364,7 +372,11 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>   
>       rdma_rm_dealloc_cq(&dev->rdma_dev_res, cmd->cq_handle);
>   
> -    return 0;
> +    rsp->hdr.err = 0;
> +
> +out:
> +    pr_dbg("ret=%d\n", rsp->hdr.err);
> +    return rsp->hdr.err;
>   }
>   
>   static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
> @@ -553,7 +565,8 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       qp = rdma_rm_get_qp(&dev->rdma_dev_res, cmd->qp_handle);
>       if (!qp) {
>           pr_dbg("Invalid QP handle\n");
> -        return -EINVAL;
> +        rsp->hdr.err = -EINVAL;
> +        goto out;
>       }
>   
>       rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
> @@ -567,7 +580,11 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       rdma_pci_dma_unmap(PCI_DEVICE(dev), ring->ring_state, TARGET_PAGE_SIZE);
>       g_free(ring);
>   
> -    return 0;
> +    rsp->hdr.err = 0;
> +
> +out:
> +    pr_dbg("ret=%d\n", rsp->hdr.err);
> +    return rsp->hdr.err;
>   }
>   
>   static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
> @@ -580,7 +597,8 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       pr_dbg("index=%d\n", cmd->index);
>   
>       if (cmd->index >= MAX_PORT_GIDS) {
> -        return -EINVAL;
> +        rsp->hdr.err = -EINVAL;
> +        goto out;
>       }
>   
>       pr_dbg("gid[%d]=0x%llx,0x%llx\n", cmd->index,
> @@ -590,10 +608,15 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       rc = rdma_rm_add_gid(&dev->rdma_dev_res, &dev->backend_dev,
>                            dev->backend_eth_device_name, gid, cmd->index);
>       if (rc < 0) {
> -        return -EINVAL;
> +        rsp->hdr.err = rc;
> +        goto out;
>       }
>   
> -    return 0;
> +    rsp->hdr.err = 0;
> +
> +out:
> +    pr_dbg("ret=%d\n", rsp->hdr.err);
> +    return rsp->hdr.err;
>   }
>   
>   static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
> @@ -606,7 +629,8 @@ static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       pr_dbg("index=%d\n", cmd->index);
>   
>       if (cmd->index >= MAX_PORT_GIDS) {
> -        return -EINVAL;
> +        rsp->hdr.err = -EINVAL;
> +        goto out;
>       }
>   
>       rc = rdma_rm_del_gid(&dev->rdma_dev_res, &dev->backend_dev,
> @@ -617,7 +641,11 @@ static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>           goto out;
>       }
>   
> -    return 0;
> +    rsp->hdr.err = 0;
> +
> +out:
> +    pr_dbg("ret=%d\n", rsp->hdr.err);
> +    return rsp->hdr.err;
>   }
>   
>   static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
> @@ -634,9 +662,8 @@ static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       resp->hdr.err = rdma_rm_alloc_uc(&dev->rdma_dev_res, cmd->pfn,
>                                        &resp->ctx_handle);
>   
> -    pr_dbg("ret=%d\n", resp->hdr.err);
> -
> -    return 0;
> +    pr_dbg("ret=%d\n", rsp->hdr.err);
> +    return rsp->hdr.err;
>   }
>   
>   static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
> @@ -648,7 +675,9 @@ static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
>   
>       rdma_rm_dealloc_uc(&dev->rdma_dev_res, cmd->ctx_handle);
>   
> -    return 0;
> +    rsp->hdr.err = 0;
> +
> +    return rsp->hdr.err;
>   }
>   struct cmd_handler {
>       uint32_t cmd;
> @@ -696,7 +725,7 @@ int execute_command(PVRDMADev *dev)
>       }
>   
>       err = cmd_handlers[dsr_info->req->hdr.cmd].exec(dev, dsr_info->req,
> -                            dsr_info->rsp);
> +                                                    dsr_info->rsp);
>   out:
>       set_reg_val(dev, PVRDMA_REG_ERR, err);
>       post_interrupt(dev, INTR_VEC_CMD_RING);
