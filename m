Received: from eggs.gnu.org ([2001:4830:134:3::10]:34756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIyQw-0006Q1-Hz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIyQr-0004md-Hq
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:33:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fIyQr-0004mP-DB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:33:37 -0400
References: <20180501101907.22638-1-peter.maydell@linaro.org>
	<a660c604-5e6e-29c7-ed3f-47e40de8da1b@redhat.com>
	<CAFEAcA_+gu3fWW9jNwT9DM5Yh2OFgehVDOnckAVACFPouzp58A@mail.gmail.com>
	<703a3977-7490-9c45-5fcd-66b96840b865@redhat.com>
	<CAFEAcA-XfLPQzPPxWC+ugCufnFt+nzFfWuDH_m+xP-mH=w9M_Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <87b443ba-43e5-73c5-9710-e1a6c61ca1ad@redhat.com>
Date: Wed, 16 May 2018 17:33:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XfLPQzPPxWC+ugCufnFt+nzFfWuDH_m+xP-mH=w9M_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi Peter,

On 05/08/2018 06:25 PM, Peter Maydell wrote:
> On 1 May 2018 at 16:53, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 05/01/2018 05:00 PM, Peter Maydell wrote:
>>> On 1 May 2018 at 15:32, Auger Eric <eric.auger@redhat.com> wrote:
>>>> Hi Peter,
>>>>
>>>> On 05/01/2018 12:19 PM, Peter Maydell wrote:
>>>>> +     * Once the IOMMU has returned a TLB entry, it must notify
>>>>> +     * the IOMMU's users if that TLB entry changes, using
>>>>> +     * memory_region_notify_iommu() (or, if necessary, by calling
>>>>> +     * memory_region_notify_one() for each registered notifier).
>>>> if caching mode is set (VFIO integration), On the first guest map
>>>> (invalidation on map), the IOMMU must replay the mapping (notify VFIO)
>>>> to get the 1st stage of the physical IOMMU programmed. At that moment
>>>> the IOMMU may not have returned any TLB entry.
>>>
>>> I'm afraid you've lost me. What is caching mode, how do you set it,
>>> how does the IOMMU replay the mapping? More concretely, what change
>>> needs to be made to this text?
>>
>> np. The caching mode relates to Intel IOMMU. When this bit is advertised
>> in the Intel IOMMU, it forces the IOMMU driver to invalidate TLB entries
>> also on map and not only on unmap. So when any iova is mapped, an
>> invalidation command is sent and this allows to trap when entries are
>> created. Then the IOMMU device can notify "users" that a mapping
>> happened and this mapping can be forwarded to the physical IOMMU.
>> Caching mode is set when a VFIO device is behind the IOMMU and both
>> stage 1 and stage 2 are combined in the physical IOMMU.
>>
>> what about: the IOMMU is responsible to call the registered user
>> notifiers when the associated event occurs on an IOTLB entry (map/unmap).
> 
> This runs into something I found when I was implementing the Arm
> Memory Protection Controller -- at the point when the guest changes
> the config,
do you mean the config structures (STE, CD) or the page table update?

 it doesn't have enough information to be able to call a
> "map" notifier, because the mapping depends on the memory transaction
> attributes, it's not fixed and dependent only on the address.
I am not sure I understand what you mean here. When the notifier get's
called, aren't we supposed to look for the info in the actual page table
(where memory access control attributes and others can be found at that
time, ie. ARM AP[] for instance) and send those through the notifier (as
stored in the IOTLBEnry)?

For instance in the intel iommu code, the whole table is parsed and the
replay hook is called for all valid entries.

vtd_iommu_replay/ptw/vtd_replay_hook/memory_region_notify_one

Thanks

Eric
 We can
> say "unmap" to indicate that the old information is not usable any
> more, but that's all. (Similarly if the mapping depends on the
> read/write permission then the IOMMU isn't going to be able to
> provide a new mapping to the notifier, because it doesn't have the
> information to do that.)

> 
> My use-case for notifiers (getting the TCG code to throw away its
> TLB entries for the now-stale information) doesn't require anything
> more from the notifier, but it's not clear to me what the exact
> notifier-calling requirements are.
> 
> If you can't actually use the memory transaction attributes info
> to inform your translation, then there's not much point plumbing
> them into the IOMMU.
> 
> thanks
> -- PMM
> 
