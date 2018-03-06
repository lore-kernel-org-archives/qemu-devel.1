Received: from eggs.gnu.org ([2001:4830:134:3::10]:49241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1et8ak-0001eY-Sx
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1et8af-0008KK-VU
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:09:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1et8af-000872-Df
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:08:57 -0500
Date: Tue, 6 Mar 2018 16:51:44 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180306085144.GA3158@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-4-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519900415-30314-4-git-send-email-yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/12] hw/core: introduce
 IOMMUSVAContext for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On Mon, Mar 05, 2018 at 02:25:09PM +1100, David Gibson wrote:
> On Thu, Mar 01, 2018 at 06:31:53PM +0800, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > This patch adds IOMMUSVAContext as an abstract for virt-SVA in
> > Qemu.
> >
> > IOMMUSVAContext is per-PASID(Process Address Space Identity).
> > A PASID Tagged AddressSpace should have an IOMMUSVAContext
> > created for it. virt-SVA emulation for emulated SVA capable
> > devices would use IOMMUSVAContext. And for assigned devices,
> > Qemu also needs to propagate guest tlb flush to host through
> > the sva_notifer based on IOMMUSVAContext.
> >
> > This patch proposes to include a sva_notifier list and
> > an IOMMUSVAContextOps in IOMMUSVAContext.
> >
> > * The sva_notifier list would include tlb invalidate nofitifer
> >   to propagate guest's iotlb flush to host.
> > * The first callback in IOMMUSVAContextOps would be an address
> >   translation callback. For the SVA aware DMAs issued by emulated
> >   SVA capable devices, it requires Qemu to emulate data read/write
> >   to guest process address space. Qemu needs to do address translation
> >   with guest process page table. So the IOMMUSVAContextOps.translate()
> >   callback would be helpful for emulating SVA capable devices.
> >
> > Note: to fulfill the IOMMUSVAContext based address translation
> > framework, may duplicate quite a few existing MemoryRegion based
> > translation code in Qemu. As this patchset is mainly to support
> > assigned SVA capable devices. So this patchset hasn't done the
> > duplication. In future, if any requirement for emulating SVA
> > capable device, it would require a separate patchset to fulfill
> > the translation framework.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  hw/core/Makefile.objs   |   1 +
> >  hw/core/pasid.c         |  64 ++++++++++++++++++++++++++++
> >  include/hw/core/pasid.h | 110 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 175 insertions(+)
> >  create mode 100644 hw/core/pasid.c
> >  create mode 100644 include/hw/core/pasid.h
>
> [snip]
> > +
> > +#ifndef HW_PCI_PASID_H
> > +#define HW_PCI_PASID_H
> > +
 > > +#include "qemu/queue.h"
> > +#ifndef CONFIG_USER_ONLY
> > +#include "exec/hwaddr.h"
> > +#endif
> > +
> > +typedef struct IOMMUSVAContext IOMMUSVAContext;
> > +
> > +enum IOMMUSVAEvent {
> > +    IOMMU_SVA_EVENT_TLB_INV,
> > +};
> > +typedef enum IOMMUSVAEvent IOMMUSVAEvent;
> > +
> > +struct IOMMUSVAEventData {
> > +    IOMMUSVAEvent event;
> > +    uint64_t length;
> > +    void *data;
> > +};
> > +typedef struct IOMMUSVAEventData IOMMUSVAEventData;
> > +
> > +typedef struct IOMMUSVANotifier IOMMUSVANotifier;
> > +
> > +typedef void (*IOMMUSVANotifyFn)(IOMMUSVANotifier *notifier,
> > +                                 IOMMUSVAEventData *event_data);
> > +
> > +typedef struct IOMMUSVATLBEntry IOMMUSVATLBEntry;
> > +
> > +/* See address_space_translate: bit 0 is read, bit 1 is write.  */
> > +typedef enum {
> > +    IOMMU_SVA_NONE = 0,
> > +    IOMMU_SVA_RO   = 1,
> > +    IOMMU_SVA_WO   = 2,
> > +    IOMMU_SVA_RW   = 3,
> > +} IOMMUSVAAccessFlags;
> > +
> > +#define IOMMU_SVA_ACCESS_FLAG(r, w) (((r) ? IOMMU_SVA_RO : 0) | \
> > +                                     ((w) ? IOMMU_SVA_WO : 0))
> > +
> > +struct IOMMUSVATLBEntry {
> > +    AddressSpace    *target_as;
> > +    hwaddr           va;
> > +    hwaddr           translated_addr;
> > +    hwaddr           addr_mask;  /* 0xfff = 4k translation */
> > +    IOMMUSVAAccessFlags perm;
> > +};
> > +
> > +typedef struct IOMMUSVAContextOps IOMMUSVAContextOps;
> > +struct IOMMUSVAContextOps {
> > +    /* Return a TLB entry that contains a given address. */
> > +    IOMMUSVATLBEntry (*translate)(IOMMUSVAContext *sva_ctx,
> > +                                  hwaddr addr, bool is_write);
> > +};
>
> A lot of the above seems to just duplicate stuff from IOMMU MRs and
> it's not clear why we need both.

yes, this is for the potential SVA aware DMA emulation. And this
is similar to IOMMU MRs. Only difference is the translation for PASID
tagged address space is based on IOMMUSVAContext. As why we need both,
it is due to not proper to mix SVA notifier with MAP/UNMAP notifier
in a chain.

> > +struct IOMMUSVANotifier {
> > +    IOMMUSVANotifyFn sva_notify;
> > +    /*
> > +     * What events we are listening to. Let's allow multiple event
> > +     * registrations from beginning.
> > +     */
> > +    IOMMUSVAEvent event;
> > +    QLIST_ENTRY(IOMMUSVANotifier) node;
> > +};
> > +
> > +/*
> > + * This stands for an IOMMU unit. Any translation device should have
> > + * this struct inside its own structure to make sure it can leverage
> > + * common IOMMU functionalities.
> > + */
> > +struct IOMMUSVAContext {
> > +    uint32_t pasid;
> > +    QLIST_HEAD(, IOMMUSVANotifier) sva_notifiers;
> > +    const IOMMUSVAContextOps *sva_ctx_ops;
> > +};
>
> I think the problem is here.  The SVAContext represents a *single*
> PASID, and once you have a single PASID the resulting object *is*
> functionally equivalent to an AddressSpace (though effectively
> required to have nothing but a single IOMMUMR within it).

I also evaluated reusing IOMMU MR. If reuse IOMMU MR, then the SVA notifiers
would be in the same list which MAP/UNMAP notifier locates. This may break
some existing logic. e.g. each time the registration of MR notifier would
result in flag changed, and some vIOMMU emulator logic relies on it. Also,
the replay logic in intel_iommu emulator also relies on the MAP/UNMAP
notifier, if new notifier added in the list, it may be a confusion. So
I didn't go with reusing IOMMU MR. But any better idea would be welcomed.

> It also seems to me unlikely that different PASIDs for the same device
> / IOMMU domain will have truly different sva_ctx_ops.

yes, sva_ctx_ops should be the same for different PASIDs. So far, translate
callback is the only candidate.

> It really seems to me the object you actually want is a level up from
> that, representing the whole cluster of address spaces indexed by
> PASID.  They would have the same operations for all PASIDs in the
> cluster, but those would take the pasid number.

yes, that's also my thought. Here IOMMUSVAContext is supposed to be
per-PASID. But the sva_ctx_ops pointer is actually shared by all
IOMMUSVAContext instances. For the sva_notifiers list, I think it should
be per-PASID since some address spaces indexed by PASID doesn't require
SVA notifier. e.g. the one binded to an emulated SVA capable device. But
the notifier functions are also shared by all IOMMUSVAContext instances.

In this series, IOMMUSVAContext co-exists with an AddressSpace within a
super structure(VTDPASIDAddressSpace in patch 11 of this series).

Thanks,
Yi Liu
