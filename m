Received: from eggs.gnu.org ([2001:4830:134:3::10]:50336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dPmLW-0002YJ-Je
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dPmLV-0000Ms-JZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:59:42 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<589f1642-775c-4805-74ac-bf67eb504733@arm.com>
	<5f47e723-1d3e-433b-cdaf-a56d16ba377e@redhat.com>
	<d4277d93-d29d-7150-7962-bdfdd1c2a275@arm.com>
	<6070f02d-20d3-98fb-e31a-e7dbf5010419@redhat.com>
	<20170627084641.GC5759@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f7e3fe04-326e-9826-0321-8092adc94736@redhat.com>
Date: Tue, 27 Jun 2017 10:59:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170627084641.GC5759@arm.com>
Content-Type: text/plain; charset=windows-1252
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
To: Will Deacon <will.deacon@arm.com>
Cc: "wei@redhat.com" <wei@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "drjones@redhat.com" <drjones@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>

Hi,

On 27/06/2017 10:46, Will Deacon wrote:
> Hi Eric,
> 
> On Tue, Jun 27, 2017 at 08:38:48AM +0200, Auger Eric wrote:
>> On 26/06/2017 18:13, Jean-Philippe Brucker wrote:
>>> On 26/06/17 09:22, Auger Eric wrote:
>>>> On 19/06/2017 12:15, Jean-Philippe Brucker wrote:
>>>>> On 19/06/17 08:54, Bharat Bhushan wrote:
>>>>>> I started added replay in virtio-iommu and came across how MSI interrupts with work with VFIO. 
>>>>>> I understand that on intel this works differently but vsmmu will have same requirement. 
>>>>>> kvm-msi-irq-route are added using the msi-address to be translated by viommu and not the final translated address.
>>>>>> While currently the irqfd framework does not know about emulated iommus (virtio-iommu, vsmmuv3/vintel-iommu).
>>>>>> So in my view we have following options:
>>>>>> - Programming with translated address when setting up kvm-msi-irq-route
>>>>>> - Route the interrupts via QEMU, which is bad from performance
>>>>>> - vhost-virtio-iommu may solve the problem in long term
>>>>>>
>>>>>> Is there any other better option I am missing?
>>>>>
>>>>> Since we're on the topic of MSIs... I'm currently trying to figure out how
>>>>> we'll handle MSIs in the nested translation mode, where the guest manages
>>>>> S1 page tables and the host doesn't know about GVA->GPA translation.
>>>>
>>>> I have a question about the "nested translation mode" terminology. Do
>>>> you mean in that case you use stage 1 + stage 2 of the physical IOMMU
>>>> (which the ARM spec normally advises or was meant for) or do you mean
>>>> stage 1 implemented in vIOMMU and stage 2 implemented in pIOMMU. At the
>>>> moment my understanding is for VFIO integration the pIOMMU uses a single
>>>> stage combining both the stage 1 and stage2 mappings but the host is not
>>>> aware of those 2 stages.
>>>
>>> Yes at the moment the VMM merges stage-1 (GVA->GPA) from the guest with
>>> its stage-2 mappings (GPA->HPA) and creates a stage-2 mapping (GVA->HPA)
>>> in the pIOMMU via VFIO_IOMMU_MAP_DMA. stage-1 is disabled in the pIOMMU.
>>>
>>> What I mean by "nested mode" is stage 1 + stage 2 in the physical IOMMU.
>>> I'm referring to the "Page Table Sharing" bit of the Future Work in the
>>> initial RFC for virtio-iommu [1], and also PASID table binding [2] in the
>>> case of vSMMU. In that mode, stage-1 page tables in the pIOMMU are managed
>>> by the guest, and the VMM only maps GPA->HPA.
>>
>> OK I need to read that part more thoroughly. I was told in the past
>> handling nested stages at pIOMMU was considered too complex and
>> difficult to maintain. But definitively The SMMU architecture is devised
>> for that. Michael asked why we did not use that already for vsmmu
>> (nested stages are used on AMD IOMMU I think).
> 
> Curious -- but what gave you that idea? I worry that something I might have
> said wasn't clear or has been misunderstood.

Lobby discussions I might not have correctly understood ;-) Anyway
that's a new direction that I am happy to investigate then.

Thanks

Eric
> 
> Will
> 
