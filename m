Received: from eggs.gnu.org ([2001:4830:134:3::10]:45014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ewPSc-00069c-VQ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ewPSc-0006ln-0e
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:46:10 -0400
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-12-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_9cmK9gebqE9997fzhTzKT6Ky9q4jn=fxwziopDyK9Ew@mail.gmail.com>
	<cc6029a1-c177-ee8c-d09b-0ed2af81c897@redhat.com>
	<75aee987-a08b-570f-ec10-8b4853d853c6@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ee14227e-8d0a-6f5e-cc60-2bfa0f029723@redhat.com>
Date: Thu, 15 Mar 2018 10:45:50 +0100
MIME-Version: 1.0
In-Reply-To: <75aee987-a08b-570f-ec10-8b4853d853c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 11/14] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

Hi Paolo,

On 13/03/18 14:37, Paolo Bonzini wrote:
> On 12/03/2018 16:16, Auger Eric wrote:
>>> It is still unclear to me if we need to register an IOMMUNotifier
>>> to handle any change in the MSI doorbell which would occur behind
>>> the scene and would not lead to any call to kvm_arch_fixup_msi_route().
>>
>> Paolo, do you know the answer to this question ?
> 
> Yes, x86 is wrong in this respect (it wouldn't use an IOMMUNotifier, but
> it still should process Interrupt Entry Cache invalidations).

I am not sure anymore of the issue we want to fix. The concen I had in
mind was: what if the MSI doorbell gets unmapped. We would need to be
notified in some way. As the doorbell lies in MMIO space, no
IOMMUNotifier is attached to it at the moment. On the other hand, if the
doorbell gets unmapped, can't we expect some kind of tear down of the
route? Paolo, is it the use case you are talking about here?
> 
>>> It seems a bit odd that:
>>>  * the code for arm for "PCI devices behind IOMMU need to have
>>>    the MSI doorbell writes go through the IOMMU" looks rather
>>>    different from the code for x86 for the same thing
>>
>> ARM SMMU translates MSIs whereas Intel/AMD IOMMU do not translate them.
>> Hence this implementation
> 
> More precisely, Intel IOMMU implements interrupt remapping through an
> MMIO region instead of an IOMMU region, because on x86 interrupt
> remapping can also change the MSI value and not just the address.
thank you for the clarification. Yes I too much focused on IOMMU DMA
translation and forgot the x86 interrupt remapping stuff which
corresponds to what is done here.
> 
>>>  * the code here needs to know specifically that this is an SMMU
>>>    and not some other kind of IOMMU
>> Yes when introducing virtio-iommu we will need to get this fixed. We
>> need a way to retrieve the iommu mr from the as. I will work on this
>> concurrently.
> 
> Probably something like address_space_translate can be used?
Yes achieved with address_space_translate + memory_region_find

Thanks

Eric

> 
> Paolo
> 
