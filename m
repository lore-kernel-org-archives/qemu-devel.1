Received: from eggs.gnu.org ([2001:4830:134:3::10]:34316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEB96-0008PD-Lh
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEB91-0005IT-NT
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:35:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEB91-0005Hq-9m
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:35:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAD9YItA064046
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:34:57 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e763rqemv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:34:57 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 09:34:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
	[9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id vAD9YqMZ36372546
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:34:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32D0942041
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:29:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D025442047
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:29:47 +0000 (GMT)
Received: from [9.145.26.235] (unknown [9.145.26.235])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:29:47 +0000 (GMT)
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109173802.7a43dcc3.cohuck@redhat.com>
	<92ed4a36-5db9-9f76-069f-cd663bbe8aee@amsat.org>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 10:34:50 +0100
MIME-Version: 1.0
In-Reply-To: <92ed4a36-5db9-9f76-069f-cd663bbe8aee@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ea1b5011-c803-4fe0-8e1a-def47424fada@linux.vnet.ibm.com>
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
To: qemu-devel@nongnu.org

On 09/11/2017 19:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/09/2017 01:38 PM, Cornelia Huck wrote:
>> On Tue,  7 Nov 2017 18:24:33 +0100
>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>
>>> There are two places where the same endianness conversion
>>> is done.
>>> Let's factor this out into a static function.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>> ---
>>>   hw/s390x/s390-pci-inst.c | 58 ++++++++++++++++++++++++++-----------=
-----------
>>>   1 file changed, 32 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>> index 8e088f3..8fcb02d 100644
>>> --- a/hw/s390x/s390-pci-inst.c
>>> +++ b/hw/s390x/s390-pci-inst.c
>>> @@ -314,6 +314,35 @@ out:
>>>       return 0;
>>>   }
>>>  =20
>>> +/**
>>> + * This function swaps the data at ptr according from one
>>> + * endianness to the other.
>>> + * valid data in the uint64_t data field.
>>
>> I'm not sure what that line is supposed to mean?
>>
>>> + * @ptr: a pointer to a uint64_t data field
>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>> + */
>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>> +{
>>> +    uint64_t data =3D *ptr;
>>> +    switch (len) {
>>> +    case 1:
>>> +        break;
>>> +    case 2:
>>> +        data =3D bswap16(data);
>>> +        break;
>>> +    case 4:
>>> +        data =3D bswap32(data);
>>> +        break;
>>> +    case 8:
>>> +        data =3D bswap64(data);
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +    *ptr =3D data;
>>> +    return 0;
>>> +}
>=20
> This is usually care taken by memory::adjust_endianness() ...

We are here intercepting an instruction with the data in a register.
That is what troubles me, but I will take a deeper look.

>=20
>> I was expecting more code to use a similar pattern, but it seems
>> surprisingly uncommon.
>=20
> Which ring a bell for latent bug?
>=20
> This remind me of a similar issue on ppc:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05121.html
> ...
> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05666.html
>=20

Thanks for the pointers.



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
