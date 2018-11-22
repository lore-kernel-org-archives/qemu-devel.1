Received: from eggs.gnu.org ([2001:4830:134:3::10]:53661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPvFE-0005UF-3Q
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPv9s-0006OE-Da
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:01:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPv9r-0006K4-0K
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:01:04 -0500
Date: Thu, 22 Nov 2018 20:00:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181122200039.GG2605@work-vm>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<1542746383-18288-5-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542746383-18288-5-git-send-email-kwankhede@nvidia.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] Add vfio_listerner_log_sync to mark
 dirty pages
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
> vfio_listerner_log_sync gets list of dirty pages from vendor driver and mark
> those pages dirty.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fb396cf00ac4..338aad7426f0 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -697,9 +697,41 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  }
>  
> +static void vfio_listerner_log_sync(MemoryListener *listener,
> +                                    MemoryRegionSection *section)
> +{
> +    uint64_t start_addr, size, pfn_count;
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            switch (vbasedev->device_state) {
> +            case VFIO_DEVICE_STATE_MIGRATION_PRECOPY:
> +            case VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY:
> +                    continue;
> +
> +            default:
> +                    return;
> +            }
> +        }
> +    }

Is that big loop just trying to find devices not in migration?
Some comments would be good.

Dave

> +    start_addr = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +    size = int128_get64(section->size);
> +    pfn_count = size >> TARGET_PAGE_BITS;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            vfio_get_dirty_page_list(vbasedev, start_addr, pfn_count);
> +        }
> +    }
> +}
> +
>  static const MemoryListener vfio_memory_listener = {
>      .region_add = vfio_listener_region_add,
>      .region_del = vfio_listener_region_del,
> +    .log_sync = vfio_listerner_log_sync,
>  };
>  
>  static void vfio_listener_release(VFIOContainer *container)
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
