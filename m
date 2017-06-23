Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dOR8y-0001oB-Ch
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dOR8x-0001ku-C5
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:09:12 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<1496851287-9428-4-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB25454D8F945071D6AC96749D9AC90@AM5PR0401MB2545.eurprd04.prod.outlook.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <70e2df1c-573b-2ba0-70ca-77b166a81863@arm.com>
Date: Fri, 23 Jun 2017 17:08:58 +0100
MIME-Version: 1.0
In-Reply-To: <AM5PR0401MB25454D8F945071D6AC96749D9AC90@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 3/8] virtio_iommu: add skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>

On 06/08/2017 12:09 PM, Bharat Bhushan wrote:
>> From: Eric Auger [mailto:eric.auger@redhat.com]
>> Sent: Wednesday, June 07, 2017 9:31 PM
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
>> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
>> qemu-arm@nongnu.org; qemu-devel@nongnu.org; jean-
>> philippe.brucker@arm.com
>> Cc: will.deacon@arm.com; robin.murphy@arm.com; kevin.tian@intel.com;
>> marc.zyngier@arm.com; christoffer.dall@linaro.org; drjones@redhat.com;
>> wei@redhat.com; tn@semihalf.com; Bharat Bhushan
>> <bharat.bhushan@nxp.com>
>> Subject: [RFC v2 3/8] virtio_iommu: add skeleton
>>
>> This patchs adds the skeleton for the virtio-iommu device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> +static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
>> +
>> +    virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
>> +                sizeof(struct virtio_iommu_config));
>> +
>> +    s->vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
>> +                             virtio_iommu_handle_command);
>> +
>> +    s->config.page_sizes = ~((1ULL << 12) - 1);
> 
> This is hardcoded to 4K, Should this be aligned to Host-page size ?

I wonder if we should introduce per-address-space page sizes, to cater
for emulated and VFIO devices being managed by the same IOMMU.

For an emulated device, it seems that the page granularity can be
arbitrary, so maybe TARGET_PAGE_MASK would be more convenient. But for
VFIO, the page granularity is a property of the physical IOMMU.

In kvmtool I instantiate two virtio-iommus for vfio and virtio devices,
so the page size issue hasn't come up, but here things won't work if the
page granularity advertised in config.page_sizes is smaller than the
pIOMMU page size.

Adding address space properties is tricky because they change when
attaching devices, and I wanted to avoid this complication. In nested
mode I have to add one AS state, where the AS is active and properties
are freezed (attaching an incompatible device is then rejected). Maybe
we need to do the same for map/unmap.

A simpler solution (for me, that is), would be to put the greatest page
granularity of all VFIO devices into page_sizes, but it doesn't take
hotplug into account.

Thanks,
Jean
