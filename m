Received: from eggs.gnu.org ([2001:4830:134:3::10]:57505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEAes-0007AG-El
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEAem-00059K-KV
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:03:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEAem-00058a-8z
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:03:52 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAD92IXq077904
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:03:43 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e759b84q5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:03:43 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 09:03:40 -0000
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109175018.1c2f1b60.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 10:03:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171109175018.1c2f1b60.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b1d8f3bf-b04c-1270-6ed0-ef5dfe7940d5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] s390x/pci: rework PCI STORE
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

On 09/11/2017 17:50, Cornelia Huck wrote:
> On Tue,  7 Nov 2017 18:24:34 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Enhance the fault detection, correction of the fault reporting.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 41 ++++++++++++++++++++++++--------------=
---
>>   1 file changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 8fcb02d..4a2f996 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -469,6 +469,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>       pcias =3D (env->regs[r2] >> 16) & 0xf;
>>       len =3D env->regs[r2] & 0xf;
>>       offset =3D env->regs[r2 + 1];
>> +    data =3D env->regs[r1];
>> +
>> +    if (!(fh & FH_MASK_ENABLE)) {
>=20
> This covers the reserved/standby/disabled states, right?

yes it does, all these states have the FH_MASK_ENABLE set to 0

>=20
>> +        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
>> +        return 0;
>> +    }
>>  =20
>>       pbdev =3D s390_pci_find_dev_by_fh(s390_get_phb(), fh);
>>       if (!pbdev) {
>> @@ -478,12 +484,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>       }
>>  =20
>>       switch (pbdev->state) {
>> -    case ZPCI_FS_RESERVED:
>> -    case ZPCI_FS_STANDBY:
>> -    case ZPCI_FS_DISABLED:
>>       case ZPCI_FS_PERMANENT_ERROR:
>> -        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
>> -        return 0;
>>       case ZPCI_FS_ERROR:
>>           setcc(cpu, ZPCI_PCI_LS_ERR);
>>           s390_set_status_code(env, r2, ZPCI_PCI_ST_BLOCKED);
>> @@ -492,9 +493,13 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>           break;
>>       }
>>  =20
>> -    data =3D env->regs[r1];
>> -    if (pcias < 6) {
>> -        if ((8 - (offset & 0x7)) < len) {
>> +    /* Test that the pcias is a valid pcias and do the according oper=
ations */
>=20
> s/according/appropriate/ ?

yes, better, thanks

>=20
>> +    switch (pcias) {
>> +    case 0 ... 5:
>> +        /* Check length:
>> +         * A length of 0 is invalid and length should not cross a dou=
ble word
>> +         */
>> +        if (!len || (len > (8 - (offset & 0x7)))) {
>>               program_interrupt(env, PGM_OPERAND, 4);
>>               return 0;
>>           }
>> @@ -512,21 +517,23 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1=
, uint8_t r2)
>>               program_interrupt(env, PGM_OPERAND, 4);
>>               return 0;
>>           }
>> -    } else if (pcias =3D=3D 15) {
>> -        if ((4 - (offset & 0x3)) < len) {
>> -            program_interrupt(env, PGM_OPERAND, 4);
>> -            return 0;
>> -        }
>> -
>> -        if (zpci_endian_swap(&data, len)) {
>> +        break;
>> +    case 15:
>> +        /* ZPCI uses the pseudo BAR number 15 as configuration space =
*/
>> +        /* possible access length are 1,2,4 and must not cross a word=
 */
>=20
> s/length/lengths/
yes, thanks

>=20
>> +        if (!len || (len > (4 - (offset & 0x3))) || len =3D=3D 3) {
>>               program_interrupt(env, PGM_OPERAND, 4);
>>               return 0;
>>           }
>> -
>> +        /* len =3D 1,2,4 so we do not need to test */
>> +        zpci_endian_swap(&data, len);
>>           pci_host_config_write_common(pbdev->pdev, offset,
>>                                        pci_config_size(pbdev->pdev),
>>                                        data, len);
>> -    } else {
>> +        break;
>> +    case PCI_ROM_SLOT:
>=20
> So, will this be filled in a later patch? (Reading from the top.)

No it will not it is only a reminder that we explicitly do not support it.
Since I do not know if we ever will support it do you think I better let=20
it fall?

>=20
>> +        /* Fall through */
>> +    default:
>>           DPRINTF("pcistg invalid space\n");
>>           setcc(cpu, ZPCI_PCI_LS_ERR);
>>           s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
>=20
> On the whole, I think this improves readability, especially for folks
> that do not have access to the spec.
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
