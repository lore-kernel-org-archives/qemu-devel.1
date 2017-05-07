Received: from eggs.gnu.org ([2001:4830:134:3::10]:37780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d7dOv-0006VC-0g
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d7dOr-00082t-RV
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:48:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:64536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d7dOr-0007lR-Gg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:48:09 -0400
Date: Sun, 7 May 2017 15:33:42 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170507073342.GA2931@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<3a67fc54-905a-b7f8-2eb5-1d75a89c2335@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a67fc54-905a-b7f8-2eb5-1d75a89c2335@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] Shared Virtual Memory
 virtualization for VT-d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, ashok.raj@intel.com, jean-philippe.brucker@arm.com, jasowang@redhat.com, qemu-devel@nongnu.org, jacob.jun.pan@intel.com

On Mon, May 08, 2017 at 12:09:42PM +0800, Xiao Guangrong wrote:
> 
> Hi Liu Yi,
> 
> I haven't started to read the code yet, however, could you
> detail more please? It emulates a SVM capable iommu device in
> a VM? Or It speeds up device's DMA access in a VM? Or it is a
> new facility introduced for a VM? Could you please add a bit
> more for its usage?

Hi Guangrong,

Nice to hear from you.

This patchset is part of the whole SVM virtualization work. The whole
patchset wants to expose a SVM capable Intel IOMMU to guest. And yes,
it is an emulated iommu.

For the detail introduction for SVM and SVM virtualization, I think
you may get more from the link below.

http://www.spinics.net/lists/kvm/msg148798.html

For the usage, I can give an example with IGD. Latest IGD is SVM capable
device. On bare metal(Intel IOMMU is also SVM capable), application could
request to share its virtual address(an allocated buffer) with IGD device
through the IOCTL cmd provided by IGD driver. e.g. OpenCL application. When
IGD is assigned to a guest, it is expected to support such usage in guest.
With the SVM virtualization patchset, the application in guest would also
be able to share its virtual address with IGD device. Different from bare
metal, it's sharing GVA with IGD. The hardware IOMMU needs to help translate
the GVA to HPA. So hardware IOMMU needs to know the GVA->HPA mapping. This
patchset would make sure the GVA->HPA mapping is built and maintain the TLB.

Be free to let me know if you want more detail.

Thanks,
Yi L

> 
> Thanks!
> 
> On 04/26/2017 06:11 PM, Liu, Yi L wrote:
> >Hi,
> >
> >This patchset introduces SVM virtualization for intel_iommu in
> >IOMMU/VFIO. The total SVM virtualization for intel_iommu touched
> >Qemu/IOMMU/VFIO.
> >
> >Another patchset would change the Qemu. It is "[RFC PATCH 0/20] Qemu:
> >Extend intel_iommu emulator to support Shared Virtual Memory"
> >
> >In this patchset, it adds two new IOMMU APIs and their implementation
> >in intel_iommu driver. In VFIO, it adds two IOCTL cmd attached on
> >container->fd to propagate data from QEMU to kernel space.
> >
> >[Patch Overview]
> >* 1 adds iommu API definition for binding guest PASID table
> >* 2 adds binding PASID table API implementation in VT-d iommu driver
> >* 3 adds iommu API definition to do IOMMU TLB invalidation from guest
> >* 4 adds IOMMU TLB invalidation implementation in VT-d iommu driver
> >* 5 adds VFIO IOCTL for propagating PASID table binding from guest
> >* 6 adds processing of pasid table binding in vfio_iommu_type1
> >* 7 adds VFIO IOCTL for propagating IOMMU TLB invalidation from guest
> >* 8 adds processing of IOMMU TLB invalidation in vfio_iommu_type1
> >
> >Best Wishes,
> >Yi L
> >
> >
> >Jacob Pan (3):
> >   iommu: Introduce bind_pasid_table API function
> >   iommu/vt-d: add bind_pasid_table function
> >   iommu/vt-d: Add iommu do invalidate function
> >
> >Liu, Yi L (5):
> >   iommu: Introduce iommu do invalidate API function
> >   VFIO: Add new IOTCL for PASID Table bind propagation
> >   VFIO: do pasid table binding
> >   VFIO: Add new IOCTL for IOMMU TLB invalidate propagation
> >   VFIO: do IOMMU TLB invalidation from guest
> >
> >  drivers/iommu/intel-iommu.c     | 146 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/iommu.c           |  32 +++++++++
> >  drivers/vfio/vfio_iommu_type1.c |  98 +++++++++++++++++++++++++++
> >  include/linux/dma_remapping.h   |   1 +
> >  include/linux/intel-iommu.h     |  11 +++
> >  include/linux/iommu.h           |  47 +++++++++++++
> >  include/uapi/linux/vfio.h       |  26 +++++++
> >  7 files changed, 361 insertions(+)
> >
> 
