Received: from eggs.gnu.org ([2001:4830:134:3::10]:43158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1ego2m-000692-NI
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1ego2g-0003Y8-W8
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:47:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39890
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1ego2g-0003Xo-QI
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:46:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0V8jvXu114301
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 03:46:54 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fu9ffjrpj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 03:46:52 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 31 Jan 2018 01:46:51 -0700
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
	<4740d12b-4dc0-d836-2f9e-574b836b72e7@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 31 Jan 2018 16:46:44 +0800
MIME-Version: 1.0
In-Reply-To: <4740d12b-4dc0-d836-2f9e-574b836b72e7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c60f402b-f013-fde1-4ccc-ea6dcc676f2b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/pci: fixup the code walking
 IOMMU tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pasic@linux.vnet.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, marcel@redhat.com, qemu-s390x@nongnu.org



=E5=9C=A8 2018/1/31 =E4=B8=8B=E5=8D=883:42, Thomas Huth =E5=86=99=E9=81=93=
:
> On 30.01.2018 10:47, Yi Min Zhao wrote:
>> Current s390x PCI IOMMU code is lack of flags' checking, including:
>> 1) protection bit
>> 2) table length
>> 3) table offset
>> 4) intermediate tables' invalid bit
>> 5) format control bit
>>
>> This patch introduces a new struct named S390IOTLBEntry, and makes up
>> these missed checkings. At the same time, inform the guest with the
>> corresponding error number when the check fails.
>>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  | 223 +++++++++++++++++++++++++++++++++++++=
+---------
>>   hw/s390x/s390-pci-bus.h  |  10 +++
>>   hw/s390x/s390-pci-inst.c |  10 ---
>>   3 files changed, 190 insertions(+), 53 deletions(-)
> [...]
>> @@ -374,26 +511,26 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUM=
emoryRegion *mr, hwaddr addr,
>>       DPRINTF("iommu trans addr 0x%" PRIx64 "\n", addr);
>>  =20
>>       if (addr < iommu->pba || addr > iommu->pal) {
>> -        return ret;
>> +        error =3D ERR_EVENT_OORANGE;
>> +        goto err;
>>       }
>>  =20
>> -    pte =3D s390_guest_io_table_walk(s390_pci_get_table_origin(iommu-=
>g_iota),
>> -                                   addr);
>> -    if (!pte) {
>> -        return ret;
>> -    }
>> +    error =3D s390_guest_io_table_walk(iommu->g_iota, addr, &entry);
>>  =20
>> -    flags =3D pte & ZPCI_PTE_FLAG_MASK;
>> -    ret.iova =3D addr;
>> -    ret.translated_addr =3D pte & ZPCI_PTE_ADDR_MASK;
>> -    ret.addr_mask =3D 0xfff;
>> +    ret.iova =3D entry.iova;
>> +    ret.translated_addr =3D entry.translated_addr;
>> +    ret.addr_mask =3D entry.len - 1;
>> +    ret.perm =3D entry.perm;
>>  =20
>> -    if (flags & ZPCI_PTE_INVALID) {
>> -        ret.perm =3D IOMMU_NONE;
>> -    } else {
>> -        ret.perm =3D IOMMU_RW;
>> +    if ((flag !=3D IOMMU_NONE) && !(flag & ret.perm)) {
> You could drop the parentheses around "flag !=3D IOMMU_NONE".
OK. Will update.
>
> For the rest of the patch: Sorry, can't review due to missing PCI spec =
:-(
Thanks for your review anyway!
>
>   Thomas
>
>
