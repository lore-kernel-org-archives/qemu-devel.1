Received: from eggs.gnu.org ([2001:4830:134:3::10]:34595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqB3-0005Jy-FL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqB2-00028k-3c
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:17:57 -0400
Date: Fri, 14 Jul 2017 10:17:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714021733.GA27284@pxdev.xzpeter.org>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<1496851287-9428-7-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1496851287-9428-7-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 6/8] virtio-iommu: Implement the
 translation and commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com, wei@redhat.com, kevin.tian@intel.com, bharat.bhushan@nxp.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org

On Wed, Jun 07, 2017 at 06:01:25PM +0200, Eric Auger wrote:
> This patch adds the actual implementation for the translation routine
> and the virtio-iommu commands.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

>  static int virtio_iommu_attach(VirtIOIOMMU *s,
>                                 struct virtio_iommu_req_attach *req)
> @@ -95,10 +135,34 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>      uint32_t asid = le32_to_cpu(req->address_space);
>      uint32_t devid = le32_to_cpu(req->device);
>      uint32_t reserved = le32_to_cpu(req->reserved);
> +    viommu_as *as;
> +    viommu_dev *dev;
>  
>      trace_virtio_iommu_attach(asid, devid, reserved);
>  
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
> +    if (dev) {
> +        return -1;
> +    }
> +
> +    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
> +    if (!as) {
> +        as = g_malloc0(sizeof(*as));
> +        as->id = asid;
> +        as->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
> +                                         NULL, NULL, (GDestroyNotify)g_free);
> +        g_tree_insert(s->address_spaces, GUINT_TO_POINTER(asid), as);
> +        trace_virtio_iommu_new_asid(asid);
> +    }
> +
> +    dev = g_malloc0(sizeof(*dev));
> +    dev->as = as;
> +    dev->id = devid;
> +    as->nr_devices++;
> +    trace_virtio_iommu_new_devid(devid);
> +    g_tree_insert(s->devices, GUINT_TO_POINTER(devid), dev);

Here do we need to record something like a refcount for address space?
Since...

> +
> +    return VIRTIO_IOMMU_S_OK;
>  }
>  
>  static int virtio_iommu_detach(VirtIOIOMMU *s,
> @@ -106,10 +170,13 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
>  {
>      uint32_t devid = le32_to_cpu(req->device);
>      uint32_t reserved = le32_to_cpu(req->reserved);
> +    int ret;
>  
>      trace_virtio_iommu_detach(devid, reserved);
>  
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    ret = g_tree_remove(s->devices, GUINT_TO_POINTER(devid));

... here when detach, imho we should check the refcount: if there is
no device using specific address space, we should release the address
space as well.

Otherwise there would have no way to destroy an address space?

> +
> +    return ret ? VIRTIO_IOMMU_S_OK : VIRTIO_IOMMU_S_INVAL;
>  }

[...]

>  static int virtio_iommu_unmap(VirtIOIOMMU *s,
> @@ -133,10 +227,64 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>      uint64_t virt_addr = le64_to_cpu(req->virt_addr);
>      uint64_t size = le64_to_cpu(req->size);
>      uint32_t flags = le32_to_cpu(req->flags);
> +    viommu_mapping *mapping;
> +    viommu_interval interval;
> +    viommu_as *as;
>  
>      trace_virtio_iommu_unmap(asid, virt_addr, size, flags);
>  
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
> +    if (!as) {
> +        error_report("%s: no as", __func__);
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +    interval.low = virt_addr;
> +    interval.high = virt_addr + size - 1;
> +
> +    mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
> +
> +    while (mapping) {
> +        viommu_interval current;
> +        uint64_t low  = mapping->virt_addr;
> +        uint64_t high = mapping->virt_addr + mapping->size - 1;
> +
> +        current.low = low;
> +        current.high = high;
> +
> +        if (low == interval.low && size >= mapping->size) {
> +            g_tree_remove(as->mappings, (gpointer)&current);
> +            interval.low = high + 1;
> +            trace_virtio_iommu_unmap_left_interval(current.low, current.high,
> +                interval.low, interval.high);
> +        } else if (high == interval.high && size >= mapping->size) {
> +            trace_virtio_iommu_unmap_right_interval(current.low, current.high,
> +                interval.low, interval.high);
> +            g_tree_remove(as->mappings, (gpointer)&current);
> +            interval.high = low - 1;
> +        } else if (low > interval.low && high < interval.high) {
> +            trace_virtio_iommu_unmap_inc_interval(current.low, current.high);
> +            g_tree_remove(as->mappings, (gpointer)&current);
> +        } else {
> +            break;
> +        }
> +        if (interval.low >= interval.high) {
> +            return VIRTIO_IOMMU_S_OK;
> +        } else {
> +            mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
> +        }
> +    }

IIUC for unmap here we are very strict - a extreme case is that when
an address space is just created (so no mapping inside), if we send
one UNMAP to a range, it'll fail currently, right? Should we loosen
it?

IMHO as long as we make sure all the mappings in the range of an UNMAP
request are destroyed, then we are good. I think at least both vfio
api and vt-d emuation have this assumption. But maybe I am wrong.
Please correct me if so.

> +
> +    if (mapping) {
> +        error_report("****** %s: Unmap 0x%"PRIx64" size=0x%"PRIx64
> +                     " from 0x%"PRIx64" size=0x%"PRIx64" is not supported",
> +                     __func__, interval.low, size,
> +                     mapping->virt_addr, mapping->size);
> +    } else {
> +        error_report("****** %s: no mapping for [0x%"PRIx64",0x%"PRIx64"]",
> +                     __func__, interval.low, interval.high);
> +    }
> +
> +    return VIRTIO_IOMMU_S_INVAL;
>  }

Thanks,

-- 
Peter Xu
