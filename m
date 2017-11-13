Received: from eggs.gnu.org ([2001:4830:134:3::10]:51746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eEA74-0006D9-8N
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eEA71-0006pA-0r
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:29:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eEA70-0006oa-Lv
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:28:58 -0500
Date: Mon, 13 Nov 2017 16:28:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171113082845.GA10932@xz-mi>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171113055601.GE1014@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, tianyu.lan@intel.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Mon, Nov 13, 2017 at 04:56:01PM +1100, David Gibson wrote:
> On Fri, Nov 03, 2017 at 08:01:52PM +0800, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > AddressSpaceOps is similar to MemoryRegionOps, it's just for address
> > spaces to store arch-specific hooks.
> > 
> > The first hook I would like to introduce is iommu_get(). Return an
> > IOMMUObject behind the AddressSpace.
> > 
> > For systems that have IOMMUs, we will create a special address
> > space per device which is different from system default address
> > space for it (please refer to pci_device_iommu_address_space()).
> > Normally when that happens, there will be one specific IOMMU (or
> > say, translation unit) stands right behind that new address space.
> > 
> > This iommu_get() fetches that guy behind the address space. Here,
> > the guy is defined as IOMMUObject, which includes a notifier_list
> > so far, may extend in future. Along with IOMMUObject, a new iommu
> > notifier mechanism is introduced. It would be used for virt-svm.
> > Also IOMMUObject can further have a IOMMUObjectOps which is similar
> > to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
> > on MemoryRegion.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> 
> Hi, sorry I didn't reply to the earlier postings of this after our
> discussion in China.  I've been sick several times and very busy.
> 
> I still don't feel like there's an adequate explanation of exactly
> what an IOMMUObject represents.   Obviously it can represent more than
> a single translation window - since that's represented by the
> IOMMUMR.  But what exactly do all the MRs - or whatever else - that
> are represented by the IOMMUObject have in common, from a functional
> point of view.
> 
> Even understanding the SVM stuff better than I did, I don't really see
> why an AddressSpace is an obvious unit to have an IOMMUObject
> associated with it.

Here's what I thought about it: IOMMUObject was planned to be the
abstraction of the hardware translation unit, which is a higher level
of the translated address spaces.  Say, for each PCI device, it can
have its own translated address space.  However for multiple PCI
devices, they can be sharing the same translation unit that handles
the translation requests from different devices.  That's the case for
Intel platforms.  We introduced this IOMMUObject because sometimes we
want to do something with that translation unit rather than a specific
device, in which we need a general IOMMU device handle.

IIRC one issue left over during last time's discussion was that there
could be more complicated IOMMU models. E.g., one device's DMA request
can be translated nestedly by two or multiple IOMMUs, and current
proposal cannot really handle that complicated hierachy.  I'm just
thinking whether we can start from a simple model (say, we don't allow
nested IOMMUs, and actually we don't even allow multiple IOMMUs so
far), then we can evolve from that point in the future.

Also, I thought there were something you mentioned that this approach
is not correct for Power systems, but I can't really remember the
details...  Anyways, I think this is not the only approach to solve
the problem, and I believe any new better idea would be greatly
welcomed as well. :)

Thanks,

> 
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
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Peter Xu
