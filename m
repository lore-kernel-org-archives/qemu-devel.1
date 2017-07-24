Received: from eggs.gnu.org ([2001:4830:134:3::10]:58612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dZZ2q-0001UF-70
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dZZ2m-0007N5-9c
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:48:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dZZ2l-0007Mj-W1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:48:48 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Mon, 24 Jul 2017 08:48:40 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D469E00C17@SHSMSX101.ccr.corp.intel.com>
References: <1491301529-24125-1-git-send-email-yulei.zhang@intel.com>
	<20170627102806.GB2123@work-vm>
In-Reply-To: <20170627102806.GB2123@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 0/5] vfio: Introduce Live migration
 capability to vfio_mdev device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Zheng, Xiao" <xiao.zheng@intel.com>, "Wang, Zhi
	A" <zhi.a.wang@intel.com>



> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Tuesday, June 27, 2017 6:28 PM
> To: Zhang, Yulei <yulei.zhang@intel.com>
> Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com; Zheng, Xiao
> <xiao.zheng@intel.com>; Wang, Zhi A <zhi.a.wang@intel.com>
> Subject: Re: [Qemu-devel] [RFC 0/5] vfio: Introduce Live migration capabi=
lity
> to vfio_mdev device
>=20
> * Yulei Zhang (yulei.zhang@intel.com) wrote:
> > Summary
> >
> > This series RFC would like to introduce the live migration capability
> > to vfio_mdev device.
> >
> > As currently vfio_mdev device don't support migration, we introduce a
> > device flag VFIO_DEVICE_FLAGS_MIGRATABLE to help determine whether
> the
> > mdev device can be migrate or not, it will check the flag during the
> > device initialization and decide to init the new vfio region
> > VFIO_PCI_DEVICE_STATE_REGION_INDEX.
> >
> > The intention to add the new region is using it for vfio_mdev device
> > status save and restore during the migration. The access to this
> > region will be trapped and forward to the vfio_mdev device driver.
> > There is an alternative way to achieve it is to add a new vfio ioctl
> > to help fetch and save the device status.
> >
> > Also this series include two new vfio ioctl
> > #define VFIO_DEVICE_PCI_STATUS_SET	_IO(VFIO_TYPE, VFIO_BASE + 14)
> > #define VFIO_DEVICE_PCI_GET_DIRTY_BITMAP _IO(VFIO_TYPE, VFIO_BASE
> +
> > 15)
> >
> > The first one is used to contorl the device running status, we want to
> > stop the mdev device before quary the status from its device driver
> > and restart the device after migration.
> > The second one is used to do the mdev device dirty page synchronization=
.
> >
> > So the vfio_mdev device migration sequence would be Source VM side:
> > 			start migration
> > 				|
> > 				V
> >         	 get the cpu state change callback
> >         	use status set ioctl to stop the mdev device
> > 				|
> > 				V
> > 		 save the deivce status into Qemufile which is
> >                  read from the new vfio device status region
> > 				|
> > 				V
> > 		   quary the dirty page bitmap from deivce
> > 		    and add into qemu dirty list for sync
>=20
> That ordering is interesting; I think the main migration flow is normally=
 to
> complete migration of RAM and then migrate the devices; so I worry about
> that order.
>=20
> Dave

Dave, thanks for help review the patch, you are right about the sequence, I=
=20
will modify the description in next version.=20

>=20
> > Target VM side:
> > 		   restore the mdev device after get the
> > 		     saved status context from Qemufile
> > 				|
> > 				V
> > 		     get the cpu state change callback
> >  		     use status set ioctl to start the mdev
> > 		     device to put it in running status
> > 				|
> > 				V
> > 			finish migration
> >
> > Yulei Zhang (5):
> >   vfio: introduce a new VFIO region for migration support
> >   vfio: Add struct vfio_vmstate_info to introduce vfio device put/get
> >     funtion
> >   vfio: introduce new VFIO ioctl VFIO_DEVICE_PCI_STATUS_SET
> >   vfio: use vfio_device_put/vfio_device_get for device status
> >     save/restore
> >   vifo: introduce new VFIO ioctl VFIO_DEVICE_PCI_GET_DIRTY_BITMAP
> >
> >  hw/vfio/pci.c              | 204
> ++++++++++++++++++++++++++++++++++++++++++++-
> >  hw/vfio/pci.h              |   3 +
> >  linux-headers/linux/vfio.h |  34 +++++++-
> >  3 files changed, 239 insertions(+), 2 deletions(-)
> >
> > --
> > 2.7.4
> >
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
