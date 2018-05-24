Received: from eggs.gnu.org ([2001:4830:134:3::10]:42211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLjfW-0004Zz-Te
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLjfV-0006Ar-8b
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:24:10 -0400
Date: Thu, 24 May 2018 14:23:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180524062352.GA12122@xz-mi>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<20180522030333.GB17282@xz-mi>
	<CAFEAcA-iOYhuPfvDv+iD6jBqXMXqN-jfTpSSBub1Zp1i-JcDbQ@mail.gmail.com>
	<20180522110236.GB31932@xz-mi>
	<CAFEAcA9b6dmpj+B=SO2YsB5sXsh=UPjkjN_U0i-uJhiDn20HHw@mail.gmail.com>
	<20180523010636.GC31932@xz-mi>
	<CAFEAcA840qn7Ms9hph9zzZgMbL8C7kN=cs4esGO9kxGXsgBg1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA840qn7Ms9hph9zzZgMbL8C7kN=cs4esGO9kxGXsgBg1A@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

On Wed, May 23, 2018 at 12:47:16PM +0100, Peter Maydell wrote:
> On 23 May 2018 at 02:06, Peter Xu <peterx@redhat.com> wrote:
> > On Tue, May 22, 2018 at 12:11:38PM +0100, Peter Maydell wrote:
> >> On 22 May 2018 at 12:02, Peter Xu <peterx@redhat.com> wrote:
> >> > On Tue, May 22, 2018 at 09:40:44AM +0100, Peter Maydell wrote:
> 
> >> > And if we see current implementation for this (still, I copied code
> >> > from other patch in the series to here to ease discussion):
> >> >
> >> > @@ -498,8 +498,15 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
> >> >      do {
> >> >          hwaddr addr = *xlat;
> >> >          IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
> >> > -        IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, addr, is_write ?
> >> > -                                              IOMMU_WO : IOMMU_RO);
> >> > +        int iommu_idx = 0;
> >> > +        IOMMUTLBEntry iotlb;
> >> > +
> >> > +        if (imrc->attrs_to_index) {
> >> > +            iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
> >> > +        }
> >> > +
> >> > +        iotlb = imrc->translate(iommu_mr, addr, is_write ?
> >> > +                                IOMMU_WO : IOMMU_RO, iommu_idx);
> >> >
> >> > Here what if we pass attrs directly into imrc->translate() and just
> >> > call imrc->attrs_to_index() inside the arch-dependent translate()
> >> > function?  Will that work too?
> >>
> >> You don't always have the attributes at the point where you want
> >> to call translate. (For instance, memory_region_notify_iommu()
> >> doesn't have attributes.)
> >>
> >> I started off with "pass the tx attrs into the translate method",
> >> which is fine for the code flows which are actually doing
> >> memory transactions, but breaks down when you try to incorporate
> >> notifiers.
> >
> > Could you elaborate a bit more on why IOMMU notifier failed to
> > corporate when passing in MemTxAttrs?  I am not sure I caught the idea
> > here, but can we copy the MemTxAttrs into IOMMUTLBEntry when
> > translating, then in IOMMU notifiers we can know the attrs (if that is
> > what MPC wants)?
> 
> (1) The notifier API lets you register a notifier before you've
> called the translate API

Yes.

> (2) An IOMMUTLBEntry can be valid for more than just the txattrs
> that it was passed in (for instance, if an IOMMU doesn't care
> about txattrs at all, then the resulting TLB entry is valid for
> any txattrs; or if the IOMMU only cares about attrs.secure the
> resulting TLB entries are valid for both attrs.user=0 and
> attrs.user=1).

[1]

Yes exactly, that's why I thought copying the txattrs into IOTLB
should work.

> (3) when the IOMMU calls the notifier because the guest config
> changed it doesn't have tx attributes, so it would have to
> fabricate some; and the guest config will invalidate transactions
> with some combinations of tx attributes and not others.

IMHO it doesn't directly matter with what we are discussing now.  That
IOMMU_NOTIFIER_[UN]MAP flag tells what kind of message would the
notifier be interested in from "what kind of mapping it is".  IMHO
it's not really related to some other attributes when translation
happens - in our case, it does not directly related to what txattrs
value is.  Here as mentioned at [1] above IMHO we can still check this
against txattrs in the notifier handler, then we ignore messages that
we don't care about.  Actually the IOMMU_NOTIFIER_[UN]MAP flags can be
removed and we can just do similar things (e.g., we can skip MAP
messages if we only care about UNMAP messages), but since it's a
general concept and easy to be generalized, so we provided these
MAP/UNMAP flags to ease the notifier hooks.

In other words, I think we can also add more flags for SECURE or not.
However I still don't see a reason (from above three points) on why we
can't pass in txattrs directly into translate(), and at the same time
we copy the txattrs into IOTLB so that IOMMUTLBEntry can contain some
context information. [2]

> 
> As Paolo pointed out you could also implement this by rather
> of having an iommu_index concept, instead having some kind
> of "here is a mask of which txattrs fields matter, and here's
> another parameter with which txattrs fields are affected".
> That makes it awkward though to implement "txattrs.unspecified
> acts like txattrs.secure == 1" type behaviour, though, which is
> easy with an index abstraction layer. It also would be harder
> to implement the default 'replay' method, I think.

Please refer to my above comment at [2] - I am still confused on why
we must use this iommu_idx concept.  How about we just introduce
IOMMU_NOTIFIER_SECURE (or something similar) and let TCG code register
with that?  Though for the rest of notifiers we'll need to touch up
too to make sure all existing notifiers will still receive all the
message, no matter whether it's secure or not.

I'd also appreciate if you could paste me the link for Paolo's
message, since I cannot find it.

> 
> Plus I think that handling this the same way TCG does is a
> reasonable approach -- we know that it's a usefully flexible
> concept.
> 
> >> > I had a quick glance at the series, I have no thorough idea on the
> >> > whole stuff, but I'd say some of the patches are exactly what I wanted
> >> > if to support MemTxAttrs in VT-d emulation one day (now DMAR of VT-d
> >> > is bypassing MemTxAttrs and IMHO that's incorrect).  If we can somehow
> >> > pass in the MemTxAttrs then that'll be perfect and I can continue to
> >> > work on that.  If we pass in iommu_idx now instead, it would take some
> >> > time for me to figure out how to further achieve the same goal for
> >> > VT-d in the future, e.g., I would still want to pass in MemTxAttrs,
> >> > but that's obviously duplicated with iommu_idx.
> >>
> >> The idea is that you should never need to pass in the MemTxAttrs,
> >> because everything that the IOMMU might care about in the tx attrs
> >> must be encoded into the iommu index. (The point where the IOMMU
> >> gets to do that encoding is in its attrs_to_index() method.)
> >
> > For the DMAR issue I would care about MemTxAttrs.requester_id.  Just
> > to confirm - do you mean I encode the 16bits field into iommu_idx too,
> > or is there any smarter way to do so?  Asked since otherwise iommu_idx
> > will gradually grow into another MemTxAttrs to me.
> 
> It will only need to do so for IOMMUs that care about that field.
> 
> (See also the other thread with Eric Auger talking about
> maybe caring about requester_id like that. Needing to look
> at requester_id is an area I haven't thought too much about,
> and it is a bit of an odd one because it's a much larger
> space than any of the other parts of the txattrs. In some
> cases it ought to be possible to say "requester_id lets
> us determine an iommu index, and there are a lot fewer
> than 2^16 actual iommu indexes because a lot of the requestor_id
> values indicate the same actual iommu translation", I suspect.)

AFAIK requester_id will only be the same in very rare cases, for
example, when multiple PCI devices (no matter whether it's PCI or
PCIe) are under the same PCIe-to-PCI bridge, then all these devices
will use the bridge's requester ID as their own.  In most cases, each
PCIe device will have their own unique requester ID.  So it'll be
common that requester ID number can be at least equal to the number of
devices.

Thanks,

-- 
Peter Xu
