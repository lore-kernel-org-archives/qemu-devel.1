Received: from eggs.gnu.org ([2001:4830:134:3::10]:38680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHCYR-0003LS-BD
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHCYO-00055s-N9
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:41:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54426
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eHCYO-00055I-H8
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:41:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALHet4j044879
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 12:41:42 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ecq4378cs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 12:41:41 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 17:41:39 -0000
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171121113506.78788104.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 18:41:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171121113506.78788104.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <2202dba4-de17-e7fe-0fac-3aa293d2ab72@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/7] s390x/pci: factor out endianess
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
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 21/11/2017 11:35, Cornelia Huck wrote:
> On Thu, 16 Nov 2017 18:51:49 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> There are two places where the same endianness conversion
>> is done.
>> Let's factor this out into a static function.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>=20
> Your two s-o-bs look a bit odd...
>=20
>> ---
>>   hw/s390x/s390-pci-inst.c | 59 +++++++++++++++++++++++++++-----------=
----------
>>   1 file changed, 33 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 8e088f3..ded1556 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -314,6 +314,36 @@ out:
>>       return 0;
>>   }
>>  =20
>> +/**
>> + * This function is called when endianess is fixed, whatever the host=
 endianess
>> + * is, like in our case from s390x BIG endian registers to little end=
ian PCI
>> + * Bars, to translate the uint64_t pointed from one endianess to the =
other.
>=20
> I would rephrase this a bit:
>=20
> "Swap data contained in s390x big endian registers to little endian PCI
> bars."

Simpler and clearer. thanks.

>=20
> That makes it clear that this function is for a specialized use case.
>=20
>> + *
>> + * @ptr: a pointer to a uint64_t data field
>> + * @len: the length of the valid data, must be 1,2,4 or 8
>> + */
>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>> +{
>> +    uint64_t data =3D *ptr;
>=20
> Please add an extra empty line.

yes.

>=20
>> +    switch (len) {
>> +    case 1:
>> +        break;
>> +    case 2:
>> +        data =3D bswap16(data);
>> +        break;
>> +    case 4:
>> +        data =3D bswap32(data);
>> +        break;
>> +    case 8:
>> +        data =3D bswap64(data);
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +    *ptr =3D data;
>> +    return 0;
>> +}
>> +
>>   int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>>   {
>>       CPUS390XState *env =3D &cpu->env;
>=20
> Other than the nits above, looks good.
>=20

Thanks for the review

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
