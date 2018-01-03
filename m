Received: from eggs.gnu.org ([2001:4830:134:3::10]:50980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWkW2-0003pB-S1
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWkVz-0008Cv-P6
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:59:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eWkVz-0008Ba-DO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:59:35 -0500
References: <20180103102911.35562-1-marcel@redhat.com>
	<20180103102911.35562-5-marcel@redhat.com>
	<20180103153432-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ed5878ae-d614-3db3-81c5-aa0397a3eb48@redhat.com>
Date: Wed, 3 Jan 2018 16:59:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180103153432-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, yuval.shaia@oracle.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

On 03/01/2018 15:41, Michael S. Tsirkin wrote:
> On Wed, Jan 03, 2018 at 12:29:10PM +0200, Marcel Apfelbaum wrote:
>> diff --git a/hw/rdma/vmw/pvrdma_types.h b/hw/rdma/vmw/pvrdma_types.h
>> new file mode 100644
>> index 0000000000..6cd2c81019
>> --- /dev/null
>> +++ b/hw/rdma/vmw/pvrdma_types.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * QEMU VMWARE paravirtual RDMA interface definitions
>> + *
>> + * Copyright (C) 2018 Oracle
>> + * Copyright (C) 2018 Red Hat Inc
>> + *
>> + * Authors:
>> + *     Yuval Shaia <yuval.shaia@oracle.com>
>> + *     Marcel Apfelbaum <marcel@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +

Hi Michael,

>> +#ifndef PVRDMA_TYPES_H
>> +#define PVRDMA_TYPES_H
>> +
>> +/* TDOD: All defs here should be removed !!! */
> 
> Please do exactly that.
> 

We will remove the includes, however we use VMware's header files
that we don't want to modify, what about using the vmxnet
approach and use something like:

  #define u64     uint64_t
  #define u32     uint32_t
  ...

Should we put the defines in the VMware header files?
(like in hw/net/vmxnet3.h)

>> +
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +#include <asm-generic/int-ll64.h>
>> +#include <include/sysemu/dma.h>
>> +#include <linux/types.h>
>> +
>> +typedef unsigned char uint8_t;
>> +typedef uint8_t           u8;
>> +typedef u8                __u8;
>> +typedef unsigned short    u16;
>> +typedef u16               __u16;
>> +typedef uint32_t          u32;
>> +typedef u32               __u32;
>> +typedef int32_t           __s32;
>> +typedef uint64_t          u64;
>> +typedef __u64 __bitwise   __be64;
>> +
>> +#endif
>> diff --git a/hw/rdma/vmw/pvrdma_utils.c b/hw/rdma/vmw/pvrdma_utils.c
> 
> Looks like a set of generic utility functions. Why are these under vmw?
> 

pvrdma_pci_dma_map/pvrdma_pci_dma_unmap are indeed generic
and we are going to move them where they belong, thanks.

The other functions however uses VMware's page directory
that is vendor specific and we should leave it vmw dir.

> 
>> new file mode 100644
>> index 0000000000..a84a2819d3
>> --- /dev/null
>> +++ b/hw/rdma/vmw/pvrdma_utils.c
>> @@ -0,0 +1,135 @@
>> +#include <qemu/osdep.h>
>> +#include <qemu/error-report.h>
>> +
>> +#include <cpu.h>
>> +#include "../rdma_utils.h"
>> +#include "pvrdma_utils.h"
>> +
>> +void pvrdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len)
>> +{
>> +    pr_dbg("%p\n", buffer);
>> +    if (buffer) {
>> +        pci_dma_unmap(dev, buffer, len, DMA_DIRECTION_TO_DEVICE, 0);
>> +    }
>> +}
>> +
>> +void *pvrdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen)
>> +{
>> +    void *p;
>> +    hwaddr len = plen;
>> +
>> +    if (!addr) {
>> +        pr_dbg("addr is NULL\n");
>> +        return NULL;
>> +    }
>> +
>> +    p = pci_dma_map(dev, addr, &len, DMA_DIRECTION_TO_DEVICE);
>> +    if (!p) {
>> +        pr_dbg("Fail in pci_dma_map, addr=0x%llx, len=%ld\n",
>> +               (long long unsigned int)addr, len);
>> +        return NULL;
>> +    }
>> +
>> +    if (len != plen) {
>> +        pvrdma_pci_dma_unmap(dev, p, len);
>> +        return NULL;
>> +    }
>> +
>> +    pr_dbg("0x%llx -> %p (len=%ld)\n", (long long unsigned int)addr, p, len);
>> +
>> +    return p;
>> +}
>> +
>> +void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma, uint32_t nchunks,
>> +                         size_t length)
>> +{
>> +    uint64_t *dir = NULL, *tbl = NULL;
>> +    int tbl_idx, dir_idx, addr_idx;
>> +    void *host_virt = NULL, *curr_page;
>> +
>> +    if (!nchunks) {
>> +        pr_dbg("nchunks=0\n");
>> +        goto out;
>> +    }
>> +
>> +    dir = pvrdma_pci_dma_map(pdev, pdir_dma, TARGET_PAGE_SIZE);
>> +    if (!dir) {
>> +        error_report("PVRDMA: Fail to map to page directory");
>> +        goto out;
>> +    }
>> +
>> +    tbl = pvrdma_pci_dma_map(pdev, dir[0], TARGET_PAGE_SIZE);
>> +    if (!tbl) {
>> +        error_report("PVRDMA: Fail to map to page table 0");
>> +        goto out_unmap_dir;
>> +    }
>> +
>> +    curr_page = pvrdma_pci_dma_map(pdev, (dma_addr_t)tbl[0], TARGET_PAGE_SIZE);
>> +    if (!curr_page) {
>> +        error_report("PVRDMA: Fail to map the first page");
>> +        goto out_unmap_tbl;
>> +    }
>> +
>> +    host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
>> +    if (host_virt == MAP_FAILED) {
>> +        host_virt = NULL;
>> +        error_report("PVRDMA: Fail to remap memory for host_virt");
>> +        goto out_unmap_tbl;
>> +    }
>> +
>> +    pvrdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
>> +
>> +    pr_dbg("host_virt=%p\n", host_virt);
>> +
>> +    dir_idx = 0;
>> +    tbl_idx = 1;
>> +    addr_idx = 1;
>> +    while (addr_idx < nchunks) {
>> +        if ((tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t)))) {
>> +            tbl_idx = 0;
>> +            dir_idx++;
>> +            pr_dbg("Mapping to table %d\n", dir_idx);
>> +            pvrdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
>> +            tbl = pvrdma_pci_dma_map(pdev, dir[dir_idx], TARGET_PAGE_SIZE);
>> +            if (!tbl) {
>> +                error_report("PVRDMA: Fail to map to page table %d", dir_idx);
>> +                goto out_unmap_host_virt;
>> +            }
>> +        }
>> +
>> +        pr_dbg("guest_dma[%d]=0x%lx\n", addr_idx, tbl[tbl_idx]);
>> +
>> +        curr_page = pvrdma_pci_dma_map(pdev, (dma_addr_t)tbl[tbl_idx],
>> +                                       TARGET_PAGE_SIZE);
>> +        if (!curr_page) {
>> +            error_report("PVRDMA: Fail to map to page %d, dir %d", tbl_idx,
>> +                         dir_idx);
>> +            goto out_unmap_host_virt;
>> +        }
>> +
>> +        mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
>> +               host_virt + TARGET_PAGE_SIZE * addr_idx);
> 
> It does not look like this will do the right thing when the host page
> size exceeds the target page size.
> 

Right, we forgot to add it to documentation, both guest and host should have the
same page size. More than that, it will not work if the guest RAM is created
from a file descriptor either.

There are solutions, but they require changing kernel code and it will take
some (unbounded) time to get it done.

(Judging the pvrdma kernel driver, it is possible that the page directories
passed between Guest and Host assume the page size is always 4K, so
we may even hit a wall there, but I am not sure yet)

We'll be sure to add the limitations to the documentation.

Thanks,
Marcel

> 
>> +
>> +        pvrdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
>> +
>> +        addr_idx++;
>> +
>> +        tbl_idx++;
>> +    }
>> +
>> +    goto out_unmap_tbl;
>> +
>> +out_unmap_host_virt:
>> +    munmap(host_virt, length);
>> +    host_virt = NULL;
>> +
>> +out_unmap_tbl:
>> +    pvrdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
>> +
>> +out_unmap_dir:
>> +    pvrdma_pci_dma_unmap(pdev, dir, TARGET_PAGE_SIZE);
>> +
>> +out:
>> +    return host_virt;
>> +
>> +}
