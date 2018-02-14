Received: from eggs.gnu.org ([2001:4830:134:3::10]:59823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1elxtO-0004de-0H
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1elxtJ-0001Vq-8R
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:18:38 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:42431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1elxtI-0001TH-Rx
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:18:33 -0500
Received: by mail-ot0-f173.google.com with SMTP id a7so20493979otk.9
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 06:18:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212180819.82556-4-marcel@redhat.com>
References: <20180212180819.82556-1-marcel@redhat.com>
	<20180212180819.82556-4-marcel@redhat.com>
From: Gal Hammer <ghammer@redhat.com>
Date: Wed, 14 Feb 2018 16:18:28 +0200
Message-ID: <CAA2ifQz=6tHeMJ9FX8krnymPNU7cAyN5nqa5gAgaU09uxuF+YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 3/9] include/standard-headers: add
 pvrdma related headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com, Michael Tsirkin <mst@redhat.com>, yuval.shaia@oracle.com, yanjun.zhu@oracle.com, dotanb@mellanox.com

Hi,

I'm not familiar with the pvrdma device itself, but I reviewed the
changes to the update-linux-headers.sh script.

Reviewed-by: Gal Hammer <ghammer@redhat.com>

    Gal.


On Mon, Feb 12, 2018 at 8:08 PM, Marcel Apfelbaum <marcel@redhat.com> wrote:
> Also modify update-linux-headers.sh script to manage
> the headers needed by the pvrdma device.
>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h      | 667 +++++++++++++++++++++
>  .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h | 114 ++++
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        | 383 ++++++++++++
>  include/standard-headers/rdma/vmw_pvrdma-abi.h     | 293 +++++++++
>  scripts/update-linux-headers.sh                    |  27 +
>  5 files changed, 1484 insertions(+)
>  create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
>  create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
>  create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
>  create mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h
>
> diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> new file mode 100644
> index 0000000000..422eb3f4c1
> --- /dev/null
> +++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> @@ -0,0 +1,667 @@
> +/*
> + * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of EITHER the GNU General Public License
> + * version 2 as published by the Free Software Foundation or the BSD
> + * 2-Clause License. This program is distributed in the hope that it
> + * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
> + * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License version 2 for more details at
> + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program available in the file COPYING in the main
> + * directory of this source tree.
> + *
> + * The BSD 2-Clause License
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#ifndef __PVRDMA_DEV_API_H__
> +#define __PVRDMA_DEV_API_H__
> +
> +#include "standard-headers/linux/types.h"
> +
> +#include "pvrdma_verbs.h"
> +
> +/*
> + * PVRDMA version macros. Some new features require updates to PVRDMA_VERSION.
> + * These macros allow us to check for different features if necessary.
> + */
> +
> +#define PVRDMA_ROCEV1_VERSION          17
> +#define PVRDMA_ROCEV2_VERSION          18
> +#define PVRDMA_VERSION                 PVRDMA_ROCEV2_VERSION
> +
> +#define PVRDMA_BOARD_ID                        1
> +#define PVRDMA_REV_ID                  1
> +
> +/*
> + * Masks and accessors for page directory, which is a two-level lookup:
> + * page directory -> page table -> page. Only one directory for now, but we
> + * could expand that easily. 9 bits for tables, 9 bits for pages, gives one
> + * gigabyte for memory regions and so forth.
> + */
> +
> +#define PVRDMA_PDIR_SHIFT              18
> +#define PVRDMA_PTABLE_SHIFT            9
> +#define PVRDMA_PAGE_DIR_DIR(x)         (((x) >> PVRDMA_PDIR_SHIFT) & 0x1)
> +#define PVRDMA_PAGE_DIR_TABLE(x)       (((x) >> PVRDMA_PTABLE_SHIFT) & 0x1ff)
> +#define PVRDMA_PAGE_DIR_PAGE(x)                ((x) & 0x1ff)
> +#define PVRDMA_PAGE_DIR_MAX_PAGES      (1 * 512 * 512)
> +#define PVRDMA_MAX_FAST_REG_PAGES      128
> +
> +/*
> + * Max MSI-X vectors.
> + */
> +
> +#define PVRDMA_MAX_INTERRUPTS  3
> +
> +/* Register offsets within PCI resource on BAR1. */
> +#define PVRDMA_REG_VERSION     0x00    /* R: Version of device. */
> +#define PVRDMA_REG_DSRLOW      0x04    /* W: Device shared region low PA. */
> +#define PVRDMA_REG_DSRHIGH     0x08    /* W: Device shared region high PA. */
> +#define PVRDMA_REG_CTL         0x0c    /* W: PVRDMA_DEVICE_CTL */
> +#define PVRDMA_REG_REQUEST     0x10    /* W: Indicate device request. */
> +#define PVRDMA_REG_ERR         0x14    /* R: Device error. */
> +#define PVRDMA_REG_ICR         0x18    /* R: Interrupt cause. */
> +#define PVRDMA_REG_IMR         0x1c    /* R/W: Interrupt mask. */
> +#define PVRDMA_REG_MACL                0x20    /* R/W: MAC address low. */
> +#define PVRDMA_REG_MACH                0x24    /* R/W: MAC address high. */
> +
> +/* Object flags. */
> +#define PVRDMA_CQ_FLAG_ARMED_SOL       BIT(0)  /* Armed for solicited-only. */
> +#define PVRDMA_CQ_FLAG_ARMED           BIT(1)  /* Armed. */
> +#define PVRDMA_MR_FLAG_DMA             BIT(0)  /* DMA region. */
> +#define PVRDMA_MR_FLAG_FRMR            BIT(1)  /* Fast reg memory region. */
> +
> +/*
> + * Atomic operation capability (masked versions are extended atomic
> + * operations.
> + */
> +
> +#define PVRDMA_ATOMIC_OP_COMP_SWAP     BIT(0)  /* Compare and swap. */
> +#define PVRDMA_ATOMIC_OP_FETCH_ADD     BIT(1)  /* Fetch and add. */
> +#define PVRDMA_ATOMIC_OP_MASK_COMP_SWAP        BIT(2)  /* Masked compare and swap. */
> +#define PVRDMA_ATOMIC_OP_MASK_FETCH_ADD        BIT(3)  /* Masked fetch and add. */
> +
> +/*
> + * Base Memory Management Extension flags to support Fast Reg Memory Regions
> + * and Fast Reg Work Requests. Each flag represents a verb operation and we
> + * must support all of them to qualify for the BMME device cap.
> + */
> +
> +#define PVRDMA_BMME_FLAG_LOCAL_INV     BIT(0)  /* Local Invalidate. */
> +#define PVRDMA_BMME_FLAG_REMOTE_INV    BIT(1)  /* Remote Invalidate. */
> +#define PVRDMA_BMME_FLAG_FAST_REG_WR   BIT(2)  /* Fast Reg Work Request. */
> +
> +/*
> + * GID types. The interpretation of the gid_types bit field in the device
> + * capabilities will depend on the device mode. For now, the device only
> + * supports RoCE as mode, so only the different GID types for RoCE are
> + * defined.
> + */
> +
> +#define PVRDMA_GID_TYPE_FLAG_ROCE_V1   BIT(0)
> +#define PVRDMA_GID_TYPE_FLAG_ROCE_V2   BIT(1)
> +
> +/*
> + * Version checks. This checks whether each version supports specific
> + * capabilities from the device.
> + */
> +
> +#define PVRDMA_IS_VERSION17(_dev)                                      \
> +       (_dev->dsr_version == PVRDMA_ROCEV1_VERSION &&                  \
> +        _dev->dsr->caps.gid_types == PVRDMA_GID_TYPE_FLAG_ROCE_V1)
> +
> +#define PVRDMA_IS_VERSION18(_dev)                                      \
> +       (_dev->dsr_version >= PVRDMA_ROCEV2_VERSION &&                  \
> +        (_dev->dsr->caps.gid_types == PVRDMA_GID_TYPE_FLAG_ROCE_V1 ||  \
> +         _dev->dsr->caps.gid_types == PVRDMA_GID_TYPE_FLAG_ROCE_V2))   \
> +
> +#define PVRDMA_SUPPORTED(_dev)                                         \
> +       ((_dev->dsr->caps.mode == PVRDMA_DEVICE_MODE_ROCE) &&           \
> +        (PVRDMA_IS_VERSION17(_dev) || PVRDMA_IS_VERSION18(_dev)))
> +
> +/*
> + * Get capability values based on device version.
> + */
> +
> +#define PVRDMA_GET_CAP(_dev, _old_val, _val) \
> +       ((PVRDMA_IS_VERSION18(_dev)) ? _val : _old_val)
> +
> +enum pvrdma_pci_resource {
> +       PVRDMA_PCI_RESOURCE_MSIX,       /* BAR0: MSI-X, MMIO. */
> +       PVRDMA_PCI_RESOURCE_REG,        /* BAR1: Registers, MMIO. */
> +       PVRDMA_PCI_RESOURCE_UAR,        /* BAR2: UAR pages, MMIO, 64-bit. */
> +       PVRDMA_PCI_RESOURCE_LAST,       /* Last. */
> +};
> +
> +enum pvrdma_device_ctl {
> +       PVRDMA_DEVICE_CTL_ACTIVATE,     /* Activate device. */
> +       PVRDMA_DEVICE_CTL_UNQUIESCE,    /* Unquiesce device. */
> +       PVRDMA_DEVICE_CTL_RESET,        /* Reset device. */
> +};
> +
> +enum pvrdma_intr_vector {
> +       PVRDMA_INTR_VECTOR_RESPONSE,    /* Command response. */
> +       PVRDMA_INTR_VECTOR_ASYNC,       /* Async events. */
> +       PVRDMA_INTR_VECTOR_CQ,          /* CQ notification. */
> +       /* Additional CQ notification vectors. */
> +};
> +
> +enum pvrdma_intr_cause {
> +       PVRDMA_INTR_CAUSE_RESPONSE      = (1 << PVRDMA_INTR_VECTOR_RESPONSE),
> +       PVRDMA_INTR_CAUSE_ASYNC         = (1 << PVRDMA_INTR_VECTOR_ASYNC),
> +       PVRDMA_INTR_CAUSE_CQ            = (1 << PVRDMA_INTR_VECTOR_CQ),
> +};
> +
> +enum pvrdma_gos_bits {
> +       PVRDMA_GOS_BITS_UNK,            /* Unknown. */
> +       PVRDMA_GOS_BITS_32,             /* 32-bit. */
> +       PVRDMA_GOS_BITS_64,             /* 64-bit. */
> +};
> +
> +enum pvrdma_gos_type {
> +       PVRDMA_GOS_TYPE_UNK,            /* Unknown. */
> +       PVRDMA_GOS_TYPE_LINUX,          /* Linux. */
> +};
> +
> +enum pvrdma_device_mode {
> +       PVRDMA_DEVICE_MODE_ROCE,        /* RoCE. */
> +       PVRDMA_DEVICE_MODE_IWARP,       /* iWarp. */
> +       PVRDMA_DEVICE_MODE_IB,          /* InfiniBand. */
> +};
> +
> +struct pvrdma_gos_info {
> +       uint32_t gos_bits:2;                    /* W: PVRDMA_GOS_BITS_ */
> +       uint32_t gos_type:4;                    /* W: PVRDMA_GOS_TYPE_ */
> +       uint32_t gos_ver:16;                    /* W: Guest OS version. */
> +       uint32_t gos_misc:10;           /* W: Other. */
> +       uint32_t pad;                   /* Pad to 8-byte alignment. */
> +};
> +
> +struct pvrdma_device_caps {
> +       uint64_t fw_ver;                                /* R: Query device. */
> +       uint64_t node_guid;
> +       uint64_t sys_image_guid;
> +       uint64_t max_mr_size;
> +       uint64_t page_size_cap;
> +       uint64_t atomic_arg_sizes;                      /* EX verbs. */
> +       uint32_t ex_comp_mask;                  /* EX verbs. */
> +       uint32_t device_cap_flags2;                     /* EX verbs. */
> +       uint32_t max_fa_bit_boundary;           /* EX verbs. */
> +       uint32_t log_max_atomic_inline_arg;             /* EX verbs. */
> +       uint32_t vendor_id;
> +       uint32_t vendor_part_id;
> +       uint32_t hw_ver;
> +       uint32_t max_qp;
> +       uint32_t max_qp_wr;
> +       uint32_t device_cap_flags;
> +       uint32_t max_sge;
> +       uint32_t max_sge_rd;
> +       uint32_t max_cq;
> +       uint32_t max_cqe;
> +       uint32_t max_mr;
> +       uint32_t max_pd;
> +       uint32_t max_qp_rd_atom;
> +       uint32_t max_ee_rd_atom;
> +       uint32_t max_res_rd_atom;
> +       uint32_t max_qp_init_rd_atom;
> +       uint32_t max_ee_init_rd_atom;
> +       uint32_t max_ee;
> +       uint32_t max_rdd;
> +       uint32_t max_mw;
> +       uint32_t max_raw_ipv6_qp;
> +       uint32_t max_raw_ethy_qp;
> +       uint32_t max_mcast_grp;
> +       uint32_t max_mcast_qp_attach;
> +       uint32_t max_total_mcast_qp_attach;
> +       uint32_t max_ah;
> +       uint32_t max_fmr;
> +       uint32_t max_map_per_fmr;
> +       uint32_t max_srq;
> +       uint32_t max_srq_wr;
> +       uint32_t max_srq_sge;
> +       uint32_t max_uar;
> +       uint32_t gid_tbl_len;
> +       uint16_t max_pkeys;
> +       uint8_t  local_ca_ack_delay;
> +       uint8_t  phys_port_cnt;
> +       uint8_t  mode;                          /* PVRDMA_DEVICE_MODE_ */
> +       uint8_t  atomic_ops;                            /* PVRDMA_ATOMIC_OP_* bits */
> +       uint8_t  bmme_flags;                            /* FRWR Mem Mgmt Extensions */
> +       uint8_t  gid_types;                             /* PVRDMA_GID_TYPE_FLAG_ */
> +       uint32_t max_fast_reg_page_list_len;
> +};
> +
> +struct pvrdma_ring_page_info {
> +       uint32_t num_pages;                             /* Num pages incl. header. */
> +       uint32_t reserved;                              /* Reserved. */
> +       uint64_t pdir_dma;                              /* Page directory PA. */
> +};
> +
> +#pragma pack(push, 1)
> +
> +struct pvrdma_device_shared_region {
> +       uint32_t driver_version;                        /* W: Driver version. */
> +       uint32_t pad;                           /* Pad to 8-byte align. */
> +       struct pvrdma_gos_info gos_info;        /* W: Guest OS information. */
> +       uint64_t cmd_slot_dma;                  /* W: Command slot address. */
> +       uint64_t resp_slot_dma;                 /* W: Response slot address. */
> +       struct pvrdma_ring_page_info async_ring_pages;
> +                                               /* W: Async ring page info. */
> +       struct pvrdma_ring_page_info cq_ring_pages;
> +                                               /* W: CQ ring page info. */
> +       uint32_t uar_pfn;                               /* W: UAR pageframe. */
> +       uint32_t pad2;                          /* Pad to 8-byte align. */
> +       struct pvrdma_device_caps caps;         /* R: Device capabilities. */
> +};
> +
> +#pragma pack(pop)
> +
> +/* Event types. Currently a 1:1 mapping with enum ib_event. */
> +enum pvrdma_eqe_type {
> +       PVRDMA_EVENT_CQ_ERR,
> +       PVRDMA_EVENT_QP_FATAL,
> +       PVRDMA_EVENT_QP_REQ_ERR,
> +       PVRDMA_EVENT_QP_ACCESS_ERR,
> +       PVRDMA_EVENT_COMM_EST,
> +       PVRDMA_EVENT_SQ_DRAINED,
> +       PVRDMA_EVENT_PATH_MIG,
> +       PVRDMA_EVENT_PATH_MIG_ERR,
> +       PVRDMA_EVENT_DEVICE_FATAL,
> +       PVRDMA_EVENT_PORT_ACTIVE,
> +       PVRDMA_EVENT_PORT_ERR,
> +       PVRDMA_EVENT_LID_CHANGE,
> +       PVRDMA_EVENT_PKEY_CHANGE,
> +       PVRDMA_EVENT_SM_CHANGE,
> +       PVRDMA_EVENT_SRQ_ERR,
> +       PVRDMA_EVENT_SRQ_LIMIT_REACHED,
> +       PVRDMA_EVENT_QP_LAST_WQE_REACHED,
> +       PVRDMA_EVENT_CLIENT_REREGISTER,
> +       PVRDMA_EVENT_GID_CHANGE,
> +};
> +
> +/* Event queue element. */
> +struct pvrdma_eqe {
> +       uint32_t type;  /* Event type. */
> +       uint32_t info;  /* Handle, other. */
> +};
> +
> +/* CQ notification queue element. */
> +struct pvrdma_cqne {
> +       uint32_t info;  /* Handle */
> +};
> +
> +enum {
> +       PVRDMA_CMD_FIRST,
> +       PVRDMA_CMD_QUERY_PORT = PVRDMA_CMD_FIRST,
> +       PVRDMA_CMD_QUERY_PKEY,
> +       PVRDMA_CMD_CREATE_PD,
> +       PVRDMA_CMD_DESTROY_PD,
> +       PVRDMA_CMD_CREATE_MR,
> +       PVRDMA_CMD_DESTROY_MR,
> +       PVRDMA_CMD_CREATE_CQ,
> +       PVRDMA_CMD_RESIZE_CQ,
> +       PVRDMA_CMD_DESTROY_CQ,
> +       PVRDMA_CMD_CREATE_QP,
> +       PVRDMA_CMD_MODIFY_QP,
> +       PVRDMA_CMD_QUERY_QP,
> +       PVRDMA_CMD_DESTROY_QP,
> +       PVRDMA_CMD_CREATE_UC,
> +       PVRDMA_CMD_DESTROY_UC,
> +       PVRDMA_CMD_CREATE_BIND,
> +       PVRDMA_CMD_DESTROY_BIND,
> +       PVRDMA_CMD_CREATE_SRQ,
> +       PVRDMA_CMD_MODIFY_SRQ,
> +       PVRDMA_CMD_QUERY_SRQ,
> +       PVRDMA_CMD_DESTROY_SRQ,
> +       PVRDMA_CMD_MAX,
> +};
> +
> +enum {
> +       PVRDMA_CMD_FIRST_RESP = (1 << 31),
> +       PVRDMA_CMD_QUERY_PORT_RESP = PVRDMA_CMD_FIRST_RESP,
> +       PVRDMA_CMD_QUERY_PKEY_RESP,
> +       PVRDMA_CMD_CREATE_PD_RESP,
> +       PVRDMA_CMD_DESTROY_PD_RESP_NOOP,
> +       PVRDMA_CMD_CREATE_MR_RESP,
> +       PVRDMA_CMD_DESTROY_MR_RESP_NOOP,
> +       PVRDMA_CMD_CREATE_CQ_RESP,
> +       PVRDMA_CMD_RESIZE_CQ_RESP,
> +       PVRDMA_CMD_DESTROY_CQ_RESP_NOOP,
> +       PVRDMA_CMD_CREATE_QP_RESP,
> +       PVRDMA_CMD_MODIFY_QP_RESP,
> +       PVRDMA_CMD_QUERY_QP_RESP,
> +       PVRDMA_CMD_DESTROY_QP_RESP,
> +       PVRDMA_CMD_CREATE_UC_RESP,
> +       PVRDMA_CMD_DESTROY_UC_RESP_NOOP,
> +       PVRDMA_CMD_CREATE_BIND_RESP_NOOP,
> +       PVRDMA_CMD_DESTROY_BIND_RESP_NOOP,
> +       PVRDMA_CMD_CREATE_SRQ_RESP,
> +       PVRDMA_CMD_MODIFY_SRQ_RESP,
> +       PVRDMA_CMD_QUERY_SRQ_RESP,
> +       PVRDMA_CMD_DESTROY_SRQ_RESP,
> +       PVRDMA_CMD_MAX_RESP,
> +};
> +
> +struct pvrdma_cmd_hdr {
> +       uint64_t response;              /* Key for response lookup. */
> +       uint32_t cmd;           /* PVRDMA_CMD_ */
> +       uint32_t reserved;              /* Reserved. */
> +};
> +
> +struct pvrdma_cmd_resp_hdr {
> +       uint64_t response;              /* From cmd hdr. */
> +       uint32_t ack;           /* PVRDMA_CMD_XXX_RESP */
> +       uint8_t err;                    /* Error. */
> +       uint8_t reserved[3];            /* Reserved. */
> +};
> +
> +struct pvrdma_cmd_query_port {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint8_t port_num;
> +       uint8_t reserved[7];
> +};
> +
> +struct pvrdma_cmd_query_port_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       struct pvrdma_port_attr attrs;
> +};
> +
> +struct pvrdma_cmd_query_pkey {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint8_t port_num;
> +       uint8_t index;
> +       uint8_t reserved[6];
> +};
> +
> +struct pvrdma_cmd_query_pkey_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint16_t pkey;
> +       uint8_t reserved[6];
> +};
> +
> +struct pvrdma_cmd_create_uc {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t pfn; /* UAR page frame number */
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_uc_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t ctx_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_destroy_uc {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t ctx_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_pd {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t ctx_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_pd_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t pd_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_destroy_pd {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t pd_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_mr {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint64_t start;
> +       uint64_t length;
> +       uint64_t pdir_dma;
> +       uint32_t pd_handle;
> +       uint32_t access_flags;
> +       uint32_t flags;
> +       uint32_t nchunks;
> +};
> +
> +struct pvrdma_cmd_create_mr_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t mr_handle;
> +       uint32_t lkey;
> +       uint32_t rkey;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_destroy_mr {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t mr_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_cq {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint64_t pdir_dma;
> +       uint32_t ctx_handle;
> +       uint32_t cqe;
> +       uint32_t nchunks;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_cq_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t cq_handle;
> +       uint32_t cqe;
> +};
> +
> +struct pvrdma_cmd_resize_cq {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t cq_handle;
> +       uint32_t cqe;
> +};
> +
> +struct pvrdma_cmd_resize_cq_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t cqe;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_destroy_cq {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t cq_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_srq {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint64_t pdir_dma;
> +       uint32_t pd_handle;
> +       uint32_t nchunks;
> +       struct pvrdma_srq_attr attrs;
> +       uint8_t srq_type;
> +       uint8_t reserved[7];
> +};
> +
> +struct pvrdma_cmd_create_srq_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t srqn;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_modify_srq {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t srq_handle;
> +       uint32_t attr_mask;
> +       struct pvrdma_srq_attr attrs;
> +};
> +
> +struct pvrdma_cmd_query_srq {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t srq_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_query_srq_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       struct pvrdma_srq_attr attrs;
> +};
> +
> +struct pvrdma_cmd_destroy_srq {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t srq_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_qp {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint64_t pdir_dma;
> +       uint32_t pd_handle;
> +       uint32_t send_cq_handle;
> +       uint32_t recv_cq_handle;
> +       uint32_t srq_handle;
> +       uint32_t max_send_wr;
> +       uint32_t max_recv_wr;
> +       uint32_t max_send_sge;
> +       uint32_t max_recv_sge;
> +       uint32_t max_inline_data;
> +       uint32_t lkey;
> +       uint32_t access_flags;
> +       uint16_t total_chunks;
> +       uint16_t send_chunks;
> +       uint16_t max_atomic_arg;
> +       uint8_t sq_sig_all;
> +       uint8_t qp_type;
> +       uint8_t is_srq;
> +       uint8_t reserved[3];
> +};
> +
> +struct pvrdma_cmd_create_qp_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t qpn;
> +       uint32_t max_send_wr;
> +       uint32_t max_recv_wr;
> +       uint32_t max_send_sge;
> +       uint32_t max_recv_sge;
> +       uint32_t max_inline_data;
> +};
> +
> +struct pvrdma_cmd_modify_qp {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t qp_handle;
> +       uint32_t attr_mask;
> +       struct pvrdma_qp_attr attrs;
> +};
> +
> +struct pvrdma_cmd_query_qp {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t qp_handle;
> +       uint32_t attr_mask;
> +};
> +
> +struct pvrdma_cmd_query_qp_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       struct pvrdma_qp_attr attrs;
> +};
> +
> +struct pvrdma_cmd_destroy_qp {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t qp_handle;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_destroy_qp_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       uint32_t events_reported;
> +       uint8_t reserved[4];
> +};
> +
> +struct pvrdma_cmd_create_bind {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t mtu;
> +       uint32_t vlan;
> +       uint32_t index;
> +       uint8_t new_gid[16];
> +       uint8_t gid_type;
> +       uint8_t reserved[3];
> +};
> +
> +struct pvrdma_cmd_destroy_bind {
> +       struct pvrdma_cmd_hdr hdr;
> +       uint32_t index;
> +       uint8_t dest_gid[16];
> +       uint8_t reserved[4];
> +};
> +
> +union pvrdma_cmd_req {
> +       struct pvrdma_cmd_hdr hdr;
> +       struct pvrdma_cmd_query_port query_port;
> +       struct pvrdma_cmd_query_pkey query_pkey;
> +       struct pvrdma_cmd_create_uc create_uc;
> +       struct pvrdma_cmd_destroy_uc destroy_uc;
> +       struct pvrdma_cmd_create_pd create_pd;
> +       struct pvrdma_cmd_destroy_pd destroy_pd;
> +       struct pvrdma_cmd_create_mr create_mr;
> +       struct pvrdma_cmd_destroy_mr destroy_mr;
> +       struct pvrdma_cmd_create_cq create_cq;
> +       struct pvrdma_cmd_resize_cq resize_cq;
> +       struct pvrdma_cmd_destroy_cq destroy_cq;
> +       struct pvrdma_cmd_create_qp create_qp;
> +       struct pvrdma_cmd_modify_qp modify_qp;
> +       struct pvrdma_cmd_query_qp query_qp;
> +       struct pvrdma_cmd_destroy_qp destroy_qp;
> +       struct pvrdma_cmd_create_bind create_bind;
> +       struct pvrdma_cmd_destroy_bind destroy_bind;
> +       struct pvrdma_cmd_create_srq create_srq;
> +       struct pvrdma_cmd_modify_srq modify_srq;
> +       struct pvrdma_cmd_query_srq query_srq;
> +       struct pvrdma_cmd_destroy_srq destroy_srq;
> +};
> +
> +union pvrdma_cmd_resp {
> +       struct pvrdma_cmd_resp_hdr hdr;
> +       struct pvrdma_cmd_query_port_resp query_port_resp;
> +       struct pvrdma_cmd_query_pkey_resp query_pkey_resp;
> +       struct pvrdma_cmd_create_uc_resp create_uc_resp;
> +       struct pvrdma_cmd_create_pd_resp create_pd_resp;
> +       struct pvrdma_cmd_create_mr_resp create_mr_resp;
> +       struct pvrdma_cmd_create_cq_resp create_cq_resp;
> +       struct pvrdma_cmd_resize_cq_resp resize_cq_resp;
> +       struct pvrdma_cmd_create_qp_resp create_qp_resp;
> +       struct pvrdma_cmd_query_qp_resp query_qp_resp;
> +       struct pvrdma_cmd_destroy_qp_resp destroy_qp_resp;
> +       struct pvrdma_cmd_create_srq_resp create_srq_resp;
> +       struct pvrdma_cmd_query_srq_resp query_srq_resp;
> +};
> +
> +#endif /* __PVRDMA_DEV_API_H__ */
> diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> new file mode 100644
> index 0000000000..acd4c8346d
> --- /dev/null
> +++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> @@ -0,0 +1,114 @@
> +/*
> + * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of EITHER the GNU General Public License
> + * version 2 as published by the Free Software Foundation or the BSD
> + * 2-Clause License. This program is distributed in the hope that it
> + * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
> + * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License version 2 for more details at
> + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program available in the file COPYING in the main
> + * directory of this source tree.
> + *
> + * The BSD 2-Clause License
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#ifndef __PVRDMA_RING_H__
> +#define __PVRDMA_RING_H__
> +
> +#include "standard-headers/linux/types.h"
> +
> +#define PVRDMA_INVALID_IDX     -1      /* Invalid index. */
> +
> +struct pvrdma_ring {
> +       int prod_tail;  /* Producer tail. */
> +       int cons_head;  /* Consumer head. */
> +};
> +
> +struct pvrdma_ring_state {
> +       struct pvrdma_ring tx;  /* Tx ring. */
> +       struct pvrdma_ring rx;  /* Rx ring. */
> +};
> +
> +static inline int pvrdma_idx_valid(uint32_t idx, uint32_t max_elems)
> +{
> +       /* Generates fewer instructions than a less-than. */
> +       return (idx & ~((max_elems << 1) - 1)) == 0;
> +}
> +
> +static inline int32_t pvrdma_idx(int *var, uint32_t max_elems)
> +{
> +       const unsigned int idx = atomic_read(var);
> +
> +       if (pvrdma_idx_valid(idx, max_elems))
> +               return idx & (max_elems - 1);
> +       return PVRDMA_INVALID_IDX;
> +}
> +
> +static inline void pvrdma_idx_ring_inc(int *var, uint32_t max_elems)
> +{
> +       uint32_t idx = atomic_read(var) + 1;    /* Increment. */
> +
> +       idx &= (max_elems << 1) - 1;            /* Modulo size, flip gen. */
> +       atomic_set(var, idx);
> +}
> +
> +static inline int32_t pvrdma_idx_ring_has_space(const struct pvrdma_ring *r,
> +                                             uint32_t max_elems, uint32_t *out_tail)
> +{
> +       const uint32_t tail = atomic_read(&r->prod_tail);
> +       const uint32_t head = atomic_read(&r->cons_head);
> +
> +       if (pvrdma_idx_valid(tail, max_elems) &&
> +           pvrdma_idx_valid(head, max_elems)) {
> +               *out_tail = tail & (max_elems - 1);
> +               return tail != (head ^ max_elems);
> +       }
> +       return PVRDMA_INVALID_IDX;
> +}
> +
> +static inline int32_t pvrdma_idx_ring_has_data(const struct pvrdma_ring *r,
> +                                            uint32_t max_elems, uint32_t *out_head)
> +{
> +       const uint32_t tail = atomic_read(&r->prod_tail);
> +       const uint32_t head = atomic_read(&r->cons_head);
> +
> +       if (pvrdma_idx_valid(tail, max_elems) &&
> +           pvrdma_idx_valid(head, max_elems)) {
> +               *out_head = head & (max_elems - 1);
> +               return tail != head;
> +       }
> +       return PVRDMA_INVALID_IDX;
> +}
> +
> +#endif /* __PVRDMA_RING_H__ */
> diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> new file mode 100644
> index 0000000000..1677208a41
> --- /dev/null
> +++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> @@ -0,0 +1,383 @@
> +/*
> + * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of EITHER the GNU General Public License
> + * version 2 as published by the Free Software Foundation or the BSD
> + * 2-Clause License. This program is distributed in the hope that it
> + * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
> + * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License version 2 for more details at
> + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program available in the file COPYING in the main
> + * directory of this source tree.
> + *
> + * The BSD 2-Clause License
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#ifndef __PVRDMA_VERBS_H__
> +#define __PVRDMA_VERBS_H__
> +
> +#include "standard-headers/linux/types.h"
> +
> +union pvrdma_gid {
> +       uint8_t raw[16];
> +       struct {
> +               uint64_t        subnet_prefix;
> +               uint64_t        interface_id;
> +       } global;
> +};
> +
> +enum pvrdma_link_layer {
> +       PVRDMA_LINK_LAYER_UNSPECIFIED,
> +       PVRDMA_LINK_LAYER_INFINIBAND,
> +       PVRDMA_LINK_LAYER_ETHERNET,
> +};
> +
> +enum pvrdma_mtu {
> +       PVRDMA_MTU_256  = 1,
> +       PVRDMA_MTU_512  = 2,
> +       PVRDMA_MTU_1024 = 3,
> +       PVRDMA_MTU_2048 = 4,
> +       PVRDMA_MTU_4096 = 5,
> +};
> +
> +static inline int pvrdma_mtu_enum_to_int(enum pvrdma_mtu mtu)
> +{
> +       switch (mtu) {
> +       case PVRDMA_MTU_256:    return  256;
> +       case PVRDMA_MTU_512:    return  512;
> +       case PVRDMA_MTU_1024:   return 1024;
> +       case PVRDMA_MTU_2048:   return 2048;
> +       case PVRDMA_MTU_4096:   return 4096;
> +       default:                return   -1;
> +       }
> +}
> +
> +static inline enum pvrdma_mtu pvrdma_mtu_int_to_enum(int mtu)
> +{
> +       switch (mtu) {
> +       case 256:       return PVRDMA_MTU_256;
> +       case 512:       return PVRDMA_MTU_512;
> +       case 1024:      return PVRDMA_MTU_1024;
> +       case 2048:      return PVRDMA_MTU_2048;
> +       case 4096:
> +       default:        return PVRDMA_MTU_4096;
> +       }
> +}
> +
> +enum pvrdma_port_state {
> +       PVRDMA_PORT_NOP                 = 0,
> +       PVRDMA_PORT_DOWN                = 1,
> +       PVRDMA_PORT_INIT                = 2,
> +       PVRDMA_PORT_ARMED               = 3,
> +       PVRDMA_PORT_ACTIVE              = 4,
> +       PVRDMA_PORT_ACTIVE_DEFER        = 5,
> +};
> +
> +enum pvrdma_port_cap_flags {
> +       PVRDMA_PORT_SM                          = 1 <<  1,
> +       PVRDMA_PORT_NOTICE_SUP                  = 1 <<  2,
> +       PVRDMA_PORT_TRAP_SUP                    = 1 <<  3,
> +       PVRDMA_PORT_OPT_IPD_SUP                 = 1 <<  4,
> +       PVRDMA_PORT_AUTO_MIGR_SUP               = 1 <<  5,
> +       PVRDMA_PORT_SL_MAP_SUP                  = 1 <<  6,
> +       PVRDMA_PORT_MKEY_NVRAM                  = 1 <<  7,
> +       PVRDMA_PORT_PKEY_NVRAM                  = 1 <<  8,
> +       PVRDMA_PORT_LED_INFO_SUP                = 1 <<  9,
> +       PVRDMA_PORT_SM_DISABLED                 = 1 << 10,
> +       PVRDMA_PORT_SYS_IMAGE_GUID_SUP          = 1 << 11,
> +       PVRDMA_PORT_PKEY_SW_EXT_PORT_TRAP_SUP   = 1 << 12,
> +       PVRDMA_PORT_EXTENDED_SPEEDS_SUP         = 1 << 14,
> +       PVRDMA_PORT_CM_SUP                      = 1 << 16,
> +       PVRDMA_PORT_SNMP_TUNNEL_SUP             = 1 << 17,
> +       PVRDMA_PORT_REINIT_SUP                  = 1 << 18,
> +       PVRDMA_PORT_DEVICE_MGMT_SUP             = 1 << 19,
> +       PVRDMA_PORT_VENDOR_CLASS_SUP            = 1 << 20,
> +       PVRDMA_PORT_DR_NOTICE_SUP               = 1 << 21,
> +       PVRDMA_PORT_CAP_MASK_NOTICE_SUP         = 1 << 22,
> +       PVRDMA_PORT_BOOT_MGMT_SUP               = 1 << 23,
> +       PVRDMA_PORT_LINK_LATENCY_SUP            = 1 << 24,
> +       PVRDMA_PORT_CLIENT_REG_SUP              = 1 << 25,
> +       PVRDMA_PORT_IP_BASED_GIDS               = 1 << 26,
> +       PVRDMA_PORT_CAP_FLAGS_MAX               = PVRDMA_PORT_IP_BASED_GIDS,
> +};
> +
> +enum pvrdma_port_width {
> +       PVRDMA_WIDTH_1X         = 1,
> +       PVRDMA_WIDTH_4X         = 2,
> +       PVRDMA_WIDTH_8X         = 4,
> +       PVRDMA_WIDTH_12X        = 8,
> +};
> +
> +static inline int pvrdma_width_enum_to_int(enum pvrdma_port_width width)
> +{
> +       switch (width) {
> +       case PVRDMA_WIDTH_1X:   return  1;
> +       case PVRDMA_WIDTH_4X:   return  4;
> +       case PVRDMA_WIDTH_8X:   return  8;
> +       case PVRDMA_WIDTH_12X:  return 12;
> +       default:                return -1;
> +       }
> +}
> +
> +enum pvrdma_port_speed {
> +       PVRDMA_SPEED_SDR        = 1,
> +       PVRDMA_SPEED_DDR        = 2,
> +       PVRDMA_SPEED_QDR        = 4,
> +       PVRDMA_SPEED_FDR10      = 8,
> +       PVRDMA_SPEED_FDR        = 16,
> +       PVRDMA_SPEED_EDR        = 32,
> +};
> +
> +struct pvrdma_port_attr {
> +       enum pvrdma_port_state  state;
> +       enum pvrdma_mtu         max_mtu;
> +       enum pvrdma_mtu         active_mtu;
> +       uint32_t                        gid_tbl_len;
> +       uint32_t                        port_cap_flags;
> +       uint32_t                        max_msg_sz;
> +       uint32_t                        bad_pkey_cntr;
> +       uint32_t                        qkey_viol_cntr;
> +       uint16_t                        pkey_tbl_len;
> +       uint16_t                        lid;
> +       uint16_t                        sm_lid;
> +       uint8_t                 lmc;
> +       uint8_t                 max_vl_num;
> +       uint8_t                 sm_sl;
> +       uint8_t                 subnet_timeout;
> +       uint8_t                 init_type_reply;
> +       uint8_t                 active_width;
> +       uint8_t                 active_speed;
> +       uint8_t                 phys_state;
> +       uint8_t                 reserved[2];
> +};
> +
> +struct pvrdma_global_route {
> +       union pvrdma_gid        dgid;
> +       uint32_t                        flow_label;
> +       uint8_t                 sgid_index;
> +       uint8_t                 hop_limit;
> +       uint8_t                 traffic_class;
> +       uint8_t                 reserved;
> +};
> +
> +struct pvrdma_grh {
> +       uint32_t                        version_tclass_flow;
> +       uint16_t                        paylen;
> +       uint8_t                 next_hdr;
> +       uint8_t                 hop_limit;
> +       union pvrdma_gid        sgid;
> +       union pvrdma_gid        dgid;
> +};
> +
> +enum pvrdma_ah_flags {
> +       PVRDMA_AH_GRH = 1,
> +};
> +
> +enum pvrdma_rate {
> +       PVRDMA_RATE_PORT_CURRENT        = 0,
> +       PVRDMA_RATE_2_5_GBPS            = 2,
> +       PVRDMA_RATE_5_GBPS              = 5,
> +       PVRDMA_RATE_10_GBPS             = 3,
> +       PVRDMA_RATE_20_GBPS             = 6,
> +       PVRDMA_RATE_30_GBPS             = 4,
> +       PVRDMA_RATE_40_GBPS             = 7,
> +       PVRDMA_RATE_60_GBPS             = 8,
> +       PVRDMA_RATE_80_GBPS             = 9,
> +       PVRDMA_RATE_120_GBPS            = 10,
> +       PVRDMA_RATE_14_GBPS             = 11,
> +       PVRDMA_RATE_56_GBPS             = 12,
> +       PVRDMA_RATE_112_GBPS            = 13,
> +       PVRDMA_RATE_168_GBPS            = 14,
> +       PVRDMA_RATE_25_GBPS             = 15,
> +       PVRDMA_RATE_100_GBPS            = 16,
> +       PVRDMA_RATE_200_GBPS            = 17,
> +       PVRDMA_RATE_300_GBPS            = 18,
> +};
> +
> +struct pvrdma_ah_attr {
> +       struct pvrdma_global_route      grh;
> +       uint16_t                                dlid;
> +       uint16_t                                vlan_id;
> +       uint8_t                         sl;
> +       uint8_t                         src_path_bits;
> +       uint8_t                         static_rate;
> +       uint8_t                         ah_flags;
> +       uint8_t                         port_num;
> +       uint8_t                         dmac[6];
> +       uint8_t                         reserved;
> +};
> +
> +enum pvrdma_cq_notify_flags {
> +       PVRDMA_CQ_SOLICITED             = 1 << 0,
> +       PVRDMA_CQ_NEXT_COMP             = 1 << 1,
> +       PVRDMA_CQ_SOLICITED_MASK        = PVRDMA_CQ_SOLICITED |
> +                                         PVRDMA_CQ_NEXT_COMP,
> +       PVRDMA_CQ_REPORT_MISSED_EVENTS  = 1 << 2,
> +};
> +
> +struct pvrdma_qp_cap {
> +       uint32_t        max_send_wr;
> +       uint32_t        max_recv_wr;
> +       uint32_t        max_send_sge;
> +       uint32_t        max_recv_sge;
> +       uint32_t        max_inline_data;
> +       uint32_t        reserved;
> +};
> +
> +enum pvrdma_sig_type {
> +       PVRDMA_SIGNAL_ALL_WR,
> +       PVRDMA_SIGNAL_REQ_WR,
> +};
> +
> +enum pvrdma_qp_type {
> +       PVRDMA_QPT_SMI,
> +       PVRDMA_QPT_GSI,
> +       PVRDMA_QPT_RC,
> +       PVRDMA_QPT_UC,
> +       PVRDMA_QPT_UD,
> +       PVRDMA_QPT_RAW_IPV6,
> +       PVRDMA_QPT_RAW_ETHERTYPE,
> +       PVRDMA_QPT_RAW_PACKET = 8,
> +       PVRDMA_QPT_XRC_INI = 9,
> +       PVRDMA_QPT_XRC_TGT,
> +       PVRDMA_QPT_MAX,
> +};
> +
> +enum pvrdma_qp_create_flags {
> +       PVRDMA_QP_CREATE_IPOPVRDMA_UD_LSO               = 1 << 0,
> +       PVRDMA_QP_CREATE_BLOCK_MULTICAST_LOOPBACK       = 1 << 1,
> +};
> +
> +enum pvrdma_qp_attr_mask {
> +       PVRDMA_QP_STATE                 = 1 << 0,
> +       PVRDMA_QP_CUR_STATE             = 1 << 1,
> +       PVRDMA_QP_EN_SQD_ASYNC_NOTIFY   = 1 << 2,
> +       PVRDMA_QP_ACCESS_FLAGS          = 1 << 3,
> +       PVRDMA_QP_PKEY_INDEX            = 1 << 4,
> +       PVRDMA_QP_PORT                  = 1 << 5,
> +       PVRDMA_QP_QKEY                  = 1 << 6,
> +       PVRDMA_QP_AV                    = 1 << 7,
> +       PVRDMA_QP_PATH_MTU              = 1 << 8,
> +       PVRDMA_QP_TIMEOUT               = 1 << 9,
> +       PVRDMA_QP_RETRY_CNT             = 1 << 10,
> +       PVRDMA_QP_RNR_RETRY             = 1 << 11,
> +       PVRDMA_QP_RQ_PSN                = 1 << 12,
> +       PVRDMA_QP_MAX_QP_RD_ATOMIC      = 1 << 13,
> +       PVRDMA_QP_ALT_PATH              = 1 << 14,
> +       PVRDMA_QP_MIN_RNR_TIMER         = 1 << 15,
> +       PVRDMA_QP_SQ_PSN                = 1 << 16,
> +       PVRDMA_QP_MAX_DEST_RD_ATOMIC    = 1 << 17,
> +       PVRDMA_QP_PATH_MIG_STATE        = 1 << 18,
> +       PVRDMA_QP_CAP                   = 1 << 19,
> +       PVRDMA_QP_DEST_QPN              = 1 << 20,
> +       PVRDMA_QP_ATTR_MASK_MAX         = PVRDMA_QP_DEST_QPN,
> +};
> +
> +enum pvrdma_qp_state {
> +       PVRDMA_QPS_RESET,
> +       PVRDMA_QPS_INIT,
> +       PVRDMA_QPS_RTR,
> +       PVRDMA_QPS_RTS,
> +       PVRDMA_QPS_SQD,
> +       PVRDMA_QPS_SQE,
> +       PVRDMA_QPS_ERR,
> +};
> +
> +enum pvrdma_mig_state {
> +       PVRDMA_MIG_MIGRATED,
> +       PVRDMA_MIG_REARM,
> +       PVRDMA_MIG_ARMED,
> +};
> +
> +enum pvrdma_mw_type {
> +       PVRDMA_MW_TYPE_1 = 1,
> +       PVRDMA_MW_TYPE_2 = 2,
> +};
> +
> +struct pvrdma_srq_attr {
> +       uint32_t                        max_wr;
> +       uint32_t                        max_sge;
> +       uint32_t                        srq_limit;
> +       uint32_t                        reserved;
> +};
> +
> +struct pvrdma_qp_attr {
> +       enum pvrdma_qp_state    qp_state;
> +       enum pvrdma_qp_state    cur_qp_state;
> +       enum pvrdma_mtu         path_mtu;
> +       enum pvrdma_mig_state   path_mig_state;
> +       uint32_t                        qkey;
> +       uint32_t                        rq_psn;
> +       uint32_t                        sq_psn;
> +       uint32_t                        dest_qp_num;
> +       uint32_t                        qp_access_flags;
> +       uint16_t                        pkey_index;
> +       uint16_t                        alt_pkey_index;
> +       uint8_t                 en_sqd_async_notify;
> +       uint8_t                 sq_draining;
> +       uint8_t                 max_rd_atomic;
> +       uint8_t                 max_dest_rd_atomic;
> +       uint8_t                 min_rnr_timer;
> +       uint8_t                 port_num;
> +       uint8_t                 timeout;
> +       uint8_t                 retry_cnt;
> +       uint8_t                 rnr_retry;
> +       uint8_t                 alt_port_num;
> +       uint8_t                 alt_timeout;
> +       uint8_t                 reserved[5];
> +       struct pvrdma_qp_cap    cap;
> +       struct pvrdma_ah_attr   ah_attr;
> +       struct pvrdma_ah_attr   alt_ah_attr;
> +};
> +
> +enum pvrdma_send_flags {
> +       PVRDMA_SEND_FENCE       = 1 << 0,
> +       PVRDMA_SEND_SIGNALED    = 1 << 1,
> +       PVRDMA_SEND_SOLICITED   = 1 << 2,
> +       PVRDMA_SEND_INLINE      = 1 << 3,
> +       PVRDMA_SEND_IP_CSUM     = 1 << 4,
> +       PVRDMA_SEND_FLAGS_MAX   = PVRDMA_SEND_IP_CSUM,
> +};
> +
> +enum pvrdma_access_flags {
> +       PVRDMA_ACCESS_LOCAL_WRITE       = 1 << 0,
> +       PVRDMA_ACCESS_REMOTE_WRITE      = 1 << 1,
> +       PVRDMA_ACCESS_REMOTE_READ       = 1 << 2,
> +       PVRDMA_ACCESS_REMOTE_ATOMIC     = 1 << 3,
> +       PVRDMA_ACCESS_MW_BIND           = 1 << 4,
> +       PVRDMA_ZERO_BASED               = 1 << 5,
> +       PVRDMA_ACCESS_ON_DEMAND         = 1 << 6,
> +       PVRDMA_ACCESS_FLAGS_MAX         = PVRDMA_ACCESS_ON_DEMAND,
> +};
> +
> +#endif /* __PVRDMA_VERBS_H__ */
> diff --git a/include/standard-headers/rdma/vmw_pvrdma-abi.h b/include/standard-headers/rdma/vmw_pvrdma-abi.h
> new file mode 100644
> index 0000000000..0d0f7a8aca
> --- /dev/null
> +++ b/include/standard-headers/rdma/vmw_pvrdma-abi.h
> @@ -0,0 +1,293 @@
> +/*
> + * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of EITHER the GNU General Public License
> + * version 2 as published by the Free Software Foundation or the BSD
> + * 2-Clause License. This program is distributed in the hope that it
> + * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
> + * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License version 2 for more details at
> + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program available in the file COPYING in the main
> + * directory of this source tree.
> + *
> + * The BSD 2-Clause License
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#ifndef __VMW_PVRDMA_ABI_H__
> +#define __VMW_PVRDMA_ABI_H__
> +
> +#include "standard-headers/linux/types.h"
> +
> +#define PVRDMA_UVERBS_ABI_VERSION      3               /* ABI Version. */
> +#define PVRDMA_UAR_HANDLE_MASK         0x00FFFFFF      /* Bottom 24 bits. */
> +#define PVRDMA_UAR_QP_OFFSET           0               /* QP doorbell. */
> +#define PVRDMA_UAR_QP_SEND             BIT(30)         /* Send bit. */
> +#define PVRDMA_UAR_QP_RECV             BIT(31)         /* Recv bit. */
> +#define PVRDMA_UAR_CQ_OFFSET           4               /* CQ doorbell. */
> +#define PVRDMA_UAR_CQ_ARM_SOL          BIT(29)         /* Arm solicited bit. */
> +#define PVRDMA_UAR_CQ_ARM              BIT(30)         /* Arm bit. */
> +#define PVRDMA_UAR_CQ_POLL             BIT(31)         /* Poll bit. */
> +
> +enum pvrdma_wr_opcode {
> +       PVRDMA_WR_RDMA_WRITE,
> +       PVRDMA_WR_RDMA_WRITE_WITH_IMM,
> +       PVRDMA_WR_SEND,
> +       PVRDMA_WR_SEND_WITH_IMM,
> +       PVRDMA_WR_RDMA_READ,
> +       PVRDMA_WR_ATOMIC_CMP_AND_SWP,
> +       PVRDMA_WR_ATOMIC_FETCH_AND_ADD,
> +       PVRDMA_WR_LSO,
> +       PVRDMA_WR_SEND_WITH_INV,
> +       PVRDMA_WR_RDMA_READ_WITH_INV,
> +       PVRDMA_WR_LOCAL_INV,
> +       PVRDMA_WR_FAST_REG_MR,
> +       PVRDMA_WR_MASKED_ATOMIC_CMP_AND_SWP,
> +       PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD,
> +       PVRDMA_WR_BIND_MW,
> +       PVRDMA_WR_REG_SIG_MR,
> +};
> +
> +enum pvrdma_wc_status {
> +       PVRDMA_WC_SUCCESS,
> +       PVRDMA_WC_LOC_LEN_ERR,
> +       PVRDMA_WC_LOC_QP_OP_ERR,
> +       PVRDMA_WC_LOC_EEC_OP_ERR,
> +       PVRDMA_WC_LOC_PROT_ERR,
> +       PVRDMA_WC_WR_FLUSH_ERR,
> +       PVRDMA_WC_MW_BIND_ERR,
> +       PVRDMA_WC_BAD_RESP_ERR,
> +       PVRDMA_WC_LOC_ACCESS_ERR,
> +       PVRDMA_WC_REM_INV_REQ_ERR,
> +       PVRDMA_WC_REM_ACCESS_ERR,
> +       PVRDMA_WC_REM_OP_ERR,
> +       PVRDMA_WC_RETRY_EXC_ERR,
> +       PVRDMA_WC_RNR_RETRY_EXC_ERR,
> +       PVRDMA_WC_LOC_RDD_VIOL_ERR,
> +       PVRDMA_WC_REM_INV_RD_REQ_ERR,
> +       PVRDMA_WC_REM_ABORT_ERR,
> +       PVRDMA_WC_INV_EECN_ERR,
> +       PVRDMA_WC_INV_EEC_STATE_ERR,
> +       PVRDMA_WC_FATAL_ERR,
> +       PVRDMA_WC_RESP_TIMEOUT_ERR,
> +       PVRDMA_WC_GENERAL_ERR,
> +};
> +
> +enum pvrdma_wc_opcode {
> +       PVRDMA_WC_SEND,
> +       PVRDMA_WC_RDMA_WRITE,
> +       PVRDMA_WC_RDMA_READ,
> +       PVRDMA_WC_COMP_SWAP,
> +       PVRDMA_WC_FETCH_ADD,
> +       PVRDMA_WC_BIND_MW,
> +       PVRDMA_WC_LSO,
> +       PVRDMA_WC_LOCAL_INV,
> +       PVRDMA_WC_FAST_REG_MR,
> +       PVRDMA_WC_MASKED_COMP_SWAP,
> +       PVRDMA_WC_MASKED_FETCH_ADD,
> +       PVRDMA_WC_RECV = 1 << 7,
> +       PVRDMA_WC_RECV_RDMA_WITH_IMM,
> +};
> +
> +enum pvrdma_wc_flags {
> +       PVRDMA_WC_GRH                   = 1 << 0,
> +       PVRDMA_WC_WITH_IMM              = 1 << 1,
> +       PVRDMA_WC_WITH_INVALIDATE       = 1 << 2,
> +       PVRDMA_WC_IP_CSUM_OK            = 1 << 3,
> +       PVRDMA_WC_WITH_SMAC             = 1 << 4,
> +       PVRDMA_WC_WITH_VLAN             = 1 << 5,
> +       PVRDMA_WC_WITH_NETWORK_HDR_TYPE = 1 << 6,
> +       PVRDMA_WC_FLAGS_MAX             = PVRDMA_WC_WITH_NETWORK_HDR_TYPE,
> +};
> +
> +struct pvrdma_alloc_ucontext_resp {
> +       uint32_t qp_tab_size;
> +       uint32_t reserved;
> +};
> +
> +struct pvrdma_alloc_pd_resp {
> +       uint32_t pdn;
> +       uint32_t reserved;
> +};
> +
> +struct pvrdma_create_cq {
> +       uint64_t buf_addr;
> +       uint32_t buf_size;
> +       uint32_t reserved;
> +};
> +
> +struct pvrdma_create_cq_resp {
> +       uint32_t cqn;
> +       uint32_t reserved;
> +};
> +
> +struct pvrdma_resize_cq {
> +       uint64_t buf_addr;
> +       uint32_t buf_size;
> +       uint32_t reserved;
> +};
> +
> +struct pvrdma_create_srq {
> +       uint64_t buf_addr;
> +       uint32_t buf_size;
> +       uint32_t reserved;
> +};
> +
> +struct pvrdma_create_srq_resp {
> +       uint32_t srqn;
> +       uint32_t reserved;
> +};
> +
> +struct pvrdma_create_qp {
> +       uint64_t rbuf_addr;
> +       uint64_t sbuf_addr;
> +       uint32_t rbuf_size;
> +       uint32_t sbuf_size;
> +       uint64_t qp_addr;
> +};
> +
> +/* PVRDMA masked atomic compare and swap */
> +struct pvrdma_ex_cmp_swap {
> +       uint64_t swap_val;
> +       uint64_t compare_val;
> +       uint64_t swap_mask;
> +       uint64_t compare_mask;
> +};
> +
> +/* PVRDMA masked atomic fetch and add */
> +struct pvrdma_ex_fetch_add {
> +       uint64_t add_val;
> +       uint64_t field_boundary;
> +};
> +
> +/* PVRDMA address vector. */
> +struct pvrdma_av {
> +       uint32_t port_pd;
> +       uint32_t sl_tclass_flowlabel;
> +       uint8_t dgid[16];
> +       uint8_t src_path_bits;
> +       uint8_t gid_index;
> +       uint8_t stat_rate;
> +       uint8_t hop_limit;
> +       uint8_t dmac[6];
> +       uint8_t reserved[6];
> +};
> +
> +/* PVRDMA scatter/gather entry */
> +struct pvrdma_sge {
> +       uint64_t   addr;
> +       uint32_t   length;
> +       uint32_t   lkey;
> +};
> +
> +/* PVRDMA receive queue work request */
> +struct pvrdma_rq_wqe_hdr {
> +       uint64_t wr_id;         /* wr id */
> +       uint32_t num_sge;               /* size of s/g array */
> +       uint32_t total_len;     /* reserved */
> +};
> +/* Use pvrdma_sge (ib_sge) for receive queue s/g array elements. */
> +
> +/* PVRDMA send queue work request */
> +struct pvrdma_sq_wqe_hdr {
> +       uint64_t wr_id;         /* wr id */
> +       uint32_t num_sge;               /* size of s/g array */
> +       uint32_t total_len;     /* reserved */
> +       uint32_t opcode;                /* operation type */
> +       uint32_t send_flags;    /* wr flags */
> +       union {
> +               uint32_t imm_data;
> +               uint32_t invalidate_rkey;
> +       } ex;
> +       uint32_t reserved;
> +       union {
> +               struct {
> +                       uint64_t remote_addr;
> +                       uint32_t rkey;
> +                       uint8_t reserved[4];
> +               } rdma;
> +               struct {
> +                       uint64_t remote_addr;
> +                       uint64_t compare_add;
> +                       uint64_t swap;
> +                       uint32_t rkey;
> +                       uint32_t reserved;
> +               } atomic;
> +               struct {
> +                       uint64_t remote_addr;
> +                       uint32_t log_arg_sz;
> +                       uint32_t rkey;
> +                       union {
> +                               struct pvrdma_ex_cmp_swap  cmp_swap;
> +                               struct pvrdma_ex_fetch_add fetch_add;
> +                       } wr_data;
> +               } masked_atomics;
> +               struct {
> +                       uint64_t iova_start;
> +                       uint64_t pl_pdir_dma;
> +                       uint32_t page_shift;
> +                       uint32_t page_list_len;
> +                       uint32_t length;
> +                       uint32_t access_flags;
> +                       uint32_t rkey;
> +               } fast_reg;
> +               struct {
> +                       uint32_t remote_qpn;
> +                       uint32_t remote_qkey;
> +                       struct pvrdma_av av;
> +               } ud;
> +       } wr;
> +};
> +/* Use pvrdma_sge (ib_sge) for send queue s/g array elements. */
> +
> +/* Completion queue element. */
> +struct pvrdma_cqe {
> +       uint64_t wr_id;
> +       uint64_t qp;
> +       uint32_t opcode;
> +       uint32_t status;
> +       uint32_t byte_len;
> +       uint32_t imm_data;
> +       uint32_t src_qp;
> +       uint32_t wc_flags;
> +       uint32_t vendor_err;
> +       uint16_t pkey_index;
> +       uint16_t slid;
> +       uint8_t sl;
> +       uint8_t dlid_path_bits;
> +       uint8_t port_num;
> +       uint8_t smac[6];
> +       uint8_t network_hdr_type;
> +       uint8_t reserved2[6]; /* Pad to next power of 2 (64). */
> +};
> +
> +#endif /* __VMW_PVRDMA_ABI_H__ */
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 135a10d96a..c1a7c1e99c 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -38,6 +38,7 @@ cp_portable() {
>                                       -e 'linux/if_ether' \
>                                       -e 'input-event-codes' \
>                                       -e 'sys/' \
> +                                     -e 'pvrdma_verbs' \
>                                       > /dev/null
>      then
>          echo "Unexpected #include in input file $f".
> @@ -46,6 +47,7 @@ cp_portable() {
>
>      header=$(basename "$f");
>      sed -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
> +        -e 's/u\([0-9][0-9]*\)/uint\1_t/g' \
>          -e 's/__s\([0-9][0-9]*\)/int\1_t/g' \
>          -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
>          -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
> @@ -56,6 +58,7 @@ cp_portable() {
>          -e 's/__inline__/inline/' \
>          -e '/sys\/ioctl.h/d' \
>          -e 's/SW_MAX/SW_MAX_/' \
> +        -e 's/atomic_t/int/' \
>          "$f" > "$to/$header";
>  }
>
> @@ -147,6 +150,30 @@ for i in "$tmpdir"/include/linux/*virtio*.h "$tmpdir/include/linux/input.h" \
>      cp_portable "$i" "$output/include/standard-headers/linux"
>  done
>
> +rm -rf "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma"
> +mkdir -p "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma"
> +
> +# Remove the unused functions from pvrdma_verbs.h avoiding the unnecessary
> +# import of several infiniband/networking/other headers
> +tmp_pvrdma_verbs="$tmpdir/pvrdma_verbs.h"
> +sed  -e '1h;2,$H;$!d;g'  -e 's/[^};]*pvrdma[^(| ]*([^)]*);//g' \
> +    "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h" > \
> +    "$tmp_pvrdma_verbs";
> +
> +for i in "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h" \
> +         "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h" \
> +         "$tmp_pvrdma_verbs"; do \
> +    cp_portable "$i" \
> +         "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/"
> +done
> +
> +rm -rf "$output/include/standard-headers/rdma/"
> +mkdir -p "$output/include/standard-headers/rdma/"
> +for i in "$tmpdir/include/rdma/vmw_pvrdma-abi.h"; do
> +    cp_portable "$i" \
> +         "$output/include/standard-headers/rdma/"
> +done
> +
>  cat <<EOF >$output/include/standard-headers/linux/types.h
>  /* For QEMU all types are already defined via osdep.h, so this
>   * header does not need to do anything.
> --
> 2.13.5
>
>
