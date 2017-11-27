Received: from eggs.gnu.org ([2001:4830:134:3::10]:59244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJEbz-0003gl-FR
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJEbu-00010m-I4
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:17:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eJEbu-00010H-97
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:17:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAR88bru129938
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 03:17:48 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2egceje1d1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 03:17:48 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 08:17:46 -0000
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<5741f969-30b8-eda9-3b37-a89f8c8e7310@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 09:17:44 +0100
MIME-Version: 1.0
In-Reply-To: <5741f969-30b8-eda9-3b37-a89f8c8e7310@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ee5bae91-1685-d019-548f-dfeac6f3806e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/7] s390x/pci: rework PCI STORE BLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de

On 23/11/2017 10:26, Thomas Huth wrote:
> On 22.11.2017 23:05, Pierre Morel wrote:
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
>>   hw/s390x/s390-pci-inst.c | 63 ++++++++++++++++++++++++++++++--------=
----------
>>   hw/s390x/s390-pci-inst.h |  2 +-
>>   3 files changed, 41 insertions(+), 25 deletions(-)
> [...]
>> @@ -722,6 +733,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r3, uint64_t gaddr,
>>  =20
>>       setcc(cpu, ZPCI_PCI_LS_OK);
>>       return 0;
>> +
>> +addressing_error:
>> +    program_interrupt(env, PGM_SPECIFICATION, 6);
>=20
> The label is called "addressing_error", but then you insert a
> PGM_SPECIFICTATION ? According to the name of the label, I'd rather
> expected a PGM_ADDRESSING here ... so maybe rename the label to
> "spec_error" or something similar?
>=20
>> +    return 0;
>>   }
>=20
>   Thomas
>=20

I used this name because the error is really related to an addressing=20
problem, alignment, crossing a boundary.
I agree, if no opinion against it I will change it to spec_error.

Thanks,

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
