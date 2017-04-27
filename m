Received: from eggs.gnu.org ([2001:4830:134:3::10]:34843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3cSl-0007zk-45
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3cSg-0000sL-9M
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:59:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:36239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3cSg-0000qt-12
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:59:30 -0400
Date: Thu, 27 Apr 2017 13:43:32 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170427054332.GB14925@sky-dev>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
	<e8927c18-148f-4dbd-28f9-1a8805a98e05@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8927c18-148f-4dbd-28f9-1a8805a98e05@arm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 5/8] VFIO: Add new IOTCL for PASID
 Table bind propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, ashok.raj@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org, jacob.jun.pan@intel.com

On Wed, Apr 26, 2017 at 05:56:50PM +0100, Jean-Philippe Brucker wrote:
> On 26/04/17 11:12, Liu, Yi L wrote:
> > From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> > 
> > This patch adds VFIO_IOMMU_SVM_BIND_TASK for potential PASID table
> > binding requests.
> > 
> > On VT-d, this IOCTL cmd would be used to link the guest PASID page table
> > to host. While for other vendors, it may also be used to support other
> > kind of SVM bind request. Previously, there is a discussion on it with
> > ARM engineer. It can be found by the link below. This IOCTL cmd may
> > support SVM PASID bind request from userspace driver, or page table(cr3)
> > bind request from guest. These SVM bind requests would be supported by
> > adding different flags. e.g. VFIO_SVM_BIND_PASID is added to support
> > PASID bind from userspace driver, VFIO_SVM_BIND_PGTABLE is added to
> > support page table bind from guest.
> > 
> > https://patchwork.kernel.org/patch/9594231/
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  include/uapi/linux/vfio.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 519eff3..6b97987 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -547,6 +547,23 @@ struct vfio_iommu_type1_dma_unmap {
> >  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
> >  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
> >  
> > +/* IOCTL for Shared Virtual Memory Bind */
> > +struct vfio_device_svm {
> > +	__u32	argsz;
> > +#define VFIO_SVM_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
> > +#define VFIO_SVM_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver */
> > +#define VFIO_SVM_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
> > +	__u32	flags;
> > +	__u32	length;
> > +	__u8	data[];
> > +};
> > +
> > +#define VFIO_SVM_TYPE_MASK	(VFIO_SVM_BIND_PASIDTBL | \
> > +				VFIO_SVM_BIND_PASID | \
> > +				VFIO_SVM_BIND_PGTABLE)
> > +
> > +#define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> 
> This could be called "VFIO_IOMMU_SVM_BIND, since it will be used both to
> bind tables and individual tasks.

yes, it is. would modify it in next version.

Thanks,
Yi L 
> Thanks,
> Jean
> 
