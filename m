Received: from eggs.gnu.org ([2001:4830:134:3::10]:47235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fzwJA-0002hk-7c
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 23:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fzwCW-0001II-2z
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 23:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fzwCV-0001Hg-UX
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 23:52:24 -0400
Date: Wed, 12 Sep 2018 11:52:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180912035214.GC3829@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] x86_iommu/amd: Prepare for interrupt
 remap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Tue, Sep 11, 2018 at 11:49:45AM -0500, Brijesh Singh wrote:
>  static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  {
>      AMDVIState *s = opaque;
> @@ -1055,6 +1151,12 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>          address_space_init(&iommu_as[devfn]->as,
>                             MEMORY_REGION(&iommu_as[devfn]->iommu),
>                             "amd-iommu");
> +        memory_region_init_io(&iommu_as[devfn]->iommu_ir, OBJECT(s),
> +                              &amdvi_ir_ops, s, "amd-iommu-ir",
> +                              AMDVI_INT_ADDR_SIZE);
> +        memory_region_add_subregion(MEMORY_REGION(&iommu_as[devfn]->iommu),
> +                              AMDVI_INT_ADDR_FIRST,
> +                              &iommu_as[devfn]->iommu_ir);

A pure question: just to make sure this IR region won't be masked out
by other memory regions.  Asked since VT-d is explicitly setting a
higher priority of the memory region for interrupts with
memory_region_add_subregion_overlap().

>      }
>      return &iommu_as[devfn]->as;
>  }
> @@ -1172,6 +1274,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
>          return;
>      }
>  
> +    /* Pseudo address space under root PCI bus. */
> +    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_SB_IOAPIC_ID);
> +    s->intr_enabled = x86_iommu->intr_supported;

So does this mean that AMD IR cannot be disabled if declared support?
For VT-d, IR needs to be explicitly enabled otherwise disabled (even
supported).

Otherwise the patch looks good to me.  Thanks,

> +
>      /* set up MMIO */
>      memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
>                            AMDVI_MMIO_SIZE);
> @@ -1205,6 +1311,7 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
>      dc->vmsd = &vmstate_amdvi;
>      dc->hotpluggable = false;
>      dc_class->realize = amdvi_realize;
> +    dc_class->int_remap = amdvi_int_remap;
>      /* Supported by the pc-q35-* machine types */
>      dc->user_creatable = true;
>  }

Regards,

-- 
Peter Xu
