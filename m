Received: from eggs.gnu.org ([2001:4830:134:3::10]:56285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1e2avq-00005f-0S
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1e2avp-0003GG-1O
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:41:38 -0400
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-0MK18DakmNPRXCNYbDpBvzE0h12nNjg7zr+F_m0EnDw@mail.gmail.com>
	<f3a263b7-27e6-26df-592d-a34902bab6fe@redhat.com>
	<CAFEAcA_2RaRsvm_=V4iDNk_vMOtiWUZs3-SdMh+DSYqGyPE0PQ@mail.gmail.com>
	<08ce288c-610c-4dea-927d-262e7b75051f@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1f4895e8-cc64-feb7-65e4-d17128c570d1@arm.com>
Date: Thu, 12 Oct 2017 11:46:26 +0100
MIME-Version: 1.0
In-Reply-To: <08ce288c-610c-4dea-927d-262e7b75051f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 00/16] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, Will Deacon <Will.Deacon@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Christoffer Dall <christoffer.dall@linaro.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>

On 12/10/17 11:09, Auger Eric wrote:
> Hi Peter,
> 
> On 12/10/2017 11:54, Peter Maydell wrote:
>> On 11 October 2017 at 17:08, Auger Eric <eric.auger@redhat.com> wrote:
>>> Hi Peter,
>>>
>>> On 11/10/2017 16:56, Peter Maydell wrote:
>>>> On 19 September 2017 at 08:46, Eric Auger <eric.auger@redhat.com> wrote:
>>>>> This series implements the virtio-iommu device.
>>>>>
>>>>> This v4 is an upgrade to v0.4 spec [1] and applies on QEMU v2.10.0.
>>>>> - probe request support although no reserved region is returned at
>>>>>   the moment
>>>>> - unmap semantics less strict, as specified in v0.4
>>>>> - device registration, attach/detach revisited
>>>>> - split into smaller patches to ease review
>>>>> - propose a way to inform the IOMMU mr about the page_size_mask
>>>>>   of underlying HW IOMMU, if any
>>>>> - remove warning associated with the translation of the MSI doorbell
>>>>>
>>>>> The device gets instantiated using the "-device virtio-iommu-device"
>>>>> option. It currently works with ARM virt machine only, as the machine
>>>>> must handle the dt binding between the virtio-mmio "iommu" node and
>>>>> the PCI host bridge node.
>>>>
>>>> Could this work on x86, or is it inherently arm-only?
>>>
>>> Yes this is the goal. At the moment the ACPI probing is not yet properly
>>> specified but a Q35 prototype was developed in the Red Hat Virt team.
>>> This will be presented at the KVM forum.
>>
>> Since I have very little familiarity with virtio or iommu code,
>> I'd be much happier if this was reviewed as a generic virtio-iommu
>> by the x86/virtio devs and then the arm specific parts done second...
> 
> Understood. I was rather expecting you to review the smmuv3 emulation
> code which you did, in a comprehensive manner ;-), and many thanks for that.
> 
> Note sure this is time yet to get this RFC reviewed as
> - the v0.4 virtio-iommu driver it relies on was not officially submitted,
> - the virtio-iommu specification review has not really been reviewed,
> - the ACPI probing method has not been discussed yet.
> 
> Jean-Philippe, please correct me if I am wrong.
> 
> So to me, this is pure RFC at the moment.

Yes, having it as an RFC for the moment allowed to break compatibility
between versions of the specification. The downside is that it probably
doesn't get as many eyeballs as it would without an RFC tag (although I
did receive tonnes of helpful comments). Maybe v0.5, that should be
published shortly, can be a candidate for mainline.

Thanks,
Jean

>> I'm also not clear on what we're expecting the recommended or normal
>> way to do device passthrough is going to be -- this virtio-mmio,
>> or presenting the guest with an SMMUv3 interface? Do we really
>> need to implement both ?
> 
> I think the KVM forum is the right place to sync as both approaches will
> be presented and some pros/cons + performance figures will be given.
> 
> As we talk about choosing, there is one alternative that was suggested
> on the ML by Alex & Michael but never really get considered yet and
> maybe should be: using intel iommu emulation code for ARM. I aknowledge
> this deserves a thorough impact study on kernel and FW side but I would
> be happy to get your opinion about the QEMU side. Would you have a by-
> principle rejection of this idea to instantiate such an Intel device in
> mach virt or would it be something you would be ready to consider?
> 
> Thanks
> 
> Eric
> 
> 
>>
>> thanks
>> -- PMM
>>
