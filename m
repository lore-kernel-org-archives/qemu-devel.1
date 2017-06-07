Received: from eggs.gnu.org ([2001:4830:134:3::10]:58601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1dIVl8-0000Hc-SK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1dIVl4-00082G-TK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:52:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:22754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1dIVl4-00081o-Kg
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:52:02 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Wed, 7 Jun 2017 07:51:55 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743908AF7E@shsmsx102.ccr.corp.intel.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-9-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 8/8] iommu: introduce hw/core/iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

Hi Peter,

Some updates on it.

> -----Original Message-----
> From: Peter Xu [mailto:peterx@redhat.com]
> Sent: Thursday, April 27, 2017 5:34 PM
> To: qemu-devel@nongnu.org
> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Paolo Bonzini <pbonzini@redhat.co=
m>;
> Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>;
> peterx@redhat.com; Jason Wang <jasowang@redhat.com>; David Gibson
> <david@gibson.dropbear.id.au>; Alex Williamson <alex.williamson@redhat.co=
m>
> Subject: [RFC PATCH 8/8] iommu: introduce hw/core/iommu
>=20
> Time to consider a common stuff for IOMMU. Let's start from an common IOM=
MU
> object (which should be inlayed in custom IOMMU implementations) and a no=
tifier
> mechanism.
>=20
> Let VT-d IOMMU be the first user.
>=20
> An example to use this per-iommu notifier:
>=20
>   (when registering)
>   iommu =3D address_space_iommu_get(pci_device_iommu_address_space(dev));
>   notifier =3D iommu_notifier_register(iommu, IOMMU_EVENT_SVM_PASID, func=
);
>   ...
>   (when notify)
>   IOMMUEvent event =3D { .type =3D IOMMU_EVENT_SVM_PASID ... };
>   iommu_notify(iommu, &event);
>   ...
>   (when releasing)
>   iommu_notifier_unregister(notifier);
>   notifier =3D NULL;
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

[...]

> +#include "qemu/osdep.h"
> +#include "hw/core/iommu.h"
> +
> +IOMMUNotifier *iommu_notifier_register(IOMMUObject *iommu,
> +                                       IOMMUNotifyFn fn,
> +                                       uint64_t event_mask) {
> +    IOMMUNotifier *notifier =3D g_new0(IOMMUNotifier, 1);

For this part, I think may need to consider to alloc the memory in a
similar way with IOMMUMRNotifier. The notifier surely needs to
be connect with vfio container so that it could manipulate
pIOMMU through vfio IOCTL.

I'm thinking of adding a new struct VFIOGuestIOMMUObject which
is similar to strcut VFIOGuestIOMMU. And have the original struct
VFIOGuestIOMMU modified to be VFIOGuestIOMMUMR.

Then there would be following definition in
"include\hw\vfio\vfio-common.h":

typedef struct VFIOGuestIOMMUObject {
    VFIOContainer *container;
    IOMMUObject *iommu;
    IOMMUNotifier n; // n is for non-MemoryRegion related events, e.g. pasi=
d table binding
    QLIST_ENTRY(VFIOGuestIOMMUObject) giommu_next;
} VFIOGuestIOMMUObject;

typedef struct VFIOGuestIOMMUMR {
    VFIOContainer *container;
    MemoryRegion *iommu;
    hwaddr iommu_offset;
    IOMMUNotifier n;
    QLIST_ENTRY(VFIOGuestIOMMUMR) giommu_next;
} VFIOGuestIOMMUMR;

How about your opinion?

Thanks,
Yi L
