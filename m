Received: from eggs.gnu.org ([2001:4830:134:3::10]:46669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1evf7B-0006gp-VG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1evf77-0000i4-N3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:16:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:55984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1evf77-0000cd-9g
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:16:53 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Tue, 13 Mar 2018 08:16:45 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A0A8E07@SHSMSX101.ccr.corp.intel.com>
References: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
	<20180312162144.69420683@w520.home>
In-Reply-To: <20180312162144.69420683@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V3 0/4] vfio: Introduce Live migration
 capability to vfio_mdev device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, Juan Quintela <quintela@redhat.com>



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, March 13, 2018 6:22 AM
> To: Zhang, Yulei <yulei.zhang@intel.com>
> Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> zhenyuw@linux.intel.com; kwankhede@nvidia.com; Juan Quintela
> <quintela@redhat.com>
> Subject: Re: [PATCH V3 0/4] vfio: Introduce Live migration capability to
> vfio_mdev device
>=20
> [cc +Juan]
>=20
> On Mon,  5 Mar 2018 14:00:49 +0800
> Yulei Zhang <yulei.zhang@intel.com> wrote:
>=20
> > Summary
> >
> > This series RFC would like to resume the discussion about how to
> > introduce the live migration capability to vfio mdev device.
> >
> > By adding a new vfio subtype region
> VFIO_REGION_SUBTYPE_DEVICE_STATE,
> > the mdev device will be set to migratable if the new region exist
> > during the initialization.
> >
> > The intention to add the new region is using it for mdev device status
> > save and restore during the migration. The access to this region
> > will be trapped and forward to the mdev device driver, it also uses
> > the first byte in the new region to control the running state of mdev
> > device, so during the migration after stop the mdev driver, qemu could
> > retrieve the specific device status from this region and transfer to
> > the target VM side for the mdev device restore.
> >
> > In addition,  we add one new ioctl VFIO_IOMMU_GET_DIRTY_BITMAP to
> help do
> > the mdev device dirty page synchronization during the migration,
> currently
> > it is just for static copy, in the future we would like to add new inte=
rface
> > for the pre-copy.
>=20
> Juan had concerns about another dirty bitmap implementation.  I'm not
> sure what alternatives we have, but let's loop him in for guidance on
> the best migration strategies.  The migration state for a device could
> be many gigabytes.
>=20
> > Below is the vfio_mdev device migration sequence
> > Source VM side:
> > 			start migration
> > 				|
> > 				V
> >         	 get the cpu state change callback, write to the
> >         	 subregion's first byte to stop the mdev device
> > 				|
> > 				V
> > 		 quary the dirty page bitmap from iommu container
> > 		 and add into qemu dirty list for synchronization
> > 				|
> > 				V
> > 		 save the deivce status into Qemufile which is
> >                      read from the vfio device subregion
> >
> > Target VM side:
> > 		   restore the mdev device after get the
> > 		     saved status context from Qemufile
> > 				|
> > 				V
> > 		     get the cpu state change callback
> >  		     write to subregion's first byte to
> >                       start the mdev device to put it in
> >                       running status
> > 				|
> > 				V
> > 			finish migration
> >
> > V3->V2:
> > 1. rebase the patch to Qemu stable 2.10 branch.
> > 2. use a common name for the subregion instead of specific for
> >    intel IGD.
>=20
> But it's still tied to Intel's vendor ID??
>=20
No. this is not necessary, I will remove the intel vendor ID.=20

> Thanks,
> Alex
>=20
>=20
> >
> > V1->V2:
> > Per Alex's suggestion:
> > 1. use device subtype region instead of VFIO PCI fixed region.
> > 2. remove unnecessary ioctl, use the first byte of subregion to
> >    control the running state of mdev device.
> > 3. for dirty page synchronization, implement the interface with
> >    VFIOContainer instead of vfio pci device.
> >
> > Yulei Zhang (4):
> >   vfio: introduce a new VFIO subregion for mdev device migration suppor=
t
> >   vfio: Add vm status change callback to stop/restart the mdev device
> >   vfio: Add struct vfio_vmstate_info to introduce put/get callback
> >     funtion for vfio device status save/restore
> >   vifo: introduce new VFIO ioctl VFIO_IOMMU_GET_DIRTY_BITMAP
> >
> >  hw/vfio/common.c              |  34 +++++++++
> >  hw/vfio/pci.c                 | 171
> +++++++++++++++++++++++++++++++++++++++++-
> >  hw/vfio/pci.h                 |   1 +
> >  include/hw/vfio/vfio-common.h |   1 +
> >  linux-headers/linux/vfio.h    |  29 ++++++-
> >  5 files changed, 232 insertions(+), 4 deletions(-)
> >
