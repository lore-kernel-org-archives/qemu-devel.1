Received: from eggs.gnu.org ([2001:4830:134:3::10]:55325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU7xm-00053F-D4
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU7xj-0008IV-8y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cU7xj-0008IL-2b
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:51 -0500
Date: Thu, 19 Jan 2017 16:20:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170119082044.GE4914@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-14-git-send-email-peterx@redhat.com>
	<20170116125357.31b7ef82@t450s.home>
	<20170117140000.GN30108@pxdev.xzpeter.org>
	<20170117084604.2b1f5e50@t450s.home>
	<20170118074944.GR30108@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170118074944.GR30108@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH RFC v3 13/14] intel_iommu: allow dynamic
 switch of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com

On Wed, Jan 18, 2017 at 03:49:44PM +0800, Peter Xu wrote:

[...]

> I was trying to invalidate the entire address space by sending a big
> IOTLB notification to vfio-pci, which looks like:
> 
>   IOMMUTLBEntry entry = {
>       .target_as = &address_space_memory,
>       .iova = 0,
>       .translated_addr = 0,
>       .addr_mask = (1 << 63) - 1,
>       .perm = IOMMU_NONE,     /* UNMAP */
>   };
> 
> Then I feed this entry to vfio-pci IOMMU notifier.
> 
> However, this was blocked in vfio_iommu_map_notify(), with error:
> 
>   qemu-system-x86_64: iommu has granularity incompatible with target AS
> 
> Since we have:
> 
>   /*
>    * The IOMMU TLB entry we have just covers translation through
>    * this IOMMU to its immediate target.  We need to translate
>    * it the rest of the way through to memory.
>    */
>   rcu_read_lock();
>   mr = address_space_translate(&address_space_memory,
>                                iotlb->translated_addr,
>                                &xlat, &len, iotlb->perm & IOMMU_WO);
>   if (!memory_region_is_ram(mr)) {
>       error_report("iommu map to non memory area %"HWADDR_PRIx"",
>                    xlat);
>       goto out;
>   }
>   /*
>    * Translation truncates length to the IOMMU page size,
>    * check that it did not truncate too much.
>    */
>   if (len & iotlb->addr_mask) {
>       error_report("iommu has granularity incompatible with target AS");
>       goto out;
>   }
> 
> In my case len == 0xa0000 (that's the translation result), and
> iotlb->addr_mask == (1<<63)-1. So looks like the translation above
> splitted the big region and a simple big UNMAP doesn't work for me.
> 
> Do you have any suggestion on how I can solve this? In what case will
> we need the above address_space_translate()?

Hmm... it should be checking that the translated address range is RAM.

However if with this, IOMMU notifiers won't be able to leverage the
vfio driver feature to unmap a very big region.

IMHO the check should only be meaningful for map operations. I'll try
to post a RFC patch for vfio-pci to allow unmap of very big regions,
to see whether that'll be a workable approach.

Thanks,

-- peterx
