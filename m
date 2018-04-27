Received: from eggs.gnu.org ([2001:4830:134:3::10]:49015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4tr-0000B3-H1
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4tq-0002B2-HM
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:03:03 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC4tq-0002A3-CP
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:03:02 -0400
Received: by mail-ot0-x241.google.com with SMTP id w4-v6so2346068ote.12
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 08:03:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180219114332.70443-9-marcel@redhat.com>
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-9-marcel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 16:01:58 +0100
Message-ID: <CAFEAcA8rx712pVT=yn0Xx_CEza2cSNO26F7_RPDudKWi6LnMwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL v2 08/10] hw/rdma: PVRDMA commands and
 data-path ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>

On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
>
> First PVRDMA sub-module - implementation of the PVRDMA device.
> - PVRDMA commands such as create CQ and create MR.
> - Data path QP operations - post_send and post_recv.
> - Completion handler.

Coverity CID 1390620: we call munmap() on a NULL pointer.

> +static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                     union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_create_mr *cmd = &req->create_mr;
> +    struct pvrdma_cmd_create_mr_resp *resp = &rsp->create_mr_resp;
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +    void *host_virt = NULL;

Here we set host_virt to NULL...

> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_CREATE_MR_RESP;
> +
> +    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
> +    pr_dbg("access_flags=0x%x\n", cmd->access_flags);
> +    pr_dbg("flags=0x%x\n", cmd->flags);
> +
> +    if (!(cmd->flags & PVRDMA_MR_FLAG_DMA)) {

...and if we don't take this if() we won't set host_virt to anything...

> +        host_virt = pvrdma_map_to_pdir(pci_dev, cmd->pdir_dma, cmd->nchunks,
> +                                       cmd->length);
> +        if (!host_virt) {
> +            pr_dbg("Failed to map to pdir\n");
> +            resp->hdr.err = -EINVAL;
> +            goto out;
> +        }
> +    }
> +
> +    resp->hdr.err = rdma_rm_alloc_mr(&dev->rdma_dev_res, cmd->pd_handle,
> +                                     cmd->start, cmd->length, host_virt,
> +                                     cmd->access_flags, &resp->mr_handle,
> +                                     &resp->lkey, &resp->rkey);
> +    if (!resp->hdr.err) {
> +        munmap(host_virt, cmd->length);

...but here we call munmap() on it without checking if it is NULL.
Unlike g_free(), munmap() isn't specified to be "do nothing if
passed a NULL pointer".

> +    }
> +
> +out:
> +    pr_dbg("ret=%d\n", resp->hdr.err);
> +    return resp->hdr.err;
> +}

thanks
-- PMM
