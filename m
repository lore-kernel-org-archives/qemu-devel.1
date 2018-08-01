Received: from eggs.gnu.org ([2001:4830:134:3::10]:55689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fkmZc-0007tF-Fy
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fkmZZ-0005M6-Rn
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:33:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fkmZZ-0005LE-NL
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:33:33 -0400
References: <20180720083644.1431-1-tiwei.bie@intel.com>
	<20180801082244.GA11408@debian.sh.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c61aae7-4a19-01e9-5208-fb0033af2602@redhat.com>
Date: Wed, 1 Aug 2018 16:33:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180801082244.GA11408@debian.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: check region type before casting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org



On 2018=E5=B9=B408=E6=9C=8801=E6=97=A5 16:22, Tiwei Bie wrote:
> Ping..
>
> It seems that the final release for QEMU 3.0 will be
> out soon [1]. But this fix hasn't been merged yet.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg06004.h=
tml
>
> Thanks,
> Tiwei

Cc: qemu-stable@nongnu.org
Acked-by: Jason Wang <jasowang@redhat.com>

>
> On Fri, Jul 20, 2018 at 04:36:44PM +0800, Tiwei Bie wrote:
>> Check region type first before casting the memory region
>> to IOMMUMemoryRegion. Otherwise QEMU will abort with below
>> error message when casting non-IOMMU memory region:
>>
>> vhost_iommu_region_add: Object 0x561f28bce4f0 is not an
>> instance of type qemu:iommu-memory-region
>>
>> Fixes: cb1efcf462a2 ("iommu: Add IOMMU index argument to notifier APIs=
")
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>
>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>> ---
>>   hw/virtio/vhost.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index b129cb9ddd..d4cb5894a8 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -663,12 +663,14 @@ static void vhost_iommu_region_add(MemoryListene=
r *listener,
>>       struct vhost_iommu *iommu;
>>       Int128 end;
>>       int iommu_idx;
>> -    IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
>> +    IOMMUMemoryRegion *iommu_mr;
>>  =20
>>       if (!memory_region_is_iommu(section->mr)) {
>>           return;
>>       }
>>  =20
>> +    iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
>> +
>>       iommu =3D g_malloc0(sizeof(*iommu));
>>       end =3D int128_add(int128_make64(section->offset_within_region),
>>                        section->size);
>> --=20
>> 2.18.0
>>
>>
