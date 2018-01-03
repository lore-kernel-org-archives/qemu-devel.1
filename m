Received: from eggs.gnu.org ([2001:4830:134:3::10]:41221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eWjII-0001av-M1
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eWjIE-00022i-Mq
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:41:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eWjIE-0001zo-7F
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:41:18 -0500
Date: Wed, 3 Jan 2018 15:41:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180103153432-mutt-send-email-mst@kernel.org>
References: <20180103102911.35562-1-marcel@redhat.com>
	<20180103102911.35562-5-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103102911.35562-5-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, yuval.shaia@oracle.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

On Wed, Jan 03, 2018 at 12:29:10PM +0200, Marcel Apfelbaum wrote:
> diff --git a/hw/rdma/vmw/pvrdma_types.h b/hw/rdma/vmw/pvrdma_types.h
> new file mode 100644
> index 0000000000..6cd2c81019
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_types.h
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU VMWARE paravirtual RDMA interface definitions
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
> +#ifndef PVRDMA_TYPES_H
> +#define PVRDMA_TYPES_H
> +
> +/* TDOD: All defs here should be removed !!! */

Please do exactly that.

> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <asm-generic/int-ll64.h>
> +#include <include/sysemu/dma.h>
> +#include <linux/types.h>
> +
> +typedef unsigned char uint8_t;
> +typedef uint8_t           u8;
> +typedef u8                __u8;
> +typedef unsigned short    u16;
> +typedef u16               __u16;
> +typedef uint32_t          u32;
> +typedef u32               __u32;
> +typedef int32_t           __s32;
> +typedef uint64_t          u64;
> +typedef __u64 __bitwise   __be64;
> +
> +#endif
> diff --git a/hw/rdma/vmw/pvrdma_utils.c b/hw/rdma/vmw/pvrdma_utils.c

Looks like a set of generic utility functions. Why are these under vmw?


> new file mode 100644
> index 0000000000..a84a2819d3
> --- /dev/null
> +++ b/hw/rdma/vmw/pvrdma_utils.c
> @@ -0,0 +1,135 @@
> +#include <qemu/osdep.h>
> +#include <qemu/error-report.h>
> +
> +#include <cpu.h>
> +#include "../rdma_utils.h"
> +#include "pvrdma_utils.h"
> +
> +void pvrdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len)
> +{
> +    pr_dbg("%p\n", buffer);
> +    if (buffer) {
> +        pci_dma_unmap(dev, buffer, len, DMA_DIRECTION_TO_DEVICE, 0);
> +    }
> +}
> +
> +void *pvrdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen)
> +{
> +    void *p;
> +    hwaddr len = plen;
> +
> +    if (!addr) {
> +        pr_dbg("addr is NULL\n");
> +        return NULL;
> +    }
> +
> +    p = pci_dma_map(dev, addr, &len, DMA_DIRECTION_TO_DEVICE);
> +    if (!p) {
> +        pr_dbg("Fail in pci_dma_map, addr=0x%llx, len=%ld\n",
> +               (long long unsigned int)addr, len);
> +        return NULL;
> +    }
> +
> +    if (len != plen) {
> +        pvrdma_pci_dma_unmap(dev, p, len);
> +        return NULL;
> +    }
> +
> +    pr_dbg("0x%llx -> %p (len=%ld)\n", (long long unsigned int)addr, p, len);
> +
> +    return p;
> +}
> +
> +void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma, uint32_t nchunks,
> +                         size_t length)
> +{
> +    uint64_t *dir = NULL, *tbl = NULL;
> +    int tbl_idx, dir_idx, addr_idx;
> +    void *host_virt = NULL, *curr_page;
> +
> +    if (!nchunks) {
> +        pr_dbg("nchunks=0\n");
> +        goto out;
> +    }
> +
> +    dir = pvrdma_pci_dma_map(pdev, pdir_dma, TARGET_PAGE_SIZE);
> +    if (!dir) {
> +        error_report("PVRDMA: Fail to map to page directory");
> +        goto out;
> +    }
> +
> +    tbl = pvrdma_pci_dma_map(pdev, dir[0], TARGET_PAGE_SIZE);
> +    if (!tbl) {
> +        error_report("PVRDMA: Fail to map to page table 0");
> +        goto out_unmap_dir;
> +    }
> +
> +    curr_page = pvrdma_pci_dma_map(pdev, (dma_addr_t)tbl[0], TARGET_PAGE_SIZE);
> +    if (!curr_page) {
> +        error_report("PVRDMA: Fail to map the first page");
> +        goto out_unmap_tbl;
> +    }
> +
> +    host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
> +    if (host_virt == MAP_FAILED) {
> +        host_virt = NULL;
> +        error_report("PVRDMA: Fail to remap memory for host_virt");
> +        goto out_unmap_tbl;
> +    }
> +
> +    pvrdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
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
> +            pvrdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
> +            tbl = pvrdma_pci_dma_map(pdev, dir[dir_idx], TARGET_PAGE_SIZE);
> +            if (!tbl) {
> +                error_report("PVRDMA: Fail to map to page table %d", dir_idx);
> +                goto out_unmap_host_virt;
> +            }
> +        }
> +
> +        pr_dbg("guest_dma[%d]=0x%lx\n", addr_idx, tbl[tbl_idx]);
> +
> +        curr_page = pvrdma_pci_dma_map(pdev, (dma_addr_t)tbl[tbl_idx],
> +                                       TARGET_PAGE_SIZE);
> +        if (!curr_page) {
> +            error_report("PVRDMA: Fail to map to page %d, dir %d", tbl_idx,
> +                         dir_idx);
> +            goto out_unmap_host_virt;
> +        }
> +
> +        mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
> +               host_virt + TARGET_PAGE_SIZE * addr_idx);

It does not look like this will do the right thing when the host page
size exceeds the target page size.


> +
> +        pvrdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
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
> +    pvrdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
> +
> +out_unmap_dir:
> +    pvrdma_pci_dma_unmap(pdev, dir, TARGET_PAGE_SIZE);
> +
> +out:
> +    return host_virt;
> +
> +}
