Received: from eggs.gnu.org ([2001:4830:134:3::10]:35208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1gMxcH-0004XP-NR
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1gMxc5-0006Jw-UI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:02:07 -0500
References: <20181109112957.10067-1-eric.auger@redhat.com>
	<20181109112957.10067-12-eric.auger@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e1ce4892-a405-6e0e-764d-965b18fc942d@arm.com>
Date: Wed, 14 Nov 2018 16:01:18 +0000
MIME-Version: 1.0
In-Reply-To: <20181109112957.10067-12-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v8 11/18] virtio-iommu: Add an msi_bypass
 property
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

On 09/11/2018 11:29, Eric Auger wrote:
> +static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
> +                                              uint8_t subtype,
> +                                              uint64_t start, uint64_t end)
> +{
> +    viommu_interval *interval;
> +    struct virtio_iommu_probe_resv_mem *reg;
> +
> +    interval = g_malloc0(sizeof(*interval));
> +    interval->low = start;
> +    interval->high = end;
> +
> +    reg = g_malloc0(sizeof(*reg));
> +    reg->subtype = subtype;
> +    reg->start = cpu_to_le64(start);
> +    reg->end = cpu_to_le64(end);
> +
> +    g_tree_insert(ep->reserved_regions, interval, reg);
> +}
> +
>  static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>                                                    uint32_t ep_id)
>  {
> @@ -120,6 +142,12 @@ static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>      ep->reserved_regions = g_tree_new_full((GCompareDataFunc)interval_cmp,
>                                              NULL, (GDestroyNotify)g_free,
>                                              (GDestroyNotify)g_free);
> +    if (s->msi_bypass) {
> +        virtio_iommu_register_resv_region(ep, VIRTIO_IOMMU_RESV_MEM_T_MSI,
> +                                          IOAPIC_RANGE_START,
> +                                          IOAPIC_RANGE_SIZE);

The last argument of register_resv_region is 'end' but you're passing a size

Thanks,
Jean
