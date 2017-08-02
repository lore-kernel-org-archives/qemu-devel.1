Received: from eggs.gnu.org ([2001:4830:134:3::10]:38953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dcjUQ-0003iT-5N
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dcjUM-00016I-TF
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:34:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dcjUM-000130-Ja
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:34:22 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Wed, 2 Aug 2017 02:34:15 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D469E0FF18@SHSMSX101.ccr.corp.intel.com>
References: <1494316727-15518-1-git-send-email-yulei.zhang@intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D50356@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D50356@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC V2 0/4] vfio: Introduce Live migration
 capability to vfio_mdev device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Zheng, Xiao" <xiao.zheng@intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>



> -----Original Message-----
> From: Tian, Kevin
> Sent: Monday, July 31, 2017 2:55 PM
> To: Zhang, Yulei <yulei.zhang@intel.com>; qemu-devel@nongnu.org
> Cc: joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com; Zheng, Xiao
> <xiao.zheng@intel.com>; Wang, Zhi A <zhi.a.wang@intel.com>;
> alex.williamson@redhat.com
> Subject: RE: [Qemu-devel][RFC V2 0/4] vfio: Introduce Live migration
> capability to vfio_mdev device
>=20
> > From: Zhang, Yulei
> > Sent: Tuesday, May 9, 2017 3:59 PM
> >
> > Summary
> >
> > This series RFC would like to introduce the live migration capability
> > to vfio_mdev device.
> >
> > As currently vfio_mdev device don't support migration, we introduce a
> > new vfio subtype region
> VFIO_REGION_SUBTYPE_INTEL_IGD_DEVICE_STATE
> > for Intel vGPU device, during the vfio device initialization, the mdev
> > device will be set to migratable if the new region exist.
>=20
> Looking at your series, there is really nothing specific to vGPU or even =
Intel
> vGPU regarding to device state save/restore...
>=20

You are right, we may define a new subtype for it as it is common region fo=
r vfio=20
device state save/restore.

> >
> > The intention to add the new region is using it for vfio_mdev device
> > status save and restore during the migration. The access to this
> > region will be trapped and forward to the vfio_mdev device driver. And
> > we use the first byte in the new region to control the running state
> > of mdev device.
> >
> > Meanwhile we add one new ioctl VFIO_IOMMU_GET_DIRTY_BITMAP to
> help do
> > the mdev device dirty page synchronization.
> >
> > So the vfio_mdev device migration sequence would be Source VM side:
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
> > V1->V2:
> > Per Alex's suggestion:
> > 1. use device subtype region instead of VFIO PCI fixed region.
> > 2. remove unnecessary ioctl, use the first byte of subregion to
> >    control the running state of mdev device.
> > 3. for dirty page synchronization, implement the interface with
> >    VFIOContainer instead of vfio pci device.
> >
> > Yulei Zhang (4):
> >   vfio: introduce a new VFIO sub region for mdev device migration
> >     support
> >   vfio: Add vm status change callback to stop/restart the mdev device
> >   vfio: Add struct vfio_vmstate_info to introduce put/get callback
> >     funtion     for vfio device status save/restore
> >   vifo: introduce new VFIO ioctl VFIO_IOMMU_GET_DIRTY_BITMAP
> >
> >  hw/vfio/common.c              |  32 +++++++++
> >  hw/vfio/pci.c                 | 164
> > +++++++++++++++++++++++++++++++++++++++++-
> >  hw/vfio/pci.h                 |   1 +
> >  include/hw/vfio/vfio-common.h |   1 +
> >  linux-headers/linux/vfio.h    |  26 ++++++-
> >  5 files changed, 220 insertions(+), 4 deletions(-)
> >
> > --
> > 2.7.4
