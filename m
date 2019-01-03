Received: from eggs.gnu.org ([208.118.235.92]:41379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gezwW-0007C6-V0
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gezwS-0006vy-VW
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:09:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gezwR-0006VI-1A
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:09:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x03A9Isx028651
	for <qemu-devel@nongnu.org>; Thu, 3 Jan 2019 05:09:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2psf1537da-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:09:21 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 3 Jan 2019 10:09:13 -0000
Reply-To: pmorel@linux.ibm.com
References: <1545224225-24267-1-git-send-email-pmorel@linux.ibm.com>
	<1545224225-24267-2-git-send-email-pmorel@linux.ibm.com>
	<20181219152249.487e2bdf.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 3 Jan 2019 11:09:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181219152249.487e2bdf.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <97eea5fc-ccbf-3d93-ccef-40d0ac92a376@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On 19/12/2018 15:22, Cornelia Huck wrote:
> On Wed, 19 Dec 2018 13:57:05 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> From: Yi Min Zhao <zyimin@linux.ibm.com>
>>
>> Common function measurement block is used to report zPCI internal
>> counters of successful pcilg/stg/stb and rpcit instructions to
>> a memory location provided by the program.
>>
>> This patch introduces a new ZpciFmb structure and schedules a timer
>> callback to copy the zPCI measures to the FMB in the guest memory
>> at an interval time set to 4s.
>>
>> An error while attemping to update the FMB, would generate an error
>> event to the guest.
>>
>> The pcilg/stg/stb and rpcit interception handlers increase the
>> related counter on a successful call.
>> The guest shall pass a null FMBA (FMB address) in the FIB (Function
>> Information Block) when it issues a Modify PCI Function Control
>> instruction to switch off FMB and stop the corresponding timer.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  |   4 +-
>>   hw/s390x/s390-pci-bus.h  |  29 +++++++++++
>>   hw/s390x/s390-pci-inst.c | 129 +++++++++++++++++++++++++++++++++++++=
++++++++--
>>   hw/s390x/s390-pci-inst.h |   1 +
>>   4 files changed, 159 insertions(+), 4 deletions(-)
>>
>=20
>> +static void fmb_update(void *opaque)
>> +{
>> +    S390PCIBusDevice *pbdev =3D opaque;
>> +    int64_t t =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>> +    int i;
>> +
>> +    /* Update U bit */
>> +    pbdev->fmb.last_update *=3D 2;
>> +    pbdev->fmb.last_update |=3D UPDATE_U_BIT;
>> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
>> +                      pbdev->fmb.last_update, sizeof(uint64_t))) {
>=20
> Uh... the size of the last_update field would make more sense here...
> Also for the other fields below. Is there a reason that does not work?

None, I send a v6 :)



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
