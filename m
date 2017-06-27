Received: from eggs.gnu.org ([2001:4830:134:3::10]:40700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPnjE-0004nJ-EA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPnjA-0001iy-GK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dPnjA-0001gc-7f
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:28:12 -0400
Date: Tue, 27 Jun 2017 11:28:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170627102806.GB2123@work-vm>
References: <1491301529-24125-1-git-send-email-yulei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491301529-24125-1-git-send-email-yulei.zhang@intel.com>
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
To: Yulei Zhang <yulei.zhang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, xiao.zheng@intel.com, zhi.a.wang@intel.com

* Yulei Zhang (yulei.zhang@intel.com) wrote:
> Summary
> 
> This series RFC would like to introduce the live migration capability
> to vfio_mdev device. 
> 
> As currently vfio_mdev device don't support migration, we introduce a
> device flag VFIO_DEVICE_FLAGS_MIGRATABLE to help determine whether the
> mdev device can be migrate or not, it will check the flag during the 
> device initialization and decide to init the new vfio region 
> VFIO_PCI_DEVICE_STATE_REGION_INDEX. 
> 
> The intention to add the new region is using it for vfio_mdev device
> status save and restore during the migration. The access to this region
> will be trapped and forward to the vfio_mdev device driver. There is 
> an alternative way to achieve it is to add a new vfio ioctl to help fetch
> and save the device status.
> 
> Also this series include two new vfio ioctl 
> #define VFIO_DEVICE_PCI_STATUS_SET	_IO(VFIO_TYPE, VFIO_BASE + 14)
> #define VFIO_DEVICE_PCI_GET_DIRTY_BITMAP _IO(VFIO_TYPE, VFIO_BASE + 15)
> 
> The first one is used to contorl the device running status, we want to
> stop the mdev device before quary the status from its device driver and
> restart the device after migration.
> The second one is used to do the mdev device dirty page synchronization.
> 
> So the vfio_mdev device migration sequence would be
> Source VM side:
> 			start migration
> 				|
> 				V
>         	 get the cpu state change callback
>         	use status set ioctl to stop the mdev device
> 				|
> 				V
> 		 save the deivce status into Qemufile which is 
>                  read from the new vfio device status region
> 				|
> 				V
> 		   quary the dirty page bitmap from deivce
> 		    and add into qemu dirty list for sync

That ordering is interesting; I think the main migration flow
is normally to complete migration of RAM and then migrate the
devices; so I worry about that order.

Dave

> Target VM side:
> 		   restore the mdev device after get the
> 		     saved status context from Qemufile
> 				|
> 				V
> 		     get the cpu state change callback
>  		     use status set ioctl to start the mdev 
> 		     device to put it in running status
> 				|
> 				V
> 			finish migration
> 
> Yulei Zhang (5):
>   vfio: introduce a new VFIO region for migration support
>   vfio: Add struct vfio_vmstate_info to introduce vfio device put/get
>     funtion
>   vfio: introduce new VFIO ioctl VFIO_DEVICE_PCI_STATUS_SET
>   vfio: use vfio_device_put/vfio_device_get for device status
>     save/restore
>   vifo: introduce new VFIO ioctl VFIO_DEVICE_PCI_GET_DIRTY_BITMAP
> 
>  hw/vfio/pci.c              | 204 ++++++++++++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci.h              |   3 +
>  linux-headers/linux/vfio.h |  34 +++++++-
>  3 files changed, 239 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
