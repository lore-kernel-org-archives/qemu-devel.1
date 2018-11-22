Received: from eggs.gnu.org ([2001:4830:134:3::10]:33619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPu7U-0001oR-QM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPu7Q-0005lO-FB
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:54:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPu7Q-0005il-5r
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:54:28 -0500
Date: Thu, 22 Nov 2018 18:54:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181122185417.GE2605@work-vm>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<1542746383-18288-2-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542746383-18288-2-git-send-email-kwankhede@nvidia.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, qemu-devel@nongnu.org

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> - Defined MIGRATION region type and sub-type.
> - Defined VFIO device states during migration process.
> - Defined vfio_device_migration_info structure which will be placed at 0th
>   offset of migration region to get/set VFIO device related information.
>   Defined actions and members of structure usage for each action:
>     * To convey VFIO device state to be transitioned to.
>     * To get pending bytes yet to be migrated for VFIO device
>     * To ask driver to write data to migration region and return number of bytes
>       written in the region
>     * In migration resume path, user space app writes to migration region and
>       communicates it to vendor driver.
>     * Get bitmap of dirty pages from vendor driver from given start address
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>

<snip>

> + * Action Get buffer:
> + *      On this action, vendor driver should write data to migration region and
> + *      return number of bytes written in the region.
> + *      data.offset [output] : offset in the region from where data is written.
> + *      data.size [output] : number of bytes written in migration buffer by
> + *          vendor driver.

<snip>

> + */
> +
> +struct vfio_device_migration_info {
> +        __u32 device_state;         /* VFIO device state */
> +        struct {
> +            __u64 precopy_only;
> +            __u64 compatible;
> +            __u64 postcopy_only;
> +            __u64 threshold_size;
> +        } pending;
> +        struct {
> +            __u64 offset;           /* offset */
> +            __u64 size;             /* size */
> +        } data;

I'm curious how the offsets/size work; how does the 
kernel driver know the maximum size of state it's allowed to write?
Why would it pick a none-0 offset into the output region?

Without having dug further these feel like i/o rather than just output;
i.e. the calling process says 'put it at that offset and you've got size
bytes' and the kernel replies with 'I did put it at offset and I wrote
only this size bytes'

Dave

> +        struct {
> +            __u64 start_addr;
> +            __u64 total;
> +            __u64 copied;
> +        } dirty_pfns;
> +} __attribute__((packed));
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
