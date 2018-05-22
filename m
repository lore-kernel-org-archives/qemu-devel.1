Received: from eggs.gnu.org ([2001:4830:134:3::10]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fL54G-0006kh-Ny
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fL54B-0006Bg-QN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:03:00 -0400
Date: Tue, 22 May 2018 19:02:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180522110236.GB31932@xz-mi>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<20180522030333.GB17282@xz-mi>
	<CAFEAcA-iOYhuPfvDv+iD6jBqXMXqN-jfTpSSBub1Zp1i-JcDbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-iOYhuPfvDv+iD6jBqXMXqN-jfTpSSBub1Zp1i-JcDbQ@mail.gmail.com>
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

On Tue, May 22, 2018 at 09:40:44AM +0100, Peter Maydell wrote:
> On 22 May 2018 at 04:03, Peter Xu <peterx@redhat.com> wrote:
> > On Mon, May 21, 2018 at 03:03:49PM +0100, Peter Maydell wrote:
> >> If an IOMMU supports mappings that care about the memory
> >> transaction attributes, then it no longer has a unique
> >> address -> output mapping, but more than one. We can
> >> represent these using an IOMMU index, analogous to TCG's
> >> mmu indexes.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >>  include/exec/memory.h | 52 +++++++++++++++++++++++++++++++++++++++++++
> >>  memory.c              | 23 +++++++++++++++++++
> >>  2 files changed, 75 insertions(+)
> >>
> >> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >> index 309fdfb89b..f6226fb263 100644
> >> --- a/include/exec/memory.h
> >> +++ b/include/exec/memory.h
> >> @@ -206,6 +206,20 @@ enum IOMMUMemoryRegionAttr {
> >>   * to report whenever mappings are changed, by calling
> >>   * memory_region_notify_iommu() (or, if necessary, by calling
> >>   * memory_region_notify_one() for each registered notifier).
> >> + *
> >> + * Conceptually an IOMMU provides a mapping from input address
> >> + * to an output TLB entry. If the IOMMU is aware of memory transaction
> >> + * attributes and the output TLB entry depends on the transaction
> >> + * attributes, we represent this using IOMMU indexes. Each index
> >
> > Hi, Peter,
> >
> > In what case will an IOMMU translation depend on translation
> > attributes?  It seems to me that we should always pass in the
> > translation attributes into the translate() function.  The translate()
> > function can omit that parameter if the specific IOMMU does not need
> > that information, but still I am confused about why we need to index
> > IOMMU by translation attributes.
> 
> The MPC implementation at the tail end of the patchset is
> one example -- it needs to look at attrs.secure, because
> "translation for secure access to address X" differs from
> that for address Y". The Arm SMMUv3 is the same when it supports
> TrustZone (the implementation in-tree does not), and it can also
> give different permissions for transactions with attrs.user = 0 vs 1.

Thanks for providing more context.

> 
> The reason for not just passing in the transaction attributes to
> translate is that
> (a) the iommu index abstraction makes the notifier setup simpler:
> rather than having to have some indication in the API of which
> of the transaction attributes are important and which the notifier
> cares about, we can just use indexs

Hmm, so here IIUC we'll have a new IOMMU notifier that will only
listen to part of the IOMMU notifies, e.g., when attrs.secure=true.
Yes I think adding something into IOMMUNotifier might work, but just
to mention that in IOMMUTLBEntry we have IOMMUTLBEntry.target_as
defined.  Until now it's hardly used at least on x86 platform since
all of the translations on x86 are targeted to the system RAM.
However it seems to be quite tailored in this case since it seems to
me that different attrs.secure value for translations should be based
on different address spaces too.  Then in the IOMMU notifiers that
would care about MemTxAttrs, could it be possible to identify that by
check against the IOMMUTLBEntry.target_as?

> (b) it means that it's harder to write an iommu with the bug that
> it looks at parts of the transaction attributes that it didn't
> claim were important in the notifier API

It is just confusing to me when I looked at current translate()
interface (I copied it from some other patch of the series):

@@ -252,9 +252,10 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      * @hwaddr: address to be translated within the memory region
      * @flag: requested access permissions
+     * @iommu_idx: IOMMU index for the translation
      */
     IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
-                               IOMMUAccessFlags flag);
+                               IOMMUAccessFlags flag, int iommu_idx);

The "iommu_idx" parameter is really hard to understand here at the
first glance.  Now I think I understand that it is somehow related to
the MemTxAttrs, but still it will take time to understand.

And if we see current implementation for this (still, I copied code
from other patch in the series to here to ease discussion):

@@ -498,8 +498,15 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
     do {
         hwaddr addr = *xlat;
         IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
-        IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, addr, is_write ?
-                                              IOMMU_WO : IOMMU_RO);
+        int iommu_idx = 0;
+        IOMMUTLBEntry iotlb;
+
+        if (imrc->attrs_to_index) {
+            iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
+        }
+
+        iotlb = imrc->translate(iommu_mr, addr, is_write ?
+                                IOMMU_WO : IOMMU_RO, iommu_idx);

Here what if we pass attrs directly into imrc->translate() and just
call imrc->attrs_to_index() inside the arch-dependent translate()
function?  Will that work too?

I had a quick glance at the series, I have no thorough idea on the
whole stuff, but I'd say some of the patches are exactly what I wanted
if to support MemTxAttrs in VT-d emulation one day (now DMAR of VT-d
is bypassing MemTxAttrs and IMHO that's incorrect).  If we can somehow
pass in the MemTxAttrs then that'll be perfect and I can continue to
work on that.  If we pass in iommu_idx now instead, it would take some
time for me to figure out how to further achieve the same goal for
VT-d in the future, e.g., I would still want to pass in MemTxAttrs,
but that's obviously duplicated with iommu_idx.

(Also CCing David and Alex)

Thanks,

-- 
Peter Xu
