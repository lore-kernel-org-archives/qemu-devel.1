Received: from eggs.gnu.org ([2001:4830:134:3::10]:33496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dVFIV-0006YB-3B
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dVFIT-0002gZ-FS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:55:11 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<HE1PR0401MB255696A487DFEB2B8972980F9AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<e9ea564a-f02b-0ed5-e700-b7b1dfd89722@arm.com>
	<AM5PR0401MB25459345E9533FFC3BBE00289AD50@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<15b631c8-5708-1426-90a2-9be51a796614@redhat.com>
	<AM5PR0401MB2545C23F66D6D0E096DCB0369AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<a67cb139-e1b6-02fc-d451-4001bcbfceb3@redhat.com>
	<AM5PR0401MB2545A78764598CD87827B14F9AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<615e22ce-80b3-b000-360f-7272a867cdf9@arm.com>
	<AM5PR0401MB2545F60CA898D23D5E2F1E6D9AAE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<9cdd8947-2c8a-4106-1a1a-56c2238843d6@arm.com>
	<AM5PR0401MB25457988FA1531A684FF0DC09AAF0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<659fc660-9f3b-7ef4-a041-8ba6d49e8345@arm.com>
	<HE1PR0401MB25560018AA040A0B6A97BF599AAF0@HE1PR0401MB2556.eurprd04.prod.outlook.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <8eba46e3-996f-9eb9-5414-75cfc3fdc45d@arm.com>
Date: Wed, 12 Jul 2017 11:58:00 +0100
MIME-Version: 1.0
In-Reply-To: <HE1PR0401MB25560018AA040A0B6A97BF599AAF0@HE1PR0401MB2556.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wei@redhat.com" <wei@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On 12/07/17 11:27, Bharat Bhushan wrote:
> 
> 
>> -----Original Message-----
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Wednesday, July 12, 2017 3:48 PM
>> To: Bharat Bhushan <bharat.bhushan@nxp.com>; Auger Eric
>> <eric.auger@redhat.com>; eric.auger.pro@gmail.com;
>> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
>> qemu-arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: wei@redhat.com; kevin.tian@intel.com; marc.zyngier@arm.com;
>> tn@semihalf.com; will.deacon@arm.com; drjones@redhat.com;
>> robin.murphy@arm.com; christoffer.dall@linaro.org
>> Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
>>
>> On 12/07/17 04:50, Bharat Bhushan wrote:
>> [...]
>>>> The size of the virtio_iommu_req_probe structure is variable, and
>> depends
>>>> what fields the device implements. So the device initially computes the
>> size it
>>>> needs to fill virtio_iommu_req_probe, describes it in probe_size, and the
>>>> driver allocates that many bytes for virtio_iommu_req_probe.content[]
>>>>
>>>>>> * When device offers VIRTIO_IOMMU_F_PROBE, the driver should
>> send
>>>> an
>>>>>> VIRTIO_IOMMU_T_PROBE request for each new endpoint.
>>>>>> * The driver allocates a device-writeable buffer of probe_size (plus
>>>>>> framing) and sends it as a VIRTIO_IOMMU_T_PROBE request.
>>>>>> * The device fills the buffer with various information.
>>>>>>
>>>>>> struct virtio_iommu_req_probe {
>>>>>> 	/* device-readable */
>>>>>> 	struct virtio_iommu_req_head head;
>>>>>> 	le32 device;
>>>>>> 	le32 flags;
>>>>>>
>>>>>> 	/* maybe also le32 content_size, but it must be equal to
>>>>>> 	   probe_size */
>>>>>
>>>>> Can you please describe why we need to pass size of "probe_size" in
>> probe
>>>> request?
>>>>
>>>> We don't. I don't think we should add this 'content_size' field unless there
>> is
>>>> a compelling reason to do so.
>>>>
>>>>>>
>>>>>> 	/* device-writeable */
>>>>>> 	u8 content[];
>>>>>
>>>>> I assume content_size above is the size of array "content[]" and max
>> value
>>>> can be equal to probe_size advertised by device?
>>>>
>>>> probe_size is exactly the size of array content[]. The driver must allocate a
>>>> buffer of this size (plus the space needed for head, device, flags and tail).
>>>>
>>>> Then the device is free to leave parts of content[] empty. Field 'type' 0 will
>> be
>>>> reserved and mark the end of the array.
>>>>
>>>>>> 	struct virtio_iommu_req_tail tail;
>>>>>> };
>>>>>>
>>>>>> I'm still struggling with the content and layout of the probe
>>>>>> request, and would appreciate any feedback. To be easily extended, I
>>>>>> think it should contain a list of fields of variable size:
>>>>>>
>>>>>> 	|0           15|16           31|32               N|
>>>>>> 	|     type     |    length     |      values      |
>>>>>>
>>>>>> 'length' might be made optional if it can be deduced from type, but
>>>>>> might make driver-side parsing more robust.
>>>>>>
>>>>>> The probe could either be done for each endpoint, or for each address
>>>>>> space. I much prefer endpoint because it is the smallest granularity.
>>>>>> The driver can then decide what endpoints to put together in the same
>>>>>> address space based on their individual capabilities. The
>>>>>> specification would described how each endpoint property is combined
>>>>>> when endpoints are put in the same address space. For example, take
>>>>>> the minimum of all PASID size, the maximum of all page granularities,
>>>>>> combine doorbell addresses, etc.
>>>>>>
>>>>>> If we did the probe on address spaces instead, the driver would have
>>>>>> to re-send a probe request each time a new endpoint is attached to an
>>>>>> existing address space, to see if it is still capable of page table
>>>>>> handover or if the driver just combined a VFIO and an emulated
>>>>>> endpoint by accident.
>>>>>>
>>>>>>                                  ***
>>>>>>
>>>>>> Using this framework, the device can declare doorbell regions by
>>>>>> adding one or more RESV fields into the probe buffer:
>>>>>>
>>>>>> /* 'type' */
>>>>>> #define VIRTIO_IOMMU_PROBE_T_RESV 	0x1
>>>>>>
>>>>>> /* 'values'. 'length' is sizeof(struct virtio_iommu_probe_resv) */
>>>>>> struct virtio_iommu_probe_resv {
>>>>>> 	le64 gpa;
>>>>>> 	le64 size;
>>>>>>
>>>>>> #define VIRTIO_IOMMU_PROBE_RESV_MSI	0x1
>>>>>> 	u8 type;
>>>
>>> To be sure I am understanding it correctly, Is this "type" in struct
>> virtio_iommu_req_head?
>>
>> No, virtio_iommu_req_head::type is the request type
>> (ATTACH/DETACH/MAP/UNMAP/PROBE).
>>
>> Then virtio_iommu_probe_property::type is the property type (only RESV
>> for
>> the moment).
>>
>> And this is virtio_iommu_probe_resv::type, which is the type of the resv
>> region (MSI). I renamed it to 'subtype' below, but I think it still is
>> pretty confusing.
>>
>>
>> I did a number of changes to structures and naming when trying to
>> integrate it to the specification:
>>
>> * Added 64 bytes of padding in virtio_iommu_req_probe, so that future
>> extensions can add fields in the device-readable part.
>> * renamed "RESV" to "RESV_MEM".
>> * The resv_mem property now looks like this:
>>   struct virtio_iommu_probe_resv_mem {
>>         u8      subtype;
>>         u8      padding[3];
>>         le32    flags;
>>         le64    addr;
>>         le64    size;
>>   };
>> * subtype for MSI doorbells is now
>> VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS
>> (because transactions to this region bypass the IOMMU). 'flags' contain a
>> hint VIRTIO_IOMMU_PROBE_RESV_MEM_F_MSI, telling the driver that this
>> region is used for MSIs.
>>
>> Here is an example of a probe request returning an MSI doorbell property.
>>
>>      31                       7      0
>>     +---------------------------------+
>>     |           0            |  type  | <- request type = PROBE (5)
>>     +---------------------------------+
>>     |             device              |
>>     +---------------------------------+
>>     :                                 :
>>     :          (64B padding)          :
>>     :                                 :
>>     +---------------------------------+
>>   ^ |  length = 24   |    type = 1    | <- property type = RESV_MEM (1)
>>   | +---------------------------------+
>>   | |           0            |subtype | <- RESV_MEM subtype = BYPASS (1)
>>  p| +---------------------------------+
>>  r| |           flags = MSI           |
>>  o| +---------------------------------+
>>  b| |         addr = 0xfee00000       |
>>  e| |                                 |
>>  _| +---------------------------------+
>>  s| |         size = 0x00100000       |
>>  i| |                                 |
>>  z| +---------------------------------+
>>  e| |    length      |      type      | <- another property may start
>>   | :                                 :    here
>>   v :               ...               :
>>     +---------------------------------+
>>     |           0            | status | <- request tail
>>     +---------------------------------+
> 
> So we want a single probe will return info of all "types" and each "subtype" of given "type"? I was of impression that based on flags there will be separate probe request for a type.

Argh, now I'm lost :)

The virtio-iommu driver sends a single PROBE request for each endpoint.
The virtio-iommu device fills the 'properties' field with a list of
properties.

And endpoint may have one or more reserved virtual addresses. Each such
region is described by the virtio-iommu device with a RESV_MEM property in
the properties list.

There will be other types of properties in the future, for other
information than RESV_MEM. So the PROBE request is a generic channel for
different types of properties, all aggregated into a single list. The
virtio-iommu device chooses which property it needs to communicate to the
driver.

The list does not have a fixed layout, and the driver knows what
properties it contains by reading the 'type' header of each property.

The virtio-iommu driver parses the 'properties' list filled by the device.
If it encounters one or more RESV_MEM properties, the driver should take
note of them. Thereafter, the driver should never create a mapping
overlapping RESV_MEM regions for this endpoint.

If, in addition, the RESV_MEM property is of subtype BYPASS and has flag
MSI, then the driver knows that it is an MSI doorbell and it doesn't need
to create a mapping (using a MAP request) for this MSI doorbell.

Maybe my prototype implementation will be more clear.

Thanks,
Jean


>>
>>
>> I'll try to send the next version of the spec out as soon as possible.
>>
>> Thanks,
>> Jean
>>
>>
>>> Thanks
>>> -Bharat
>>>
>>>>>
>>>>> type is 16 bit above?
>>>>
>>>> Ah, the naming isn't great. This is not the same as above, and could be
>> called
>>>> 'subtype' to avoid confusion. The above 16-bit type describes the field
>> type,
>>>> e.g. struct virtio_iommu_probe_resv. I proposed 16-bit because it seems
>>>> easy to reach more than 255 kinds of endpoint properties, but
>>>> 65535 should do.
>>>>
>>>> This subtype describes which kind of resv region is described in the
>> structure.
>>>> For the moment there only is VIRTIO_IOMMU_PROBE_RESV_MSI, but we
>>>> could for example add resv regions that the driver should never use or
>> that it
>>>> should identity-map (equivalent to IOMMU_RESV_RESERVED/DIRECT in
>>>> Linux). I think 8 bits should be enough to contain any future types, unless
>> we
>>>> make this a bitfield. For identity-map, there may be an additional flags
>> field
>>>> describing the protection.
>>>>
>>>>>> };
>>>>>>
>>>>>> Such a region would be subject to the following rules:
>>>>>>
>>>>>> * Driver should not use any IOVA declared as RESV_MSI in a mapping.
>>>>>> * Device should leave any transaction matching a RESV_MSI region pass
>>>>>> through untranslated.
>>>>>> * If the device does not advertise any RESV region, then the driver
>>>>>> should assume that MSI doorbells, like any other GPA, must be
>> mapped
>>>>>> with an arbitrary IOVA in order for the endpoint to access them.
>>>>>> * Given that the driver *should* perform a probe request if
>>>>>> available, and it *should* understand the
>>>> VIRTIO_IOMMU_PROBE_T_RESV
>>>>>> field, then this field tells the guest how it should handle MSI
>>>>>> doorbells, and whether it should map the address via MAP requests or
>>>> not.
>>>>>>
>>>>>> Does this make sense and did I overlook something?
>>>>>
>>>>> Overall it looks good to me. Do you have plans to implements this in
>> virtio-
>>>> iommu driver and kvmtool?
>>>>
>>>> Yes, if there is no objection I'll try to formalize it and implement it right
>> away.
>>>>
>>>> Thanks,
>>>> Jean
> 
