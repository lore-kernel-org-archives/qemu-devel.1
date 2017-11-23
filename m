Received: from eggs.gnu.org ([2001:4830:134:3::10]:34605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eHqIV-0000P9-5M
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eHqIL-00011Q-Me
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:07:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51806
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eHqIL-00010P-Gi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:07:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vANC5cbH002387
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 07:07:50 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2edtdcrkd5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 07:07:49 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Thu, 23 Nov 2017 07:07:49 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<3acc6fdb-5638-97b2-2dc7-bce34d22cd1f@redhat.com>
	<20171123104903.24424b40.cohuck@redhat.com>
	<a3655016-0e6b-b80f-2282-f6efbff9e1f9@redhat.com>
	<20171123110844.4649f3b1.cohuck@redhat.com>
	<58a08c1d-3935-42e7-cdc0-7bc45c08d2d3@redhat.com>
	<20171123113326.3b2c5281.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 20:07:40 +0800
MIME-Version: 1.0
In-Reply-To: <20171123113326.3b2c5281.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <6ab0d29e-1af0-888a-c932-a0a294ea225d@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: pasic@linux.vnet.ibm.com, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>



=D4=DA 2017/11/23 =CF=C2=CE=E76:33, Cornelia Huck =D0=B4=B5=C0:
> On Thu, 23 Nov 2017 11:25:10 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>
>> On 23.11.2017 11:08, Cornelia Huck wrote:
>>> On Thu, 23 Nov 2017 11:01:23 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>   =20
>>>> On 23.11.2017 10:49, Cornelia Huck wrote:
>>>>> On Thu, 23 Nov 2017 09:48:41 +0100
>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>> On 22.11.2017 23:05, Pierre Morel wrote:
>> [...]
>>>>>>> +/**
>>>>>>> + * Swap data contained in s390x big endian registers to little e=
ndian
>>>>>>> + * PCI bars.
>>>>>>> + *
>>>>>>> + * @ptr: a pointer to a uint64_t data field
>>>>>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>>>>>> + */
>>>>>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>>>>>> +{
>>>>>>> +    uint64_t data =3D *ptr;
>>>>>>> +
>>>>>>> +    switch (len) {
>>>>>>> +    case 1:
>>>>>>> +        break;
>>>>>>> +    case 2:
>>>>>>> +        data =3D bswap16(data);
>>>>>>> +        break;
>>>>>>> +    case 4:
>>>>>>> +        data =3D bswap32(data);
>>>>>>> +        break;
>>>>>>> +    case 8:
>>>>>>> +        data =3D bswap64(data);
>>>>>>> +        break;
>>>>>>> +    default:
>>>>>>> +        return -EINVAL;
>>>>>>> +    }
>>>>>>> +    *ptr =3D data;
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>> While you're at it, I think that should rather be leXX_to_cpu() in=
stead
>>>>>> of bswapXX() here,
>>>>> I don't think that's correct, as this is supposed to swap BE regist=
ers
>>>>> to LE PCI bars.
>>>> Yes, but for the CPU emulation, the registers are stored in the host=
's
>>>> endianness in the CPUS390XState structure. Or why do we byte-swap th=
em
>>>> again with cpu_to_be64() during s390_store_status(), for example?
>>> Gah, endian conversion is eating my brain...
>>>
>>> So, is the content we get BE or not? I thought in our last discussion
>>> we came to the conclusion that it is.
>> data is read from / written to env->regs[r1], so this is host endian, =
as
>> far as I know. PCI is little endian, so using le32_to_cpu() /
>> cpu_to_le32() should IMHO be the right way to go here.
>>
>> By the way, if we want to use both, cpu_to_le and le_to_cpu, depending
>> on whether we read from or write to PCI, we should maybe *not* put thi=
s
>> code into a separate function?
> Yes, if your assessment is correct, we need two functions (I think this
> conversion is used in other places in later patches as well). Or are
> there mechanisms for that already available?
I have a question, is the data in cpu->regs the guest's endianess?
In our case, the guest is S390. Although the arch is big-endian, the data=
 in
pcilg/stg instructions is little-endian.

Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu() mean the=20
host endianess?

If the answers to upper two questions are yes, we actually need handle=20
two cases.
1) For pcilg, we need to translate the data to little-endian, thus=20
cpu_to_le**().
2) For pcistg, we need to translate the data to host endianess, thus=20
le**_to_cpu().
>
>>> [I really need to continue working on wiring up zpci in tcg, but I ke=
ep
>>> getting sidetracked.]
>> Maybe best if you get it running on a big endian host first ... if it =
is
>> then not working on a little endian host, you know that you have to lo=
ok
>> for things like these "bswapXX()" statements...
> That was exactly my reasoning behind getting tcg to run... but getting
> it to run at all is the hard part :)
>
>
