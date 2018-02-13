Received: from eggs.gnu.org ([2001:4830:134:3::10]:38101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yanjun.zhu@oracle.com>) id 1elVra-0007kC-TV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yanjun.zhu@oracle.com>) id 1elVrW-0005ja-P8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:22:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yanjun.zhu@oracle.com>)
	id 1elVrW-0005j4-8W
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:22:50 -0500
References: <20180212180819.82556-1-marcel@redhat.com>
	<20180212180819.82556-8-marcel@redhat.com>
From: Yanjun Zhu <yanjun.zhu@oracle.com>
Message-ID: <5cdd2d88-fc37-0d32-ad3b-5920391f1e76@oracle.com>
Date: Tue, 13 Feb 2018 16:22:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180212180819.82556-8-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V10 7/9] hw/rdma: PVRDMA commands and
 data-path ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, mst@redhat.com, dotanb@mellanox.com



On 2018/2/13 2:08, Marcel Apfelbaum wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
>
> First PVRDMA sub-module - implementation of the PVRDMA device.
> - PVRDMA commands such as create CQ and create MR.
> - Data path QP operations - post_send and post_recv.
> - Completion handler.
>
> Reviewed-by: Dotan Barak <dotanb@mellanox.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>

Zhu Yanjun
> ---
>   hw/rdma/Makefile.objs         |   2 +
>   hw/rdma/vmw/pvrdma.h          | 122 ++++++++
>   hw/rdma/vmw/pvrdma_cmd.c      | 673 ++++++++++++++++++++++++++++++++++++++++++
>   hw/rdma/vmw/pvrdma_dev_ring.c | 155 ++++++++++
>   hw/rdma/vmw/pvrdma_dev_ring.h |  42 +++
>   hw/rdma/vmw/pvrdma_qp_ops.c   | 222 ++++++++++++++
>   hw/rdma/vmw/pvrdma_qp_ops.h   |  27 ++
>   7 files changed, 1243 insertions(+)
>   create mode 100644 hw/rdma/vmw/pvrdma.h
>   create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
>   create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
>   create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
>   create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
>   create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
>
> diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
> index 6a59bf0d5b..44a85f687d 100644
> --- a/hw/rdma/Makefile.objs
> +++ b/hw/rdma/Makefile.objs
> @@ -1,3 +1,5 @@
>   ifeq ($(CONFIG_RDMA),y)
>   obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o
> +obj-$(CONFIG_PCI) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
> +                     vmw/pvrdma_qp_ops.o
>   endif
> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> new file mode 100644
> index 0000000000..b05f94a473
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma.h
> @@ -0,0 +1,122 @@
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
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef PVRDMA_PVRDMA_H
> +#define PVRDMA_PVRDMA_H
> +
> +#include <hw/pci/pci.h>
> +#include <hw/pci/msix.h>
> +
> +#include "../rdma_backend_defs.h"
> +#include "../rdma_rm_defs.h"
> +
> +#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h>
> +#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h>
> +#include "pvrdma_dev_ring.h"
> +
> +/* BARs */
> +#define RDMA_MSIX_BAR_IDX    0
> +#define RDMA_REG_BAR_IDX     1
> +#define RDMA_UAR_BAR_IDX     2
> +#define RDMA_BAR0_MSIX_SIZE  (16 * 1024)
> +#define RDMA_BAR1_REGS_SIZE  256
> +#define RDMA_BAR2_UAR_SIZE   (0x1000 * MAX_UCS) /* each uc gets page */
> +
> +/* MSIX */
> +#define RDMA_MAX_INTRS       3
> +#define RDMA_MSIX_TABLE      0x0000
> +#define RDMA_MSIX_PBA        0x2000
> +
> +/* Interrupts Vectors */
> +#define INTR_VEC_CMD_RING            0
> +#define INTR_VEC_CMD_ASYNC_EVENTS    1
> +#define INTR_VEC_CMD_COMPLETION_Q    2
> +
> +/* HW attributes */
> +#define PVRDMA_HW_NAME       "pvrdma"
> +#define PVRDMA_HW_VERSION    17
> +#define PVRDMA_FW_VERSION    14
> +
> +typedef struct DSRInfo {
> +    dma_addr_t dma;
> +    struct pvrdma_device_shared_region *dsr;
> +
> +    union pvrdma_cmd_req *req;
> +    union pvrdma_cmd_resp *rsp;
> +
> +    struct pvrdma_ring *async_ring_state;
> +    PvrdmaRing async;
> +
> +    struct pvrdma_ring *cq_ring_state;
> +    PvrdmaRing cq;
> +} DSRInfo;
> +
> +typedef struct PVRDMADev {
> +    PCIDevice parent_obj;
> +    MemoryRegion msix;
> +    MemoryRegion regs;
> +    uint32_t regs_data[RDMA_BAR1_REGS_SIZE];
> +    MemoryRegion uar;
> +    uint32_t uar_data[RDMA_BAR2_UAR_SIZE];
> +    DSRInfo dsr_info;
> +    int interrupt_mask;
> +    struct ibv_device_attr dev_attr;
> +    uint64_t node_guid;
> +    char *backend_device_name;
> +    uint8_t backend_gid_idx;
> +    uint8_t backend_port_num;
> +    RdmaBackendDev backend_dev;
> +    RdmaDeviceResources rdma_dev_res;
> +} PVRDMADev;
> +#define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
> +
> +static inline int get_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t *val)
> +{
> +    int idx = addr >> 2;
> +
> +    if (idx > RDMA_BAR1_REGS_SIZE) {
> +        return -EINVAL;
> +    }
> +
> +    *val = dev->regs_data[idx];
> +
> +    return 0;
> +}
> +
> +static inline int set_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t val)
> +{
> +    int idx = addr >> 2;
> +
> +    if (idx > RDMA_BAR1_REGS_SIZE) {
> +        return -EINVAL;
> +    }
> +
> +    dev->regs_data[idx] = val;
> +
> +    return 0;
> +}
> +
> +static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
> +{
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +
> +    if (likely(!dev->interrupt_mask)) {
> +        msix_notify(pci_dev, vector);
> +    }
> +}
> +
> +int execute_command(PVRDMADev *dev);
> +
> +#endif
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> new file mode 100644
> index 0000000000..293dfed29f
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -0,0 +1,673 @@
> +/*
> + * QEMU paravirtual RDMA - Command channel
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <qemu/osdep.h>
> +#include <qemu/error-report.h>
> +#include <cpu.h>
> +#include <linux/types.h>
> +#include "hw/hw.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_ids.h"
> +
> +#include "../rdma_backend.h"
> +#include "../rdma_rm.h"
> +#include "../rdma_utils.h"
> +
> +#include "pvrdma.h"
> +#include <standard-headers/rdma/vmw_pvrdma-abi.h>
> +
> +static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
> +                                uint32_t nchunks, size_t length)
> +{
> +    uint64_t *dir, *tbl;
> +    int tbl_idx, dir_idx, addr_idx;
> +    void *host_virt = NULL, *curr_page;
> +
> +    if (!nchunks) {
> +        pr_dbg("nchunks=0\n");
> +        return NULL;
> +    }
> +
> +    dir = rdma_pci_dma_map(pdev, pdir_dma, TARGET_PAGE_SIZE);
> +    if (!dir) {
> +        error_report("PVRDMA: Failed to map to page directory");
> +        return NULL;
> +    }
> +
> +    tbl = rdma_pci_dma_map(pdev, dir[0], TARGET_PAGE_SIZE);
> +    if (!tbl) {
> +        error_report("PVRDMA: Failed to map to page table 0");
> +        goto out_unmap_dir;
> +    }
> +
> +    curr_page = rdma_pci_dma_map(pdev, (dma_addr_t)tbl[0], TARGET_PAGE_SIZE);
> +    if (!curr_page) {
> +        error_report("PVRDMA: Failed to map the first page");
> +        goto out_unmap_tbl;
> +    }
> +
> +    host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
> +    if (host_virt == MAP_FAILED) {
> +        host_virt = NULL;
> +        error_report("PVRDMA: Failed to remap memory for host_virt");
> +        goto out_unmap_tbl;
> +    }
> +
> +    rdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
> +
> +    pr_dbg("host_virt=%p\n", host_virt);
> +
> +    dir_idx = 0;
> +    tbl_idx = 1;
> +    addr_idx = 1;
> +    while (addr_idx < nchunks) {
> +        if ((tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t)))) {
> +            tbl_idx = 0;
> +            dir_idx++;
> +            pr_dbg("Mapping to table %d\n", dir_idx);
> +            rdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
> +            tbl = rdma_pci_dma_map(pdev, dir[dir_idx], TARGET_PAGE_SIZE);
> +            if (!tbl) {
> +                error_report("PVRDMA: Failed to map to page table %d", dir_idx);
> +                goto out_unmap_host_virt;
> +            }
> +        }
> +
> +        pr_dbg("guest_dma[%d]=0x%lx\n", addr_idx, tbl[tbl_idx]);
> +
> +        curr_page = rdma_pci_dma_map(pdev, (dma_addr_t)tbl[tbl_idx],
> +                                     TARGET_PAGE_SIZE);
> +        if (!curr_page) {
> +            error_report("PVRDMA: Failed to map to page %d, dir %d", tbl_idx,
> +                         dir_idx);
> +            goto out_unmap_host_virt;
> +        }
> +
> +        mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
> +               host_virt + TARGET_PAGE_SIZE * addr_idx);
> +
> +        rdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
> +
> +        addr_idx++;
> +
> +        tbl_idx++;
> +    }
> +
> +    goto out_unmap_tbl;
> +
> +out_unmap_host_virt:
> +    munmap(host_virt, length);
> +    host_virt = NULL;
> +
> +out_unmap_tbl:
> +    rdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
> +
> +out_unmap_dir:
> +    rdma_pci_dma_unmap(pdev, dir, TARGET_PAGE_SIZE);
> +
> +    return host_virt;
> +}
> +
> +static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_query_port *cmd = &req->query_port;
> +    struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
> +    struct pvrdma_port_attr attrs = {0};
> +
> +    pr_dbg("port=%d\n", cmd->port_num);
> +
> +    if (rdma_backend_query_port(&dev->backend_dev,
> +                                (struct ibv_port_attr *)&attrs)) {
> +        return -ENOMEM;
> +    }
> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_QUERY_PORT_RESP;
> +    resp->hdr.err = 0;
> +
> +    resp->attrs.state = attrs.state;
> +    resp->attrs.max_mtu = attrs.max_mtu;
> +    resp->attrs.active_mtu = attrs.active_mtu;
> +    resp->attrs.phys_state = attrs.phys_state;
> +    resp->attrs.gid_tbl_len = MIN(MAX_PORT_GIDS, attrs.gid_tbl_len);
> +    resp->attrs.max_msg_sz = 1024;
> +    resp->attrs.pkey_tbl_len = MIN(MAX_PORT_PKEYS, attrs.pkey_tbl_len);
> +    resp->attrs.active_width = 1;
> +    resp->attrs.active_speed = 1;
> +
> +    return 0;
> +}
> +
> +static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_query_pkey *cmd = &req->query_pkey;
> +    struct pvrdma_cmd_query_pkey_resp *resp = &rsp->query_pkey_resp;
> +
> +    pr_dbg("port=%d\n", cmd->port_num);
> +    pr_dbg("index=%d\n", cmd->index);
> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_QUERY_PKEY_RESP;
> +    resp->hdr.err = 0;
> +
> +    resp->pkey = 0x7FFF;
> +    pr_dbg("pkey=0x%x\n", resp->pkey);
> +
> +    return 0;
> +}
> +
> +static int create_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                     union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_create_pd *cmd = &req->create_pd;
> +    struct pvrdma_cmd_create_pd_resp *resp = &rsp->create_pd_resp;
> +
> +    pr_dbg("context=0x%x\n", cmd->ctx_handle ? cmd->ctx_handle : 0);
> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_CREATE_PD_RESP;
> +    resp->hdr.err = rdma_rm_alloc_pd(&dev->rdma_dev_res, &dev->backend_dev,
> +                                     &resp->pd_handle, cmd->ctx_handle);
> +
> +    pr_dbg("ret=%d\n", resp->hdr.err);
> +    return resp->hdr.err;
> +}
> +
> +static int destroy_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_destroy_pd *cmd = &req->destroy_pd;
> +
> +    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
> +
> +    rdma_rm_dealloc_pd(&dev->rdma_dev_res, cmd->pd_handle);
> +
> +    return 0;
> +}
> +
> +static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                     union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_create_mr *cmd = &req->create_mr;
> +    struct pvrdma_cmd_create_mr_resp *resp = &rsp->create_mr_resp;
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +    void *host_virt = NULL;
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
> +    }
> +
> +out:
> +    pr_dbg("ret=%d\n", resp->hdr.err);
> +    return resp->hdr.err;
> +}
> +
> +static int destroy_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_destroy_mr *cmd = &req->destroy_mr;
> +
> +    pr_dbg("mr_handle=%d\n", cmd->mr_handle);
> +
> +    rdma_rm_dealloc_mr(&dev->rdma_dev_res, cmd->mr_handle);
> +
> +    return 0;
> +}
> +
> +static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
> +                          uint64_t pdir_dma, uint32_t nchunks, uint32_t cqe)
> +{
> +    uint64_t *dir = NULL, *tbl = NULL;
> +    PvrdmaRing *r;
> +    int rc = -EINVAL;
> +    char ring_name[MAX_RING_NAME_SZ];
> +
> +    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
> +    dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
> +    if (!dir) {
> +        pr_dbg("Failed to map to CQ page directory\n");
> +        goto out;
> +    }
> +
> +    tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
> +    if (!tbl) {
> +        pr_dbg("Failed to map to CQ page table\n");
> +        goto out;
> +    }
> +
> +    r = g_malloc(sizeof(*r));
> +    *ring = r;
> +
> +    r->ring_state = (struct pvrdma_ring *)
> +        rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
> +
> +    if (!r->ring_state) {
> +        pr_dbg("Failed to map to CQ ring state\n");
> +        goto out_free_ring;
> +    }
> +
> +    sprintf(ring_name, "cq_ring_%lx", pdir_dma);
> +    rc = pvrdma_ring_init(r, ring_name, pci_dev, &r->ring_state[1],
> +                          cqe, sizeof(struct pvrdma_cqe),
> +                          /* first page is ring state */
> +                          (dma_addr_t *)&tbl[1], nchunks - 1);
> +    if (rc) {
> +        goto out_unmap_ring_state;
> +    }
> +
> +    goto out;
> +
> +out_unmap_ring_state:
> +    /* ring_state was in slot 1, not 0 so need to jump back */
> +    rdma_pci_dma_unmap(pci_dev, --r->ring_state, TARGET_PAGE_SIZE);
> +
> +out_free_ring:
> +    g_free(r);
> +
> +out:
> +    rdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
> +    rdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
> +
> +    return rc;
> +}
> +
> +static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                     union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_create_cq *cmd = &req->create_cq;
> +    struct pvrdma_cmd_create_cq_resp *resp = &rsp->create_cq_resp;
> +    PvrdmaRing *ring = NULL;
> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_CREATE_CQ_RESP;
> +
> +    resp->cqe = cmd->cqe;
> +
> +    resp->hdr.err = create_cq_ring(PCI_DEVICE(dev), &ring, cmd->pdir_dma,
> +                                   cmd->nchunks, cmd->cqe);
> +    if (resp->hdr.err) {
> +        goto out;
> +    }
> +
> +    pr_dbg("ring=%p\n", ring);
> +
> +    resp->hdr.err = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev,
> +                                     cmd->cqe, &resp->cq_handle, ring);
> +    resp->cqe = cmd->cqe;
> +
> +out:
> +    pr_dbg("ret=%d\n", resp->hdr.err);
> +    return resp->hdr.err;
> +}
> +
> +static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_destroy_cq *cmd = &req->destroy_cq;
> +    RdmaRmCQ *cq;
> +    PvrdmaRing *ring;
> +
> +    pr_dbg("cq_handle=%d\n", cmd->cq_handle);
> +
> +    cq = rdma_rm_get_cq(&dev->rdma_dev_res, cmd->cq_handle);
> +    if (!cq) {
> +        pr_dbg("Invalid CQ handle\n");
> +        return -EINVAL;
> +    }
> +
> +    ring = (PvrdmaRing *)cq->opaque;
> +    pvrdma_ring_free(ring);
> +    /* ring_state was in slot 1, not 0 so need to jump back */
> +    rdma_pci_dma_unmap(PCI_DEVICE(dev), --ring->ring_state, TARGET_PAGE_SIZE);
> +    g_free(ring);
> +
> +    rdma_rm_dealloc_cq(&dev->rdma_dev_res, cmd->cq_handle);
> +
> +    return 0;
> +}
> +
> +static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
> +                           PvrdmaRing **rings, uint32_t scqe, uint32_t smax_sge,
> +                           uint32_t spages, uint32_t rcqe, uint32_t rmax_sge,
> +                           uint32_t rpages)
> +{
> +    uint64_t *dir = NULL, *tbl = NULL;
> +    PvrdmaRing *sr, *rr;
> +    int rc = -EINVAL;
> +    char ring_name[MAX_RING_NAME_SZ];
> +    uint32_t wqe_sz;
> +
> +    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
> +    dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
> +    if (!dir) {
> +        pr_dbg("Failed to map to CQ page directory\n");
> +        goto out;
> +    }
> +
> +    tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
> +    if (!tbl) {
> +        pr_dbg("Failed to map to CQ page table\n");
> +        goto out;
> +    }
> +
> +    sr = g_malloc(2 * sizeof(*rr));
> +    rr = &sr[1];
> +    pr_dbg("sring=%p\n", sr);
> +    pr_dbg("rring=%p\n", rr);
> +
> +    *rings = sr;
> +
> +    pr_dbg("scqe=%d\n", scqe);
> +    pr_dbg("smax_sge=%d\n", smax_sge);
> +    pr_dbg("spages=%d\n", spages);
> +    pr_dbg("rcqe=%d\n", rcqe);
> +    pr_dbg("rmax_sge=%d\n", rmax_sge);
> +    pr_dbg("rpages=%d\n", rpages);
> +
> +    /* Create send ring */
> +    sr->ring_state = (struct pvrdma_ring *)
> +        rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
> +    if (!sr->ring_state) {
> +        pr_dbg("Failed to map to CQ ring state\n");
> +        goto out_free_sr_mem;
> +    }
> +
> +    wqe_sz = pow2ceil(sizeof(struct pvrdma_sq_wqe_hdr) +
> +                      sizeof(struct pvrdma_sge) * smax_sge - 1);
> +
> +    sprintf(ring_name, "qp_sring_%lx", pdir_dma);
> +    rc = pvrdma_ring_init(sr, ring_name, pci_dev, sr->ring_state,
> +                          scqe, wqe_sz, (dma_addr_t *)&tbl[1], spages);
> +    if (rc) {
> +        goto out_unmap_ring_state;
> +    }
> +
> +    /* Create recv ring */
> +    rr->ring_state = &sr->ring_state[1];
> +    wqe_sz = pow2ceil(sizeof(struct pvrdma_rq_wqe_hdr) +
> +                      sizeof(struct pvrdma_sge) * rmax_sge - 1);
> +    sprintf(ring_name, "qp_rring_%lx", pdir_dma);
> +    rc = pvrdma_ring_init(rr, ring_name, pci_dev, rr->ring_state,
> +                          rcqe, wqe_sz, (dma_addr_t *)&tbl[1 + spages], rpages);
> +    if (rc) {
> +        goto out_free_sr;
> +    }
> +
> +    goto out;
> +
> +out_free_sr:
> +    pvrdma_ring_free(sr);
> +
> +out_unmap_ring_state:
> +    rdma_pci_dma_unmap(pci_dev, sr->ring_state, TARGET_PAGE_SIZE);
> +
> +out_free_sr_mem:
> +    g_free(sr);
> +
> +out:
> +    rdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
> +    rdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
> +
> +    return rc;
> +}
> +
> +static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                     union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_create_qp *cmd = &req->create_qp;
> +    struct pvrdma_cmd_create_qp_resp *resp = &rsp->create_qp_resp;
> +    PvrdmaRing *rings = NULL;
> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_CREATE_QP_RESP;
> +
> +    pr_dbg("total_chunks=%d\n", cmd->total_chunks);
> +    pr_dbg("send_chunks=%d\n", cmd->send_chunks);
> +
> +    resp->hdr.err = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
> +                                    cmd->max_send_wr, cmd->max_send_sge,
> +                                    cmd->send_chunks, cmd->max_recv_wr,
> +                                    cmd->max_recv_sge, cmd->total_chunks -
> +                                    cmd->send_chunks - 1);
> +    if (resp->hdr.err) {
> +        goto out;
> +    }
> +
> +    pr_dbg("rings=%p\n", rings);
> +
> +    resp->hdr.err = rdma_rm_alloc_qp(&dev->rdma_dev_res, cmd->pd_handle,
> +                                     cmd->qp_type, cmd->max_send_wr,
> +                                     cmd->max_send_sge, cmd->send_cq_handle,
> +                                     cmd->max_recv_wr, cmd->max_recv_sge,
> +                                     cmd->recv_cq_handle, rings, &resp->qpn);
> +
> +    resp->max_send_wr = cmd->max_send_wr;
> +    resp->max_recv_wr = cmd->max_recv_wr;
> +    resp->max_send_sge = cmd->max_send_sge;
> +    resp->max_recv_sge = cmd->max_recv_sge;
> +    resp->max_inline_data = cmd->max_inline_data;
> +
> +out:
> +    pr_dbg("ret=%d\n", resp->hdr.err);
> +    return resp->hdr.err;
> +}
> +
> +static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                     union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_modify_qp *cmd = &req->modify_qp;
> +
> +    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
> +
> +    memset(rsp, 0, sizeof(*rsp));
> +    rsp->hdr.response = cmd->hdr.response;
> +    rsp->hdr.ack = PVRDMA_CMD_MODIFY_QP_RESP;
> +
> +    rsp->hdr.err = rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev,
> +                                 cmd->qp_handle, cmd->attr_mask,
> +                                 (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
> +                                 cmd->attrs.dest_qp_num, cmd->attrs.qp_state,
> +                                 cmd->attrs.qkey, cmd->attrs.rq_psn,
> +                                 cmd->attrs.sq_psn);
> +
> +    pr_dbg("ret=%d\n", rsp->hdr.err);
> +    return rsp->hdr.err;
> +}
> +
> +static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_destroy_qp *cmd = &req->destroy_qp;
> +    RdmaRmQP *qp;
> +    PvrdmaRing *ring;
> +
> +    qp = rdma_rm_get_qp(&dev->rdma_dev_res, cmd->qp_handle);
> +    if (!qp) {
> +        pr_dbg("Invalid QP handle\n");
> +        return -EINVAL;
> +    }
> +
> +    rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
> +
> +    ring = (PvrdmaRing *)qp->opaque;
> +    pr_dbg("sring=%p\n", &ring[0]);
> +    pvrdma_ring_free(&ring[0]);
> +    pr_dbg("rring=%p\n", &ring[1]);
> +    pvrdma_ring_free(&ring[1]);
> +
> +    rdma_pci_dma_unmap(PCI_DEVICE(dev), ring->ring_state, TARGET_PAGE_SIZE);
> +    g_free(ring);
> +
> +    return 0;
> +}
> +
> +static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                       union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_create_bind *cmd = &req->create_bind;
> +#ifdef PVRDMA_DEBUG
> +    __be64 *subnet = (__be64 *)&cmd->new_gid[0];
> +    __be64 *if_id = (__be64 *)&cmd->new_gid[8];
> +#endif
> +
> +    pr_dbg("index=%d\n", cmd->index);
> +
> +    if (cmd->index > MAX_PORT_GIDS) {
> +        return -EINVAL;
> +    }
> +
> +    pr_dbg("gid[%d]=0x%llx,0x%llx\n", cmd->index,
> +           (long long unsigned int)be64_to_cpu(*subnet),
> +           (long long unsigned int)be64_to_cpu(*if_id));
> +
> +    /* Driver forces to one port only */
> +    memcpy(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, &cmd->new_gid,
> +           sizeof(cmd->new_gid));
> +
> +    /* TODO: Since drivers stores node_guid at load_dsr phase then this
> +     * assignment is not relevant, i need to figure out a way how to
> +     * retrieve MAC of our netdev */
> +    dev->node_guid = dev->rdma_dev_res.ports[0].gid_tbl[0].global.interface_id;
> +    pr_dbg("dev->node_guid=0x%llx\n",
> +           (long long unsigned int)be64_to_cpu(dev->node_guid));
> +
> +    return 0;
> +}
> +
> +static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                        union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_destroy_bind *cmd = &req->destroy_bind;
> +
> +    pr_dbg("clear index %d\n", cmd->index);
> +
> +    memset(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, 0,
> +           sizeof(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw));
> +
> +    return 0;
> +}
> +
> +static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                     union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_create_uc *cmd = &req->create_uc;
> +    struct pvrdma_cmd_create_uc_resp *resp = &rsp->create_uc_resp;
> +
> +    pr_dbg("pfn=%d\n", cmd->pfn);
> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_CREATE_UC_RESP;
> +    resp->hdr.err = rdma_rm_alloc_uc(&dev->rdma_dev_res, cmd->pfn,
> +                                     &resp->ctx_handle);
> +
> +    pr_dbg("ret=%d\n", resp->hdr.err);
> +
> +    return 0;
> +}
> +
> +static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_destroy_uc *cmd = &req->destroy_uc;
> +
> +    pr_dbg("ctx_handle=%d\n", cmd->ctx_handle);
> +
> +    rdma_rm_dealloc_uc(&dev->rdma_dev_res, cmd->ctx_handle);
> +
> +    return 0;
> +}
> +struct cmd_handler {
> +    uint32_t cmd;
> +    int (*exec)(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +            union pvrdma_cmd_resp *rsp);
> +};
> +
> +static struct cmd_handler cmd_handlers[] = {
> +    {PVRDMA_CMD_QUERY_PORT, query_port},
> +    {PVRDMA_CMD_QUERY_PKEY, query_pkey},
> +    {PVRDMA_CMD_CREATE_PD, create_pd},
> +    {PVRDMA_CMD_DESTROY_PD, destroy_pd},
> +    {PVRDMA_CMD_CREATE_MR, create_mr},
> +    {PVRDMA_CMD_DESTROY_MR, destroy_mr},
> +    {PVRDMA_CMD_CREATE_CQ, create_cq},
> +    {PVRDMA_CMD_RESIZE_CQ, NULL},
> +    {PVRDMA_CMD_DESTROY_CQ, destroy_cq},
> +    {PVRDMA_CMD_CREATE_QP, create_qp},
> +    {PVRDMA_CMD_MODIFY_QP, modify_qp},
> +    {PVRDMA_CMD_QUERY_QP, NULL},
> +    {PVRDMA_CMD_DESTROY_QP, destroy_qp},
> +    {PVRDMA_CMD_CREATE_UC, create_uc},
> +    {PVRDMA_CMD_DESTROY_UC, destroy_uc},
> +    {PVRDMA_CMD_CREATE_BIND, create_bind},
> +    {PVRDMA_CMD_DESTROY_BIND, destroy_bind},
> +};
> +
> +int execute_command(PVRDMADev *dev)
> +{
> +    int err = 0xFFFF;
> +    DSRInfo *dsr_info;
> +
> +    dsr_info = &dev->dsr_info;
> +
> +    pr_dbg("cmd=%d\n", dsr_info->req->hdr.cmd);
> +    if (dsr_info->req->hdr.cmd >= sizeof(cmd_handlers) /
> +                      sizeof(struct cmd_handler)) {
> +        pr_dbg("Unsupported command\n");
> +        goto out;
> +    }
> +
> +    if (!cmd_handlers[dsr_info->req->hdr.cmd].exec) {
> +        pr_dbg("Unsupported command (not implemented yet)\n");
> +        goto out;
> +    }
> +
> +    err = cmd_handlers[dsr_info->req->hdr.cmd].exec(dev, dsr_info->req,
> +                            dsr_info->rsp);
> +out:
> +    set_reg_val(dev, PVRDMA_REG_ERR, err);
> +    post_interrupt(dev, INTR_VEC_CMD_RING);
> +
> +    return (err == 0) ? 0 : -EINVAL;
> +}
> diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
> new file mode 100644
> index 0000000000..ec309dad55
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_dev_ring.c
> @@ -0,0 +1,155 @@
> +/*
> + * QEMU paravirtual RDMA - Device rings
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <qemu/osdep.h>
> +#include <hw/pci/pci.h>
> +#include <cpu.h>
> +
> +#include "../rdma_utils.h"
> +#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h>
> +#include "pvrdma_dev_ring.h"
> +
> +int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
> +                     struct pvrdma_ring *ring_state, uint32_t max_elems,
> +                     size_t elem_sz, dma_addr_t *tbl, dma_addr_t npages)
> +{
> +    int i;
> +    int rc = 0;
> +
> +    strncpy(ring->name, name, MAX_RING_NAME_SZ);
> +    ring->name[MAX_RING_NAME_SZ - 1] = 0;
> +    pr_dbg("Initializing %s ring\n", ring->name);
> +    ring->dev = dev;
> +    ring->ring_state = ring_state;
> +    ring->max_elems = max_elems;
> +    ring->elem_sz = elem_sz;
> +    pr_dbg("ring->elem_sz=%ld\n", ring->elem_sz);
> +    pr_dbg("npages=%ld\n", npages);
> +    /* TODO: Give a moment to think if we want to redo driver settings
> +    atomic_set(&ring->ring_state->prod_tail, 0);
> +    atomic_set(&ring->ring_state->cons_head, 0);
> +    */
> +    ring->npages = npages;
> +    ring->pages = g_malloc(npages * sizeof(void *));
> +
> +    for (i = 0; i < npages; i++) {
> +        if (!tbl[i]) {
> +            pr_err("npages=%ld but tbl[%d] is NULL\n", (long)npages, i);
> +            continue;
> +        }
> +
> +        ring->pages[i] = rdma_pci_dma_map(dev, tbl[i], TARGET_PAGE_SIZE);
> +        if (!ring->pages[i]) {
> +            rc = -ENOMEM;
> +            pr_dbg("Failed to map to page %d\n", i);
> +            goto out_free;
> +        }
> +        memset(ring->pages[i], 0, TARGET_PAGE_SIZE);
> +    }
> +
> +    goto out;
> +
> +out_free:
> +    while (i--) {
> +        rdma_pci_dma_unmap(dev, ring->pages[i], TARGET_PAGE_SIZE);
> +    }
> +    g_free(ring->pages);
> +
> +out:
> +    return rc;
> +}
> +
> +void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
> +{
> +    unsigned int idx = 0, offset;
> +
> +    /*
> +    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
> +           ring->ring_state->cons_head);
> +    */
> +
> +    if (!pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx)) {
> +        pr_dbg("No more data in ring\n");
> +        return NULL;
> +    }
> +
> +    offset = idx * ring->elem_sz;
> +    /*
> +    pr_dbg("idx=%d\n", idx);
> +    pr_dbg("offset=%d\n", offset);
> +    */
> +    return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
> +}
> +
> +void pvrdma_ring_read_inc(PvrdmaRing *ring)
> +{
> +    pvrdma_idx_ring_inc(&ring->ring_state->cons_head, ring->max_elems);
> +    /*
> +    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
> +           ring->ring_state->prod_tail, ring->ring_state->cons_head,
> +           ring->max_elems);
> +    */
> +}
> +
> +void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
> +{
> +    unsigned int idx, offset, tail;
> +
> +    /*
> +    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
> +           ring->ring_state->cons_head);
> +    */
> +
> +    if (!pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail)) {
> +        pr_dbg("CQ is full\n");
> +        return NULL;
> +    }
> +
> +    idx = pvrdma_idx(&ring->ring_state->prod_tail, ring->max_elems);
> +    /* TODO: tail == idx */
> +
> +    offset = idx * ring->elem_sz;
> +    return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
> +}
> +
> +void pvrdma_ring_write_inc(PvrdmaRing *ring)
> +{
> +    pvrdma_idx_ring_inc(&ring->ring_state->prod_tail, ring->max_elems);
> +    /*
> +    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
> +           ring->ring_state->prod_tail, ring->ring_state->cons_head,
> +           ring->max_elems);
> +    */
> +}
> +
> +void pvrdma_ring_free(PvrdmaRing *ring)
> +{
> +    if (!ring) {
> +        return;
> +    }
> +
> +    if (!ring->pages) {
> +        return;
> +    }
> +
> +    pr_dbg("ring->npages=%d\n", ring->npages);
> +    while (ring->npages--) {
> +        rdma_pci_dma_unmap(ring->dev, ring->pages[ring->npages],
> +                           TARGET_PAGE_SIZE);
> +    }
> +
> +    g_free(ring->pages);
> +    ring->pages = NULL;
> +}
> diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.h
> new file mode 100644
> index 0000000000..02a590b86d
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_dev_ring.h
> @@ -0,0 +1,42 @@
> +/*
> + * QEMU VMWARE paravirtual RDMA ring utilities
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef PVRDMA_DEV_RING_H
> +#define PVRDMA_DEV_RING_H
> +
> +#include <qemu/typedefs.h>
> +
> +#define MAX_RING_NAME_SZ 32
> +
> +typedef struct PvrdmaRing {
> +    char name[MAX_RING_NAME_SZ];
> +    PCIDevice *dev;
> +    uint32_t max_elems;
> +    size_t elem_sz;
> +    struct pvrdma_ring *ring_state; /* used only for unmap */
> +    int npages;
> +    void **pages;
> +} PvrdmaRing;
> +
> +int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
> +                     struct pvrdma_ring *ring_state, uint32_t max_elems,
> +                     size_t elem_sz, dma_addr_t *tbl, dma_addr_t npages);
> +void *pvrdma_ring_next_elem_read(PvrdmaRing *ring);
> +void pvrdma_ring_read_inc(PvrdmaRing *ring);
> +void *pvrdma_ring_next_elem_write(PvrdmaRing *ring);
> +void pvrdma_ring_write_inc(PvrdmaRing *ring);
> +void pvrdma_ring_free(PvrdmaRing *ring);
> +
> +#endif
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> new file mode 100644
> index 0000000000..f0a1f9eb02
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -0,0 +1,222 @@
> +/*
> + * QEMU paravirtual RDMA - QP implementation
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <qemu/osdep.h>
> +
> +#include "../rdma_utils.h"
> +#include "../rdma_rm.h"
> +#include "../rdma_backend.h"
> +
> +#include "pvrdma.h"
> +#include <standard-headers/rdma/vmw_pvrdma-abi.h>
> +#include "pvrdma_qp_ops.h"
> +
> +typedef struct CompHandlerCtx {
> +    PVRDMADev *dev;
> +    uint32_t cq_handle;
> +    struct pvrdma_cqe cqe;
> +} CompHandlerCtx;
> +
> +/* Send Queue WQE */
> +typedef struct PvrdmaSqWqe {
> +    struct pvrdma_sq_wqe_hdr hdr;
> +    struct pvrdma_sge sge[0];
> +} PvrdmaSqWqe;
> +
> +/* Recv Queue WQE */
> +typedef struct PvrdmaRqWqe {
> +    struct pvrdma_rq_wqe_hdr hdr;
> +    struct pvrdma_sge sge[0];
> +} PvrdmaRqWqe;
> +
> +/*
> + * 1. Put CQE on send CQ ring
> + * 2. Put CQ number on dsr completion ring
> + * 3. Interrupt host
> + */
> +static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
> +                           struct pvrdma_cqe *cqe)
> +{
> +    struct pvrdma_cqe *cqe1;
> +    struct pvrdma_cqne *cqne;
> +    PvrdmaRing *ring;
> +    RdmaRmCQ *cq = rdma_rm_get_cq(&dev->rdma_dev_res, cq_handle);
> +
> +    if (unlikely(!cq)) {
> +        pr_dbg("Invalid cqn %d\n", cq_handle);
> +        return -EINVAL;
> +    }
> +
> +    ring = (PvrdmaRing *)cq->opaque;
> +    pr_dbg("ring=%p\n", ring);
> +
> +    /* Step #1: Put CQE on CQ ring */
> +    pr_dbg("Writing CQE\n");
> +    cqe1 = pvrdma_ring_next_elem_write(ring);
> +    if (unlikely(!cqe1)) {
> +        return -EINVAL;
> +    }
> +
> +    cqe1->wr_id = cqe->wr_id;
> +    cqe1->qp = cqe->qp;
> +    cqe1->opcode = cqe->opcode;
> +    cqe1->status = cqe->status;
> +    cqe1->vendor_err = cqe->vendor_err;
> +
> +    pvrdma_ring_write_inc(ring);
> +
> +    /* Step #2: Put CQ number on dsr completion ring */
> +    pr_dbg("Writing CQNE\n");
> +    cqne = pvrdma_ring_next_elem_write(&dev->dsr_info.cq);
> +    if (unlikely(!cqne)) {
> +        return -EINVAL;
> +    }
> +
> +    cqne->info = cq_handle;
> +    pvrdma_ring_write_inc(&dev->dsr_info.cq);
> +
> +    pr_dbg("cq->notify=%d\n", cq->notify);
> +    if (cq->notify) {
> +        cq->notify = false;
> +        post_interrupt(dev, INTR_VEC_CMD_COMPLETION_Q);
> +    }
> +
> +    return 0;
> +}
> +
> +static void pvrdma_qp_ops_comp_handler(int status, unsigned int vendor_err,
> +                                       void *ctx)
> +{
> +    CompHandlerCtx *comp_ctx = (CompHandlerCtx *)ctx;
> +
> +    pr_dbg("cq_handle=%d\n", comp_ctx->cq_handle);
> +    pr_dbg("wr_id=%ld\n", comp_ctx->cqe.wr_id);
> +    pr_dbg("status=%d\n", status);
> +    pr_dbg("vendor_err=0x%x\n", vendor_err);
> +    comp_ctx->cqe.status = status;
> +    comp_ctx->cqe.vendor_err = vendor_err;
> +    pvrdma_post_cqe(comp_ctx->dev, comp_ctx->cq_handle, &comp_ctx->cqe);
> +    g_free(ctx);
> +}
> +
> +void pvrdma_qp_ops_fini(void)
> +{
> +    rdma_backend_unregister_comp_handler();
> +}
> +
> +int pvrdma_qp_ops_init(void)
> +{
> +    rdma_backend_register_comp_handler(pvrdma_qp_ops_comp_handler);
> +
> +    return 0;
> +}
> +
> +int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
> +{
> +    RdmaRmQP *qp;
> +    PvrdmaSqWqe *wqe;
> +    PvrdmaRing *ring;
> +
> +    pr_dbg("qp_handle=%d\n", qp_handle);
> +
> +    qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
> +    if (unlikely(!qp)) {
> +        return -EINVAL;
> +    }
> +
> +    ring = (PvrdmaRing *)qp->opaque;
> +    pr_dbg("sring=%p\n", ring);
> +
> +    wqe = (struct PvrdmaSqWqe *)pvrdma_ring_next_elem_read(ring);
> +    while (wqe) {
> +        CompHandlerCtx *comp_ctx;
> +
> +        pr_dbg("wr_id=%ld\n", wqe->hdr.wr_id);
> +
> +        /* Prepare CQE */
> +        comp_ctx = g_malloc(sizeof(CompHandlerCtx));
> +        comp_ctx->dev = dev;
> +        comp_ctx->cq_handle = qp->send_cq_handle;
> +        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
> +        comp_ctx->cqe.qp = qp_handle;
> +        comp_ctx->cqe.opcode = wqe->hdr.opcode;
> +
> +        rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
> +                               (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
> +                               (union ibv_gid *)wqe->hdr.wr.ud.av.dgid,
> +                               wqe->hdr.wr.ud.remote_qpn,
> +                               wqe->hdr.wr.ud.remote_qkey, comp_ctx);
> +
> +        pvrdma_ring_read_inc(ring);
> +
> +        wqe = pvrdma_ring_next_elem_read(ring);
> +    }
> +
> +    return 0;
> +}
> +
> +int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
> +{
> +    RdmaRmQP *qp;
> +    PvrdmaRqWqe *wqe;
> +    PvrdmaRing *ring;
> +
> +    pr_dbg("qp_handle=%d\n", qp_handle);
> +
> +    qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
> +    if (unlikely(!qp)) {
> +        return -EINVAL;
> +    }
> +
> +    ring = &((PvrdmaRing *)qp->opaque)[1];
> +    pr_dbg("rring=%p\n", ring);
> +
> +    wqe = (struct PvrdmaRqWqe *)pvrdma_ring_next_elem_read(ring);
> +    while (wqe) {
> +        CompHandlerCtx *comp_ctx;
> +
> +        pr_dbg("wr_id=%ld\n", wqe->hdr.wr_id);
> +
> +        /* Prepare CQE */
> +        comp_ctx = g_malloc(sizeof(CompHandlerCtx));
> +        comp_ctx->dev = dev;
> +        comp_ctx->cq_handle = qp->recv_cq_handle;
> +        comp_ctx->cqe.qp = qp_handle;
> +        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
> +
> +        rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
> +                               &qp->backend_qp, qp->qp_type,
> +                               (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
> +                               comp_ctx);
> +
> +        pvrdma_ring_read_inc(ring);
> +
> +        wqe = pvrdma_ring_next_elem_read(ring);
> +    }
> +
> +    return 0;
> +}
> +
> +void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
> +{
> +    RdmaRmCQ *cq;
> +
> +    cq = rdma_rm_get_cq(dev_res, cq_handle);
> +    if (!cq) {
> +        pr_dbg("Invalid CQ# %d\n", cq_handle);
> +    }
> +
> +    rdma_backend_poll_cq(dev_res, &cq->backend_cq);
> +}
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h
> new file mode 100644
> index 0000000000..ac46bf7fdf
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.h
> @@ -0,0 +1,27 @@
> +/*
> + * QEMU VMWARE paravirtual RDMA QP Operations
> + *
> + * Copyright (C) 2018 Oracle
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *     Yuval Shaia <yuval.shaia@oracle.com>
> + *     Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef PVRDMA_QP_H
> +#define PVRDMA_QP_H
> +
> +#include "pvrdma.h"
> +
> +int pvrdma_qp_ops_init(void);
> +void pvrdma_qp_ops_fini(void);
> +int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle);
> +int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle);
> +void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle);
> +
> +#endif
