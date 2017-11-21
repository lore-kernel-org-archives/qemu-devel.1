Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHCxX-0008T1-SG
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHCxU-0007wa-Ft
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:07:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38088
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eHCxU-0007wS-A5
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:07:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALI4Mte144986
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:07:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ecqmfefju-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:07:37 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 18:07:11 -0000
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171121114243.7ac15767.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 19:07:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171121114243.7ac15767.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <cd7b7f6e-dbb3-3d9a-bd3d-a5fb7d7b9d2b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/pci: rework PCI STORE BLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 21/11/2017 11:42, Cornelia Huck wrote:
> On Thu, 16 Nov 2017 18:51:52 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Enhance the fault detection.
>>
>> Fixup the precedence to check the destination path existance
>> before checking for the source accessibility.
>>
>> Add the maxstbl entry to both the Query PCI Function Group
>> response and the PCIBusDevice structure.
>>
>> Initialize the maxstbl to 128 per default until we get
>> the actual data from the hardware.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.h  |  1 +
>>   hw/s390x/s390-pci-inst.c | 62 +++++++++++++++++++++++++++++---------=
----------
>>   hw/s390x/s390-pci-inst.h |  2 +-
>>   3 files changed, 40 insertions(+), 25 deletions(-)
>=20
>> @@ -700,8 +685,33 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r3, uint64_t gaddr,
>>           break;
>>       }
>>  =20
>> +    if (pcias > 5) {
>> +        DPRINTF("pcistb invalid space\n");
>> +        setcc(cpu, ZPCI_PCI_LS_ERR);
>> +        s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
>> +        return 0;
>> +    }
>> +
>> +    /* Verify the address, offset and length */
>> +    /* offset must be a multiple of 8 */
>> +    if (offset % 8) {
>> +        goto addressing_error;
>> +    }
>> +    /* Length must be greater than 8, a multiple of 8, not greater ma=
xstbl */
>=20
> "not greater than maxstlb"

Better I know but greater that 80 characters, this is why I preferred=20
broken English.
What do I do ? break the line or English ?

>=20
>> +    if ((len <=3D 8) || (len % 8) || (len > pbdev->maxstbl)) {
>> +        goto addressing_error;
>> +    }
>> +    /* Do not cross a 4K-byte boundary */
>> +    if (((offset & 0xfff) + len) > 0x1000) {
>> +        goto addressing_error;
>> +    }
>> +    /* Guest address must be double word aligned */
>> +    if (gaddr & 0x07UL) {
>> +        goto addressing_error;
>> +    }
>> +
>>       mr =3D pbdev->pdev->io_regions[pcias].memory;
>> -    if (!memory_region_access_valid(mr, env->regs[r3], len, true)) {
>> +    if (!memory_region_access_valid(mr, offset, len, true)) {
>>           program_interrupt(env, PGM_OPERAND, 6);
>>           return 0;
>>       }
>=20
> Looks good.
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
