Received: from eggs.gnu.org ([2001:4830:134:3::10]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmYQZ-0004ov-Aw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmYQW-0000ZD-7N
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmYQV-0000Z7-Ux
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:47:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T4hr4B006283
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:46:58 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmx61kx50-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:46:58 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 00:46:57 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7T4krAS31588552
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 04:46:53 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A955AE04B
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:47:17 -0400 (EDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.63])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id BB513AE034
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:47:16 -0400 (EDT)
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828175722.0b54b59a.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 12:46:51 +0800
MIME-Version: 1.0
In-Reply-To: <20170828175722.0b54b59a.cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



=E5=9C=A8 2017/8/28 =E4=B8=8B=E5=8D=8811:57, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Mon, 28 Aug 2017 10:04:47 +0200
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
>>   hw/s390x/s390-pci-bus.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 9e1f7ff5c5..359509ccea 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -407,6 +407,13 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMe=
moryRegion *mr, hwaddr addr,
>>       return ret;
>>   }
>>  =20
>> +static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
>> +                                  IOMMUNotifier *notifier)
>> +{
>> +    /* we don't need iommu replay currently */
> This really needs to be heavier on the _why_. My guess is that anything
> which would require replay goes through the rpcit instruction?
My understanding is:
Our arch is different from others. Each pci device has its own iommu, not
like other archs' implementation. So currently there must be no existing
mappings belonging to any newly plugged pci device whose iommu doesn't
have any mapping at the time.
In addition, it's also due to vfio blocking migration. If vfio-pci suppor=
ts
migration in future, we could implement iommu replay by that time.
>
>> +    return;
>> +}
>> +
>>   static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus=
,
>>                                           int devfn)
>>   {
>> @@ -1055,6 +1062,7 @@ static void s390_iommu_memory_region_class_init(=
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
>
