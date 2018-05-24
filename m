Received: from eggs.gnu.org ([2001:4830:134:3::10]:46412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLvgd-0003nS-Ao
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLvgc-0002qE-6b
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:14:07 -0400
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-16-peter.maydell@linaro.org>
	<0774094d-d3e1-5983-ccb8-3d3412bf44fc@redhat.com>
	<CAFEAcA95XD7_4q0p0Q6aPCxHHxHoRrVaKc+Nq+niZp-4PV8JLw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8b0353e6-18f1-6e7f-5f4e-2d1a06a20b29@redhat.com>
Date: Thu, 24 May 2018 21:13:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95XD7_4q0p0Q6aPCxHHxHoRrVaKc+Nq+niZp-4PV8JLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/27] iommu: Add IOMMU index argument to
 notifier APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>

Hi Peter,
On 05/24/2018 07:03 PM, Peter Maydell wrote:
> On 24 May 2018 at 16:29, Auger Eric <eric.auger@redhat.com> wrote:
>> On 05/21/2018 04:03 PM, Peter Maydell wrote:
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index f6226fb263..4e6b125add 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -71,6 +71,7 @@ struct IOMMUTLBEntry {
>>>      hwaddr           iova;
>>>      hwaddr           translated_addr;
>>>      hwaddr           addr_mask;  /* 0xfff = 4k translation */
>>> +    int              iommu_idx;
>> I don't get why ne need iommu_idx field here. On translate the caller
>> has it. On notify the notifier has it?
> 
> I think this is an accidental leftover from some earlier draft;
> nothing in the patchset actually reads or writes this field, and
> it should be deleted.
> 
>>>      IOMMUAccessFlags perm;
>>>  };
>>>
> 
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 8e57265edf..fb396cf00a 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -507,6 +507,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>>      if (memory_region_is_iommu(section->mr)) {
>>>          VFIOGuestIOMMU *giommu;
>>>          IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
>>> +        int iommu_idx;
>>>
>>>          trace_vfio_listener_region_add_iommu(iova, end);
>>>          /*
>>> @@ -523,10 +524,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>>          llend = int128_add(int128_make64(section->offset_within_region),
>>>                             section->size);
>>>          llend = int128_sub(llend, int128_one());
>>> +        iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
>>> +                                                       MEMTXATTRS_UNSPECIFIED);
>> In that case VFIO ideally wants to be notified for any guest update
>> (whatever the page set) to reprogram the physical IOMMU corresponding
>> entries and doesn't want to register a notifier per iommu_idx. Also it
>> does not know which ones are supported. Is there a corresponding
>> iommu_idx value? MEMTXATTRS_ANY?
> 
> If VFIO is actually dealing with an IOMMU that needs to handle
> multiple possible transactions for different tx attributes, then
> it needs to know about all of them, because how it programs
> the physical IOMMU needs to be different for "map X to Y for
> Secure transactions" versus "map X to Y for NonSecure" (say).
> (This would require new kernel APIs, I assume.)

Hum agreed. In any case the iommu_idx must be passed to VFIO along with
the notification, either as part of the notifier itself or in the
IOMMUTLBEntry. So VFIO may need to enumerate the supported iommu_idx and
register a notifier for relevant ones.

Thanks

Eric
> 
> If, as is currently the case, the VFIO infrastructure assumes that
> the IOMMU will always translate any transaction from a device
> identically regardless of its transaction attributes, then it
> should just use MEMTXATTRS_UNSPECIFIED, and trust that the
> emulated IOMMU will translate those correctly. (There might be
> scope for VFIO checking that the IOMMU really does, eg that
> it is only using one iommu index?)
> 
> Basically, VFIO is shadowing the behaviour of the emulated
> IOMMU to reflect it into the kernel; if the IOMMU it's shadowing
> is complicated then VFIO is going to need to be similarly
> complicated, and "merge updates for different page tables
> down into one" is not going to be the right behaviour.
> 
> thanks
> -- PMM
> 
