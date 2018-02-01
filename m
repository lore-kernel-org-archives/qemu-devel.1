Received: from eggs.gnu.org ([2001:4830:134:3::10]:50867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehEjr-0006nh-8C
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehEjn-0008LF-6P
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:17:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ehEjm-0008Kv-U8
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:17:11 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w11DFT3m129634
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 08:17:09 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fv2vvjadn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 08:17:07 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 13:17:05 -0000
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
	<20180131115824.7329b8ee.cohuck@redhat.com>
	<a048761a-7dbc-80e2-8b57-2b5b0fc35ff0@linux.vnet.ibm.com>
	<76ce13fe-f5e1-8b31-7f62-58c9d6b0271a@linux.vnet.ibm.com>
	<20180201131500.637834fc.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 14:17:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180201131500.637834fc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <52c8d3ef-9863-871a-c674-08024a70ab32@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On 01/02/2018 13:15, Cornelia Huck wrote:
> On Thu, 1 Feb 2018 12:56:01 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 01/02/2018 12:28, Yi Min Zhao wrote:
>>>
>>> =E5=9C=A8 2018/1/31 =E4=B8=8B=E5=8D=886:58, Cornelia Huck =E5=86=99=E9=
=81=93:
>>>> On Tue, 30 Jan 2018 10:47:13 +0100
>>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>>>> index be449210d9..63fa06fb97 100644
>>>>> --- a/hw/s390x/s390-pci-inst.c
>>>>> +++ b/hw/s390x/s390-pci-inst.c
>>>>> @@ -644,16 +644,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t
>>>>> r1, uint8_t r2, uintptr_t ra)
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (start < end) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D i=
mrc->translate(iommu_mr, start, IOMMU_NONE);
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!entry.translated_a=
ddr) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pbdev->state =3D ZPCI_FS_ERROR;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 setcc(cpu, ZPCI_PCI_LS_ERR);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s390_pci_generate_error_event(ERR_EVENT_SERR,
>>>>> pbdev->fh, pbdev->fid,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start, ERR_EVENT_Q_BIT);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto out;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_regi=
on_notify_iommu(iommu_mr, entry);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start +=3D =
entry.addr_mask + 1;
>>>> You're now progressing even though you might have generated an error
>>>> event. Is that what's intended?
>>> Yes, this is wrong. The right thing is only delete the code generatin=
g
>>> error event,
>>> and keep the if check here in this patch.
>> Hum, I do not see any problem with having a translated address being 0.
>>
>> I would say it is one of the fixup ;) .
> Isn't this in response to an instruction that is supposed to
> register/... something? IOW, the caller of the instruction tried to
> make something happen, but something did not work out as intended (and
> doesn't the code stumble over this later? Or do we get an error then?)
> Shouldn't the caller get an indication of that? Of course, this again
> depends on what the architecture says :)
>
I don't think so, I think it was really an implementation error in the
previous code because we have no way to return an error from the
translate() function, we just return the TLB entry.

If we have an R or W or RW entry we return the entry in all other cases,
including a RW protected, invalid or on internal error entry we return=20
IOMMU_NONE

IMHO it would have been clearer if this function have been void.

Regards,

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
