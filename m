Received: from eggs.gnu.org ([2001:4830:134:3::10]:47325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYrJX-00022I-7r
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYrJS-0004Th-LT
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:39:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eYrJS-0004Sz-Bs
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:39:22 -0500
Date: Tue, 9 Jan 2018 11:39:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180109113911.1746995b.cohuck@redhat.com>
In-Reply-To: <20180107123224.100877-5-marcel@redhat.com>
References: <20180107123224.100877-1-marcel@redhat.com>
	<20180107123224.100877-5-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

On Sun,  7 Jan 2018 14:32:23 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> From: Yuval Shaia <yuval.shaia@oracle.com>
> 
> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
> It works with its Linux Kernel driver AS IS, no need for any special guest
> modifications.
> 
> While it complies with the VMware device, it can also communicate with bare
> metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
> can work with Soft-RoCE (rxe).
> 
> It does not require the whole guest RAM to be pinned allowing memory
> over-commit and, even if not implemented yet, migration support will be
> possible with some HW assistance.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  Makefile.objs                      |   2 +
>  configure                          |   9 +-
>  default-configs/arm-softmmu.mak    |   1 +
>  default-configs/i386-softmmu.mak   |   1 +
>  default-configs/x86_64-softmmu.mak |   1 +
>  hw/Makefile.objs                   |   1 +
>  hw/rdma/Makefile.objs              |   6 +
>  hw/rdma/rdma_backend.c             | 815 +++++++++++++++++++++++++++++++++++++
>  hw/rdma/rdma_backend.h             |  92 +++++
>  hw/rdma/rdma_backend_defs.h        |  62 +++
>  hw/rdma/rdma_rm.c                  | 619 ++++++++++++++++++++++++++++
>  hw/rdma/rdma_rm.h                  |  69 ++++
>  hw/rdma/rdma_rm_defs.h             | 106 +++++
>  hw/rdma/rdma_utils.c               |  52 +++
>  hw/rdma/rdma_utils.h               |  43 ++
>  hw/rdma/trace-events               |   5 +
>  hw/rdma/vmw/pvrdma.h               | 122 ++++++
>  hw/rdma/vmw/pvrdma_cmd.c           | 679 ++++++++++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_dev_api.h       | 602 +++++++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_dev_ring.c      | 139 +++++++
>  hw/rdma/vmw/pvrdma_dev_ring.h      |  42 ++
>  hw/rdma/vmw/pvrdma_ib_verbs.h      | 433 ++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_main.c          | 644 +++++++++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_qp_ops.c        | 212 ++++++++++
>  hw/rdma/vmw/pvrdma_qp_ops.h        |  27 ++
>  hw/rdma/vmw/pvrdma_ring.h          | 134 ++++++
>  hw/rdma/vmw/trace-events           |   5 +
>  hw/rdma/vmw/vmw_pvrdma-abi.h       | 311 ++++++++++++++
>  include/hw/pci/pci_ids.h           |   3 +
>  29 files changed, 5233 insertions(+), 4 deletions(-)
>  create mode 100644 hw/rdma/Makefile.objs
>  create mode 100644 hw/rdma/rdma_backend.c
>  create mode 100644 hw/rdma/rdma_backend.h
>  create mode 100644 hw/rdma/rdma_backend_defs.h
>  create mode 100644 hw/rdma/rdma_rm.c
>  create mode 100644 hw/rdma/rdma_rm.h
>  create mode 100644 hw/rdma/rdma_rm_defs.h
>  create mode 100644 hw/rdma/rdma_utils.c
>  create mode 100644 hw/rdma/rdma_utils.h
>  create mode 100644 hw/rdma/trace-events
>  create mode 100644 hw/rdma/vmw/pvrdma.h
>  create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
>  create mode 100644 hw/rdma/vmw/pvrdma_dev_api.h
>  create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
>  create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
>  create mode 100644 hw/rdma/vmw/pvrdma_ib_verbs.h
>  create mode 100644 hw/rdma/vmw/pvrdma_main.c
>  create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
>  create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
>  create mode 100644 hw/rdma/vmw/pvrdma_ring.h
>  create mode 100644 hw/rdma/vmw/trace-events
>  create mode 100644 hw/rdma/vmw/vmw_pvrdma-abi.h

(...)

> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index b0d6e65038..0e7a3c1700 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -132,3 +132,4 @@ CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_XILINX_AXI=y
> +CONFIG_PVRDMA=y
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 95ac4b464a..88298e4ef5 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -61,3 +61,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
>  CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
>  CONFIG_FW_CFG_DMA=y
> +CONFIG_PVRDMA=y
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 0221236825..f571da36eb 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -61,3 +61,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
>  CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
>  CONFIG_FW_CFG_DMA=y
> +CONFIG_PVRDMA=y

Any reason you did not add this to other architectures?

I added "CONFIG_PVRDMA=$(CONFIG_PCI)" to s390x-softmmu.mak, and it at
least builds (did not try to actually get it to work, although I don't
see any immediate blocker for that).

(...)

> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> new file mode 100644
> index 0000000000..dcb799f49b
> --- /dev/null
> +++ b/hw/rdma/rdma_backend.c

(...)

> +static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq,
> +                    bool one_poll)
> +{
> +    int i, ne;
> +    BackendCtx *bctx;
> +    struct ibv_wc wc[2];
> +
> +    pr_dbg("Entering poll_cq loop on cq %p\n", ibcq);
> +    do {
> +        ne = ibv_poll_cq(ibcq, 2, wc);
> +        if (ne == 0 && one_poll) {
> +            pr_dbg("CQ is empty\n");
> +            return;
> +        }
> +    } while (ne < 0);
> +
> +    pr_dbg("Got %d completion(s) from cq %p\n", ne, ibcq);
> +
> +    for (i = 0; i < ne; i++) {
> +        pr_dbg("wr_id=0x%lx\n", wc[i].wr_id);
> +        pr_dbg("status=%d\n", wc[i].status);
> +
> +        bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> +        if (unlikely(!bctx)) {
> +            pr_dbg("Error: Fail to find ctx for req %ld\n", wc[i].wr_id);

s/Fail/Failed/

(A lot of these through out the various files. Just thought I'd point
that out; but I don't really have time to do a real review.)

> +            continue;
> +        }
> +        pr_dbg("Processing %s CQE\n", bctx->is_tx_req ? "send" : "recv");
> +
> +        comp_handler(wc[i].status, wc[i].vendor_err, bctx->up_ctx);
> +
> +        rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> +        free(bctx);
> +    }
> +}

(...)

> diff --git a/hw/rdma/vmw/pvrdma_dev_api.h b/hw/rdma/vmw/pvrdma_dev_api.h
> new file mode 100644
> index 0000000000..bf1986a976
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_dev_api.h
> @@ -0,0 +1,602 @@
> +/*
> + * QEMU VMWARE paravirtual RDMA device definitions
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef PVRDMA_DEV_API_H
> +#define PVRDMA_DEV_API_H
> +
> +/*
> + * Following is an interface definition for PVRDMA device as provided by
> + * VMWARE.
> + * See original copyright from Linux kernel v4.14.5 header file
> + * drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h

Could that file be exported as UAPI in the kernel and added to the
linux-headers script?

(...)

> diff --git a/hw/rdma/vmw/pvrdma_ib_verbs.h b/hw/rdma/vmw/pvrdma_ib_verbs.h
> new file mode 100644
> index 0000000000..cf1430024b
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_ib_verbs.h
> @@ -0,0 +1,433 @@
> +/*
> + * QEMU VMWARE paravirtual RDMA device definitions
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef PVRDMA_IB_VERBS_H
> +#define PVRDMA_IB_VERBS_H
> +
> +/*
> + * VMWARE headers we got from Linux kernel do not fully comply QEMU coding
> + * standards in sense of types and defines used.
> + * Since we didn't want to change VMWARE code, following set of typedefs
> + * and defines needed to compile these headers with QEMU introduced.
> + */
> +
> +#define u8     uint8_t
> +#define u16    unsigned short
> +#define u32    uint32_t
> +#define u64    uint64_t

I think the headers update already takes care of some conversions.
Otherwise, same comment as for the header above.

> +
> +/*
> + * Following is an interface definition for PVRDMA device as provided by
> + * VMWARE.
> + * See original copyright from Linux kernel v4.14.5 header file
> + * drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> + */

(...)

> diff --git a/hw/rdma/vmw/vmw_pvrdma-abi.h b/hw/rdma/vmw/vmw_pvrdma-abi.h
> new file mode 100644
> index 0000000000..8cfb9d7745
> --- /dev/null
> +++ b/hw/rdma/vmw/vmw_pvrdma-abi.h
> @@ -0,0 +1,311 @@
> +/*
> + * QEMU VMWARE paravirtual RDMA device definitions
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef VMW_PVRDMA_ABI_H
> +#define VMW_PVRDMA_ABI_H
> +
> +/*
> + * Following is an interface definition for PVRDMA device as provided by
> + * VMWARE.
> + * See original copyright from Linux kernel v4.14.5 header file
> + * include/uapi/rdma/vmw_pvrdma-abi.h
> + */

This one is already exported.
