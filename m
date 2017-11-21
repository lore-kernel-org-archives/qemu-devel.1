Received: from eggs.gnu.org ([2001:4830:134:3::10]:46422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHCtT-0006Ok-HD
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHCtP-0005za-CY
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:03:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eHCtP-0005zA-4b
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:03:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALI3JnP082530
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:03:24 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ecqgsnd8s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:03:23 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 18:03:21 -0000
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171121113845.0a0377d1.cohuck@redhat.com>
	<20171121152503.1f0a023b.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 19:03:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171121152503.1f0a023b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <c7ab1846-30ef-cd18-e905-a2b41c7fd9fd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/7] s390x/pci: rework PCI STORE
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

On 21/11/2017 15:25, Cornelia Huck wrote:
> On Tue, 21 Nov 2017 11:38:45 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> On Thu, 16 Nov 2017 18:51:50 +0100
>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>>> @@ -493,9 +494,13 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1=
, uint8_t r2)
>>>           break;
>>>       }
>>>  =20
>>> -    data =3D env->regs[r1];
>>> -    if (pcias < 6) {
>>> -        if ((8 - (offset & 0x7)) < len) {
>>> +    /* Test that the pcias is valid and do the appropriates operatio=
ns */
>>> +    switch (pcias) {
>>> +    case 0 ... 5:
>>
>> Make this
>> case 0...5:
>> ?
>=20
> ...only that it confuses the compiler when using numbers. We can either

I did not see this as I replied to the previous email, sorry.

> keep the slightly ugly version, or introduce #defines.
> ZPCI_PCIAS_IOREGION_{MIN,MAX} (and maybe ZPCI_PCIAS_CONFIG for 15)?


I agree something is missing.
But I am not sure that a #define brings clarity.
I would prefer to add a comment.
	/* A ZPCI PCI card may use any BAR from BAR 0 to BAR 5 */

?


>>> +         * A length of 0 is invalid and length should not cross a do=
uble word
>>> +         */
>>> +        if (!len || (len > (8 - (offset & 0x7)))) {
>>>               program_interrupt(env, PGM_OPERAND, 4);
>>>               return 0;
>>>           }
>>> @@ -513,21 +518,21 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r=
1, uint8_t r2)
>>>               program_interrupt(env, PGM_OPERAND, 4);
>>>               return 0;
>>>           }
>>> -    } else if (pcias =3D=3D 15) {
>>> -        if ((4 - (offset & 0x3)) < len) {
>>> -            program_interrupt(env, PGM_OPERAND, 4);
>>> -            return 0;
>>> -        }
>>> -
>>> -        if (zpci_endian_swap(&data, len)) {
>>> +        break;
>>> +    case 15:
>>> +        /* ZPCI uses the pseudo BAR number 15 as configuration space=
 */
>>> +        /* possible access lengths are 1,2,4 and must not cross a wo=
rd */
>>> +        if (!len || (len > (4 - (offset & 0x3))) || len =3D=3D 3) {
>>>               program_interrupt(env, PGM_OPERAND, 4);
>>>               return 0;
>>>           }
>>> -
>>> +        /* len =3D 1,2,4 so we do not need to test */
>>> +        zpci_endian_swap(&data, len);
>>>           pci_host_config_write_common(pbdev->pdev, offset,
>>>                                        pci_config_size(pbdev->pdev),
>>>                                        data, len);
>>> -    } else {
>>> +        break;
>>> +    default:
>>>           DPRINTF("pcistg invalid space\n");
>>>           setcc(cpu, ZPCI_PCI_LS_ERR);
>>>           s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
>>
>> Other than the nits, looks good.
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
