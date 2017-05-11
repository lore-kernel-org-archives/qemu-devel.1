Received: from eggs.gnu.org ([2001:4830:134:3::10]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d982Q-0006lq-Qd
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d982M-0002i0-46
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:43:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:41497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d982L-0002h6-SL
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:43:06 -0400
Date: Thu, 11 May 2017 18:29:02 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170511102902.GD2931@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
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
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, ashok.raj@intel.com, jean-philippe.brucker@arm.com, jasowang@redhat.com, qemu-devel@nongnu.org, jacob.jun.pan@intel.com

On Wed, Apr 26, 2017 at 06:12:02PM +0800, Liu, Yi L wrote:
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

Hi Alex,

In this patchset, I'm trying to add two new IOCTL cmd for Shared
Virtual Memory virtualization. One for binding guest PASID Table
and one for iommu tlb invalidation from guest. ARM has similar
requirement on SVM supporting. Since it touched VFIO, I'd like
to know your comments on changes in VFIO.

Thanks,
Yi L

> This patch adds VFIO_IOMMU_SVM_BIND_TASK for potential PASID table
> binding requests.
> 
> On VT-d, this IOCTL cmd would be used to link the guest PASID page table
> to host. While for other vendors, it may also be used to support other
> kind of SVM bind request. Previously, there is a discussion on it with
> ARM engineer. It can be found by the link below. This IOCTL cmd may
> support SVM PASID bind request from userspace driver, or page table(cr3)
> bind request from guest. These SVM bind requests would be supported by
> adding different flags. e.g. VFIO_SVM_BIND_PASID is added to support
> PASID bind from userspace driver, VFIO_SVM_BIND_PGTABLE is added to
> support page table bind from guest.
> 
> https://patchwork.kernel.org/patch/9594231/
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  include/uapi/linux/vfio.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 519eff3..6b97987 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -547,6 +547,23 @@ struct vfio_iommu_type1_dma_unmap {
>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/* IOCTL for Shared Virtual Memory Bind */
> +struct vfio_device_svm {
> +	__u32	argsz;
> +#define VFIO_SVM_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
> +#define VFIO_SVM_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver */
> +#define VFIO_SVM_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
> +	__u32	flags;
> +	__u32	length;
> +	__u8	data[];
> +};
> +
> +#define VFIO_SVM_TYPE_MASK	(VFIO_SVM_BIND_PASIDTBL | \
> +				VFIO_SVM_BIND_PASID | \
> +				VFIO_SVM_BIND_PGTABLE)
> +
> +#define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
> -- 
> 1.9.1
> 
> 
