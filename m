Received: from eggs.gnu.org ([2001:4830:134:3::10]:57628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZTYg-0007YT-BU
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZTYc-0003wm-Uw
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:29:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eZTYc-0003vu-Oq
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:29:34 -0500
References: <20171218201340.27583-1-dgilbert@redhat.com>
	<20171218201340.27583-4-dgilbert@redhat.com>
	<20171227150621.0955a09d@igors-macbook-pro.local>
	<20180108175449.GH2462@work-vm> <20180110112355.05c60456@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a6b1ed11-fac0-6ad7-26fb-a0d4f09a7355@redhat.com>
Date: Thu, 11 Jan 2018 11:29:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180110112355.05c60456@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/7] vhost: Simplify ring verification
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: mst@redhat.com, groug@kaod.org, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, maxime.coquelin@redhat.com, pbonzini@redhat.com



On 2018=E5=B9=B401=E6=9C=8810=E6=97=A5 18:23, Igor Mammedov wrote:
> On Mon, 8 Jan 2018 17:54:50 +0000
> "Dr. David Alan Gilbert"<dgilbert@redhat.com>  wrote:
>
>> * Igor Mammedov (imammedo@redhat.com) wrote:
>>> On Mon, 18 Dec 2017 20:13:36 +0000
>>> "Dr. David Alan Gilbert (git)"<dgilbert@redhat.com>  wrote:
>>>   =20
>>>> From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
>>>>
>>>> vhost_verify_ring_mappings() were used to verify that
>>>> rings are still accessible and related memory hasn't
>>>> been moved after flatview is updated.
>>>>
>>>> It was doing checks by mapping ring's GPA+len and
>>>> checking that HVA hadn't changed with new memory map.
>>>> To avoid maybe expensive mapping call, we were
>>>> identifying address range that changed and were doing
>>>> mapping only if ring was in changed range.
>>>>
>>>> However it's not neccessary to perform ring's GPA
>>>> mapping as we already have its current HVA and all
>>>> we need is to verify that ring's GPA translates to
>>>> the same HVA in updated flatview.
>>>>
>>>> This will allow the following patches to simplify the range
>>>> comparison that was previously needed to avoid expensive
>>>> verify_ring_mapping calls.
>>>>
>>>> Signed-off-by: Igor Mammedov<imammedo@redhat.com>
>>>> with modifications by:
>>>> Signed-off-by: Dr. David Alan Gilbert<dgilbert@redhat.com>  =20
>>> an additional question,
>>>
>>> in iommu case ring_hva =3D=3D ring_gpa if we look in to vhost_memory_=
map()
>>> have you check if iommu case is working with new code?
>> No I've not; do you have a suggested way of testing it?
> Not really,
> CCing Jason and Peter who worked on IOMMU stuff there,
> maybe the would suggest a test case.
>
>

Haven't read the thread but for IOMMU test you need:

1) enable iommu_platform for virtio device
2) enable ats for virtio device
3) boot with intel_iomu device
4) boot a guest with intel_iommu=3Dstrict (which makes the flush happens=20
immediately)
5) do some network loads e.g netperf TCP_STREAM test

Thanks
