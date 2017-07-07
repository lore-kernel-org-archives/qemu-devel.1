Received: from eggs.gnu.org ([2001:4830:134:3::10]:36672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dTV0N-0002Jf-7S
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dTV0L-00034u-VA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:17:15 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<c80977c4-1955-4e9d-3fc8-4d884562fd28@redhat.com>
	<HE1PR0401MB2556D19D91F25DCE96FE7B199AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<8a7fb667-e6c0-2412-6dca-a8233dd27836@redhat.com>
	<HE1PR0401MB255696A487DFEB2B8972980F9AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<e9ea564a-f02b-0ed5-e700-b7b1dfd89722@arm.com>
	<AM5PR0401MB25459345E9533FFC3BBE00289AD50@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<15b631c8-5708-1426-90a2-9be51a796614@redhat.com>
	<AM5PR0401MB2545C23F66D6D0E096DCB0369AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<a67cb139-e1b6-02fc-d451-4001bcbfceb3@redhat.com>
	<AM5PR0401MB2545A78764598CD87827B14F9AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <615e22ce-80b3-b000-360f-7272a867cdf9@arm.com>
Date: Fri, 7 Jul 2017 16:19:51 +0100
MIME-Version: 1.0
In-Reply-To: <AM5PR0401MB2545A78764598CD87827B14F9AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
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

On 07/07/17 12:36, Bharat Bhushan wrote:
>>> In this proposal, QEMU reserves a iova-range for guest (not host) and guest
>> kernel will use this as msi-iova untranslated (IOMMU_RESV_MSI). While this
>> does not change host interface and it will continue to use host reserved
>> mapping for actual interrupt generation, no?
>> But then userspace needs to provide IOMMU_RESV_MSI range to guest
>> kernel, right? What would be the proposed manner?
> 
> Just an opinion, we can define feature (VIRTIO_IOMMU_F_RES_MSI_RANGE) and provide this info via a command (VIRTIO_IOMMU_T_MSI_RANGE). Guest iommu-driver will make this call during initialization and store the value. This value will just replace MSI_IOVA_BASE and MSI_IOVA_LENGHT hash define. Rest will remain same in virtio-iommu driver.

Yes I had something similar in mind, although more generic since we'll
need to get other bits of information from the device in future extensions
(fault handling, page table formats and dynamic reserves of memory for
SVM), and maybe also for finding out per-address-space page granularity
(see my reply of patch 3/8). These are per-endpoint properties that cannot
be advertise in the virtio config space.

                                 ***

So I propose to add a per-endpoint probing mechanism on the request queue:

* The device advertises a new command VIRTIO_IOMMU_T_PROBE with feature
bit VIRTIO_IOMMU_F_PROBE.
* When this feature is advertised, the device sets probe_size field in the
the config space.
* When device offers VIRTIO_IOMMU_F_PROBE, the driver should send an
VIRTIO_IOMMU_T_PROBE request for each new endpoint.
* The driver allocates a device-writeable buffer of probe_size (plus
framing) and sends it as a VIRTIO_IOMMU_T_PROBE request.
* The device fills the buffer with various information.

struct virtio_iommu_req_probe {
	/* device-readable */
	struct virtio_iommu_req_head head;
	le32 device;
	le32 flags;

	/* maybe also le32 content_size, but it must be equal to
	   probe_size */

	/* device-writeable */
	u8 content[];
	struct virtio_iommu_req_tail tail;
};

I'm still struggling with the content and layout of the probe request, and
would appreciate any feedback. To be easily extended, I think it should
contain a list of fields of variable size:

	|0           15|16           31|32               N|
	|     type     |    length     |      values      |

'length' might be made optional if it can be deduced from type, but might
make driver-side parsing more robust.

The probe could either be done for each endpoint, or for each address
space. I much prefer endpoint because it is the smallest granularity. The
driver can then decide what endpoints to put together in the same address
space based on their individual capabilities. The specification would
described how each endpoint property is combined when endpoints are put in
the same address space. For example, take the minimum of all PASID size,
the maximum of all page granularities, combine doorbell addresses, etc.

If we did the probe on address spaces instead, the driver would have to
re-send a probe request each time a new endpoint is attached to an
existing address space, to see if it is still capable of page table
handover or if the driver just combined a VFIO and an emulated endpoint by
accident.

                                 ***

Using this framework, the device can declare doorbell regions by adding
one or more RESV fields into the probe buffer:

/* 'type' */
#define VIRTIO_IOMMU_PROBE_T_RESV 	0x1

/* 'values'. 'length' is sizeof(struct virtio_iommu_probe_resv) */
struct virtio_iommu_probe_resv {
	le64 gpa;
	le64 size;

#define VIRTIO_IOMMU_PROBE_RESV_MSI	0x1
	u8 type;
};

Such a region would be subject to the following rules:

* Driver should not use any IOVA declared as RESV_MSI in a mapping.
* Device should leave any transaction matching a RESV_MSI region pass
through untranslated.
* If the device does not advertise any RESV region, then the driver should
assume that MSI doorbells, like any other GPA, must be mapped with an
arbitrary IOVA in order for the endpoint to access them.
* Given that the driver *should* perform a probe request if available, and
it *should* understand the VIRTIO_IOMMU_PROBE_T_RESV field, then this
field tells the guest how it should handle MSI doorbells, and whether it
should map the address via MAP requests or not.

Does this make sense and did I overlook something?

Thanks,
Jean
