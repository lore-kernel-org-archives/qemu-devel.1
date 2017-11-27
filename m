Received: from eggs.gnu.org ([2001:4830:134:3::10]:59412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJDOO-0007ZQ-DM
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJDOJ-0008DX-GP
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:59:48 -0500
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
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2ab76ab0-b20a-9eaf-cafb-195e1621edd6@redhat.com>
Date: Mon, 27 Nov 2017 07:59:36 +0100
MIME-Version: 1.0
In-Reply-To: <37aa6eb3-cbdf-39af-2068-7d0e5949e601@linux.vnet.ibm.com>
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On 25.11.2017 14:49, Pierre Morel wrote:
> On 24/11/2017 07:19, Yi Min Zhao wrote:
>>
>>
>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=888:18, Thomas Huth =E5=86=99=E9=81=
=93:
>>> On 23.11.2017 13:07, Yi Min Zhao wrote:
>>>>
>>>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=886:33, Cornelia Huck =E5=86=99=
=E9=81=93:
>>>>> On Thu, 23 Nov 2017 11:25:10 +0100
>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>
>>>>>> On 23.11.2017 11:08, Cornelia Huck wrote:
>>>>>>> On Thu, 23 Nov 2017 11:01:23 +0100
>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>> On 23.11.2017 10:49, Cornelia Huck wrote:
>>>>>>>>> On Thu, 23 Nov 2017 09:48:41 +0100
>>>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>>>> On 22.11.2017 23:05, Pierre Morel wrote:
>>>>>> [...]
>>>>>>>>>>> +/**
>>>>>>>>>>> + * Swap data contained in s390x big endian registers to litt=
le
>>>>>>>>>>> endian
>>>>>>>>>>> + * PCI bars.
>>>>>>>>>>> + *
>>>>>>>>>>> + * @ptr: a pointer to a uint64_t data field
>>>>>>>>>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>>>>>>>>>> + */
>>>>>>>>>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>>>>>>>>>> +{
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t data =3D *ptr;
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 switch (len) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 1:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 2:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap16(=
data);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 4:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap32(=
data);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 8:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap64(=
data);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 *ptr =3D data;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>>>> +}
>>>>>>>>>> While you're at it, I think that should rather be leXX_to_cpu(=
)
>>>>>>>>>> instead
>>>>>>>>>> of bswapXX() here,
>>>>>>>>> I don't think that's correct, as this is supposed to swap BE
>>>>>>>>> registers
>>>>>>>>> to LE PCI bars.
>>>>>>>> Yes, but for the CPU emulation, the registers are stored in the
>>>>>>>> host's
>>>>>>>> endianness in the CPUS390XState structure. Or why do we
>>>>>>>> byte-swap them
>>>>>>>> again with cpu_to_be64() during s390_store_status(), for example=
?
>>>>>>> Gah, endian conversion is eating my brain...
>>>>>>>
>>>>>>> So, is the content we get BE or not? I thought in our last
>>>>>>> discussion
>>>>>>> we came to the conclusion that it is.
>>>>>> data is read from / written to env->regs[r1], so this is host
>>>>>> endian, as
>>>>>> far as I know. PCI is little endian, so using le32_to_cpu() /
>>>>>> cpu_to_le32() should IMHO be the right way to go here.
>>>>>>
>>>>>> By the way, if we want to use both, cpu_to_le and le_to_cpu,
>>>>>> depending
>>>>>> on whether we read from or write to PCI, we should maybe *not* put
>>>>>> this
>>>>>> code into a separate function?
>>>>> Yes, if your assessment is correct, we need two functions (I think
>>>>> this
>>>>> conversion is used in other places in later patches as well). Or ar=
e
>>>>> there mechanisms for that already available?
>>>> I have a question, is the data in cpu->regs the guest's endianess?
>>> As far as I know, it's host endianness, so on x86 with TCG emulation,
>>> it's little endian.
>>>
>>>> In our case, the guest is S390. Although the arch is big-endian, the
>>>> data in
>>>> pcilg/stg instructions is little-endian.
>>> PCI memory is always little endian, right.
>>>
>>>> Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu() mean =
the
>>>> host endianess?
>>> Yes, the "cpu" in cpu_to_le or le_to_cpu means the host, indeed. It's
>>> confusing :-/
>>>
>>>> If the answers to upper two questions are yes, we actually need hand=
le
>>>> two cases.
>>>> 1) For pcilg, we need to translate the data to little-endian, thus
>>>> cpu_to_le**().
>>>> 2) For pcistg, we need to translate the data to host endianess, thus
>>>> le**_to_cpu().
>>> I think we've got to byte-swap if the host is big endian (s390x), but
>>> not if the host is little endian (x86 with TCG).
>=20
> Here is my comprehension of this funny swapping:
>=20
> - TCG for a BE guest and a le host swap bytes because if we do (registe=
r
> & 0x01) in the zPCI interception code it must work what ever the
> endianess is.

Uhhh, I might have missed that the value has already been byte-swapped
once by TCG for env->regs[r1] ...
Now I'm pretty much completely confused ... sorry for the noise if I was
wrong... I think it's best you ignore my comment for now (i.e. go with
bswapXX() instead of le_to_cpuXX()), and if we later wire up zPCI with
TCG, we still can fix this if necessary.

 Thomas
