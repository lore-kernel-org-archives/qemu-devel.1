Received: from eggs.gnu.org ([2001:4830:134:3::10]:35531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHoh5-0006fE-Ih
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHoh0-0003tI-K5
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:25:19 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<3acc6fdb-5638-97b2-2dc7-bce34d22cd1f@redhat.com>
	<20171123104903.24424b40.cohuck@redhat.com>
	<a3655016-0e6b-b80f-2282-f6efbff9e1f9@redhat.com>
	<20171123110844.4649f3b1.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <58a08c1d-3935-42e7-cdc0-7bc45c08d2d3@redhat.com>
Date: Thu, 23 Nov 2017 11:25:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171123110844.4649f3b1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/7] s390x/pci: factor out endianess
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
Cc: pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On 23.11.2017 11:08, Cornelia Huck wrote:
> On Thu, 23 Nov 2017 11:01:23 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 23.11.2017 10:49, Cornelia Huck wrote:
>>> On Thu, 23 Nov 2017 09:48:41 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>> On 22.11.2017 23:05, Pierre Morel wrote: =20
[...]
>>>>> +/**
>>>>> + * Swap data contained in s390x big endian registers to little end=
ian
>>>>> + * PCI bars.
>>>>> + *
>>>>> + * @ptr: a pointer to a uint64_t data field
>>>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>>>> + */
>>>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>>>> +{
>>>>> +    uint64_t data =3D *ptr;
>>>>> +
>>>>> +    switch (len) {
>>>>> +    case 1:
>>>>> +        break;
>>>>> +    case 2:
>>>>> +        data =3D bswap16(data);
>>>>> +        break;
>>>>> +    case 4:
>>>>> +        data =3D bswap32(data);
>>>>> +        break;
>>>>> +    case 8:
>>>>> +        data =3D bswap64(data);
>>>>> +        break;
>>>>> +    default:
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +    *ptr =3D data;
>>>>> +    return 0;
>>>>> +}   =20
>>>>
>>>> While you're at it, I think that should rather be leXX_to_cpu() inst=
ead
>>>> of bswapXX() here, =20
>>>
>>> I don't think that's correct, as this is supposed to swap BE register=
s
>>> to LE PCI bars. =20
>>
>> Yes, but for the CPU emulation, the registers are stored in the host's
>> endianness in the CPUS390XState structure. Or why do we byte-swap them
>> again with cpu_to_be64() during s390_store_status(), for example?
>=20
> Gah, endian conversion is eating my brain...
>=20
> So, is the content we get BE or not? I thought in our last discussion
> we came to the conclusion that it is.

data is read from / written to env->regs[r1], so this is host endian, as
far as I know. PCI is little endian, so using le32_to_cpu() /
cpu_to_le32() should IMHO be the right way to go here.

By the way, if we want to use both, cpu_to_le and le_to_cpu, depending
on whether we read from or write to PCI, we should maybe *not* put this
code into a separate function?

> [I really need to continue working on wiring up zpci in tcg, but I keep
> getting sidetracked.]

Maybe best if you get it running on a big endian host first ... if it is
then not working on a little endian host, you know that you have to look
for things like these "bswapXX()" statements...

 Thomas
