Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eD5nb-0005y5-Sh
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eD5nW-0008Dp-Sc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:40:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eD5nW-0008Cb-Jj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:40:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAA9d4lg129149
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 04:40:20 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e57wdvwu7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 04:40:19 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 02:40:18 -0700
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-7-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109202308.06a8bc45.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 17:40:12 +0800
MIME-Version: 1.0
In-Reply-To: <20171109202308.06a8bc45.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <15d59e1d-e42f-3068-ddc5-e991a5f21879@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] s390x/pci: move the memory region
 write from pcistg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com



=D4=DA 2017/11/10 =C9=CF=CE=E73:23, Cornelia Huck =D0=B4=B5=C0:
> On Tue,  7 Nov 2017 18:24:38 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> Let's move the memory region write from pcistg into a dedicated
>> function.
>> This allows us to prepare a later patch searching for subregions
>> inside of the memory region.
> OK, so here is the memory region write. Do we have any sleeping
> endianness bugs in there for when we wire up tcg? I'm not sure how this
> plays with the bswaps (see patch 1).
>
> But maybe I've just gotten lost somewhere.
I think there's no error. For PCI bars' MRs, we got the little-endian dat=
a
that is exactly fit to the byte ordering of pcilg instruction. For PCI=20
config
space, the data has been swapped according to the cpu byte ordering.
So we use zpci_swap_endian() to swap the data back to the little-endian
ordering.
>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 50135a0..97f62b5 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -455,12 +455,27 @@ static int trap_msix(S390PCIBusDevice *pbdev, ui=
nt64_t offset, uint8_t pcias)
>>       }
>>   }
>>  =20
>> +static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pc=
ias,
>> +                                  uint64_t offset, uint64_t data, uin=
t8_t len)
>> +{
>> +    MemoryRegion *mr;
>> +
>> +    if (trap_msix(pbdev, offset, pcias)) {
>> +        offset =3D offset - pbdev->msix.table_offset;
>> +        mr =3D &pbdev->pdev->msix_table_mmio;
>> +    } else {
>> +        mr =3D pbdev->pdev->io_regions[pcias].memory;
>> +    }
>> +
>> +    return memory_region_dispatch_write(mr, offset, data, len,
>> +                                        MEMTXATTRS_UNSPECIFIED);
>> +}
>> +
>>   int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>>   {
>>       CPUS390XState *env =3D &cpu->env;
>>       uint64_t offset, data;
>>       S390PCIBusDevice *pbdev;
>> -    MemoryRegion *mr;
>>       MemTxResult result;
>>       uint8_t len;
>>       uint32_t fh;
>> @@ -517,15 +532,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>               return 0;
>>           }
>>  =20
>> -        if (trap_msix(pbdev, offset, pcias)) {
>> -            offset =3D offset - pbdev->msix.table_offset;
>> -            mr =3D &pbdev->pdev->msix_table_mmio;
>> -        } else {
>> -            mr =3D pbdev->pdev->io_regions[pcias].memory;
>> -        }
>> -
>> -        result =3D memory_region_dispatch_write(mr, offset, data, len=
,
>> -                                     MEMTXATTRS_UNSPECIFIED);
>> +        result =3D zpci_write_bar(pbdev, pcias, offset, data, len);
>>           if (result !=3D MEMTX_OK) {
>>               program_interrupt(env, PGM_OPERAND, 4);
>>               return 0;
>
