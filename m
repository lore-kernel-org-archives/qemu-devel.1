Received: from eggs.gnu.org ([2001:4830:134:3::10]:60026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIapj-0002Jf-9T
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 08:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eIape-0000wb-JH
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 08:49:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eIape-0000vo-AO
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 08:49:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAPDnCHx039955
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 08:49:19 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ef3qy2deg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 08:49:18 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Sat, 25 Nov 2017 13:49:16 -0000
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<3acc6fdb-5638-97b2-2dc7-bce34d22cd1f@redhat.com>
	<20171123104903.24424b40.cohuck@redhat.com>
	<a3655016-0e6b-b80f-2282-f6efbff9e1f9@redhat.com>
	<20171123110844.4649f3b1.cohuck@redhat.com>
	<58a08c1d-3935-42e7-cdc0-7bc45c08d2d3@redhat.com>
	<20171123113326.3b2c5281.cohuck@redhat.com>
	<6ab0d29e-1af0-888a-c932-a0a294ea225d@linux.vnet.ibm.com>
	<d59edb51-71ba-7b75-83df-e4be246d2fce@redhat.com>
	<4000596f-d2a0-c32e-7683-7e074e8132e2@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Sat, 25 Nov 2017 14:49:12 +0100
MIME-Version: 1.0
In-Reply-To: <4000596f-d2a0-c32e-7683-7e074e8132e2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <37aa6eb3-cbdf-39af-2068-7d0e5949e601@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/7] s390x/pci: factor out
 endianess conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On 24/11/2017 07:19, Yi Min Zhao wrote:
>=20
>=20
> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=888:18, Thomas Huth =E5=86=99=E9=81=
=93:
>> On 23.11.2017 13:07, Yi Min Zhao wrote:
>>>
>>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=886:33, Cornelia Huck =E5=86=99=E9=
=81=93:
>>>> On Thu, 23 Nov 2017 11:25:10 +0100
>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>>> On 23.11.2017 11:08, Cornelia Huck wrote:
>>>>>> On Thu, 23 Nov 2017 11:01:23 +0100
>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>> On 23.11.2017 10:49, Cornelia Huck wrote:
>>>>>>>> On Thu, 23 Nov 2017 09:48:41 +0100
>>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>>> On 22.11.2017 23:05, Pierre Morel wrote:
>>>>> [...]
>>>>>>>>>> +/**
>>>>>>>>>> + * Swap data contained in s390x big endian registers to littl=
e
>>>>>>>>>> endian
>>>>>>>>>> + * PCI bars.
>>>>>>>>>> + *
>>>>>>>>>> + * @ptr: a pointer to a uint64_t data field
>>>>>>>>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>>>>>>>>> + */
>>>>>>>>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>>>>>>>>> +{
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t data =3D *ptr;
>>>>>>>>>> +
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 switch (len) {
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 1:
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 2:
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap16(d=
ata);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 4:
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap32(d=
ata);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 8:
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap64(d=
ata);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 *ptr =3D data;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>>> +}
>>>>>>>>> While you're at it, I think that should rather be leXX_to_cpu()
>>>>>>>>> instead
>>>>>>>>> of bswapXX() here,
>>>>>>>> I don't think that's correct, as this is supposed to swap BE
>>>>>>>> registers
>>>>>>>> to LE PCI bars.
>>>>>>> Yes, but for the CPU emulation, the registers are stored in the=20
>>>>>>> host's
>>>>>>> endianness in the CPUS390XState structure. Or why do we byte-swap=
=20
>>>>>>> them
>>>>>>> again with cpu_to_be64() during s390_store_status(), for example?
>>>>>> Gah, endian conversion is eating my brain...
>>>>>>
>>>>>> So, is the content we get BE or not? I thought in our last discuss=
ion
>>>>>> we came to the conclusion that it is.
>>>>> data is read from / written to env->regs[r1], so this is host=20
>>>>> endian, as
>>>>> far as I know. PCI is little endian, so using le32_to_cpu() /
>>>>> cpu_to_le32() should IMHO be the right way to go here.
>>>>>
>>>>> By the way, if we want to use both, cpu_to_le and le_to_cpu, depend=
ing
>>>>> on whether we read from or write to PCI, we should maybe *not* put=20
>>>>> this
>>>>> code into a separate function?
>>>> Yes, if your assessment is correct, we need two functions (I think t=
his
>>>> conversion is used in other places in later patches as well). Or are
>>>> there mechanisms for that already available?
>>> I have a question, is the data in cpu->regs the guest's endianess?
>> As far as I know, it's host endianness, so on x86 with TCG emulation,
>> it's little endian.
>>
>>> In our case, the guest is S390. Although the arch is big-endian, the
>>> data in
>>> pcilg/stg instructions is little-endian.
>> PCI memory is always little endian, right.
>>
>>> Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu() mean t=
he
>>> host endianess?
>> Yes, the "cpu" in cpu_to_le or le_to_cpu means the host, indeed. It's
>> confusing :-/
>>
>>> If the answers to upper two questions are yes, we actually need handl=
e
>>> two cases.
>>> 1) For pcilg, we need to translate the data to little-endian, thus
>>> cpu_to_le**().
>>> 2) For pcistg, we need to translate the data to host endianess, thus
>>> le**_to_cpu().
>> I think we've got to byte-swap if the host is big endian (s390x), but
>> not if the host is little endian (x86 with TCG).



Here is my comprehension of this funny swapping:

- TCG for a BE guest and a le host swap bytes because if we do (register=20
& 0x01) in the zPCI interception code it must work what ever the=20
endianess is.

- Guest always write data Little Endian because it think it writes to PCI.

- Kernel standard PCI code needs to swap endianness for a BE host but=20
not for a le host.


So it follows:

Z Guest writes data BE in its register and swap its data to le before=20
issuing zPCI

QEMU intercepts, receives the data from the register and store it
	-> Native: it stores as is: -> le
	-> TCG: it stores swapping data -> BE

QEMU-PCI swaps the bytes always
	-> Native : data is now BE
	-> TCG: data is now le

QEMU send the data to the PCI card
	-> Native, it goes through kernel which swap BE ->le
	-> TCG: data is directly written to PCI memory: -> le

So for my view, we must always swap data. if we want it le at the end

It comes because
1) guest and host kernels both make and translation BE->le
    the QEMU PCI needs to swap back the data before sending to the host

2) TCG swap the bytes, i.e. le->BE on saving registers
    the QEMU PCI writes directly to the memory then it needs to swap to
    back to le

I may have miss something or misunderstood something else so : Is it righ=
t?

Regards,

Pierre


>=20
>=20
> Thanks for your replies! We will send the new version ASAP to udpate=20
> this patch.
>>
>> =C2=A0 Thomas
>>
>>
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
