Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehD7D-0000NE-N9
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehD78-0006Fz-Qk
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:33:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ehD78-0006FH-Hg
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:33:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w11BTToF059956
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 06:33:09 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fv1m5hj7n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 06:33:08 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 11:33:06 -0000
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-4-zyimin@linux.vnet.ibm.com>
	<20180131124400.4f74cf1c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 12:33:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180131124400.4f74cf1c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b779846e-3e25-5c33-217b-1d9f5e85ec70@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/pci: use the right pal and pba
 in reg_ioat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On 31/01/2018 12:44, Cornelia Huck wrote:
> On Tue, 30 Jan 2018 10:47:15 +0100
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> When registering ioat, pba should be comprised of leftmost 52 bits and
>> rightmost 12 binary zeros, and pal should be comprised of leftmost 52
>> bits and right most 12 binary ones. Let's fixup this.
>>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 997a9cc2e9..3fcc330fe3 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -865,6 +865,8 @@ static int reg_ioat(CPUS390XState *env, S390PCIIOM=
MU *iommu, ZpciFib fib,
>>       uint8_t dt =3D (g_iota >> 2) & 0x7;
>>       uint8_t t =3D (g_iota >> 11) & 0x1;
>>  =20
>> +    pba &=3D ~0xfff;
>> +    pal |=3D 0xfff;
>>       if (pba > pal || pba < ZPCI_SDMA_ADDR || pal > ZPCI_EDMA_ADDR) {
>>           s390_program_interrupt(env, PGM_OPERAND, 6, ra);
>>           return -EINVAL;
> It seems like pba and pal are part of the fib, which in turn seems to
> be provided by the caller. Is that correct? If yes, is it valid for
> them to not have the rightmost 12 bits as 0s resp. 1s?
>
> (Probably answered in the architecture, I know. Might make sense to be
> a tad more explicit in the description.)
>
Yes it is, only word6 and the bits 0-19 of word 7 are used for PAL and
the zPCI facility treats the right most 12 bits of the PAL as containing=20
ones.

For PBA words 4 and 0-19 bits of word 5 with 12 0 append on the right=20
provides the PBA.

The lower 12 bits of words 5 and 7 of the FIB are ignored by the facility.

@Yi Min: may be add the last sentence to the commit message.

@Conny: Is it clearer?

Regards,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
