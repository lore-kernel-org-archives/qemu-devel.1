Received: from eggs.gnu.org ([2001:4830:134:3::10]:47277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e2udh-0002mv-Nw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e2udg-00084e-KS
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:44:13 -0400
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-0MK18DakmNPRXCNYbDpBvzE0h12nNjg7zr+F_m0EnDw@mail.gmail.com>
	<f3a263b7-27e6-26df-592d-a34902bab6fe@redhat.com>
	<CAFEAcA_2RaRsvm_=V4iDNk_vMOtiWUZs3-SdMh+DSYqGyPE0PQ@mail.gmail.com>
	<08ce288c-610c-4dea-927d-262e7b75051f@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190E139B0@SHSMSX151.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4ce3a29a-6105-88ef-8b90-75658285dd78@redhat.com>
Date: Fri, 13 Oct 2017 09:43:52 +0200
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190E139B0@SHSMSX151.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 00/16] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Will Deacon <will.deacon@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Christoffer Dall <christoffer.dall@linaro.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>

Hi Kevin,

On 13/10/2017 09:01, Tian, Kevin wrote:
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: Thursday, October 12, 2017 6:10 PM
>>
>> Hi Peter,
>>
>> On 12/10/2017 11:54, Peter Maydell wrote:
>>> On 11 October 2017 at 17:08, Auger Eric <eric.auger@redhat.com> wrote=
:
>>>> Hi Peter,
>>>>
>>>> On 11/10/2017 16:56, Peter Maydell wrote:
>>>>> On 19 September 2017 at 08:46, Eric Auger <eric.auger@redhat.com>
>> wrote:
>>>>>> This series implements the virtio-iommu device.
>>>>>>
>>>>>> This v4 is an upgrade to v0.4 spec [1] and applies on QEMU v2.10.0=
.
>>>>>> - probe request support although no reserved region is returned at
>>>>>>   the moment
>>>>>> - unmap semantics less strict, as specified in v0.4
>>>>>> - device registration, attach/detach revisited
>>>>>> - split into smaller patches to ease review
>>>>>> - propose a way to inform the IOMMU mr about the page_size_mask
>>>>>>   of underlying HW IOMMU, if any
>>>>>> - remove warning associated with the translation of the MSI doorbe=
ll
>>>>>>
>>>>>> The device gets instantiated using the "-device virtio-iommu-devic=
e"
>>>>>> option. It currently works with ARM virt machine only, as the mach=
ine
>>>>>> must handle the dt binding between the virtio-mmio "iommu" node
>> and
>>>>>> the PCI host bridge node.
>>>>>
>>>>> Could this work on x86, or is it inherently arm-only?
>>>>
>>>> Yes this is the goal. At the moment the ACPI probing is not yet prop=
erly
>>>> specified but a Q35 prototype was developed in the Red Hat Virt team=
.
>>>> This will be presented at the KVM forum.
>>>
>>> Since I have very little familiarity with virtio or iommu code,
>>> I'd be much happier if this was reviewed as a generic virtio-iommu
>>> by the x86/virtio devs and then the arm specific parts done second...
>>
>> Understood. I was rather expecting you to review the smmuv3 emulation
>> code which you did, in a comprehensive manner ;-), and many thanks for
>> that.
>>
>> Note sure this is time yet to get this RFC reviewed as
>> - the v0.4 virtio-iommu driver it relies on was not officially submitt=
ed,
>> - the virtio-iommu specification review has not really been reviewed,
>> - the ACPI probing method has not been discussed yet.
>>
>> Jean-Philippe, please correct me if I am wrong.
>>
>> So to me, this is pure RFC at the moment.
>>>
>>> I'm also not clear on what we're expecting the recommended or normal
>>> way to do device passthrough is going to be -- this virtio-mmio,
>>> or presenting the guest with an SMMUv3 interface? Do we really
>>> need to implement both ?
>>
>> I think the KVM forum is the right place to sync as both approaches wi=
ll
>> be presented and some pros/cons + performance figures will be given.
>>
>> As we talk about choosing, there is one alternative that was suggested
>> on the ML by Alex & Michael but never really get considered yet and
>> maybe should be: using intel iommu emulation code for ARM. I
>> aknowledge
>> this deserves a thorough impact study on kernel and FW side but I woul=
d
>> be happy to get your opinion about the QEMU side. Would you have a by-
>> principle rejection of this idea to instantiate such an Intel device i=
n
>> mach virt or would it be something you would be ready to consider?
>>
>=20
> bear posting a link to Alex/Michael's comment? interesting to know
> the rationale...

This was suggested here for instance:

https://lkml.org/lkml/2017/7/12/579

I think rationale was
- this is an emulated platform so there is more freedom
- vtd emulation code is rather stable
- it has pieces missing on smmu: cachine mode, IOTLB invalidation
command with addr_mask,
- intel iommu driver implements deferred IOTLB Invalidation which boosts
perf

But problems I foresee are:
- MSI handling. ARM MSI doorbells can be anywhere in the GPA address
space whereas Intel has MSIs within the APIC window: [FEE0_0000h =E2=80=93
FEF0_000h]. So I suspect the MSI handling may not work at kernel level.
- intel IOMMU input/output address ranges and page sizes may be
different from ARM ones.
- ARM uses ACPI IORT for binding RC <-> IOMMU <-> MSI controller whereas
Intel uses other tables
- Intel's dmar kernel code must be compiled/enabled on ARM

So personally I don't think this solution is viable but I prefer this
gets discussed on the ML.

Thanks

Eric
>=20
> Thanks
> Kevin
>=20
