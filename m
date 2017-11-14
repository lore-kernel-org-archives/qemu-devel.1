Received: from eggs.gnu.org ([2001:4830:134:3::10]:36354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eEcKs-0003hP-Bo
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eEcKp-0003mu-1Z
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:37:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:1301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eEcKo-0003lV-JD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:37:06 -0500
Date: Tue, 14 Nov 2017 22:20:26 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171114142026.GB3895@sky-dev>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<cddc6820-86d8-4db2-126a-94edd86fbffe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cddc6820-86d8-4db2-126a-94edd86fbffe@redhat.com>
Subject: Re: [Qemu-devel] [RESEND PATCH 2/6] memory: introduce
 AddressSpaceOps and IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, jasowang@redhat.com, peterx@redhat.com

Hi Eric,

On Tue, Nov 14, 2017 at 11:21:59AM +0100, Auger Eric wrote:
> Hi Yi L,
> 
> On 03/11/2017 13:01, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > AddressSpaceOps is similar to MemoryRegionOps, it's just for address
> > spaces to store arch-specific hooks.
> > 
> > The first hook I would like to introduce is iommu_get(). Return an
> > IOMMUObject behind the AddressSpace.
> 
> David had an objection in the past about this method, saying that
> several IOMMUs could translate a single AS?
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01610.html
> 
> On ARM I think it works in general:
> In
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/pci/pci-iommu.txt,
> it is said
> "a given PCI device can only master through one IOMMU"
> > 
> > For systems that have IOMMUs, we will create a special address
> > space per device which is different from system default address
> > space for it (please refer to pci_device_iommu_address_space()).
> > Normally when that happens, there will be one specific IOMMU (or
> > say, translation unit) stands right behind that new address space.
> standing
> > 
> > This iommu_get() fetches that guy behind the address space. Here,
> > the guy is defined as IOMMUObject, which includes a notifier_list
> > so far, may extend in future. Along with IOMMUObject, a new iommu
> > notifier mechanism is introduced. It would be used for virt-svm.
> > Also IOMMUObject can further have a IOMMUObjectOps which is similar
> > to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
> relying
> > on MemoryRegion.
> > 
> I think I would split this patch into a 1 first patch introducing the
> iommu object and a second adding the AS ops and address_space_iommu_get()

Good point.

> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  hw/core/Makefile.objs   |  1 +
> >  hw/core/iommu.c         | 58 +++++++++++++++++++++++++++++++++++++++
> >  include/exec/memory.h   | 22 +++++++++++++++
> >  include/hw/core/iommu.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  memory.c                | 10 +++++--
> >  5 files changed, 162 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/core/iommu.c
> >  create mode 100644 include/hw/core/iommu.h
> > 
> > diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> > index f8d7a4a..d688412 100644
> > --- a/hw/core/Makefile.objs
> > +++ b/hw/core/Makefile.objs
> > @@ -5,6 +5,7 @@ common-obj-y += fw-path-provider.o
> >  # irq.o needed for qdev GPIO handling:
> >  common-obj-y += irq.o
> >  common-obj-y += hotplug.o
> > +common-obj-y += iommu.o
> >  common-obj-y += nmi.o
> >  
> >  common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
> > diff --git a/hw/core/iommu.c b/hw/core/iommu.c
> > new file mode 100644
> > index 0000000..7c4fcfe
> > --- /dev/null
> > +++ b/hw/core/iommu.c
> > @@ -0,0 +1,58 @@
> > +/*
> > + * QEMU emulation of IOMMU logic
> May be rephrased as it does not really explain what the iommu object
> exposes as an API

yes, may need to rephrase to address it clear.

> > + *
> > + * Copyright (C) 2017 Red Hat Inc.
> > + *
> > + * Authors: Peter Xu <peterx@redhat.com>,
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/core/iommu.h"
> 
> > +                             IOMMUNotifier *n)
> > +
> > +void iommu_notifier_register(IOMMUObject *iommu,
> > +                             IOMMUNotifier *n,
> > +                             IOMMUNotifyFn fn,
> > +                             IOMMUEvent event)
> > +{
> > +    n->event = event;
> > +    n->iommu_notify = fn;
> > +    QLIST_INSERT_HEAD(&iommu->iommu_notifiers, n, node);
> > +    return;
> > +}
> > +
> > +void iommu_notifier_unregister(IOMMUObject *iommu,
> > +                               IOMMUNotifier *notifier)
> > +{
> > +    IOMMUNotifier *cur, *next;
> > +
> > +    QLIST_FOREACH_SAFE(cur, &iommu->iommu_notifiers, node, next) {
> > +        if (cur == notifier) {
> > +            QLIST_REMOVE(cur, node);
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data)
> > +{
> > +    IOMMUNotifier *cur;
> > +
> > +    QLIST_FOREACH(cur, &iommu->iommu_notifiers, node) {
> > +        if ((cur->event == event_data->event) && cur->iommu_notify) {
> can cur->iommu_notify be NULL if registered as above?

the cur->event is actually initialized with a event and also a iommu_notify.
So if the cur->event meets the requested event type, then it should be
non-NULL.

> > +            cur->iommu_notify(cur, event_data);
> > +        }
> > +    }
> > +}
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 03595e3..8350973 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -26,6 +26,7 @@
> >  #include "qom/object.h"
> >  #include "qemu/rcu.h"
> >  #include "hw/qdev-core.h"
> > +#include "hw/core/iommu.h"
> >  
> >  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
> >  
> > @@ -301,6 +302,19 @@ struct MemoryListener {
> >  };
> >  
> >  /**
> > + * AddressSpaceOps: callbacks structure for address space specific operations
> > + *
> > + * @iommu_get: returns an IOMMU object that backs the address space.
> > + *             Normally this should be NULL for generic address
> > + *             spaces, and it's only used when there is one
> > + *             translation unit behind this address space.
> > + */
> > +struct AddressSpaceOps {
> > +    IOMMUObject *(*iommu_get)(AddressSpace *as);
> > +};
> > +typedef struct AddressSpaceOps AddressSpaceOps;
> > +
> > +/**
> >   * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
> >   */
> >  struct AddressSpace {
> > @@ -316,6 +330,7 @@ struct AddressSpace {
> >      struct MemoryRegionIoeventfd *ioeventfds;
> >      QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
> >      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> > +    AddressSpaceOps as_ops;
> >  };
> >  
> >  FlatView *address_space_to_flatview(AddressSpace *as);
> > @@ -1988,6 +2003,13 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
> >      address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
> >  }
> >  
> > +/**
> > + * address_space_iommu_get: Get the backend IOMMU for the address space
> > + *
> > + * @as: the address space to fetch IOMMU from
> > + */
> > +IOMMUObject *address_space_iommu_get(AddressSpace *as);
> > +
> >  #endif
> >  
> >  #endif
> > diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> > new file mode 100644
> > index 0000000..34387c0
> > --- /dev/null
> > +++ b/include/hw/core/iommu.h
> > @@ -0,0 +1,73 @@
> > +/*
> > + * QEMU emulation of IOMMU logic
> > + *
> > + * Copyright (C) 2017 Red Hat Inc.
> > + *
> > + * Authors: Peter Xu <peterx@redhat.com>,
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_CORE_IOMMU_H
> > +#define HW_CORE_IOMMU_H
> > +
> > +#include "qemu/queue.h"
> > +
> > +enum IOMMUEvent {
> > +    IOMMU_EVENT_BIND_PASIDT,
> > +};
> > +typedef enum IOMMUEvent IOMMUEvent;
> > +
> > +struct IOMMUEventData {
> > +    IOMMUEvent event;
> /* length and opaque data passed to notifiers */ ?

yes, it is. But the "void *data" would be replaced with well defined structure.
No plan to do it as opaque. Once this patchset is accepted, later patchset
would define it as；

struct IOMMUEventData {
    IOMMUEvent event;
    uint64_t length;
    union {
        struct pasid_table_config pasidt_info;
        struct tlb_invalidate_info tlb_info;
    };
};
typedef struct IOMMUEventData IOMMUEventData;

This is in my further patchset. Currently, we want to show the idea of
introducing this new notifier framework.

> > +    uint64_t length;
> > +    void *data;
> > +};
> > +typedef struct IOMMUEventData IOMMUEventData;
> > +
> > +typedef struct IOMMUNotifier IOMMUNotifier;
> > +
> > +typedef void (*IOMMUNotifyFn)(IOMMUNotifier *notifier,
> > +                              IOMMUEventData *event_data);
> > +
> > +struct IOMMUNotifier {
> > +    IOMMUNotifyFn iommu_notify;
> > +    /*
> > +     * What events we are listening to. Let's allow multiple event
> > +     * registrations from beginning.
> > +     */
> > +    IOMMUEvent event; 
> /* the event the notifier is sensitive to ? */

events(aka. operations) like bind pasid table/flush 1st level tlb. etc.

> > +    QLIST_ENTRY(IOMMUNotifier) node;
> > +};
> > +
> > +typedef struct IOMMUObject IOMMUObject;
> > +
> > +/*
> > + * This stands for an IOMMU unit. Any translation device should have
> > + * this struct inside its own structure to make sure it can leverage
> > + * common IOMMU functionalities.
> > + */
> > +struct IOMMUObject {
> > +    QLIST_HEAD(, IOMMUNotifier) iommu_notifiers;
> where is the QLIST_INIT supposed to be done?

yeah, need to add it accordingly.

Thanks,
Yi L

> Thanks
> 
> Eric
> > +};
> > +
> > +void iommu_notifier_register(IOMMUObject *iommu,
> > +                             IOMMUNotifier *n,
> > +                             IOMMUNotifyFn fn,
> > +                             IOMMUEvent event);
> > +void iommu_notifier_unregister(IOMMUObject *iommu,
> > +                               IOMMUNotifier *notifier);
> > +void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data);
> > +
> > +#endif
> > diff --git a/memory.c b/memory.c
> > index 77fb3ef..307f665 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -235,8 +235,6 @@ struct FlatView {
> >      MemoryRegion *root;
> >  };
> >  
> > -typedef struct AddressSpaceOps AddressSpaceOps;
> > -
> >  #define FOR_EACH_FLAT_RANGE(var, view)          \
> >      for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)
> >  
> > @@ -2793,6 +2791,14 @@ static void do_address_space_destroy(AddressSpace *as)
> >      memory_region_unref(as->root);
> >  }
> >  
> > +IOMMUObject *address_space_iommu_get(AddressSpace *as)
> > +{
> > +    if (!as->as_ops.iommu_get) {
> > +        return NULL;
> > +    }
> > +    return as->as_ops.iommu_get(as);
> > +}
> > +
> >  void address_space_destroy(AddressSpace *as)
> >  {
> >      MemoryRegion *root = as->root;
> > 
> 
