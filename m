Received: from eggs.gnu.org ([2001:4830:134:3::10]:56557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJEVG-0001WF-KV
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJEVD-0006xZ-EV
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:10:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39316
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eJEVD-0006xP-8U
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:10:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAR89rht023707
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 03:10:52 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egexxr1bp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 03:10:52 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 08:10:50 -0000
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-8-git-send-email-pmorel@linux.vnet.ibm.com>
	<deec080f-b03c-85ae-72dd-5704d557cc02@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 09:10:47 +0100
MIME-Version: 1.0
In-Reply-To: <deec080f-b03c-85ae-72dd-5704d557cc02@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <47b0be10-3c5a-3a7f-f90f-23937693c2d6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] s390x/pci: search for subregion
 inside the BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de, Qemu-s390x list <qemu-s390x@nongnu.org>

On 23/11/2017 10:54, Thomas Huth wrote:
> On 22.11.2017 23:05, Pierre Morel wrote:
>> When dispatching memory access to PCI BAR region, we must
>> look for possible subregions, used by the PCI device to map
>> different memory areas inside the same PCI BAR.
>>
>> Since the data offset we received is calculated starting at the
>> region start address we need to adjust the offset for the subregion.
>>
>> The data offset inside the subregion is calculated by substracting
>> the subregion's starting address from the data offset in the region.
>>
>> The access to the MSIX region is now handled in a generic way,
>> we do not need the specific trap_msix() function anymore.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 44 +++++++++++++++++++++++++-------------=
------
>>   1 file changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 8d35f8f..fae3ef7 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -345,12 +345,31 @@ static int zpci_endian_swap(uint64_t *ptr, uint8=
_t len)
>>       return 0;
>>   }
>>  =20
>> +static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t of=
fset,
>> +                                        uint8_t len)
>> +{
>> +    MemoryRegion *other;
>=20
> Just my personal taste, but I'd rather call it "submr" or something sim=
ilar.

OK, you are right it is more speaking.

>=20
>> +    uint64_t subregion_size;
>> +
>> +    QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>> +        subregion_size =3D int128_get64(other->size);
>> +        if ((offset >=3D other->addr) &&
>> +            (offset + len) <=3D (other->addr + subregion_size)) {
>=20
> (Too much parentheses for my taste ;-))

I find it more readable so.
So if no other opinion I would let it so.

>=20
>> +            mr =3D other;
>> +            break;
>> +        }
>> +    }
>> +    return mr;
>> +}
>> +
>>   static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pc=
ias,
>>                                    uint64_t offset, uint64_t *data, ui=
nt8_t len)
>>   {
>>       MemoryRegion *mr;
>>  =20
>>       mr =3D pbdev->pdev->io_regions[pcias].memory;
>> +    mr =3D s390_get_subregion(mr, offset, len);
>> +    offset -=3D mr->addr;
>=20
> I'm not that familiar with the MemoryRegion nesting ... So may I ask: I=
s
> that "offset -=3D mr->addr" also right if mr does *not* point to a
> sub-region, but to the main memory region? (I.e. is mr->addr =3D=3D 0 i=
n
> that case?)

Yes.
This routine is common to VIRTIO and VFIO and we have a single region in=20
VFIO.

>=20
>>       return memory_region_dispatch_read(mr, offset, data, len,
>>                                          MEMTXATTRS_UNSPECIFIED);
>>   }
>> @@ -442,30 +461,14 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>       return 0;
>>   }
>>  =20
>> -static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_=
t pcias)
>> -{
>> -    if (pbdev->msix.available && pbdev->msix.table_bar =3D=3D pcias &=
&
>> -        offset >=3D pbdev->msix.table_offset &&
>> -        offset < (pbdev->msix.table_offset +
>> -                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
>> -        return 1;
>> -    } else {
>> -        return 0;
>> -    }
>> -}
>> -
>>   static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t p=
cias,
>>                                     uint64_t offset, uint64_t data, ui=
nt8_t len)
>>   {
>>       MemoryRegion *mr;
>>  =20
>> -    if (trap_msix(pbdev, offset, pcias)) {
>> -        offset =3D offset - pbdev->msix.table_offset;
>> -        mr =3D &pbdev->pdev->msix_table_mmio;
>> -    } else {
>> -        mr =3D pbdev->pdev->io_regions[pcias].memory;
>> -    }
>> -
>> +    mr =3D pbdev->pdev->io_regions[pcias].memory;
>> +    mr =3D s390_get_subregion(mr, offset, len);
>> +    offset -=3D mr->addr;
>>       return memory_region_dispatch_write(mr, offset, data, len,
>>                                           MEMTXATTRS_UNSPECIFIED);
>>   }
>> @@ -726,6 +729,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, =
uint8_t r3, uint64_t gaddr,
>>       }
>>  =20
>>       mr =3D pbdev->pdev->io_regions[pcias].memory;
>=20
> Since this above line is done right before all calls to
> s390_get_subregion(), you could maybe move it into that function, too.
> (and rather call the function sth. like pci_mem_get_subregion() instead=
?)

Yes, I know, I could also have a pointer to offset in the call and put=20
the offset adjustment in the call.
I save 4 lines but have an extra argument and I find that the result is=20
less readable.

So it no other opinions I would prefer to let it like this.

>=20
>> +    mr =3D s390_get_subregion(mr, offset, len);
>> +    offset -=3D mr->addr;
>> +
>>       if (!memory_region_access_valid(mr, offset, len, true)) {
>>           program_interrupt(env, PGM_OPERAND, 6);
>>           return 0;
>>
>=20
>   Thomas
>=20

Thanks for the review,

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
