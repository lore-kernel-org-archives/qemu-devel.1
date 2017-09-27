Received: from eggs.gnu.org ([2001:4830:134:3::10]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dx674-0006jM-Of
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dx673-0003S2-Ms
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:46:30 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Wed, 27 Sep 2017 06:46:18 +0000
Message-ID: <AM5PR0401MB25458FFED2D7D405A71F954C9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/5] virtio-iommu: VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>
Cc: "wei@redhat.com" <wei@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>

Hi Peter,

While vfio with virtio-iommu I observed one issue,  When virtio-iommu devic=
e exists but guest kernel does not have virtio-iommu driver (not enabled in=
 Config) then IOMMU faults are reported on host.

This is because no mapping is created in IOMMU, not even default guest-phys=
ical to real-physical. While looking at vfio_listener_region_add(), it does=
 not create initial mapping in IOMMU and relies on guest to create mapping.=
 Is this something known or I am missing something?

Thanks
-Bharat

> -----Original Message-----
> From: Bharat Bhushan [mailto:Bharat.Bhushan@nxp.com]
> Sent: Wednesday, September 27, 2017 12:03 PM
> To: eric.auger@redhat.com; eric.auger.pro@gmail.com;
> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: wei@redhat.com; kevin.tian@intel.com; marc.zyngier@arm.com;
> tn@semihalf.com; will.deacon@arm.com; drjones@redhat.com;
> robin.murphy@arm.com; christoffer.dall@linaro.org;
> bharatb.yadav@gmail.com; Bharat Bhushan <bharat.bhushan@nxp.com>
> Subject: [PATCH v4 0/5] virtio-iommu: VFIO integration
>=20
> This patch series integrates VFIO/VHOST with virtio-iommu.
>=20
> This version is mainly about rebasing on v4 version on virtio-iommu devic=
e
> framework from Eric Augur and addresing review comments.
>=20
> This patch series allows PCI pass-through using virtio-iommu.
>=20
> This series is based on:
>  - virtio-iommu kernel driver by Jean-Philippe Brucker
>     [1] [RFC] virtio-iommu version 0.4
>     git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
>=20
>  - virtio-iommu device emulation by Eric Augur.
>    [RFC v4 00/16] VIRTIO-IOMMU device
>    https://github.com/eauger/qemu/tree/v2.10.0-virtio-iommu-v4
>=20
> Changes are available at : https://github.com/bharaty/qemu.git virtio-
> iommu-vfio-integration-v4
>=20
> v3->v4:
>  - Rebase to v4 version from Eric
>  - Fixes from Eric with DPDK in VM
>  - Logical division in multiple patches
>=20
> v2->v3:
>  - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
>    Which is based on top of v2.10-rc0 that
>  - Fixed issue with two PCI devices
>  - Addressed review comments
>=20
> v1->v2:
>   - Added trace events
>   - removed vSMMU3 link in patch description
>=20
> Bharat Bhushan (5):
>   target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
>   virtio-iommu: Add iommu notifier for map/unmap
>   virtio-iommu: Call iommu notifier for attach/detach
>   virtio-iommu: add iommu replay
>   virtio-iommu: add iommu notifier memory-region
>=20
>  hw/virtio/trace-events           |   5 ++
>  hw/virtio/virtio-iommu.c         | 181
> ++++++++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-iommu.h |   6 ++
>  target/arm/kvm.c                 |  27 ++++++
>  target/arm/trace-events          |   3 +
>  5 files changed, 219 insertions(+), 3 deletions(-)
>=20
> --
> 1.9.3
