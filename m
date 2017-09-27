Received: from eggs.gnu.org ([2001:4830:134:3::10]:39944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxEST-00006y-0h
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxESS-0005Bb-1y
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:41:09 -0400
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
	<1505807208-9063-11-git-send-email-eric.auger@redhat.com>
	<4cecfa75-c97a-586b-aadf-9b0bfd168960@caviumnetworks.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3213d48c-c2ec-5728-bc39-d46c60c4e028@redhat.com>
Date: Wed, 27 Sep 2017 17:40:43 +0200
MIME-Version: 1.0
In-Reply-To: <4cecfa75-c97a-586b-aadf-9b0bfd168960@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 10/16] virtio-iommu: Implement probe
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomasz Nowicki <tnowicki@caviumnetworks.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, will.deacon@arm.com, drjones@redhat.com, peterx@redhat.com, linuc.decode@gmail.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org

Hi Tomasz,
On 27/09/2017 12:53, Tomasz Nowicki wrote:
> Hi Eric,
> 
> On 19.09.2017 09:46, Eric Auger wrote:
>> This patch implements the PROBE request. At the moment,
>> no reserved regions are returned.
>>
>> At the moment reserved regions are stored per device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
> 
> [...]
> 
>> +
>> +static int virtio_iommu_fill_property(int devid, int type,
>> +                                      viommu_property_buffer *bufstate)
>> +{
>> +    int ret = -ENOSPC;
>> +
>> +    if (bufstate->filled + 4 >= VIOMMU_PROBE_SIZE) {
>> +        bufstate->error = true;
>> +        goto out;
>> +    }
>> +
>> +    switch (type) {
>> +    case VIRTIO_IOMMU_PROBE_T_NONE:
>> +        ret = virtio_iommu_fill_none_prop(bufstate);
>> +        break;
>> +    case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
>> +    {
>> +        viommu_dev *dev = bufstate->dev;
>> +
>> +        g_tree_foreach(dev->reserved_regions,
>> +                       virtio_iommu_fill_resv_mem_prop,
>> +                       bufstate);
>> +        if (!bufstate->error) {
>> +            ret = 0;
>> +        }
>> +        break;
>> +    }
>> +    default:
>> +        ret = -ENOENT;
>> +        break;
>> +    }
>> +out:
>> +    if (ret) {
>> +        error_report("%s property of type=%d could not be filled (%d),"
>> +                     " remaining size = 0x%lx",
>> +                     __func__, type, ret, bufstate->filled);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static int virtio_iommu_probe(VirtIOIOMMU *s,
>> +                              struct virtio_iommu_req_probe *req,
>> +                              uint8_t *buf)
>> +{
>> +    uint32_t devid = le32_to_cpu(req->device);
>> +    int16_t prop_types = SUPPORTED_PROBE_PROPERTIES, type;
>> +    viommu_property_buffer bufstate;
>> +    viommu_dev *dev;
>> +    int ret;
>> +
>> +    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
>> +    if (!dev) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    bufstate.start = buf;
>> +    bufstate.filled = 0;
>> +    bufstate.dev = dev;
> 
> bufstate.error is not initialized which may cause false alarm in
> virtio_iommu_fill_property()
thanks for spotting that. I owe you several fixes in both vsmmuv3 and
virtio-iommu. Thank you for testing, again!

Best Regards

Eric
> 
>> +
>> +    while ((type = ctz32(prop_types)) != 32) {
>> +        ret = virtio_iommu_fill_property(devid, 1 << type, &bufstate);
>> +        if (ret) {
>> +            break;
>> +        }
>> +        prop_types &= ~(1 << type);
>> +    }
>> +    virtio_iommu_fill_property(devid, VIRTIO_IOMMU_PROBE_T_NONE,
>> &bufstate);
>> +
>> +    return VIRTIO_IOMMU_S_OK;
>> +}
>> +
>>   #define get_payload_size(req) (\
>>   sizeof((req)) - sizeof(struct virtio_iommu_req_tail))
>>   @@ -433,6 +567,24 @@ static int
>> virtio_iommu_handle_unmap(VirtIOIOMMU *s,
>>       return virtio_iommu_unmap(s, &req);
>>   }
> 
> Thanks,
> Tomasz
> 
