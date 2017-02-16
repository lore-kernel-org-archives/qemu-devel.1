Received: from eggs.gnu.org ([2001:4830:134:3::10]:45805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceF6f-0002TW-Sp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceF6c-0002Yq-NA
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:59:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceF6c-0002YQ-E8
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:59:50 -0500
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
	<c1f86fba-6b22-8316-156f-2024bee46b0c@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <00b66a54-57d0-d85a-8358-e84f927f2904@redhat.com>
Date: Thu, 16 Feb 2017 13:59:41 +0800
MIME-Version: 1.0
In-Reply-To: <c1f86fba-6b22-8316-156f-2024bee46b0c@redhat.com>
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
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 13:43, Jason Wang wrote:
>
>
> On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 13:36, Liu, Yi L wrote:
>>> -----Original Message-----
>>> From: Qemu-devel=20
>>> [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.org]
>>> On Behalf Of Michael S. Tsirkin
>>> Sent: Tuesday, January 10, 2017 1:40 PM
>>> To: qemu-devel@nongnu.org
>>> Cc: Peter Maydell <peter.maydell@linaro.org>; Eduardo Habkost
>>> <ehabkost@redhat.com>; Jason Wang <jasowang@redhat.com>; Peter Xu
>>> <peterx@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>>> Henderson <rth@twiddle.net>
>>> Subject: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
>>> descriptor
>>>
>>> From: Jason Wang <jasowang@redhat.com>
>>>
>>> This patch enables device IOTLB support for intel iommu. The major=20
>>> work is to
>>> implement QI device IOTLB descriptor processing and notify the=20
>>> device through
>>> iommu notifier.
>>>
>> Hi Jason/Michael,
>>
>> Recently Peter Xu's patch also touched intel-iommu emulation. His=20
>> patch shadows
>> second-level page table by capturing iotlb flush from guest. It would=20
>> result in page
>> table updating in host. Does this patch also use the same map/umap=20
>> API provided
>> by VFIO?
>
> Yes, it depends on the iommu notifier too.
>
>> If it is, then I think it would also update page table in host. It=20
>> looks to be
>> a duplicate update. Pls refer to the following snapshot captured from=20
>> section 6.5.2.5
>> of vtd spec.
>>
>> "Since translation requests from a device may be serviced by hardware=20
>> from the IOTLB, software must
>> always request IOTLB invalidation (iotlb_inv_dsc) before requesting=20
>> corresponding Device-TLB
>> (dev_tlb_inv_dsc) invalidation."
>>
>> Maybe for device-iotlb, we need a separate API which just pass down=20
>> the invalidate
>> info without updating page table. Any thoughts?
>
> cc Alex.
>
> If we want ATS to be visible for guest (but I'm not sure if VFIO=20
> support this), we probably need another notifier or a new flag.
>
> Thanks=20

Or need a dedicated address_space if ATS were enabled for the device.
