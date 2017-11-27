Received: from eggs.gnu.org ([2001:4830:134:3::10]:45968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJHLf-0003gb-2f
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJHLX-0004LY-0m
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:13:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eJHLW-0004L7-OJ
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:13:06 -0500
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
	<37aa6eb3-cbdf-39af-2068-7d0e5949e601@linux.vnet.ibm.com>
	<2ab76ab0-b20a-9eaf-cafb-195e1621edd6@redhat.com>
	<fc028628-55ae-a9d5-d226-ae611d56fa0e@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <29101b83-77c9-7a6f-e243-f4a856a1e609@redhat.com>
Date: Mon, 27 Nov 2017 12:13:03 +0100
MIME-Version: 1.0
In-Reply-To: <fc028628-55ae-a9d5-d226-ae611d56fa0e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 27.11.2017 11:09, Yi Min Zhao wrote:
>=20
>=20
> =E5=9C=A8 2017/11/27 =E4=B8=8B=E5=8D=882:59, Thomas Huth =E5=86=99=E9=81=
=93:
>> On 25.11.2017 14:49, Pierre Morel wrote:
>>> On 24/11/2017 07:19, Yi Min Zhao wrote:
>>>>
>>>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=888:18, Thomas Huth =E5=86=99=E9=
=81=93:
>>>>> On 23.11.2017 13:07, Yi Min Zhao wrote:
>>>>>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=886:33, Cornelia Huck =E5=86=99=
=E9=81=93:
>>>>>>> On Thu, 23 Nov 2017 11:25:10 +0100
>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>
>>>>>>>> On 23.11.2017 11:08, Cornelia Huck wrote:
>>>>>>>>> On Thu, 23 Nov 2017 11:01:23 +0100
>>>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>>>> On 23.11.2017 10:49, Cornelia Huck wrote:
>>>>>>>>>>> On Thu, 23 Nov 2017 09:48:41 +0100
>>>>>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>>>>>> On 22.11.2017 23:05, Pierre Morel wrote:
>>>>>>>> [...]
>>>>>>>>>>>>> +/**
>>>>>>>>>>>>> + * Swap data contained in s390x big endian registers to
>>>>>>>>>>>>> little
>>>>>>>>>>>>> endian
>>>>>>>>>>>>> + * PCI bars.
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * @ptr: a pointer to a uint64_t data field
>>>>>>>>>>>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>>>>>>>>>>>> + */
>>>>>>>>>>>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t data =3D *ptr;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 switch (len) {
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 1:
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 2:
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap1=
6(data);
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 4:
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap3=
2(data);
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 8:
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap6=
4(data);
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 *ptr =3D data;
>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>>>>>> +}
>>>>>>>>>>>> While you're at it, I think that should rather be leXX_to_cp=
u()
>>>>>>>>>>>> instead
>>>>>>>>>>>> of bswapXX() here,
>>>>>>>>>>> I don't think that's correct, as this is supposed to swap BE
>>>>>>>>>>> registers
>>>>>>>>>>> to LE PCI bars.
>>>>>>>>>> Yes, but for the CPU emulation, the registers are stored in th=
e
>>>>>>>>>> host's
>>>>>>>>>> endianness in the CPUS390XState structure. Or why do we
>>>>>>>>>> byte-swap them
>>>>>>>>>> again with cpu_to_be64() during s390_store_status(), for examp=
le?
>>>>>>>>> Gah, endian conversion is eating my brain...
>>>>>>>>>
>>>>>>>>> So, is the content we get BE or not? I thought in our last
>>>>>>>>> discussion
>>>>>>>>> we came to the conclusion that it is.
>>>>>>>> data is read from / written to env->regs[r1], so this is host
>>>>>>>> endian, as
>>>>>>>> far as I know. PCI is little endian, so using le32_to_cpu() /
>>>>>>>> cpu_to_le32() should IMHO be the right way to go here.
>>>>>>>>
>>>>>>>> By the way, if we want to use both, cpu_to_le and le_to_cpu,
>>>>>>>> depending
>>>>>>>> on whether we read from or write to PCI, we should maybe *not* p=
ut
>>>>>>>> this
>>>>>>>> code into a separate function?
>>>>>>> Yes, if your assessment is correct, we need two functions (I thin=
k
>>>>>>> this
>>>>>>> conversion is used in other places in later patches as well). Or =
are
>>>>>>> there mechanisms for that already available?
>>>>>> I have a question, is the data in cpu->regs the guest's endianess?
>>>>> As far as I know, it's host endianness, so on x86 with TCG emulatio=
n,
>>>>> it's little endian.
>>>>>
>>>>>> In our case, the guest is S390. Although the arch is big-endian, t=
he
>>>>>> data in
>>>>>> pcilg/stg instructions is little-endian.
>>>>> PCI memory is always little endian, right.
>>>>>
>>>>>> Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu()
>>>>>> mean the
>>>>>> host endianess?
>>>>> Yes, the "cpu" in cpu_to_le or le_to_cpu means the host, indeed. It=
's
>>>>> confusing :-/
>>>>>
>>>>>> If the answers to upper two questions are yes, we actually need
>>>>>> handle
>>>>>> two cases.
>>>>>> 1) For pcilg, we need to translate the data to little-endian, thus
>>>>>> cpu_to_le**().
>>>>>> 2) For pcistg, we need to translate the data to host endianess, th=
us
>>>>>> le**_to_cpu().
>>>>> I think we've got to byte-swap if the host is big endian (s390x), b=
ut
>>>>> not if the host is little endian (x86 with TCG).
>>> Here is my comprehension of this funny swapping:
>>>
>>> - TCG for a BE guest and a le host swap bytes because if we do (regis=
ter
>>> & 0x01) in the zPCI interception code it must work what ever the
>>> endianess is.
>> Uhhh, I might have missed that the value has already been byte-swapped
>> once by TCG for env->regs[r1] ...
>
> I want to ask a question. For this case, BE guest and LE host, is
> env->regs[r1] in LE byte ordering?

Generally env->regs[] are in host byte order, so LE if the host is LE.
Not sure which byte-order is stored in the register by the guest,
though, since I don't have the zPCI spec ... so if the (BE) guest wrote
a LE value in the register, and TCG byte-swapped it again, the value is
suddenly BE again and thus we have to always byte-swap it again...?
Sorry, it's hard to say without having the spec available.

 Thomas
