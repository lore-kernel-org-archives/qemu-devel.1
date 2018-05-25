Received: from eggs.gnu.org ([2001:4830:134:3::10]:52117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fM90w-0001lV-Tq
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fM90v-00038J-Cx
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:27:58 -0400
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<20180522030333.GB17282@xz-mi>
	<CAFEAcA-iOYhuPfvDv+iD6jBqXMXqN-jfTpSSBub1Zp1i-JcDbQ@mail.gmail.com>
	<20180522110236.GB31932@xz-mi>
	<CAFEAcA9b6dmpj+B=SO2YsB5sXsh=UPjkjN_U0i-uJhiDn20HHw@mail.gmail.com>
	<20180523010636.GC31932@xz-mi>
	<CAFEAcA840qn7Ms9hph9zzZgMbL8C7kN=cs4esGO9kxGXsgBg1A@mail.gmail.com>
	<20180524062352.GA12122@xz-mi>
	<CAFEAcA9SXirTw=H3wznVZDTmO1OB-LRNJAQ1MsyYm62SqvMqRQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5f966d9b-1eb9-f447-69bc-2d93df4c6d2b@redhat.com>
Date: Fri, 25 May 2018 11:27:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9SXirTw=H3wznVZDTmO1OB-LRNJAQ1MsyYm62SqvMqRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi Peter,

On 05/24/2018 12:54 PM, Peter Maydell wrote:
> On 24 May 2018 at 07:23, Peter Xu <peterx@redhat.com> wrote:
>> On Wed, May 23, 2018 at 12:47:16PM +0100, Peter Maydell wrote:
>>> On 23 May 2018 at 02:06, Peter Xu <peterx@redhat.com> wrote:
>>>> Could you elaborate a bit more on why IOMMU notifier failed to
>>>> corporate when passing in MemTxAttrs?  I am not sure I caught the idea
>>>> here, but can we copy the MemTxAttrs into IOMMUTLBEntry when
>>>> translating, then in IOMMU notifiers we can know the attrs (if that is
>>>> what MPC wants)?
>>>
>>> (1) The notifier API lets you register a notifier before you've
>>> called the translate API
>>
>> Yes.
>>
>>> (2) An IOMMUTLBEntry can be valid for more than just the txattrs
>>> that it was passed in (for instance, if an IOMMU doesn't care
>>> about txattrs at all, then the resulting TLB entry is valid for
>>> any txattrs; or if the IOMMU only cares about attrs.secure the
>>> resulting TLB entries are valid for both attrs.user=0 and
>>> attrs.user=1).
>>
>> [1]
>>
>> Yes exactly, that's why I thought copying the txattrs into IOTLB
>> should work.
> 
> I'm a bit confused about why the IOMMUTLBEntry is relevant here.
> That's the thing returned from the translate method, so there's
> no point in copying txattrs into it, because the caller by definition
> already had them. At the point where the IOMMU notices a guest
> changed the config, it doesn't have an IOMMUTLBEntry or a set of
> tx attrs.
> 
>>> (3) when the IOMMU calls the notifier because the guest config
>>> changed it doesn't have tx attributes, so it would have to
>>> fabricate some; and the guest config will invalidate transactions
>>> with some combinations of tx attributes and not others.
>>
>> IMHO it doesn't directly matter with what we are discussing now.  That
>> IOMMU_NOTIFIER_[UN]MAP flag tells what kind of message would the
>> notifier be interested in from "what kind of mapping it is".  IMHO
>> it's not really related to some other attributes when translation
>> happens - in our case, it does not directly related to what txattrs
>> value is.  Here as mentioned at [1] above IMHO we can still check this
>> against txattrs in the notifier handler, then we ignore messages that
>> we don't care about.  Actually the IOMMU_NOTIFIER_[UN]MAP flags can be
>> removed and we can just do similar things (e.g., we can skip MAP
>> messages if we only care about UNMAP messages), but since it's a
>> general concept and easy to be generalized, so we provided these
>> MAP/UNMAP flags to ease the notifier hooks.
>>
>> In other words, I think we can also add more flags for SECURE or not.
>> However I still don't see a reason (from above three points) on why we
>> can't pass in txattrs directly into translate(), and at the same time
>> we copy the txattrs into IOTLB so that IOMMUTLBEntry can contain some
>> context information. [2]
> 
> I'm afraid I really don't understand the design you're proposing
> here. But overall I think the point of divergence is that
> the mapping from "transaction attributes" to "translation contexts"
> (ie, effectively different page tables) is not 1:1. So for instance:
> 
> Our current IOMMUs which don't care about txattrs:
> 
>   [any txattr at all] -> the one and only translation context
> 
> An IOMMU which cares about attrs.secure, and also treats
> attrs.unspecified like secure:
>   [any txattr with attrs.secure = 1]  \-> 'secure' context'
>   MEMATTRS_UNSPECIFIED                /
> 
>   [txattrs with secure = 1] -> 'nonsecure' context
> 
> An IOMMU which cares about attrs.secure and attrs.user:
>   [secure=1,user=1]   -> 'secure user' context
>   [secure=0,user=1]   -> 'ns user' context
>   [secure=1,user=0]   -> 's priv' context
>   [secure=0,user=0]   -> 'ns priv' context

I fail to understand the PRIV attribute usage in SMMUv3.
My understanding is the STRW (ie. stream world, kind of indication of
the exception level the SID is used along) in the STE is used to
determine the correct TTB*. Isn't PRIV checked against the page table
attributes only?

So would be expose 4 indexes for SMMUv3 or only 2 (S and NS)?

Thanks

Eric
> 
> The IOMMU index captures this idea that there is not a 1:1
> mapping, so we have a way to think about and refer to the
> actual set of translation contexts that the IOMMU has.
> 
>>> As Paolo pointed out you could also implement this by rather
>>> of having an iommu_index concept, instead having some kind
>>> of "here is a mask of which txattrs fields matter, and here's
>>> another parameter with which txattrs fields are affected".
>>> That makes it awkward though to implement "txattrs.unspecified
>>> acts like txattrs.secure == 1" type behaviour, though, which is
>>> easy with an index abstraction layer. It also would be harder
>>> to implement the default 'replay' method, I think.
>>
>> Please refer to my above comment at [2] - I am still confused on why
>> we must use this iommu_idx concept.  How about we just introduce
>> IOMMU_NOTIFIER_SECURE (or something similar) and let TCG code register
>> with that?  Though for the rest of notifiers we'll need to touch up
>> too to make sure all existing notifiers will still receive all the
>> message, no matter whether it's secure or not.
> 
> I think I would definitely prefer not to have the secure/nonsecure
> specific thing in the API. We've got good experience with TCG
> where we abstract away the specifics of what an MMU cares about
> into an mmu_index, and I'd like to keep that approach. Otherwise,
> you immediately get into "and now we need to change the API again
> to handle IOMMUs which care about attrs.user"; and then again
> for attrs.requester_id; and now what about IOMMUs that care
> about both secure and user... Better to have an abstraction so
> that we don't need to keep changing the core code. In particular,
> TCG doesn't know whether it's secure/nonsecure that matters -- that
> is mostly handled by the target-specific parts, and TCG core code
> just passes attributes around.
> 
>> I'd also appreciate if you could paste me the link for Paolo's
>> message, since I cannot find it.
> 
> This is the one I had in mind:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg03522.html
> 
>>> It will only need to do so for IOMMUs that care about that field.
>>>
>>> (See also the other thread with Eric Auger talking about
>>> maybe caring about requester_id like that. Needing to look
>>> at requester_id is an area I haven't thought too much about,
>>> and it is a bit of an odd one because it's a much larger
>>> space than any of the other parts of the txattrs. In some
>>> cases it ought to be possible to say "requester_id lets
>>> us determine an iommu index, and there are a lot fewer
>>> than 2^16 actual iommu indexes because a lot of the requestor_id
>>> values indicate the same actual iommu translation", I suspect.)
>>
>> AFAIK requester_id will only be the same in very rare cases, for
>> example, when multiple PCI devices (no matter whether it's PCI or
>> PCIe) are under the same PCIe-to-PCI bridge, then all these devices
>> will use the bridge's requester ID as their own.  In most cases, each
>> PCIe device will have their own unique requester ID.  So it'll be
>> common that requester ID number can be at least equal to the number of
>> devices.
> 
> I haven't looked at this, but my understanding is that at the moment
> we do per-device requester_id by having each PCI device get its own
> IOMMUMemoryRegion mapped into its address space. So we'd only need
> to look at requester_id for the case of devices with multiple
> subfunctions(?), and presumably most devices only have a handful
> of those.
> 
> thanks
> -- PMM
> 
