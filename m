Received: from eggs.gnu.org ([2001:4830:134:3::10]:47557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEuZy-0007ve-Ik
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEuZt-0006tn-HF
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:05:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEuZt-0006tF-Bg
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:05:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAFA4fOu092144
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 05:05:48 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e8gfm86qq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 05:05:47 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 15 Nov 2017 10:05:45 -0000
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171113162328.3b94def6.cohuck@redhat.com>
	<cd2217c5-25ca-0a15-46ac-b37e04e528e6@linux.vnet.ibm.com>
	<20171113181059.6c9267c1.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 11:05:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171113181059.6c9267c1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <edbef73b-6b43-3896-3d18-425e1445f512@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] s390x/pci: rework PCI STORE BLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de

On 13/11/2017 18:10, Cornelia Huck wrote:
> On Mon, 13 Nov 2017 17:38:40 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> On 13/11/2017 16:23, Cornelia Huck wrote:
>>> On Tue,  7 Nov 2017 18:24:36 +0100
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>   =20
>>>> Enhance the fault detection.
>>>>
>>>> Add the maxstbl entry to both the Query PCI Function Group
>>>> response and the PCIBusDevice structure.
>>>>
>>>> Initialize the maxstbl to 128 per default until we get
>>>> the actual data from the hardware.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-bus.h  |  1 +
>>>>    hw/s390x/s390-pci-inst.c | 62 +++++++++++++++++++++++++++++------=
-------------
>>>>    hw/s390x/s390-pci-inst.h |  2 +-
>>>>    3 files changed, 40 insertions(+), 25 deletions(-)
>>>>  =20
>>>   =20
>>>> @@ -662,22 +664,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t =
r1, uint8_t r3, uint64_t gaddr,
>>>>        fh =3D env->regs[r1] >> 32;
>>>>        pcias =3D (env->regs[r1] >> 16) & 0xf;
>>>>        len =3D env->regs[r1] & 0xff;
>>>> +    offset =3D env->regs[r3];
>>>>   =20
>>>> -    if (pcias > 5) {
>>>> -        DPRINTF("pcistb invalid space\n");
>>>> -        setcc(cpu, ZPCI_PCI_LS_ERR);
>>>> -        s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
>>>> -        return 0;
>>>> -    }
>>>> -
>>>> -    switch (len) {
>>>> -    case 16:
>>>> -    case 32:
>>>> -    case 64:
>>>> -    case 128:
>>>> -        break;
>>>> -    default:
>>>> -        program_interrupt(env, PGM_SPECIFICATION, 6);
>>>> +    if (!(fh & FH_MASK_ENABLE)) {
>>>> +        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
>>>
>>> So this means you move checking for the device before checking for th=
e
>>> parameters or the as.
>>
>> Yes, this is clearly following the specifications that CC=3D3 has prio=
rity
>> over CC=3D1 or CC=3D2.
>=20
> OK, it would then make sense to mention in the patch description that
> you fixed up the precedence as well.

I will do
thanks

>=20
>>
>> By the way I find that defining ZPCI_PCI_LS_INVAL_HANDLE is obfuscatin=
g,
>> we have the information from the test we just made but we loose the
>> information about if it is a 1, 2 or 3 CC value.
>> May be in another patch?
>=20
> Let's keep this for now, we can revisit that later.

OK

>=20
>>
>>>   =20
>>>>            return 0;
>>>>        }
>>>>   =20
>>>> @@ -689,12 +679,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r=
1, uint8_t r3, uint64_t gaddr,
>>>>        }
>>>>   =20
>>>>        switch (pbdev->state) {
>>>> -    case ZPCI_FS_RESERVED:
>>>> -    case ZPCI_FS_STANDBY:
>>>> -    case ZPCI_FS_DISABLED:
>>>>        case ZPCI_FS_PERMANENT_ERROR:
>>>> -        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
>>>> -        return 0;
>>>>        case ZPCI_FS_ERROR:
>>>>            setcc(cpu, ZPCI_PCI_LS_ERR);
>>>>            s390_set_status_code(env, r1, ZPCI_PCI_ST_BLOCKED);
>>>> @@ -703,8 +688,33 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r=
1, uint8_t r3, uint64_t gaddr,
>>>>            break;
>>>>        }
>>>>   =20
>>>> +    if (pcias > 5) {
>>>> +        DPRINTF("pcistb invalid space\n");
>>>> +        setcc(cpu, ZPCI_PCI_LS_ERR);
>>>> +        s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /* Verify the address, offset and length */
>>>> +    /* offset must be a multiple of 8 */
>>>> +    if (offset % 8) {
>>>> +        goto addressing_error;
>>>> +    }
>>>> +    /* Length must be greater than 8, a multiple of 8, lower than m=
axstbl */
>>>> +    if ((len <=3D 8) || (len % 8) || (len > pbdev->maxstbl)) {
>>>> +        goto addressing_error;
>>>> +    }
>>>> +    /* Do not cross a 4K-byte boundary */
>>>> +    if (((offset & 0xfff) + len) > 0x1000) {
>>>> +        goto addressing_error;
>>>> +    }
>>>> +    /* Guest address must be double word aligned */
>>>> +    if (gaddr & 0x07UL) {
>>>> +        goto addressing_error;
>>>> +    }
>>>
>>> So the checks here are only evaluated if the instruction actually pok=
es
>>> at a valid region?
>>
>> hum, I did not find the precedence of execution for PCI STORE BLOCK.
>>
>> My logic is that you must find a destination before you start reading
>> the source, so I would say it is the right way to do.
>> But the experience as already shown that my logic may not always be
>> compatible with the internals of S390x :)
>>
>> However, the documentation specifies that if an error condition is
>> detected that precludes the *initiation* of the store operation a CC=3D=
1
>> is set.
>> The fact that the *initiation* is focused on enforce the idea I have o=
n
>> the precedence between the low level operations.
>=20
> OK, this interpretation makes sense. It might be a good idea to poke th=
e
> architecture authors if it is ambiguous, though :)

Yes.

>=20
>>
>>>   =20
>>>> +
>>>>        mr =3D pbdev->pdev->io_regions[pcias].memory;
>>>> -    if (!memory_region_access_valid(mr, env->regs[r3], len, true)) =
{
>>>> +    if (!memory_region_access_valid(mr, offset, len, true)) {
>>>>            program_interrupt(env, PGM_OPERAND, 6);
>>>>            return 0;
>>>>        }
>>>> @@ -714,9 +724,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1=
, uint8_t r3, uint64_t gaddr,
>>>>        }
>>>>   =20
>>>>        for (i =3D 0; i < len / 8; i++) {
>>>> -        result =3D memory_region_dispatch_write(mr, env->regs[r3] +=
 i * 8,
>>>> -                                     ldq_p(buffer + i * 8), 8,
>>>> -                                     MEMTXATTRS_UNSPECIFIED);
>>>> +        result =3D memory_region_dispatch_write(mr, offset + i * 8,
>>>> +                                              ldq_p(buffer + i * 8)=
, 8,
>>>> +                                              MEMTXATTRS_UNSPECIFIE=
D);
>>>>            if (result !=3D MEMTX_OK) {
>>>>                program_interrupt(env, PGM_OPERAND, 6);
>>>>                return 0;
>>>> @@ -725,6 +735,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r=
1, uint8_t r3, uint64_t gaddr,
>>>>   =20
>>>>        setcc(cpu, ZPCI_PCI_LS_OK);
>>>>        return 0;
>>>> +
>>>> +addressing_error:
>>>> +    program_interrupt(env, PGM_SPECIFICATION, 6);
>>>> +    return 0;
>>>>    }
>>>
>>> This seems more readable; I can't verify whether it is actually corre=
ct
>>> without access to the architecture, though :(
>>>   =20
>>
>>
>>
>=20
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
