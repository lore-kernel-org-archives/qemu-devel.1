Received: from eggs.gnu.org ([2001:4830:134:3::10]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9IaK-0004Wu-8H
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9IaI-0005tt-ON
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:58:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d9IaI-0005sS-Ib
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:58:50 -0400
Date: Fri, 12 May 2017 15:58:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170512155843.5abeb4bd@t450s.home>
In-Reply-To: <1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
 invalidate propagation
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

On Wed, 26 Apr 2017 18:12:04 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> This patch adds VFIO_IOMMU_TLB_INVALIDATE to propagate IOMMU TLB
> invalidate request from guest to host.
> 
> In the case of SVM virtualization on VT-d, host IOMMU driver has
> no knowledge of caching structure updates unless the guest
> invalidation activities are passed down to the host. So a new
> IOCTL is needed to propagate the guest cache invalidation through
> VFIO.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  include/uapi/linux/vfio.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 6b97987..50c51f8 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -564,6 +564,15 @@ struct vfio_device_svm {
>  
>  #define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
>  
> +/* For IOMMU TLB Invalidation Propagation */
> +struct vfio_iommu_tlb_invalidate {
> +	__u32	argsz;
> +	__u32	length;
> +	__u8	data[];
> +};
> +
> +#define VFIO_IOMMU_TLB_INVALIDATE	_IO(VFIO_TYPE, VFIO_BASE + 23)

I'm kind of wondering why this isn't just a new flag bit on
vfio_device_svm, the data structure is so similar.  Of course data
needs to be fully specified in uapi.

> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
