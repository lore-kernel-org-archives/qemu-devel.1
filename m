Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F41FC4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858B920786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fwpa3WWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858B920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka47t-0007pQ-5s
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ka46D-0006dT-Px
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ka46A-0000V5-UC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604439853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WRBJLw/A4TQuzZXEU0nfsQCJssyUt7cvtIUyV8gL8cg=;
 b=Fwpa3WWIFG2Mt2zLzcwFwVg0T5sMJJ72bLZdIVIBeTkbbsH/O/5xd8Bh1eya1pZMAzYkLr
 tfWR1foY/0rCwNNqvOjUktO8WiavWFDddoQLpGhNalXsnRjHbMc1U1kxiHdzacfbp053mU
 gceQ4kxiItL06qTkGwPahwOjeR0Wu/I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-F8QdLHzcPa2uxL-DNJ118Q-1; Tue, 03 Nov 2020 16:44:12 -0500
X-MC-Unique: F8QdLHzcPa2uxL-DNJ118Q-1
Received: by mail-wr1-f71.google.com with SMTP id j13so8375133wrn.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WRBJLw/A4TQuzZXEU0nfsQCJssyUt7cvtIUyV8gL8cg=;
 b=liJQlZAr/0bUakTJzma/9Tq3nzvJvKtbLU/BfujRQO/TPxdoEYaJSRz1GHRbrPtCpZ
 PlZQv/y7OhFGZiNJnRXXHdZjfJTUrwxCDxUPIpgo4kg/5jtY275vtWeWiEgD/TRGr/IG
 QZQ5z3P8ahjmOcyBHgJz7edLLcEWufDps+6+JpQf12Lds/5HBKsIZeBPd+D0MlexXM77
 uwgGFkwO+7PTcVamGkx1RkiRy8Yt9V4jy9SsQizx7Hodu5GGcCFpOssilynPvZ4VhIux
 ylKlYNGOBHiW8ixfuGu5rdYxYV5mhXnx0ZMeKpsvRAlPZj1JJjqRs37y9WGcmygWwBe6
 3s4g==
X-Gm-Message-State: AOAM531PdInsO2BFDFpH8RApVfJOyFkEodS1VcqgdCHzCyq9WEFIYzmn
 Y7+fkBE9K5JR8UevTd6Hg14upSaoMSybItxNGtQwEKy4Va+16yoee0vJzebiJU2yLT9iRqUVi3r
 ar61BqiuLswDKz8A=
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr1163738wmh.41.1604439850651; 
 Tue, 03 Nov 2020 13:44:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzRst4nEwMmG7aNEpFTKkh5L6+eIG1RK+/erPqfflSi1h4tQHWC6Dup+JgQgz8zzOIyBJ1vw==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr1163724wmh.41.1604439850337; 
 Tue, 03 Nov 2020 13:44:10 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id d20sm28704360wra.38.2020.11.03.13.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 13:44:09 -0800 (PST)
Date: Tue, 3 Nov 2020 16:44:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1] vfio-pci: improved tracing
Message-ID: <20201103164356-mutt-send-email-mst@kernel.org>
References: <1604345694-48400-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1604345694-48400-1-git-send-email-steven.sistare@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 11:34:54AM -0800, Steve Sistare wrote:
> Print more info for existing trace points:
>   trace_kvm_irqchip_add_msi_route
>   trace_pci_update_mappings_del
>   trace_pci_update_mappings_add
> 
> Add new trace points:
>   trace_kvm_irqchip_assign_irqfd
>   trace_msix_table_mmio_write
>   trace_vfio_dma_unmap
>   trace_vfio_dma_map
>   trace_vfio_region
>   trace_vfio_region_mmap
>   trace_ram_block_add
> 
> Sample output: (timestamps deleted for clarity)
> 
> ram_block_add host=0x7f4497e00000, maxlen=0x40000000, mr = {"pc.ram", rw}
> 
> vfio_region 0000:3a:10.0 [3]: len 0x4000 @ +0x30000000000, cap +0x20, flags 0xf
> 
> vfio_region_mmap "0000:3a:10.0 BAR 0 mmaps[0]" [0x0 - 0x3fff] maps to 0x7f44e3eb9000
> 
> msix_table_mmio_write vfio-pci, @ 16, val 0xfee01004, len 4
> 
> kvm_irqchip_add_msi_route dev vfio-pci, vector 1, virq 25, msg {addr 0xfee01004, data 0x40b1}
> 
> kvm_irqchip_assign_irqfd fd=164, virq=25, rfd=-1 returns 0
> 
> vfio_dma_map fd 24, iova 0xa0000, len 0x10000, va 0x7f4495800000, rw
> vfio_dma_unmap fd 24, iova 0xfebf5000, len 0x3000
> 
> pci_update_mappings_add vfio-pci d=0x563d101e7050 00:07.0 [3] @ 0xfebf4000 len 0x4000 "0000:3a:10.0 base BAR 3"
> pci_update_mappings_del vfio-pci d=0x563d101e7050 00:07.0 [3] @ 0xfebf4000 len 0x4000 "0000:3a:10.0 base BAR 3"
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

pci bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  accel/kvm/kvm-all.c    |  8 ++++++--
>  accel/kvm/trace-events |  3 ++-
>  exec.c                 |  3 +++
>  hw/pci/msix.c          |  1 +
>  hw/pci/pci.c           | 10 ++++++----
>  hw/pci/trace-events    |  5 +++--
>  hw/vfio/common.c       | 11 ++++++++++-
>  hw/vfio/trace-events   |  5 ++++-
>  trace-events           |  2 ++
>  9 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 63ef6af..01d0561 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -46,6 +46,7 @@
>  #include "sysemu/reset.h"
>  
>  #include "hw/boards.h"
> +#include "trace-root.h"
>  
>  /* This check must be after config-host.h is included */
>  #ifdef CONFIG_EVENTFD
> @@ -1670,7 +1671,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>      }
>  
>      trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
> -                                    vector, virq);
> +                                    vector, virq, msg.address, msg.data);
>  
>      kvm_add_routing_entry(s, &kroute);
>      kvm_arch_add_msi_route_post(&kroute, vector, dev);
> @@ -1715,6 +1716,7 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
>                                      EventNotifier *resample, int virq,
>                                      bool assign)
>  {
> +    int ret;
>      int fd = event_notifier_get_fd(event);
>      int rfd = resample ? event_notifier_get_fd(resample) : -1;
>  
> @@ -1758,7 +1760,9 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
>          return -ENOSYS;
>      }
>  
> -    return kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
> +    ret = kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
> +    trace_kvm_irqchip_assign_irqfd(fd, virq, rfd, ret);
> +    return ret;
>  }
>  
>  int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index a68eb66..c4ed199 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,7 +9,8 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>  kvm_irqchip_commit_routes(void) ""
> -kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
> +kvm_irqchip_add_msi_route(char *name, int vector, int virq, uint64_t addr, uint32_t data) "dev %s, vector %d, virq %d, msg {addr 0x%"PRIx64", data 0x%x}"
> +kvm_irqchip_assign_irqfd(int fd, int virq, int rfd, int status) "fd=%d, virq=%d, rfd=%d returns %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>  kvm_irqchip_release_virq(int virq) "virq %d"
>  kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
> diff --git a/exec.c b/exec.c
> index 6f381f9..5d05154 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2309,6 +2309,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>          }
>          ram_block_notify_add(new_block->host, new_block->max_length);
>      }
> +    trace_ram_block_add(new_block->host, new_block->max_length,
> +                        memory_region_name(new_block->mr),
> +                        new_block->mr->readonly ? "ro" : "rw");
>  }
>  
>  #ifdef CONFIG_POSIX
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 67e34f3..65a2882 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -189,6 +189,7 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
>      int vector = addr / PCI_MSIX_ENTRY_SIZE;
>      bool was_masked;
>  
> +    trace_msix_table_mmio_write(dev->name, addr, val, size);
>      was_masked = msix_is_masked(dev, vector);
>      pci_set_long(dev->msix_table + addr, val);
>      msix_handle_mask_update(dev, vector, was_masked);
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index de0fae1..1bc1533 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1321,9 +1321,11 @@ static void pci_update_mappings(PCIDevice *d)
>      PCIIORegion *r;
>      int i;
>      pcibus_t new_addr;
> +    const char *name;
>  
>      for(i = 0; i < PCI_NUM_REGIONS; i++) {
>          r = &d->io_regions[i];
> +        name = r->memory ? r->memory->name : "";
>  
>          /* this region isn't registered */
>          if (!r->size)
> @@ -1337,18 +1339,18 @@ static void pci_update_mappings(PCIDevice *d)
>  
>          /* now do the real mapping */
>          if (r->addr != PCI_BAR_UNMAPPED) {
> -            trace_pci_update_mappings_del(d, pci_dev_bus_num(d),
> +            trace_pci_update_mappings_del(d->name, d, pci_dev_bus_num(d),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
> -                                          i, r->addr, r->size);
> +                                          i, r->addr, r->size, name);
>              memory_region_del_subregion(r->address_space, r->memory);
>          }
>          r->addr = new_addr;
>          if (r->addr != PCI_BAR_UNMAPPED) {
> -            trace_pci_update_mappings_add(d, pci_dev_bus_num(d),
> +            trace_pci_update_mappings_add(d->name, d, pci_dev_bus_num(d),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
> -                                          i, r->addr, r->size);
> +                                          i, r->addr, r->size, name);
>              memory_region_add_subregion_overlap(r->address_space,
>                                                  r->addr, r->memory, 1);
>          }
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index def4b39..56fc6c6 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -1,8 +1,8 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # pci.c
> -pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> -pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> +pci_update_mappings_del(const char *dname, void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size, const char *name) "%s d=%p %02x:%02x.%x [%d] @ 0x%"PRIx64" len 0x%"PRIx64" \"%s\""
> +pci_update_mappings_add(const char *dname, void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size, const char *name) "%s d=%p %02x:%02x.%x [%d] @ 0x%"PRIx64" len 0x%"PRIx64" \"%s\""
>  
>  # pci_host.c
>  pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x -> 0x%x"
> @@ -10,3 +10,4 @@ pci_cfg_write(const char *dev, unsigned devid, unsigned fnid, unsigned offs, uns
>  
>  # msix.c
>  msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d masked %d"
> +msix_table_mmio_write(char *name, uint64_t addr, uint64_t val, unsigned size)  "%s, @ %"PRId64", val 0x%"PRIx64", len %d"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 3335714..50b8202 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -299,6 +299,8 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          .size = size,
>      };
>  
> +    trace_vfio_dma_unmap(container->fd, iova, size);
> +
>      while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          /*
>           * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> @@ -336,6 +338,9 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>          .size = size,
>      };
>  
> +    trace_vfio_dma_map(container->fd, iova, size, vaddr,
> +                       (readonly ? "r" : "rw"));
> +
>      if (!readonly) {
>          map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
>      }
> @@ -976,7 +981,8 @@ int vfio_region_mmap(VFIORegion *region)
>          trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
>                                 region->mmaps[i].offset,
>                                 region->mmaps[i].offset +
> -                               region->mmaps[i].size - 1);
> +                               region->mmaps[i].size - 1,
> +                               region->mmaps[i].mmap);
>      }
>  
>      return 0;
> @@ -1639,6 +1645,9 @@ retry:
>          goto retry;
>      }
>  
> +    trace_vfio_region(vbasedev->name, index, (*info)->size, (*info)->offset,
> +                      (*info)->cap_offset, (*info)->flags);
> +
>      return 0;
>  }
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index b1ef55a..78a3cfa 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -107,7 +107,7 @@ vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions,
>  vfio_put_base_device(int fd) "close vdev->fd=%d"
>  vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
>  vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
> -vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
> +vfio_region_mmap(const char *name, unsigned long offset, unsigned long end, void *addr) "\"%s\" [0x%lx - 0x%lx] maps to %p"
>  vfio_region_exit(const char *name, int index) "Device %s, region %d"
>  vfio_region_finalize(const char *name, int index) "Device %s, region %d"
>  vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
> @@ -115,6 +115,9 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
>  vfio_dma_unmap_overflow_workaround(void) ""
> +vfio_dma_unmap(int fd, uint64_t iova, uint64_t size) "fd %d, iova 0x%"PRIx64", len 0x%"PRIx64
> +vfio_dma_map(int fd, uint64_t iova, uint64_t size, void *addr, const char *access) "fd %d, iova 0x%"PRIx64", len 0x%"PRIx64", va %p, %s"
> +vfio_region(const char *name, int index, uint64_t size, uint64_t offset, int cap_offset, int flags) "%s [%d]: len 0x%"PRIx64" @ +0x%"PRIx64", cap +0x%x, flags 0x%x"
>  
>  # platform.c
>  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
> diff --git a/trace-events b/trace-events
> index 42107eb..e05238a 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -107,6 +107,8 @@ qmp_job_complete(void *job) "job %p"
>  qmp_job_finalize(void *job) "job %p"
>  qmp_job_dismiss(void *job) "job %p"
>  
> +# exec.c
> +ram_block_add(void *host, uint64_t maxlen, const char *name, const char *mode) "host=%p, maxlen=0x%"PRIx64", mr = {\"%s\", %s}"
>  
>  ### Guest events, keep at bottom
>  
> -- 
> 1.8.3.1


