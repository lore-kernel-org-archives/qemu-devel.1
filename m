Received: from eggs.gnu.org ([2001:4830:134:3::10]:33320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f71a4-0005gN-6Y
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f71a1-00006Y-Hr
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:29:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:33127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1f71a1-0008Vo-58
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:29:41 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Fri, 13 Apr 2018 16:29:35 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A15EEE9@SHSMSX101.ccr.corp.intel.com>
References: <1523340124-8881-1-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1523340124-8881-1-git-send-email-yulei.zhang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC V4 PATCH 0/4] vfio: Introduce live migation
 capability to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

Hi Kirti, what do you think of the pre-copy interface in this series?=20

Thanks,
Yulei
> -----Original Message-----
> From: Zhang, Yulei
> Sent: Tuesday, April 10, 2018 2:02 PM
> To: qemu-devel@nongnu.org
> Cc: Tian, Kevin <kevin.tian@intel.com>; joonas.lahtinen@linux.intel.com;
> zhenyuw@linux.intel.com; kwankhede@nvidia.com; Wang, Zhi A
> <zhi.a.wang@intel.com>; alex.williamson@redhat.com;
> dgilbert@redhat.com; quintela@redhat.com; Zhang, Yulei
> <yulei.zhang@intel.com>
> Subject: [RFC V4 PATCH 0/4] vfio: Introduce live migation capability to
>=20
> Summary
>=20
> This series RFC would like to resume the discussion about how to
> introduce the live migration capability to vfio mdev device.
>=20
> A new subtype region VFIO_REGION_SUBTYPE_DEVICE_STATE is introduced
> for vfio device status migrate, during the initialization it will
> check if the region is supported by the vfio device, otherwise it
> will remain non-migratable.
>=20
> The intention to add the new region is using it for mdev device status
> save and restore during the migration. The access to this region
> will be trapped and forward to the mdev device driver, it also uses
> the first byte in the new region to control the running state of mdev
> device, so during the migration after stop the mdev driver, qemu could
> retrieve the specific device status from this region and transfer to
> the target VM side for the mdev device restore.
>=20
> In addition, during the pre-copy period, it will be able to fetch the
> dirty bitmap of vfio device through ioctl VFIO_DEVICE_GET_DIRTY_BITMAP
> iteratively, which will be able to shorten the system downtime during
> the static copy.
>=20
> Below is the vfio mdev device migration sequence
> Source VM side:
> 			start migration
> 				|
> 				V
>                  in pre-copy stage, fetch the device dirty bitmap
>                  and add into qemu dirty list for migrate iteratively.
>                                 |
>                                 V
>         	 get the cpu state change callback, write to the
>         	 subregion's first byte to stop the mdev device
> 				|
> 				V
> 		 quary the dirty page bitmap from iommu container
> 		 and add into qemu dirty list for last synchronization
> 				|
> 				V
> 		 save the deivce status into Qemufile which is
>                  read from the vfio device subregion
>=20
> Target VM side:
> 		 restore the mdev device after get the
> 		 saved status context from Qemufile
> 				|
> 				V
> 		  get the cpu state change callback write to
>                   subregion's first byte to start the mdev device
>                   to put it in running status
> 				|
> 				V
> 			finish migration
>=20
> V3->V4:
> 1. add migration_blocker if device state region isnot supported.
> 2. instead of using vmsd, register SaveVMHandlers for VFIO device
>    to leverage the pro-copy facility, and add new ioctl for VFIO
>    device to fetch dirty bitmap during pro-copy.
> 3. remove the intel vendor ID dependence for the device state
>    subregion.
>=20
> V2->V3:
> 1. rebase the patch to Qemu stable 2.10 branch.
> 2. use a common name for the subregion instead of specific for
>    intel IGD.
>=20
> V1->V2:
> Per Alex's suggestion:
> 1. use device subtype region instead of VFIO PCI fixed region.
> 2. remove unnecessary ioctl, use the first byte of subregion to
>    control the running state of mdev device.
> 3. for dirty page synchronization, implement the interface with
>    VFIOContainer instead of vfio pci device.
>=20
> Yulei Zhang (4):
>   vfio: introduce a new VFIO subregion for mdev device migration support
>   vfio: Add vm status change callback to stop/restart the mdev device
>   vfio: Add SaveVMHanlders for VFIO device to support live migration
>   vifo: introduce new VFIO ioctl VFIO_IOMMU_GET_DIRTY_BITMAP
>=20
>  hw/vfio/common.c              |  34 ++++++
>  hw/vfio/pci.c                 | 240
> ++++++++++++++++++++++++++++++++++++++++--
>  hw/vfio/pci.h                 |   2 +
>  include/hw/vfio/vfio-common.h |   1 +
>  linux-headers/linux/vfio.h    |  43 +++++++-
>  roms/seabios                  |   2 +-
>  6 files changed, 312 insertions(+), 10 deletions(-)
>=20
> --
> 2.7.4
