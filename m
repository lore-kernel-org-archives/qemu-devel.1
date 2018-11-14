Received: from eggs.gnu.org ([2001:4830:134:3::10]:35096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1gMxc7-0004Nx-5Q
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1gMxc5-0006KA-W7
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:01:59 -0500
References: <20181109112957.10067-1-eric.auger@redhat.com>
	<20181109112957.10067-11-eric.auger@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <993a3856-1192-4c05-8f81-68d68e421b20@arm.com>
Date: Wed, 14 Nov 2018 16:01:05 +0000
MIME-Version: 1.0
In-Reply-To: <20181109112957.10067-11-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v8 10/18] virtio-iommu: Implement probe
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>, "tn@semihalf.com" <tn@semihalf.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>

Hi Eric,

A few issues creeped in when the resv_mem structure changed

On 09/11/2018 11:29, Eric Auger wrote:
> +#define SUPPORTED_PROBE_PROPERTIES (\
> +    VIRTIO_IOMMU_PROBE_T_NONE | \
> +    VIRTIO_IOMMU_PROBE_T_RESV_MEM)

You might be missing "1 <<" here, since the properties types are normal
values

[...]
> +/**
> + * virtio_iommu_fill_resv_mem_prop - Add a RESV_MEM probe
> + * property into the probe request buffer
> + *
> + * @key: interval handle
> + * @value: handle to the reserved memory region
> + * @data: handle to the probe request buffer state
> + */
> +static gboolean virtio_iommu_fill_resv_mem_prop(gpointer key,
> +                                                gpointer value,
> +                                                gpointer data)
> +{
> +    struct virtio_iommu_probe_resv_mem *resv =
> +        (struct virtio_iommu_probe_resv_mem *)value;
> +    struct virtio_iommu_probe_property *prop;
> +    struct virtio_iommu_probe_resv_mem *current;
> +    viommu_property_buffer *bufstate = (viommu_property_buffer *)data;
> +    size_t size = sizeof(*resv), total_size;
> +    uint8_t *prop_value;
> +
> +    total_size = size + sizeof(*prop);

size already contains sizeof(*prop)

> +
> +    if (bufstate->filled + total_size >= VIOMMU_PROBE_SIZE) {
> +        bufstate->error = true;
> +        /* get the traversal stopped by returning true */
> +        return true;
> +    }
> +    prop = (struct virtio_iommu_probe_property *)
> +                (bufstate->start + bufstate->filled);
> +    prop->type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM) &
> +                    VIRTIO_IOMMU_PROBE_T_MASK;
> +    prop->length = cpu_to_le16(size);

Should be size-4

> +
> +    prop_value = (uint8_t *)prop + 4;
> +    current = (struct virtio_iommu_probe_resv_mem *)prop_value;
> +    *current = *resv;

*resv includes the property header, but *current doesn't, so the resv
property is corrupted.

Thanks,
Jean
