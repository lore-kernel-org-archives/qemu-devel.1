Received: from eggs.gnu.org ([2001:4830:134:3::10]:33548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eEWyE-0005Ih-56
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eEWyA-0002bg-A5
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1eEWyA-0002b2-0E
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:22 -0500
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box> <20171113095847.GA9527@sky-dev>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
Date: Tue, 14 Nov 2017 09:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171113095847.GA9527@sky-dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com

Hi Yi L,

On 13/11/2017 10:58, Liu, Yi L wrote:
> On Mon, Nov 13, 2017 at 04:56:01PM +1100, David Gibson wrote:
>> On Fri, Nov 03, 2017 at 08:01:52PM +0800, Liu, Yi L wrote:
>>> From: Peter Xu <peterx@redhat.com>
>>>
>>> AddressSpaceOps is similar to MemoryRegionOps, it's just for address
>>> spaces to store arch-specific hooks.
>>>
>>> The first hook I would like to introduce is iommu_get(). Return an
>>> IOMMUObject behind the AddressSpace.
>>>
>>> For systems that have IOMMUs, we will create a special address
>>> space per device which is different from system default address
>>> space for it (please refer to pci_device_iommu_address_space()).
>>> Normally when that happens, there will be one specific IOMMU (or
>>> say, translation unit) stands right behind that new address space.
>>>
>>> This iommu_get() fetches that guy behind the address space. Here,
>>> the guy is defined as IOMMUObject, which includes a notifier_list
>>> so far, may extend in future. Along with IOMMUObject, a new iommu
>>> notifier mechanism is introduced. It would be used for virt-svm.
>>> Also IOMMUObject can further have a IOMMUObjectOps which is similar
>>> to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
>>> on MemoryRegion.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>>
>> Hi, sorry I didn't reply to the earlier postings of this after our
>> discussion in China.  I've been sick several times and very busy.
>=20
> Hi David,
>=20
> Fully understood. I'll try my best to address your question. Also,
> feel free to input further questions, anyhow, the more we discuss the
> better work we done.
>=20
>> I still don't feel like there's an adequate explanation of exactly
>> what an IOMMUObject represents.   Obviously it can represent more than
>=20
> IOMMUObject is aimed to represent the iommu itself. e.g. the iommu
> specific operations. One of the key purpose of IOMMUObject is to
> introduce a notifier framework to let iommu emulator to be able to
> do iommu operations other than MAP/UNMAP. As IOMMU grows more and
> more feature, MAP/UNMAP is not the only operation iommu emulator needs
> to deal. e.g. shared virtual memory. So far, as I know AMD/ARM also
> has it. may correct me on it. As my cover letter mentioned, MR based
> notifier framework doesn=E2=80=99t work for the newly added IOMMU opera=
tions.
> Like bind guest pasid table pointer to host and propagate guest's
> iotlb flush to host.
>=20
>> a single translation window - since that's represented by the
>> IOMMUMR.  But what exactly do all the MRs - or whatever else - that
>> are represented by the IOMMUObject have in common, from a functional
>> point of view.
>=20
> Let me take virt-SVM as an example. As far as I know, for virt-SVM,
> the implementation of different vendors are similar. The key design
> is to have a nested translation(aka. two stage translation). It is to
> have guest maintain gVA->gPA mapping and hypervisor builds gPA->hPA
> mapping. Similar to EPT based virt-MMU solution.
>=20
> In Qemu, gPA->hPA mapping is done through MAP/UNMAP notifier, it can
> keep going. But for gVA->gPA mapping, only guest knows it, so hyperviso=
r
> needs to trap specific guest iommu operation and pass the gVA->gPA
> mapping knowledge to host through a notifier(newly added one). In VT-d,
> it is called bind guest pasid table to host.

What I don't get is the PASID table is per extended context entry. I
understand this latter is indexed by PCI device function. And today MR
are created per PCIe device if I am not wrong. So why can't we have 1
new MR notifier dedicated to PASID table passing? My understanding is
the MR, having a 1-1 correspondence with a PCIe device and thus a
context could be of right granularity. Then I understand the only flags
we currently have are NONE, MAP and UNMAP but couldn't we add a new one
for PASID TABLE passing? So this is not crystal clear to me why MR
notifiers are not adapted to PASID table passing.
>=20
> Also, for the gVA iotlb flushing, only guest knows it. So hypervisor
> needs to propagate it to host. Here, MAP/UNMAP is not suitable since
> this gVA iotlb flush here doesn=E2=80=99t require to modify host iommu
> translation table.
I don't really get this argument. IOMMUNotifier just is a notifier that
is attached to an IOMMU MR and calls a an IOMMUNotify function, right?
Then the role of the function currently is attached to the currently
existing flags, MAP, UNMAP. This is not linked to an action on the
physical IOMMU, right?

 At the time gVA iotlb flush is issued, the gVA->gPA
> mapping has already modified. Host iommu only needs to reference it whe=
n
> performing address translation. But before host iommu perform translati=
on,
> it needs to flush the old gVA cache. In VT-d, it is called 1st level ca=
che
> flushing.

The fact MR notifiers may not be relevant could be linked to the nature
of the tagging of the structures you want to flush. My understanding is
if you want to flush by source-id, MR granularity could be fine. Please
could you clarify why do you need an iommu wide operation in that case.
>=20
> Both of the two notifiers(operations) has no direct relationship with M=
R,
> instead they highly depends on virt-iommu itself.
As described above this is not obvious to me. Please could you clarify
why source-id granularity (which I understand has a 1-1 granularity with
MR/AS is not the correct granularity). Of course, please correct me if
my understanding of MR mapping is not correct.

Thanks

Eric

 If virt-iommu exists,
> then the two notfiers are needed, if not, then it's not.
> =20
>> Even understanding the SVM stuff better than I did, I don't really see
>> why an AddressSpace is an obvious unit to have an IOMMUObject
>> associated with it.
>=20
> This will benefit the notifier registration. As my comments above, the
> IOMMUObject is to represent iommu. Associate an AddressSpace with an
> IOMMUObject makes it easy to check if it is necessary to register the
> notifiers.
 If no IOMMUObject, means no virt-iommu exposed to guest, then
> no need to register notifiers. For this, I also considered to use the
> MemoryRegion.iommu_ops. e.g. for VT-d, it can be a loop to check all th=
e
> subregions and register notfiers if it is an iommu MemoryRegion. Peter
> mentioned it may not work for SPAR. So he proposed associating an
> AddressSpace with an IOMMUObject. I think it wroks and easier, so I
> didn=E2=80=99t object it.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04931.html
>=20
> +    /* Check if vIOMMU exists */
> +    QTAILQ_FOREACH(subregion, &as->root->subregions, subregions_link) =
{
> +        if (memory_region_is_iommu(subregion)) {
> +            IOMMUNotifier n1;
> +
> +            /*
> +             FIXME: current iommu notifier is actually designed for
> +             IOMMUTLB MAP/UNMAP. However, vIOMMU emulator may need
> +             notifiers other than MAP/UNMAP, so it'll be better to
> +             split the non-IOMMUTLB notifier from the current IOMMUTLB
> +             notifier framewrok.
> +             */
> +            iommu_notifier_init(&n1, vfio_iommu_bind_pasid_tbl_notify,
> +                                IOMMU_NOTIFIER_SVM_PASIDT_BIND,
> +                                0,
> +                                0);
> +            vfio_register_notifier(group->container,
> +                                   subregion,
> +                                   0,
> +                                   &n1);
> +        }
> +    }
> +
>=20
> Thanks,
> Yi L
>=20
>>> ---
>>>  hw/core/Makefile.objs   |  1 +
>>>  hw/core/iommu.c         | 58 +++++++++++++++++++++++++++++++++++++++
>>>  include/exec/memory.h   | 22 +++++++++++++++
>>>  include/hw/core/iommu.h | 73 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  memory.c                | 10 +++++--
>>>  5 files changed, 162 insertions(+), 2 deletions(-)
>>>  create mode 100644 hw/core/iommu.c
>>>  create mode 100644 include/hw/core/iommu.h
>>>
>>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>>> index f8d7a4a..d688412 100644
>>> --- a/hw/core/Makefile.objs
>>> +++ b/hw/core/Makefile.objs
>>> @@ -5,6 +5,7 @@ common-obj-y +=3D fw-path-provider.o
>>>  # irq.o needed for qdev GPIO handling:
>>>  common-obj-y +=3D irq.o
>>>  common-obj-y +=3D hotplug.o
>>> +common-obj-y +=3D iommu.o
>>>  common-obj-y +=3D nmi.o
>>> =20
>>>  common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
>>> diff --git a/hw/core/iommu.c b/hw/core/iommu.c
>>> new file mode 100644
>>> index 0000000..7c4fcfe
>>> --- /dev/null
>>> +++ b/hw/core/iommu.c
>>> @@ -0,0 +1,58 @@
>>> +/*
>>> + * QEMU emulation of IOMMU logic
>>> + *
>>> + * Copyright (C) 2017 Red Hat Inc.
>>> + *
>>> + * Authors: Peter Xu <peterx@redhat.com>,
>>> + *
>>> + * This program is free software; you can redistribute it and/or mod=
ify
>>> + * it under the terms of the GNU General Public License as published=
 by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> +
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> +
>>> + * You should have received a copy of the GNU General Public License=
 along
>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/core/iommu.h"
>>> +
>>> +void iommu_notifier_register(IOMMUObject *iommu,
>>> +                             IOMMUNotifier *n,
>>> +                             IOMMUNotifyFn fn,
>>> +                             IOMMUEvent event)
>>> +{
>>> +    n->event =3D event;
>>> +    n->iommu_notify =3D fn;
>>> +    QLIST_INSERT_HEAD(&iommu->iommu_notifiers, n, node);
>>> +    return;
>>> +}
>>> +
>>> +void iommu_notifier_unregister(IOMMUObject *iommu,
>>> +                               IOMMUNotifier *notifier)
>>> +{
>>> +    IOMMUNotifier *cur, *next;
>>> +
>>> +    QLIST_FOREACH_SAFE(cur, &iommu->iommu_notifiers, node, next) {
>>> +        if (cur =3D=3D notifier) {
>>> +            QLIST_REMOVE(cur, node);
>>> +            break;
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data)
>>> +{
>>> +    IOMMUNotifier *cur;
>>> +
>>> +    QLIST_FOREACH(cur, &iommu->iommu_notifiers, node) {
>>> +        if ((cur->event =3D=3D event_data->event) && cur->iommu_noti=
fy) {
>>> +            cur->iommu_notify(cur, event_data);
>>> +        }
>>> +    }
>>> +}
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 03595e3..8350973 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -26,6 +26,7 @@
>>>  #include "qom/object.h"
>>>  #include "qemu/rcu.h"
>>>  #include "hw/qdev-core.h"
>>> +#include "hw/core/iommu.h"
>>> =20
>>>  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
>>> =20
>>> @@ -301,6 +302,19 @@ struct MemoryListener {
>>>  };
>>> =20
>>>  /**
>>> + * AddressSpaceOps: callbacks structure for address space specific o=
perations
>>> + *
>>> + * @iommu_get: returns an IOMMU object that backs the address space.
>>> + *             Normally this should be NULL for generic address
>>> + *             spaces, and it's only used when there is one
>>> + *             translation unit behind this address space.
>>> + */
>>> +struct AddressSpaceOps {
>>> +    IOMMUObject *(*iommu_get)(AddressSpace *as);
>>> +};
>>> +typedef struct AddressSpaceOps AddressSpaceOps;
>>> +
>>> +/**
>>>   * AddressSpace: describes a mapping of addresses to #MemoryRegion o=
bjects
>>>   */
>>>  struct AddressSpace {
>>> @@ -316,6 +330,7 @@ struct AddressSpace {
>>>      struct MemoryRegionIoeventfd *ioeventfds;
>>>      QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
>>>      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
>>> +    AddressSpaceOps as_ops;
>>>  };
>>> =20
>>>  FlatView *address_space_to_flatview(AddressSpace *as);
>>> @@ -1988,6 +2003,13 @@ address_space_write_cached(MemoryRegionCache *=
cache, hwaddr addr,
>>>      address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UN=
SPECIFIED, buf, len);
>>>  }
>>> =20
>>> +/**
>>> + * address_space_iommu_get: Get the backend IOMMU for the address sp=
ace
>>> + *
>>> + * @as: the address space to fetch IOMMU from
>>> + */
>>> +IOMMUObject *address_space_iommu_get(AddressSpace *as);
>>> +
>>>  #endif
>>> =20
>>>  #endif
>>> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
>>> new file mode 100644
>>> index 0000000..34387c0
>>> --- /dev/null
>>> +++ b/include/hw/core/iommu.h
>>> @@ -0,0 +1,73 @@
>>> +/*
>>> + * QEMU emulation of IOMMU logic
>>> + *
>>> + * Copyright (C) 2017 Red Hat Inc.
>>> + *
>>> + * Authors: Peter Xu <peterx@redhat.com>,
>>> + *
>>> + * This program is free software; you can redistribute it and/or mod=
ify
>>> + * it under the terms of the GNU General Public License as published=
 by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> +
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> +
>>> + * You should have received a copy of the GNU General Public License=
 along
>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#ifndef HW_CORE_IOMMU_H
>>> +#define HW_CORE_IOMMU_H
>>> +
>>> +#include "qemu/queue.h"
>>> +
>>> +enum IOMMUEvent {
>>> +    IOMMU_EVENT_BIND_PASIDT,
>>> +};
>>> +typedef enum IOMMUEvent IOMMUEvent;
>>> +
>>> +struct IOMMUEventData {
>>> +    IOMMUEvent event;
>>> +    uint64_t length;
>>> +    void *data;
>>> +};
>>> +typedef struct IOMMUEventData IOMMUEventData;
>>> +
>>> +typedef struct IOMMUNotifier IOMMUNotifier;
>>> +
>>> +typedef void (*IOMMUNotifyFn)(IOMMUNotifier *notifier,
>>> +                              IOMMUEventData *event_data);
>>> +
>>> +struct IOMMUNotifier {
>>> +    IOMMUNotifyFn iommu_notify;
>>> +    /*
>>> +     * What events we are listening to. Let's allow multiple event
>>> +     * registrations from beginning.
>>> +     */
>>> +    IOMMUEvent event;
>>> +    QLIST_ENTRY(IOMMUNotifier) node;
>>> +};
>>> +
>>> +typedef struct IOMMUObject IOMMUObject;
>>> +
>>> +/*
>>> + * This stands for an IOMMU unit. Any translation device should have
>>> + * this struct inside its own structure to make sure it can leverage
>>> + * common IOMMU functionalities.
>>> + */
>>> +struct IOMMUObject {
>>> +    QLIST_HEAD(, IOMMUNotifier) iommu_notifiers;
>>> +};
>>> +
>>> +void iommu_notifier_register(IOMMUObject *iommu,
>>> +                             IOMMUNotifier *n,
>>> +                             IOMMUNotifyFn fn,
>>> +                             IOMMUEvent event);
>>> +void iommu_notifier_unregister(IOMMUObject *iommu,
>>> +                               IOMMUNotifier *notifier);
>>> +void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data);
>>> +
>>> +#endif
>>> diff --git a/memory.c b/memory.c
>>> index 77fb3ef..307f665 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -235,8 +235,6 @@ struct FlatView {
>>>      MemoryRegion *root;
>>>  };
>>> =20
>>> -typedef struct AddressSpaceOps AddressSpaceOps;
>>> -
>>>  #define FOR_EACH_FLAT_RANGE(var, view)          \
>>>      for (var =3D (view)->ranges; var < (view)->ranges + (view)->nr; =
++var)
>>> =20
>>> @@ -2793,6 +2791,14 @@ static void do_address_space_destroy(AddressSp=
ace *as)
>>>      memory_region_unref(as->root);
>>>  }
>>> =20
>>> +IOMMUObject *address_space_iommu_get(AddressSpace *as)
>>> +{
>>> +    if (!as->as_ops.iommu_get) {
>>> +        return NULL;
>>> +    }
>>> +    return as->as_ops.iommu_get(as);
>>> +}
>>> +
>>>  void address_space_destroy(AddressSpace *as)
>>>  {
>>>      MemoryRegion *root =3D as->root;
>>
>> --=20
>> David Gibson			| I'll have my music baroque, and my code
>> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _ot=
her_
>> 				| _way_ _around_!
>> http://www.ozlabs.org/~dgibson
>=20
>=20
>=20
