Received: from eggs.gnu.org ([2001:4830:134:3::10]:60114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d0KJa-0001Fb-Jo
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d0KJX-0004kf-Hl
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d0KJX-0004jy-7n
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:00:27 -0400
References: <1492426712-12230-1-git-send-email-peterx@redhat.com>
	<1492426712-12230-8-git-send-email-peterx@redhat.com>
	<1c5c9278-92b1-6f56-b251-53bf60c7f4e8@redhat.com>
	<20170418035033.GH16703@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <18bd8627-bdca-b9e8-8d4e-c4aa0689d4aa@redhat.com>
Date: Tue, 18 Apr 2017 12:00:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170418035033.GH16703@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] intel_iommu: support passthrough (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Lan Tianyu <tianyu.lan@intel.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S.Tsirkin" <mst@redhat.com>



On 2017=E5=B9=B404=E6=9C=8818=E6=97=A5 11:50, Peter Xu wrote:
> On Tue, Apr 18, 2017 at 11:23:35AM +0800, Jason Wang wrote:
>> On 2017=E5=B9=B404=E6=9C=8817=E6=97=A5 18:58, Peter Xu wrote:
> [...]
>
>>> +static void vtd_switch_address_space(VTDAddressSpace *as)
>>> +{
>>> +    bool use_iommu;
>>> +
>>> +    assert(as);
>>> +
>>> +    use_iommu =3D as->iommu_state->dmar_enabled;
>>> +    if (use_iommu) {
>>> +        /* Further checks per-device configuration */
>>> +        use_iommu &=3D !vtd_dev_pt_enabled(as);
>>> +    }
>> Looks like you can use as->iommu_state->dmar_enabled &&
>> !vtd_dev_pt_enabled(as)
> vtd_dev_pt_enalbed() needs to read the guest memory (starting from
> reading root entry), which is slightly slow. I was trying to avoid
> unecessary reads.
>
> [...]

I think compiler won't go to vtd_dev_pt_enabled() if dmar_enabled is fals=
e.

>
>>> @@ -991,6 +1058,18 @@ static void vtd_do_iommu_translate(VTDAddressSp=
ace *vtd_as, PCIBus *bus,
>>>           cc_entry->context_cache_gen =3D s->context_cache_gen;
>>>       }
>>> +    /*
>>> +     * We don't need to translate for pass-through context entries.
>>> +     * Also, let's ignore IOTLB caching as well for PT devices.
>>> +     */
>>> +    if (vtd_ce_get_type(&ce) =3D=3D VTD_CONTEXT_TT_PASS_THROUGH) {
>>> +        entry->translated_addr =3D entry->iova;
>>> +        entry->addr_mask =3D VTD_PAGE_SIZE - 1;
>>> +        entry->perm =3D IOMMU_RW;
>>> +        trace_vtd_translate_pt(source_id, entry->iova);
>>> +        return;
>>> +    }
>> Several questions here:
>>
>> 1) Is this just for vhost?
> No. When caching mode is not enabled, all passthroughed devices should
> be using this path.

Ok, then it looks better to switch the address space if we've found it=20
was PT?

>
>> 2) Since this is done after IOTLB querying, do we need flush IOTLB dur=
ing
>> address switching?
> IMHO if guest switches address space for a device, it is required to
> send IOTLB flush as well for that device/domain.
>
> [...]

Ok.

>
>>>   static void vtd_switch_address_space_all(IntelIOMMUState *s)
>>>   {
>>>       GHashTableIter iter;
>>> @@ -2849,6 +2914,10 @@ static void vtd_init(IntelIOMMUState *s)
>>>           s->ecap |=3D VTD_ECAP_DT;
>>>       }
>>> +    if (x86_iommu->pt_supported) {
>>> +        s->ecap |=3D VTD_ECAP_PT;
>>> +    }
>> Since we support migration now, need compat this for pre 2.10.
> Oh yes. If I set pt=3Doff by default, it should be okay then, right?

Right, but I think it's better to keep this on by default for=20
performance reason.

>
> Then, at some point, we can switch to on by default, with a touch-up
> in include/hw/compat.h I guess?

Yes.

Thanks
>
>>> +
>>>       if (s->caching_mode) {
>>>           s->cap |=3D VTD_CAP_CM;
>>>       }
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_int=
ernal.h
>>> index 29d6707..0e73a65 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -187,6 +187,7 @@
>>>   /* Interrupt Remapping support */
>>>   #define VTD_ECAP_IR                 (1ULL << 3)
>>>   #define VTD_ECAP_EIM                (1ULL << 4)
>>> +#define VTD_ECAP_PT                 (1ULL << 6)
>>>   #define VTD_ECAP_MHMV               (15ULL << 20)
>>>   /* CAP_REG */
>>> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
>>> index 04a6980..867ad0b 100644
>>> --- a/hw/i386/trace-events
>>> +++ b/hw/i386/trace-events
>>> @@ -38,6 +38,7 @@ vtd_page_walk_skip_perm(uint64_t iova, uint64_t nex=
t) "Page walk skip iova 0x%"P
>>>   vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk=
 skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
>>>   vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, boo=
l on) "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)"
>>>   vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t =
iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx=
64
>>> +vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIu16"=
, iova 0x%"PRIx64
>>>   # hw/i386/amd_iommu.c
>>>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to wr=
ite at addr 0x%"PRIx64" +  offset 0x%"PRIx32
>>> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
>>> index 02b8825..293caf8 100644
>>> --- a/hw/i386/x86-iommu.c
>>> +++ b/hw/i386/x86-iommu.c
>>> @@ -91,6 +91,7 @@ static void x86_iommu_realize(DeviceState *dev, Err=
or **errp)
>>>   static Property x86_iommu_properties[] =3D {
>>>       DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, fal=
se),
>>>       DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, f=
alse),
>>> +    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>> Do you know if AMD IOMMU support this?
> AMD IOMMU should support this. IIUC it's the first bit of Device Table =
Entry.
>
> Thanks,
>
