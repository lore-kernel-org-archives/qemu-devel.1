Received: from eggs.gnu.org ([2001:4830:134:3::10]:46026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL5Cz-0003F8-6w
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL5Cx-0001YR-P8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:12:01 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL5Cx-0001YE-IM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:11:59 -0400
Received: by mail-oi0-x242.google.com with SMTP id t27-v6so15806314oij.9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 04:11:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522110236.GB31932@xz-mi>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<20180522030333.GB17282@xz-mi>
	<CAFEAcA-iOYhuPfvDv+iD6jBqXMXqN-jfTpSSBub1Zp1i-JcDbQ@mail.gmail.com>
	<20180522110236.GB31932@xz-mi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 12:11:38 +0100
Message-ID: <CAFEAcA9b6dmpj+B=SO2YsB5sXsh=UPjkjN_U0i-uJhiDn20HHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

On 22 May 2018 at 12:02, Peter Xu <peterx@redhat.com> wrote:
> On Tue, May 22, 2018 at 09:40:44AM +0100, Peter Maydell wrote:
>> On 22 May 2018 at 04:03, Peter Xu <peterx@redhat.com> wrote:
>> The reason for not just passing in the transaction attributes to
>> translate is that
>> (a) the iommu index abstraction makes the notifier setup simpler:
>> rather than having to have some indication in the API of which
>> of the transaction attributes are important and which the notifier
>> cares about, we can just use indexs
>
> Hmm, so here IIUC we'll have a new IOMMU notifier that will only
> listen to part of the IOMMU notifies, e.g., when attrs.secure=true.
> Yes I think adding something into IOMMUNotifier might work, but just
> to mention that in IOMMUTLBEntry we have IOMMUTLBEntry.target_as
> defined.  Until now it's hardly used at least on x86 platform since
> all of the translations on x86 are targeted to the system RAM.
> However it seems to be quite tailored in this case since it seems to
> me that different attrs.secure value for translations should be based
> on different address spaces too.  Then in the IOMMU notifiers that
> would care about MemTxAttrs, could it be possible to identify that by
> check against the IOMMUTLBEntry.target_as?

No, because you can have a single address space that receives
transactions with various attributes. (Again, the MPC is an
example of this.)

>> (b) it means that it's harder to write an iommu with the bug that
>> it looks at parts of the transaction attributes that it didn't
>> claim were important in the notifier API
>
> It is just confusing to me when I looked at current translate()
> interface (I copied it from some other patch of the series):
>
> @@ -252,9 +252,10 @@ typedef struct IOMMUMemoryRegionClass {
>       * @iommu: the IOMMUMemoryRegion
>       * @hwaddr: address to be translated within the memory region
>       * @flag: requested access permissions
> +     * @iommu_idx: IOMMU index for the translation
>       */
>      IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
> -                               IOMMUAccessFlags flag);
> +                               IOMMUAccessFlags flag, int iommu_idx);
>
> The "iommu_idx" parameter is really hard to understand here at the
> first glance.  Now I think I understand that it is somehow related to
> the MemTxAttrs, but still it will take time to understand.

The part of the documentation where I try to explain the general
idea is in this patch, in the comment at the top of the struct:

+ * Conceptually an IOMMU provides a mapping from input address
+ * to an output TLB entry. If the IOMMU is aware of memory transaction
+ * attributes and the output TLB entry depends on the transaction
+ * attributes, we represent this using IOMMU indexes. Each index
+ * selects a particular translation table that the IOMMU has:
+ *   @attrs_to_index returns the IOMMU index for a set of transaction
attributes
+ *   @translate takes an input address and an IOMMU index
+ * and the mapping returned can only depend on the input address and the
+ * IOMMU index.
+ *
+ * Most IOMMUs don't care about the transaction attributes and support
+ * only a single IOMMU index. A more complex IOMMU might have one index
+ * for secure transactions and one for non-secure transactions.

Do you have suggestions for how to improve on this?

> And if we see current implementation for this (still, I copied code
> from other patch in the series to here to ease discussion):
>
> @@ -498,8 +498,15 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
>      do {
>          hwaddr addr = *xlat;
>          IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
> -        IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, addr, is_write ?
> -                                              IOMMU_WO : IOMMU_RO);
> +        int iommu_idx = 0;
> +        IOMMUTLBEntry iotlb;
> +
> +        if (imrc->attrs_to_index) {
> +            iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
> +        }
> +
> +        iotlb = imrc->translate(iommu_mr, addr, is_write ?
> +                                IOMMU_WO : IOMMU_RO, iommu_idx);
>
> Here what if we pass attrs directly into imrc->translate() and just
> call imrc->attrs_to_index() inside the arch-dependent translate()
> function?  Will that work too?

You don't always have the attributes at the point where you want
to call translate. (For instance, memory_region_notify_iommu()
doesn't have attributes.)

I started off with "pass the tx attrs into the translate method",
which is fine for the code flows which are actually doing
memory transactions, but breaks down when you try to incorporate
notifiers.

> I had a quick glance at the series, I have no thorough idea on the
> whole stuff, but I'd say some of the patches are exactly what I wanted
> if to support MemTxAttrs in VT-d emulation one day (now DMAR of VT-d
> is bypassing MemTxAttrs and IMHO that's incorrect).  If we can somehow
> pass in the MemTxAttrs then that'll be perfect and I can continue to
> work on that.  If we pass in iommu_idx now instead, it would take some
> time for me to figure out how to further achieve the same goal for
> VT-d in the future, e.g., I would still want to pass in MemTxAttrs,
> but that's obviously duplicated with iommu_idx.

The idea is that you should never need to pass in the MemTxAttrs,
because everything that the IOMMU might care about in the tx attrs
must be encoded into the iommu index. (The point where the IOMMU
gets to do that encoding is in its attrs_to_index() method.)

thanks
-- PMM
