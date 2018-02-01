Received: from eggs.gnu.org ([2001:4830:134:3::10]:47822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehDTQ-0002hp-5K
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehDTN-00010F-2M
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:56:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ehDTM-0000zk-Pj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:56:09 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w11BsVDX134329
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 06:56:07 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fv1m5jd43-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 06:56:07 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 11:56:04 -0000
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
	<20180131115824.7329b8ee.cohuck@redhat.com>
	<a048761a-7dbc-80e2-8b57-2b5b0fc35ff0@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 12:56:01 +0100
MIME-Version: 1.0
In-Reply-To: <a048761a-7dbc-80e2-8b57-2b5b0fc35ff0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Message-Id: <76ce13fe-f5e1-8b31-7f62-58c9d6b0271a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/pci: fixup the code walking
 IOMMU tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On 01/02/2018 12:28, Yi Min Zhao wrote:
>
>
> =E5=9C=A8 2018/1/31 =E4=B8=8B=E5=8D=886:58, Cornelia Huck =E5=86=99=E9=81=
=93:
>> On Tue, 30 Jan 2018 10:47:13 +0100
>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>
>>> Current s390x PCI IOMMU code is lack of flags' checking, including:
>>> 1) protection bit
>>> 2) table length
>>> 3) table offset
>>> 4) intermediate tables' invalid bit
>>> 5) format control bit
>>>
>>> This patch introduces a new struct named S390IOTLBEntry, and makes up
>>> these missed checkings. At the same time, inform the guest with the
>>> corresponding error number when the check fails.
>> There are a lot of things in this patch I cannot review due to -ENODOC=
,
>> but some comments below.
>>
>>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 hw/s390x/s390-pci-bus.c=C2=A0 | 223=20
>>> ++++++++++++++++++++++++++++++++++++++---------
>>> =C2=A0 hw/s390x/s390-pci-bus.h=C2=A0 |=C2=A0 10 +++
>>> =C2=A0 hw/s390x/s390-pci-inst.c |=C2=A0 10 ---
>>> =C2=A0 3 files changed, 190 insertions(+), 53 deletions(-)
>> (...)
>>
>>> +/* ett is expected table type, -1 page table, 0 segment table, 1=20
>>> region table */
>>> +static uint64_t get_table_index(uint64_t iova, int8_t ett)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 switch (ett) {
>>> +=C2=A0=C2=A0=C2=A0 case -1:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return calc_px(iova);
>>> +=C2=A0=C2=A0=C2=A0 case 0:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return calc_sx(iova);
>>> +=C2=A0=C2=A0=C2=A0 case 1:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return calc_rtx(iova);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return -1;
>> You use ett to differentiate between the three table types a lot. Is
>> this an architectured value, or an internal construct?
> It's an architectured value to some degree, because it's used to descri=
pt
> the translation more clearly in the doc.
>>
>> If you introduced it yourself, it might make sense to switch to an enu=
m
>> instead. Otherwise, using some #defines would improve readability of
>> the code.
> OK. I will add macros in next version.
>>
>>> +}
>> (...)
>>
>>> +/**
>>> + * table_translate: do translation within one table and return the=20
>>> following
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 table origin
>>> + *
>>> + * @entry: the entry being traslated, the result is stored in this.
>> s/traslated/translated/
> OK.
>>
>>> + * @to: the address of table origin.
>>> + * @ett: expected table type, 1 region table, 0 segment table and=20
>>> -1 page table.
>>> + * @error: error code
>>> + */
>>> +static uint64_t table_translate(S390IOTLBEntry *entry, uint64_t to,=20
>>> int8_t ett,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t *error)
>> (...)
>>
>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>> index be449210d9..63fa06fb97 100644
>>> --- a/hw/s390x/s390-pci-inst.c
>>> +++ b/hw/s390x/s390-pci-inst.c
>>> @@ -644,16 +644,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t=20
>>> r1, uint8_t r2, uintptr_t ra)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (start < end) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D imrc=
->translate(iommu_mr, start, IOMMU_NONE);
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!entry.translated_add=
r) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
bdev->state =3D ZPCI_FS_ERROR;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
etcc(cpu, ZPCI_PCI_LS_ERR);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
390_pci_generate_error_event(ERR_EVENT_SERR,=20
>>> pbdev->fh, pbdev->fid,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 start, ERR_EVENT_Q_BIT);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto out;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_=
notify_iommu(iommu_mr, entry);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start +=3D ent=
ry.addr_mask + 1;
>> You're now progressing even though you might have generated an error
>> event. Is that what's intended?
> Yes, this is wrong. The right thing is only delete the code generating=20
> error event,
> and keep the if check here in this patch.

Hum, I do not see any problem with having a translated address being 0.

I would say it is one of the fixup ;) .

Regards,
Pierre

>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
