Received: from eggs.gnu.org ([2001:4830:134:3::10]:46449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d43EF-0001zb-PM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d43EA-0005Y4-Tv
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d43EA-0005X3-LK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:34:18 -0400
Date: Fri, 28 Apr 2017 18:34:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170428103400.GE22801@pxdev.xzpeter.org>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-9-git-send-email-peterx@redhat.com>
	<20170428100158.GE15484@sky-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170428100158.GE15484@sky-dev>
Subject: Re: [Qemu-devel] [RFC PATCH 8/8] iommu: introduce hw/core/iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Apr 28, 2017 at 06:01:58PM +0800, Liu, Yi L wrote:
> On Thu, Apr 27, 2017 at 05:34:20PM +0800, Peter Xu wrote:
> > Time to consider a common stuff for IOMMU. Let's start from an common
> > IOMMU object (which should be inlayed in custom IOMMU implementations)
> > and a notifier mechanism.
> > 
> > Let VT-d IOMMU be the first user.
> > 
> > An example to use this per-iommu notifier:
> > 
> >   (when registering)
> >   iommu = address_space_iommu_get(pci_device_iommu_address_space(dev));
> >   notifier = iommu_notifier_register(iommu, IOMMU_EVENT_SVM_PASID, func);
> >   ...
> >   (when notify)
> >   IOMMUEvent event = { .type = IOMMU_EVENT_SVM_PASID ... };
> >   iommu_notify(iommu, &event);
> >   ...
> >   (when releasing)
> >   iommu_notifier_unregister(notifier);
> >   notifier = NULL;
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/core/Makefile.objs         |  1 +
> >  hw/core/iommu.c               | 61 ++++++++++++++++++++++++++++++++++++
> >  hw/i386/intel_iommu.c         |  2 +-
> >  include/exec/memory.h         | 10 +-----
> >  include/hw/core/iommu.h       | 72 +++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/i386/intel_iommu.h |  2 ++
> >  6 files changed, 138 insertions(+), 10 deletions(-)
> >  create mode 100644 hw/core/iommu.c
> >  create mode 100644 include/hw/core/iommu.h
> > 
> > diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> > index 91450b2..85cca44 100644
> > --- a/hw/core/Makefile.objs
> > +++ b/hw/core/Makefile.objs
> > @@ -5,6 +5,7 @@ common-obj-y += fw-path-provider.o
> >  # irq.o needed for qdev GPIO handling:
> >  common-obj-y += irq.o
> >  common-obj-y += hotplug.o
> > +common-obj-y += iommu.o
> >  obj-y += nmi.o
> >  
> >  common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
> > diff --git a/hw/core/iommu.c b/hw/core/iommu.c
> > new file mode 100644
> > index 0000000..e014e96
> > --- /dev/null
> > +++ b/hw/core/iommu.c
> > @@ -0,0 +1,61 @@
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
> > +IOMMUNotifier *iommu_notifier_register(IOMMUObject *iommu,
> > +                                       IOMMUNotifyFn fn,
> > +                                       uint64_t event_mask)
> > +{
> > +    IOMMUNotifier *notifier = g_new0(IOMMUNotifier, 1);
> > +
> > +    assert((event_mask & ~IOMMU_EVENT_MASK) == 0);
> > +    notifier->event_mask = event_mask;
> > +    notifier->iommu_notify = fn;
> > +    QLIST_INSERT_HEAD(&iommu->iommu_notifiers, notifier, node);
> > +
> > +    return notifier;
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
> > +void iommu_notify(IOMMUObject *iommu, IOMMUEvent *event)
> > +{
> > +    IOMMUNotifier *cur;
> > +
> > +    QLIST_FOREACH(cur, &iommu->iommu_notifiers, node) {
> > +        if (cur->event_mask & event->type && cur->iommu_notify) {
> > +            cur->iommu_notify(cur, event);
> > +        }
> > +    }
> > +}
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 5131329..d6f6701 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2635,7 +2635,7 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
> >  static IOMMUObject *vtd_as_iommu_get(AddressSpace *as)
> >  {
> >      VTDAddressSpace *vtd_dev_as = container_of(as, VTDAddressSpace, as);
> > -    return (IOMMUObject *)vtd_dev_as->iommu_state;
> > +    return &vtd_dev_as->iommu_state->iommu_common;
> >  }
> >  
> >  VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 0b0b58b..5ca1dd0 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -27,6 +27,7 @@
> >  #include "qemu/notify.h"
> >  #include "qom/object.h"
> >  #include "qemu/rcu.h"
> > +#include "hw/core/iommu.h"
> >  
> >  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
> >  
> > @@ -183,15 +184,6 @@ struct MemoryRegionOps {
> >      const MemoryRegionMmio old_mmio;
> >  };
> >  
> > -/*
> > - * This stands for an IOMMU unit. Normally it should be exactly the
> > - * IOMMU device, however this can also be actually anything which is
> > - * related to that translation unit. What it is should be totally
> > - * arch-dependent. Maybe one day we can have something better than a
> > - * (void *) here.
> > - */
> > -typedef void *IOMMUObject;
> > -
> >  typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
> >  
> >  struct MemoryRegionIOMMUOps {
> > diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> > new file mode 100644
> > index 0000000..16e6adf
> > --- /dev/null
> > +++ b/include/hw/core/iommu.h
> > @@ -0,0 +1,72 @@
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
> > +#ifndef __PCI_IOMMU_H__
> > +#define __PCI_IOMMU_H__
> > +
> > +#include "qemu/queue.h"
> > +
> > +#define IOMMU_EVENT_SVM_PASID      (0)

Oh here it should be (1 << 0) really.

> > +#define IOMMU_EVENT_MASK           (IOMMU_EVENT_SVM_PASID)
> 
> Peter,
> 
> would it better to define it just like the IOTLB notifier flag?

Actually if we would allow registering to several events for a single
notifier, imho it'll be nice to not use enum. Even use enum, we'll
need:

enum {
   FLAG_1 = 1,
   FLAG_2 = 2,
   FLAG_3 = 4,
   FLAG_4 = 8,
}

So we'll still need to setup these flags one by one - since that'll be
bitmask, not really what enum is doing naturally.

> 
> > +struct IOMMUEvent {
> > +    uint64_t type;
> > +    union {
> > +        struct {
> > +            /* TODO: fill in correct stuff. */
> > +            int value;
> > +        } svm;
> > +    } data;
> > +};
> > +typedef struct IOMMUEvent IOMMUEvent;
> > +
> > +typedef struct IOMMUNotifier IOMMUNotifier;
> > +
> > +typedef void (*IOMMUNotifyFn)(IOMMUNotifier *notifier, IOMMUEvent *event);
> 
> Regards to the IOMMUEvent definition, would it be helpful to use void*?
> virt-SVM may have two notifiers. They will have different data to pass
> in the notifier.

Hmm, I think that's why I used union in IOMMUEvent definition. You can
just extend it with:

struct IOMMUEvent {
    uint64_t type;
    union {
        struct {
            /* TODO: fill in correct stuff. */
            int value;
        } svm;
        struct {
            int value_2;
        } svm_2
    } data;
};

I would avoid using void * if possible, to have more type checks.

Thanks,

-- 
Peter Xu
