Received: from eggs.gnu.org ([2001:4830:134:3::10]:48034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cecGV-0000iV-Cb
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cecGU-0002qr-CD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:43:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cecGU-0002q9-3d
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:43:34 -0500
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
	<c1f86fba-6b22-8316-156f-2024bee46b0c@redhat.com>
	<A2975661238FB949B60364EF0F2C25743900B73D@shsmsx102.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e9022e3a-5fa5-45c3-cc84-cb78d3ff9cdc@redhat.com>
Date: Fri, 17 Feb 2017 14:43:25 +0800
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743900B73D@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, Alex Williamson <alex.williamson@redhat.com>



On 2017=E5=B9=B402=E6=9C=8817=E6=97=A5 14:18, Liu, Yi L wrote:
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Thursday, February 16, 2017 1:44 PM
>> To: Liu, Yi L <yi.l.liu@intel.com>; Michael S. Tsirkin <mst@redhat.com=
>; qemu-
>> devel@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Eduardo Habkost
>> <ehabkost@redhat.com>; Peter Xu <peterx@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>; Tian, Kevi=
n
>> <kevin.tian@intel.com>; Lan, Tianyu <tianyu.lan@intel.com>; Alex Willi=
amson
>> <alex.williamson@redhat.com>
>> Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iot=
lb
>> descriptor
>>
>>
>>
>> On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 13:36, Liu, Yi L wrote:
>>>> -----Original Message-----
>>>> From: Qemu-devel
>>>> [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.org]
>>>> On Behalf Of Michael S. Tsirkin
>>>> Sent: Tuesday, January 10, 2017 1:40 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>; Eduardo Habkost
>>>> <ehabkost@redhat.com>; Jason Wang <jasowang@redhat.com>; Peter Xu
>>>> <peterx@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>>>> Henderson <rth@twiddle.net>
>>>> Subject: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
>>>> descriptor
>>>>
>>>> From: Jason Wang <jasowang@redhat.com>
>>>>
>>>> This patch enables device IOTLB support for intel iommu. The major
>>>> work is to implement QI device IOTLB descriptor processing and notif=
y
>>>> the device through iommu notifier.
>>>>
>>> Hi Jason/Michael,
>>>
>>> Recently Peter Xu's patch also touched intel-iommu emulation. His
>>> patch shadows second-level page table by capturing iotlb flush from
>>> guest. It would result in page table updating in host. Does this patc=
h
>>> also use the same map/umap API provided by VFIO?
>> Yes, it depends on the iommu notifier too.
>>
>>> If it is, then I think it would also update page table in host. It
>>> looks to be a duplicate update. Pls refer to the following snapshot
>>> captured from section 6.5.2.5 of vtd spec.
>>>
>>> "Since translation requests from a device may be serviced by hardware
>>> from the IOTLB, software must always request IOTLB invalidation
>>> (iotlb_inv_dsc) before requesting corresponding Device-TLB
>>> (dev_tlb_inv_dsc) invalidation."
>>>
>>> Maybe for device-iotlb, we need a separate API which just pass down
>>> the invalidate info without updating page table. Any thoughts?
>> cc Alex.
>>
>> If we want ATS to be visible for guest (but I'm not sure if VFIO suppo=
rt this), we
>> probably need another notifier or a new flag.
> Jason, for assigned device, I think guest could see ATS if the assigned=
 device
> supports ATS. I can see it when passthru iGPU.
>
> Regards,
> Yi L

Good to know this.

If I understand your suggestion correctly, you want a dedicated API to=20
flush a hardware device IOTLB. I'm not sure this is really needed.

There's some discussion of similar issue in the past (when ATS is used=20
for virtio-net/vhost), looks like we could solve this by not trigger the=20
UNMAP notifier unless it was device IOTLB inv desc if ATS is enabled for=20
the device? With this remote IOMMU/IOTLB can only get invalidation=20
request once. For VFIO, the under layer IOMMU can deal with hardware=20
device IOTLB without any extra efforts.

Does this make sense?

Thanks
