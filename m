Received: from eggs.gnu.org ([2001:4830:134:3::10]:56886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dSjdK-0006d2-9A
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dSjdJ-00062r-EK
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:42:18 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<589f1642-775c-4805-74ac-bf67eb504733@arm.com>
	<5f47e723-1d3e-433b-cdaf-a56d16ba377e@redhat.com>
	<d4277d93-d29d-7150-7962-bdfdd1c2a275@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25B77@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <311754cd-a4cf-7bf4-4099-a81e63402137@arm.com>
Date: Wed, 5 Jul 2017 13:44:50 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D25B77@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>, Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wei@redhat.com" <wei@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On 05/07/17 08:25, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Tuesday, June 27, 2017 12:13 AM
>>
>> On 26/06/17 09:22, Auger Eric wrote:
>>> Hi Jean-Philippe,
>>>
>>> On 19/06/2017 12:15, Jean-Philippe Brucker wrote:
>>>> On 19/06/17 08:54, Bharat Bhushan wrote:
>>>>> Hi Eric,
>>>>>
>>>>> I started added replay in virtio-iommu and came across how MSI
>> interrupts with work with VFIO.
>>>>> I understand that on intel this works differently but vsmmu will have
>> same requirement.
>>>>> kvm-msi-irq-route are added using the msi-address to be translated by
>> viommu and not the final translated address.
>>>>> While currently the irqfd framework does not know about emulated
>> iommus (virtio-iommu, vsmmuv3/vintel-iommu).
>>>>> So in my view we have following options:
>>>>> - Programming with translated address when setting up kvm-msi-irq-
>> route
>>>>> - Route the interrupts via QEMU, which is bad from performance
>>>>> - vhost-virtio-iommu may solve the problem in long term
>>>>>
>>>>> Is there any other better option I am missing?
>>>>
>>>> Since we're on the topic of MSIs... I'm currently trying to figure out how
>>>> we'll handle MSIs in the nested translation mode, where the guest
>> manages
>>>> S1 page tables and the host doesn't know about GVA->GPA translation.
>>>
>>> I have a question about the "nested translation mode" terminology. Do
>>> you mean in that case you use stage 1 + stage 2 of the physical IOMMU
>>> (which the ARM spec normally advises or was meant for) or do you mean
>>> stage 1 implemented in vIOMMU and stage 2 implemented in pIOMMU. At
>> the
>>> moment my understanding is for VFIO integration the pIOMMU uses a
>> single
>>> stage combining both the stage 1 and stage2 mappings but the host is not
>>> aware of those 2 stages.
>>
>> Yes at the moment the VMM merges stage-1 (GVA->GPA) from the guest with
>> its stage-2 mappings (GPA->HPA) and creates a stage-2 mapping (GVA->HPA)
>> in the pIOMMU via VFIO_IOMMU_MAP_DMA. stage-1 is disabled in the
>> pIOMMU.
>>
> 
> Curious whether you are describing current smmu status or general
> vIOMMU status also applying to other vendors...

This particular paragraph was about the non-SVM state of things. The rest
was about stage-1 + stage-2 (what I call nested), which would indeed be
required for SVM. I don't think SVM can work with software merging.

Thanks,
Jean

> the usage what you described is about svm, while svm requires PASID.
> At least PASID is tied to stage-1 on Intel VT-d. Only DMA w/o PASID
> or nested translation from stage-1 will go through stage-2. Unless
> ARM smmu has a completely different implementation, I'm not sure
> how svm can be virtualized w/ stage-1 translation disabled. There
> are multiple stage-1 page tables while only one stage-2 page table per
> device. Could merging actually work here?
> 
> The only case with merging happen today is for guest stage-2 usage
> or so-called GIOVA usage. Guest programs GIOVA->GPA to vIOMMU 
> stage-2. Then vIOMMU invokes vfio map/unmap APIs to translate/
> merge to GIOVA->HPA to pIOMMU stage-2. Maybe what you
> actually meant is this one?
> 
> Thanks
> Kevin
> 
