Received: from eggs.gnu.org ([2001:4830:134:3::10]:37005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIXsY-000500-MX
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIXsV-0007GN-Ja
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:40:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48540
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eIXsV-0007Fx-Dn
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:40:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAPAd1Ma054878
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 05:40:06 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ef3jbdfbc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 05:40:06 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Sat, 25 Nov 2017 10:40:05 -0000
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-6-git-send-email-pmorel@linux.vnet.ibm.com>
	<8a6d96f7-ca15-c8b9-0c0d-e78b84b27e21@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Sat, 25 Nov 2017 11:40:01 +0100
MIME-Version: 1.0
In-Reply-To: <8a6d96f7-ca15-c8b9-0c0d-e78b84b27e21@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <495e4910-35da-3326-0e26-0b493f9ac033@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x/pci: move the memory region
 read from pcilg
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

On 23/11/2017 10:32, Thomas Huth wrote:
> On 22.11.2017 23:05, Pierre Morel wrote:
>> Let's move the memory region read from pcilg into a dedicated function.
>> This allows us to prepare a later patch.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index fe6e042..69ff7b8 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -345,13 +345,22 @@ static int zpci_endian_swap(uint64_t *ptr, uint8=
_t len)
>>       return 0;
>>   }
>>  =20
>> +static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pci=
as,
>> +                                 uint64_t offset, uint64_t *data, uin=
t8_t len)
>> +{
>> +    MemoryRegion *mr;
>> +
>> +    mr =3D pbdev->pdev->io_regions[pcias].memory;
>> +    return memory_region_dispatch_read(mr, offset, data, len,
>> +                                       MEMTXATTRS_UNSPECIFIED);
>> +}
>> +
>>   int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>>   {
>>       CPUS390XState *env =3D &cpu->env;
>>       S390PCIBusDevice *pbdev;
>>       uint64_t offset;
>>       uint64_t data;
>> -    MemoryRegion *mr;
>>       MemTxResult result;
>>       uint8_t len;
>>       uint32_t fh;
>> @@ -402,9 +411,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, u=
int8_t r2)
>>               program_interrupt(env, PGM_OPERAND, 4);
>>               return 0;
>>           }
>> -        mr =3D pbdev->pdev->io_regions[pcias].memory;
>> -        result =3D memory_region_dispatch_read(mr, offset, &data, len=
,
>> -                                             MEMTXATTRS_UNSPECIFIED);
>> +        result =3D zpci_read_bar(pbdev, pcias, offset, &data, len);
>>           if (result !=3D MEMTX_OK) {
>>               program_interrupt(env, PGM_OPERAND, 4);
>>               return 0;
>>
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
Thanks

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
