Received: from eggs.gnu.org ([2001:4830:134:3::10]:44910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJFkO-0000Md-Gv
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJFkL-0008To-Ss
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:02:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJFkL-0008TQ-FH
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:02:53 -0400
Date: Thu, 17 May 2018 18:02:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180517100247.GB26089@xz-mi>
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-3-peterx@redhat.com>
	<17437758-3b51-72c7-81ba-cb0df0a22c1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17437758-3b51-72c7-81ba-cb0df0a22c1c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/10] intel-iommu: remove
 IntelIOMMUNotifierNode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Thu, May 17, 2018 at 11:46:22AM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 05/04/2018 05:08 AM, Peter Xu wrote:
> > That is not really necessary.  Removing that node struct and put the
> > list entry directly into VTDAddressSpace.  It simplfies the code a lot.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/hw/i386/intel_iommu.h |  9 ++------
> >  hw/i386/intel_iommu.c         | 41 ++++++++++-------------------------
> >  2 files changed, 14 insertions(+), 36 deletions(-)
> > 
> > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > index 45ec8919b6..220697253f 100644
> > --- a/include/hw/i386/intel_iommu.h
> > +++ b/include/hw/i386/intel_iommu.h
> > @@ -67,7 +67,6 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
> >  typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
> >  typedef struct VTDIrq VTDIrq;
> >  typedef struct VTD_MSIMessage VTD_MSIMessage;
> > -typedef struct IntelIOMMUNotifierNode IntelIOMMUNotifierNode;
> >  
> >  /* Context-Entry */
> >  struct VTDContextEntry {
> > @@ -93,6 +92,7 @@ struct VTDAddressSpace {
> >      MemoryRegion iommu_ir;      /* Interrupt region: 0xfeeXXXXX */
> >      IntelIOMMUState *iommu_state;
> >      VTDContextCacheEntry context_cache_entry;
> > +    QLIST_ENTRY(VTDAddressSpace) next;
> >  };
> >  
> >  struct VTDBus {
> > @@ -253,11 +253,6 @@ struct VTD_MSIMessage {
> >  /* When IR is enabled, all MSI/MSI-X data bits should be zero */
> >  #define VTD_IR_MSI_DATA          (0)
> >  
> > -struct IntelIOMMUNotifierNode {
> > -    VTDAddressSpace *vtd_as;
> > -    QLIST_ENTRY(IntelIOMMUNotifierNode) next;
> > -};
> > -
> >  /* The iommu (DMAR) device state struct */
> >  struct IntelIOMMUState {
> >      X86IOMMUState x86_iommu;
> > @@ -295,7 +290,7 @@ struct IntelIOMMUState {
> >      GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
> >      VTDBus *vtd_as_by_bus_num[VTD_PCI_BUS_MAX]; /* VTDBus objects indexed by bus number */
> >      /* list of registered notifiers */
> > -    QLIST_HEAD(, IntelIOMMUNotifierNode) notifiers_list;
> > +    QLIST_HEAD(, VTDAddressSpace) notifiers_list;
> Wouldn't it make sense to rename notifiers_list into something more
> understandable like address_spaces?

But address_spaces might be a bit confusing too on the other side as
"a list of all VT-d address spaces".  How about something like:

     address_spaces_with_notifiers

?

[...]

> > -    /* update notifier node with new flags */
> > -    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
> > -        if (node->vtd_as == vtd_as) {
> > -            if (new == IOMMU_NOTIFIER_NONE) {
> > -                QLIST_REMOVE(node, next);
> > -                g_free(node);
> > -            }
> > -            return;
> > -        }
> > +        /* Insert new ones */
> s/ones/one
> 
> > +        QLIST_INSERT_HEAD(&s->notifiers_list, vtd_as, next);
> > +    } else if (new == IOMMU_NOTIFIER_NONE) {
> > +        /* Remove old ones */
> same. Not sure the comments are worth.

Will remove two "s"s there.  Thanks,

-- 
Peter Xu
