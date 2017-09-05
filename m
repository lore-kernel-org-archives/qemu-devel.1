Received: from eggs.gnu.org ([2001:4830:134:3::10]:59628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpAW4-0000Sd-0Y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpAVz-00089b-3f
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:51:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45268
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dpAVy-00089H-Ts
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:51:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v859nkHB126743
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 05:51:26 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2csrt0b4d8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:51:25 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 19:51:22 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v859pLZI32374982
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 19:51:21 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v859pKFG003975
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 19:51:20 +1000
References: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1504239778-29893-4-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170905112822.0e9319cd.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 5 Sep 2017 17:51:18 +0800
MIME-Version: 1.0
In-Reply-To: <20170905112822.0e9319cd.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <dc1bf02e-aea2-e1ef-904e-dc9949f97651@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org



=D4=DA 2017/9/5 =CF=C2=CE=E75:28, Cornelia Huck =D0=B4=B5=C0:
> On Fri,  1 Sep 2017 06:22:58 +0200
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> Let's introduce iommu replay callback for s390 pci iommu memory region.
>> Currently we don't need any dma mapping replay. So let it return
>> directly. This implementation will avoid meaningless loops calling
>> translation callback.
>>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index bd8a3e1e1c..69f45e3715 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -397,6 +397,16 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMe=
moryRegion *mr, hwaddr addr,
>>       return ret;
>>   }
>>  =20
>> +static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
>> +                                  IOMMUNotifier *notifier)
>> +{
>> +    /* It's impossible to plug a pci device on s390x that already has=
 iommu
>> +     * mappings which need to be replayed, that is due to the "one io=
mmu per
>> +     * zpci device" construct. So we don't need iommu replay currentl=
y.
> I must say that 'currently' still throws me off. Does this refer to
> vfio? If yes, reword to something like 'Should we support migration of
> vfio-pci devices in the future, we need to revisit this.'?
Yeah, it refers to vfio especially. I update this in next version.
>
>> +     */
>> +    return;
>> +}
>> +
>>   static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus=
,
>>                                           int devfn)
>>   {
>> @@ -1045,6 +1055,7 @@ static void s390_iommu_memory_region_class_init(=
ObjectClass *klass, void *data)
>>       IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass=
);
>>  =20
>>       imrc->translate =3D s390_translate_iommu;
>> +    imrc->replay =3D s390_pci_iommu_replay;
>>   }
>>  =20
>>   static const TypeInfo s390_iommu_memory_region_info =3D {
>
