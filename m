Received: from eggs.gnu.org ([2001:4830:134:3::10]:36975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIXsI-0004qx-N2
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIXsF-00072K-Jn
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:39:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eIXsF-000717-A6
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 05:39:51 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAPAd0nJ035760
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 05:39:48 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ef5wq1mg9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 05:39:47 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Sat, 25 Nov 2017 10:39:45 -0000
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<321b3e16-19bc-f519-4375-fe865ed64bad@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Sat, 25 Nov 2017 11:39:40 +0100
MIME-Version: 1.0
In-Reply-To: <321b3e16-19bc-f519-4375-fe865ed64bad@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9658fc79-5925-5bc7-0aa6-d20d5ab07b84@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/pci: rework PCI STORE
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

On 23/11/2017 10:01, Thomas Huth wrote:
> On 22.11.2017 23:05, Pierre Morel wrote:
>> Enhance the fault detection, correction of the fault reporting.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 39 ++++++++++++++++++++++----------------=
-
>>   1 file changed, 22 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 3e1f1a0..930c197 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -470,6 +470,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>       pcias =3D (env->regs[r2] >> 16) & 0xf;
>>       len =3D env->regs[r2] & 0xf;
>>       offset =3D env->regs[r2 + 1];
>> +    data =3D env->regs[r1];
>> +
>> +    if (!(fh & FH_MASK_ENABLE)) {
>> +        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
>> +        return 0;
>> +    }
>>  =20
>>       pbdev =3D s390_pci_find_dev_by_fh(s390_get_phb(), fh);
>>       if (!pbdev) {
>> @@ -479,12 +485,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
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
>=20
> -EMISSINGPUBLICDOCUMENTATION

Hi Thomas,

I do not understand what you mean here

>=20
>> @@ -493,9 +494,13 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>           break;
>>       }
>>  =20
>> -    data =3D env->regs[r1];
>> -    if (pcias < 6) {
>> -        if ((8 - (offset & 0x7)) < len) {
>> +    switch (pcias) {
>> +        /* A ZPCI PCI card may use any BAR from BAR 0 to BAR 5 */
>> +    case 0 ... 5:
>> +        /* Check length:
>> +         * A length of 0 is invalid and length should not cross a dou=
ble word
>> +         */
>> +        if (!len || (len > (8 - (offset & 0x7)))) {
>>               program_interrupt(env, PGM_OPERAND, 4);
>>               return 0;
>>           }
>> @@ -513,21 +518,21 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1=
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
>> +        /* possible access lengths are 1,2,4 and must not cross a wor=
d */
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
>> +    default:
>>           DPRINTF("pcistg invalid space\n");
>>           setcc(cpu, ZPCI_PCI_LS_ERR);
>>           s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
>>
>=20
> At least the last two hunks looks fine to me. If you want to have a
> Reviewed-by for this, you could maybe put these two hunks into a
> separate patch instead?

I do not understand what yo umean with the first one.
Can you explain?

Thanks

Pierre

>=20
>   Thomas
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
