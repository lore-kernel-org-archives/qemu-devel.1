Received: from eggs.gnu.org ([2001:4830:134:3::10]:58429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE7mn-0006IT-EB
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 01:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE7mi-0005Gq-My
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:59:57 -0500
Received: from ozlabs.org ([103.22.144.67]:33741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eE7mh-0005EX-Ua
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:59:52 -0500
Date: Mon, 13 Nov 2017 16:56:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171113055601.GE1014@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline
In-Reply-To: <1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 08:01:52PM +0800, Liu, Yi L wrote:
> From: Peter Xu <peterx@redhat.com>
>=20
> AddressSpaceOps is similar to MemoryRegionOps, it's just for address
> spaces to store arch-specific hooks.
>=20
> The first hook I would like to introduce is iommu_get(). Return an
> IOMMUObject behind the AddressSpace.
>=20
> For systems that have IOMMUs, we will create a special address
> space per device which is different from system default address
> space for it (please refer to pci_device_iommu_address_space()).
> Normally when that happens, there will be one specific IOMMU (or
> say, translation unit) stands right behind that new address space.
>=20
> This iommu_get() fetches that guy behind the address space. Here,
> the guy is defined as IOMMUObject, which includes a notifier_list
> so far, may extend in future. Along with IOMMUObject, a new iommu
> notifier mechanism is introduced. It would be used for virt-svm.
> Also IOMMUObject can further have a IOMMUObjectOps which is similar
> to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
> on MemoryRegion.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>

Hi, sorry I didn't reply to the earlier postings of this after our
discussion in China.  I've been sick several times and very busy.

I still don't feel like there's an adequate explanation of exactly
what an IOMMUObject represents.   Obviously it can represent more than
a single translation window - since that's represented by the
IOMMUMR.  But what exactly do all the MRs - or whatever else - that
are represented by the IOMMUObject have in common, from a functional
point of view.

Even understanding the SVM stuff better than I did, I don't really see
why an AddressSpace is an obvious unit to have an IOMMUObject
associated with it.

> ---
>  hw/core/Makefile.objs   |  1 +
>  hw/core/iommu.c         | 58 +++++++++++++++++++++++++++++++++++++++
>  include/exec/memory.h   | 22 +++++++++++++++
>  include/hw/core/iommu.h | 73 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  memory.c                | 10 +++++--
>  5 files changed, 162 insertions(+), 2 deletions(-)
>  create mode 100644 hw/core/iommu.c
>  create mode 100644 include/hw/core/iommu.h
>=20
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index f8d7a4a..d688412 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -5,6 +5,7 @@ common-obj-y +=3D fw-path-provider.o
>  # irq.o needed for qdev GPIO handling:
>  common-obj-y +=3D irq.o
>  common-obj-y +=3D hotplug.o
> +common-obj-y +=3D iommu.o
>  common-obj-y +=3D nmi.o
> =20
>  common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
> diff --git a/hw/core/iommu.c b/hw/core/iommu.c
> new file mode 100644
> index 0000000..7c4fcfe
> --- /dev/null
> +++ b/hw/core/iommu.c
> @@ -0,0 +1,58 @@
> +/*
> + * QEMU emulation of IOMMU logic
> + *
> + * Copyright (C) 2017 Red Hat Inc.
> + *
> + * Authors: Peter Xu <peterx@redhat.com>,
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/iommu.h"
> +
> +void iommu_notifier_register(IOMMUObject *iommu,
> +                             IOMMUNotifier *n,
> +                             IOMMUNotifyFn fn,
> +                             IOMMUEvent event)
> +{
> +    n->event =3D event;
> +    n->iommu_notify =3D fn;
> +    QLIST_INSERT_HEAD(&iommu->iommu_notifiers, n, node);
> +    return;
> +}
> +
> +void iommu_notifier_unregister(IOMMUObject *iommu,
> +                               IOMMUNotifier *notifier)
> +{
> +    IOMMUNotifier *cur, *next;
> +
> +    QLIST_FOREACH_SAFE(cur, &iommu->iommu_notifiers, node, next) {
> +        if (cur =3D=3D notifier) {
> +            QLIST_REMOVE(cur, node);
> +            break;
> +        }
> +    }
> +}
> +
> +void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data)
> +{
> +    IOMMUNotifier *cur;
> +
> +    QLIST_FOREACH(cur, &iommu->iommu_notifiers, node) {
> +        if ((cur->event =3D=3D event_data->event) && cur->iommu_notify) {
> +            cur->iommu_notify(cur, event_data);
> +        }
> +    }
> +}
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 03595e3..8350973 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -26,6 +26,7 @@
>  #include "qom/object.h"
>  #include "qemu/rcu.h"
>  #include "hw/qdev-core.h"
> +#include "hw/core/iommu.h"
> =20
>  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
> =20
> @@ -301,6 +302,19 @@ struct MemoryListener {
>  };
> =20
>  /**
> + * AddressSpaceOps: callbacks structure for address space specific opera=
tions
> + *
> + * @iommu_get: returns an IOMMU object that backs the address space.
> + *             Normally this should be NULL for generic address
> + *             spaces, and it's only used when there is one
> + *             translation unit behind this address space.
> + */
> +struct AddressSpaceOps {
> +    IOMMUObject *(*iommu_get)(AddressSpace *as);
> +};
> +typedef struct AddressSpaceOps AddressSpaceOps;
> +
> +/**
>   * AddressSpace: describes a mapping of addresses to #MemoryRegion objec=
ts
>   */
>  struct AddressSpace {
> @@ -316,6 +330,7 @@ struct AddressSpace {
>      struct MemoryRegionIoeventfd *ioeventfds;
>      QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
>      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> +    AddressSpaceOps as_ops;
>  };
> =20
>  FlatView *address_space_to_flatview(AddressSpace *as);
> @@ -1988,6 +2003,13 @@ address_space_write_cached(MemoryRegionCache *cach=
e, hwaddr addr,
>      address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPEC=
IFIED, buf, len);
>  }
> =20
> +/**
> + * address_space_iommu_get: Get the backend IOMMU for the address space
> + *
> + * @as: the address space to fetch IOMMU from
> + */
> +IOMMUObject *address_space_iommu_get(AddressSpace *as);
> +
>  #endif
> =20
>  #endif
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> new file mode 100644
> index 0000000..34387c0
> --- /dev/null
> +++ b/include/hw/core/iommu.h
> @@ -0,0 +1,73 @@
> +/*
> + * QEMU emulation of IOMMU logic
> + *
> + * Copyright (C) 2017 Red Hat Inc.
> + *
> + * Authors: Peter Xu <peterx@redhat.com>,
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_CORE_IOMMU_H
> +#define HW_CORE_IOMMU_H
> +
> +#include "qemu/queue.h"
> +
> +enum IOMMUEvent {
> +    IOMMU_EVENT_BIND_PASIDT,
> +};
> +typedef enum IOMMUEvent IOMMUEvent;
> +
> +struct IOMMUEventData {
> +    IOMMUEvent event;
> +    uint64_t length;
> +    void *data;
> +};
> +typedef struct IOMMUEventData IOMMUEventData;
> +
> +typedef struct IOMMUNotifier IOMMUNotifier;
> +
> +typedef void (*IOMMUNotifyFn)(IOMMUNotifier *notifier,
> +                              IOMMUEventData *event_data);
> +
> +struct IOMMUNotifier {
> +    IOMMUNotifyFn iommu_notify;
> +    /*
> +     * What events we are listening to. Let's allow multiple event
> +     * registrations from beginning.
> +     */
> +    IOMMUEvent event;
> +    QLIST_ENTRY(IOMMUNotifier) node;
> +};
> +
> +typedef struct IOMMUObject IOMMUObject;
> +
> +/*
> + * This stands for an IOMMU unit. Any translation device should have
> + * this struct inside its own structure to make sure it can leverage
> + * common IOMMU functionalities.
> + */
> +struct IOMMUObject {
> +    QLIST_HEAD(, IOMMUNotifier) iommu_notifiers;
> +};
> +
> +void iommu_notifier_register(IOMMUObject *iommu,
> +                             IOMMUNotifier *n,
> +                             IOMMUNotifyFn fn,
> +                             IOMMUEvent event);
> +void iommu_notifier_unregister(IOMMUObject *iommu,
> +                               IOMMUNotifier *notifier);
> +void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data);
> +
> +#endif
> diff --git a/memory.c b/memory.c
> index 77fb3ef..307f665 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -235,8 +235,6 @@ struct FlatView {
>      MemoryRegion *root;
>  };
> =20
> -typedef struct AddressSpaceOps AddressSpaceOps;
> -
>  #define FOR_EACH_FLAT_RANGE(var, view)          \
>      for (var =3D (view)->ranges; var < (view)->ranges + (view)->nr; ++va=
r)
> =20
> @@ -2793,6 +2791,14 @@ static void do_address_space_destroy(AddressSpace =
*as)
>      memory_region_unref(as->root);
>  }
> =20
> +IOMMUObject *address_space_iommu_get(AddressSpace *as)
> +{
> +    if (!as->as_ops.iommu_get) {
> +        return NULL;
> +    }
> +    return as->as_ops.iommu_get(as);
> +}
> +
>  void address_space_destroy(AddressSpace *as)
>  {
>      MemoryRegion *root =3D as->root;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloJM/EACgkQbDjKyiDZ
s5Ir2xAAsxKi6ddVLqlUiY/MaSwHUsvIfx1ie0Ttx7+XJTLTEeIFxWZOiXWO3B48
Mord6p3hOiW7wSq8U/Rzn3mLJXtyU3cprW4oXXn5NT30/3TLnE9dUvGCVGEOu0TX
EErh/UQ9vHs4EmJOXHsm72b43jsA/VcMZ4oZKL9xn6OYVfzVW1bwTD1hrydHLrWr
wY25qRznqFmSfgg70B+gNR/K9Ax3f7oCrQozhNM+0NO7KMe/9B4hYisBNsM1d0vS
IZXqh7RafxfRpFTnmIX/jOHtkISrsPheTaHdm6jU/lcU9bARQEUghZX3lXVWYguf
ReDMVCZzFeAWhzoCH2tJjxnfGPGVW6h0lJwQ+ussEXeddeQ657y5lnM+ymU50OgN
81X+WED/Sxo+g//zTGYvMsA1I5s2VbaFdyr7n2X1obsKrD5+a56ECqwDGCQT5EoJ
dS95k2euwOrFnTUDF0Khz8/3WRaQ2Ct0hdM0LV5V0bGuSu+gK8mYr1gQG+Y8CqIU
MuK2d74O/O9dj1GeqPvIXbK7PMgFimvPzldLmAbyf3FzqpjGMb5V1kk4x1Iz9Uwl
3xTFugzDgSW9nDjl05eRUEN5qtw8vCI6Jb582erVsdopI+MfXd+5Oy6NyqVRoSn0
Ss00cMqgD9kROjIq07csbzfXTfXIGehOqDExVytaZ+3MqsLruDg=
=mwrK
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
