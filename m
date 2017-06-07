Received: from eggs.gnu.org ([2001:4830:134:3::10]:39929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIWL1-0008KX-DX
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIWKx-0007Ad-D3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:29:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIWKx-0007AX-3t
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:29:07 -0400
Date: Wed, 7 Jun 2017 16:28:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170607082846.GA3847@pxdev.xzpeter.org>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-9-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C25743908AF7E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743908AF7E@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 8/8] iommu: introduce hw/core/iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

On Wed, Jun 07, 2017 at 07:51:55AM +0000, Liu, Yi L wrote:
> Hi Peter,
> 
> Some updates on it.
> 
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Thursday, April 27, 2017 5:34 PM
> > To: qemu-devel@nongnu.org
> > Cc: Lan, Tianyu <tianyu.lan@intel.com>; Paolo Bonzini <pbonzini@redhat.com>;
> > Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>;
> > peterx@redhat.com; Jason Wang <jasowang@redhat.com>; David Gibson
> > <david@gibson.dropbear.id.au>; Alex Williamson <alex.williamson@redhat.com>
> > Subject: [RFC PATCH 8/8] iommu: introduce hw/core/iommu
> > 
> > Time to consider a common stuff for IOMMU. Let's start from an common IOMMU
> > object (which should be inlayed in custom IOMMU implementations) and a notifier
> > mechanism.
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
> 
> [...]
> 
> > +#include "qemu/osdep.h"
> > +#include "hw/core/iommu.h"
> > +
> > +IOMMUNotifier *iommu_notifier_register(IOMMUObject *iommu,
> > +                                       IOMMUNotifyFn fn,
> > +                                       uint64_t event_mask) {
> > +    IOMMUNotifier *notifier = g_new0(IOMMUNotifier, 1);
> 
> For this part, I think may need to consider to alloc the memory in a
> similar way with IOMMUMRNotifier. The notifier surely needs to
> be connect with vfio container so that it could manipulate
> pIOMMU through vfio IOCTL.

Hmm yes. Or we can add one more parameter for it?

IOMMUNotifier *iommu_notifier_register(IOMMUObject *iommu,
                                       IOMMUNotifyFn fn,
                                       void *private,
                                       uint64_t event_mask);

Both works imho.

> 
> I'm thinking of adding a new struct VFIOGuestIOMMUObject which
> is similar to strcut VFIOGuestIOMMU. And have the original struct
> VFIOGuestIOMMU modified to be VFIOGuestIOMMUMR.
> 
> Then there would be following definition in
> "include\hw\vfio\vfio-common.h":
> 
> typedef struct VFIOGuestIOMMUObject {
>     VFIOContainer *container;
>     IOMMUObject *iommu;
>     IOMMUNotifier n; // n is for non-MemoryRegion related events, e.g. pasid table binding
>     QLIST_ENTRY(VFIOGuestIOMMUObject) giommu_next;
> } VFIOGuestIOMMUObject;
> 
> typedef struct VFIOGuestIOMMUMR {
>     VFIOContainer *container;
>     MemoryRegion *iommu;
>     hwaddr iommu_offset;
>     IOMMUNotifier n;
>     QLIST_ENTRY(VFIOGuestIOMMUMR) giommu_next;
> } VFIOGuestIOMMUMR;
> 
> How about your opinion?

Currently this series "blocks" at the assumption that "for each
address space we have one IOMMU backend". If you see this series, it
did not do too much thing: it tried to get the IOMMU object for a
device, then it added a notifier for it. David proposed possible model
that is against this, say, is it possible that there are more than one
IOMMUs behind one device? So before we move on to "how VFIO will
tackle with this interface", we may need to first settle down on how
we can provide such a IOMMU-oriented notifier that no one dislike.

IMHO this series may still be okay before we move on to more
complicated IOMMU models, however I cannot really persuade David since
my reasoning is not strong enough. :-)

Maybe you can think out something better so that everyone will like?
Any thoughts?

(I think I'll move my "investigate system IOMMU hierachy" TODO item
 with higher priority - imho we need to know exactly all the scenarios
 of IOMMU usage, like nested IOMMU? parallel IOMMU to separate
 translation window? etc. only after that could we finally provide a
 general and good vIOMMU framework for QEMU, then the notifier thing
 should be far easier)

Thanks,

-- 
Peter Xu
