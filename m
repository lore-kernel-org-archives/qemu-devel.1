Received: from eggs.gnu.org ([2001:4830:134:3::10]:42752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEHpY-00074z-OQ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEHpV-0000Yl-Hm
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:43:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33880
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEHpV-0000YX-BA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:43:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vADGeh3x093159
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 11:43:20 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e7ek19s3n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 11:43:19 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 16:43:18 -0000
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109173802.7a43dcc3.cohuck@redhat.com>
	<92ed4a36-5db9-9f76-069f-cd663bbe8aee@amsat.org>
	<20171109202033.1a0fb72b.cohuck@redhat.com>
	<6a7760da-7f46-e6fa-e503-691b127f3946@linux.vnet.ibm.com>
	<20171113173811.02e42414.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 17:43:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171113173811.02e42414.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9e1bc41e-d676-4814-4cde-4a49f900dd3a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] s390x/pci: factor out endianess
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, borntraeger@de.ibm.com

On 13/11/2017 17:38, Cornelia Huck wrote:
> On Mon, 13 Nov 2017 16:36:34 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> On 09/11/2017 20:20, Cornelia Huck wrote:
>>> On Thu, 9 Nov 2017 15:55:46 -0300
>>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>>>   =20
>>>> On 11/09/2017 01:38 PM, Cornelia Huck wrote:
>>>>> On Tue,  7 Nov 2017 18:24:33 +0100
>>>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>>>      =20
>>>>>> There are two places where the same endianness conversion
>>>>>> is done.
>>>>>> Let's factor this out into a static function.
>>>>>>
>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>>>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>    hw/s390x/s390-pci-inst.c | 58 ++++++++++++++++++++++++++-------=
---------------
>>>>>>    1 file changed, 32 insertions(+), 26 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>>>>> index 8e088f3..8fcb02d 100644
>>>>>> --- a/hw/s390x/s390-pci-inst.c
>>>>>> +++ b/hw/s390x/s390-pci-inst.c
>>>>>> @@ -314,6 +314,35 @@ out:
>>>>>>        return 0;
>>>>>>    }
>>>>>>   =20
>>>>>> +/**
>>>>>> + * This function swaps the data at ptr according from one
>>>>>> + * endianness to the other.
>>>>>> + * valid data in the uint64_t data field.
>>>>>
>>>>> I'm not sure what that line is supposed to mean?
>>>>>      =20
>>>>>> + * @ptr: a pointer to a uint64_t data field
>>>>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>>>>> + */
>>>>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>>>>> +{
>>>>>> +    uint64_t data =3D *ptr;
>>>>>> +    switch (len) {
>>>>>> +    case 1:
>>>>>> +        break;
>>>>>> +    case 2:
>>>>>> +        data =3D bswap16(data);
>>>>>> +        break;
>>>>>> +    case 4:
>>>>>> +        data =3D bswap32(data);
>>>>>> +        break;
>>>>>> +    case 8:
>>>>>> +        data =3D bswap64(data);
>>>>>> +        break;
>>>>>> +    default:
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +    *ptr =3D data;
>>>>>> +    return 0;
>>>>>> +}
>>>>
>>>> This is usually care taken by memory::adjust_endianness() ...
>>>
>>> Yes, but that's not a memory region write.
>>>   =20
>>>>  =20
>>>>> I was expecting more code to use a similar pattern, but it seems
>>>>> surprisingly uncommon.
>>>>
>>>> Which ring a bell for latent bug?
>>>
>>> Looking at this, it seems there *is* a latent bug, which has not popp=
ed
>>> up so far as the pci instructions are not wired up in tcg yet. This
>>> code is only called from the kvm path...
>>
>>
>> The value in the register may be read from memory somehow but it may
>> also be an immediate value, setup previously by another instruction.
>>
>> AFAIU the TCG would have already make sure that the value read from
>> memory has already been translated to big endian if read from a little
>> endian memory region.
>> So that the value in register is always big endian.
>>
>> OTOH the PCI memory is always little endian.
>>
>> So AFAIU we always need to translate from BIG to little, no mater if K=
VM
>> or TCG.
>>
>> But I am not sure that I did understand right what the TCG does.
>>
>> @Philippe, It does not seems to be the same problem as you encountered=
,
>> AFAIU your problem was between memory and a LE device and our is betwe=
en
>> a BE register and a LE device.
>>
>> Did I understood correctly what TCG does when emulating S390 ?
>=20
> So, if this function is supposed to work on a known-BE value, I think
> this should be fine. But a comment in the function description would be
> good...

Yes, I will do.
Thanks,

Pierre

>=20
>>
>>
>> Pierre
>>
>>>   =20
>>>>
>>>> This remind me of a similar issue on ppc:
>>>>
>>>> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05121.htm=
l
>>>> ...
>>>> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05666.htm=
l
>>>
>>>   =20
>>
>>
>=20
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
