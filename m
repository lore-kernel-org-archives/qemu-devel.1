Received: from eggs.gnu.org ([2001:4830:134:3::10]:33879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1esplq-0006c1-P9
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1espln-0004Ej-IE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:03:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1espln-0004BZ-9d
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:03:11 -0500
References: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <077d834a-b32b-8ab0-d2b5-264d4eefbc70@nvidia.com>
Date: Mon, 5 Mar 2018 18:32:56 +0530
MIME-Version: 1.0
In-Reply-To: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Yulei Zhang <yulei.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, zhenyuw@linux.intel.com, alex.williamson@redhat.com

Hi Yulei Zhang,

This series is same as the previous version, that is, there is no
pre-copy phase. This only takes care of stop-and-copy phase.
As per we discussed in KVM Forum 2017 in October, there should be
provision of pre-copy phase.

Thanks,
Kirti

On 3/5/2018 11:30 AM, Yulei Zhang wrote:
> Summary
> 
> This series RFC would like to resume the discussion about how to
> introduce the live migration capability to vfio mdev device. 
> 
> By adding a new vfio subtype region VFIO_REGION_SUBTYPE_DEVICE_STATE,
> the mdev device will be set to migratable if the new region exist
> during the initialization.  
> 
> The intention to add the new region is using it for mdev device status
> save and restore during the migration. The access to this region
> will be trapped and forward to the mdev device driver, it also uses 
> the first byte in the new region to control the running state of mdev
> device, so during the migration after stop the mdev driver, qemu could
> retrieve the specific device status from this region and transfer to 
> the target VM side for the mdev device restore.
> 
> In addition,  we add one new ioctl VFIO_IOMMU_GET_DIRTY_BITMAP to help do 
> the mdev device dirty page synchronization during the migration, currently
> it is just for static copy, in the future we would like to add new interface
> for the pre-copy.
> 
> Below is the vfio_mdev device migration sequence
> Source VM side:
> 			start migration
> 				|
> 				V
>         	 get the cpu state change callback, write to the
>         	 subregion's first byte to stop the mdev device
> 				|
> 				V
> 		 quary the dirty page bitmap from iommu container 
> 		 and add into qemu dirty list for synchronization
> 				|
> 				V
> 		 save the deivce status into Qemufile which is 
>                      read from the vfio device subregion
> 
> Target VM side:
> 		   restore the mdev device after get the
> 		     saved status context from Qemufile
> 				|
> 				V
> 		     get the cpu state change callback
>  		     write to subregion's first byte to 
>                       start the mdev device to put it in 
>                       running status
> 				|
> 				V
> 			finish migration
> 
> V3->V2:
> 1. rebase the patch to Qemu stable 2.10 branch.
> 2. use a common name for the subregion instead of specific for 
>    intel IGD.
> 
> V1->V2:
> Per Alex's suggestion:
> 1. use device subtype region instead of VFIO PCI fixed region.
> 2. remove unnecessary ioctl, use the first byte of subregion to 
>    control the running state of mdev device.  
> 3. for dirty page synchronization, implement the interface with
>    VFIOContainer instead of vfio pci device.
> 
> Yulei Zhang (4):
>   vfio: introduce a new VFIO subregion for mdev device migration support
>   vfio: Add vm status change callback to stop/restart the mdev device
>   vfio: Add struct vfio_vmstate_info to introduce put/get callback
>     funtion for vfio device status save/restore
>   vifo: introduce new VFIO ioctl VFIO_IOMMU_GET_DIRTY_BITMAP
> 
>  hw/vfio/common.c              |  34 +++++++++
>  hw/vfio/pci.c                 | 171 +++++++++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci.h                 |   1 +
>  include/hw/vfio/vfio-common.h |   1 +
>  linux-headers/linux/vfio.h    |  29 ++++++-
>  5 files changed, 232 insertions(+), 4 deletions(-)
> 
