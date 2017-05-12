Received: from eggs.gnu.org ([2001:4830:134:3::10]:33600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9IaP-0004Yn-8i
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9IaO-00061V-6p
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:58:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d9IaN-000601-UY
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:58:56 -0400
Date: Fri, 12 May 2017 15:58:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170512155851.627409ed@t450s.home>
In-Reply-To: <1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

On Wed, 26 Apr 2017 18:12:02 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
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

In the case of VFIO_SVM_BIND_PASIDTBL this is clearly struct
pasid_table_info?  So at a minimum this is a union including struct
pasid_table_info.  Furthermore how does a user learn what the opaque
data in struct pasid_table_info is without looking at the code?  A user
API needs to be clear and documented, not opaque and variable.  We
should also have references to the hardware spec for an Intel or ARM
PASID table in uapi.  flags should be defined as they're used, let's
not reserve them with the expectation of future use.

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
