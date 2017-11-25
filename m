Received: from eggs.gnu.org ([2001:4830:134:3::10]:37223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIXtR-0005bA-Jv
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIXtO-0007w0-H2
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:41:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eIXtO-0007vH-7n
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:41:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAPAearV134650
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 05:41:01 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ef5jfj60j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 05:41:00 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Sat, 25 Nov 2017 10:40:58 -0000
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-7-git-send-email-pmorel@linux.vnet.ibm.com>
	<d1083416-5453-980d-6756-d000623d937c@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Sat, 25 Nov 2017 11:40:54 +0100
MIME-Version: 1.0
In-Reply-To: <d1083416-5453-980d-6756-d000623d937c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d85b4c91-54bd-a71c-46f9-b329ce35540e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/pci: move the memory region
 write from pcistg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de, qemu-s390x@nongnu.org

On 23/11/2017 10:36, Thomas Huth wrote:
> On 22.11.2017 23:05, Pierre Morel wrote:
>> Let's move the memory region write from pcistg into a dedicated
>> function.
>> This allows us to prepare a later patch searching for subregions
>> inside of the memory region.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 69ff7b8..8d35f8f 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -454,12 +454,27 @@ static int trap_msix(S390PCIBusDevice *pbdev, ui=
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
>> @@ -516,15 +531,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
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
>>
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20

Thanks,

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
