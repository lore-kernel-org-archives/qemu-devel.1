Received: from eggs.gnu.org ([2001:4830:134:3::10]:36474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0AM9-0007ud-E7
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0AM6-00011v-7y
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:59:17 -0400
Received: from mail-by2nam03on0042.outbound.protection.outlook.com
	([104.47.42.42]:61120
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0AM5-00011h-Tv
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:59:14 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
	<20180912035214.GC3829@xz-x1>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9ecccc2d-9274-36c1-c0a5-56a24836d075@amd.com>
Date: Wed, 12 Sep 2018 13:59:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180912035214.GC3829@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Xu <peterx@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>



On 09/11/2018 10:52 PM, Peter Xu wrote:
> On Tue, Sep 11, 2018 at 11:49:45AM -0500, Brijesh Singh wrote:
>>   static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>   {
>>       AMDVIState *s = opaque;
>> @@ -1055,6 +1151,12 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>           address_space_init(&iommu_as[devfn]->as,
>>                              MEMORY_REGION(&iommu_as[devfn]->iommu),
>>                              "amd-iommu");
>> +        memory_region_init_io(&iommu_as[devfn]->iommu_ir, OBJECT(s),
>> +                              &amdvi_ir_ops, s, "amd-iommu-ir",
>> +                              AMDVI_INT_ADDR_SIZE);
>> +        memory_region_add_subregion(MEMORY_REGION(&iommu_as[devfn]->iommu),
>> +                              AMDVI_INT_ADDR_FIRST,
>> +                              &iommu_as[devfn]->iommu_ir);
> 
> A pure question: just to make sure this IR region won't be masked out
> by other memory regions.  Asked since VT-d is explicitly setting a
> higher priority of the memory region for interrupts with
> memory_region_add_subregion_overlap().
> 

Hmm, I was hoping that this IR region will not be masked out by other
regions but if it does then we will have trouble. thanks for pointing
this out, I think we can do similar thing as VT-d and make the region
as high priority so that we get memops invoked.


>>       }
>>       return &iommu_as[devfn]->as;
>>   }
>> @@ -1172,6 +1274,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
>>           return;
>>       }
>>   
>> +    /* Pseudo address space under root PCI bus. */
>> +    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_SB_IOAPIC_ID);
>> +    s->intr_enabled = x86_iommu->intr_supported;
> 
> So does this mean that AMD IR cannot be disabled if declared support?
> For VT-d, IR needs to be explicitly enabled otherwise disabled (even
> supported).
> 


Yes, once its declared as supported then it can not disabled. Its
upto the guest OS to decide whether it want to use the intr remapping
feature by parsing the IVRS. This also brings question, should we
just enable it by default because its guest OS decision whether it
wants to use it or not.
