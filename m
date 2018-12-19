Received: from eggs.gnu.org ([2001:4830:134:3::10]:53248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gZaz5-0003z2-IR
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gZaz2-0006vs-5y
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:29:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gZaz1-0006tP-Pd
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:29:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBJCO4Td078844
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:29:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pfmc6w8g9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:29:50 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 19 Dec 2018 12:29:48 -0000
Reply-To: pmorel@linux.ibm.com
References: <1545154139-8740-1-git-send-email-pmorel@linux.ibm.com>
	<1545154139-8740-2-git-send-email-pmorel@linux.ibm.com>
	<20181219104807.4c11f39f.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 19 Dec 2018 13:29:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181219104807.4c11f39f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <a6e21144-180d-f515-570c-54a351c605cf@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] s390x/pci: add common function
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

On 19/12/2018 10:48, Cornelia Huck wrote:
> On Tue, 18 Dec 2018 18:28:59 +0100
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
>> related counter on a successul call.
>=20
> s/successul/successful/
>=20
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
>> +                      pbdev->fmb.last_update, 8)) {
>> +        return;
>> +    }
>> +
>> +    /* Update FMB sample count */
>> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, sample),
>> +                      pbdev->fmb.sample++, 4)) {
>> +        return;
>> +    }
>> +
>> +    /* Update FMB counters */
>> +    for (i =3D 0; i < ZPCI_FMB_CNT_MAX; i++) {
>> +        if (fmb_do_update(pbdev, offsetof(ZpciFmb, counter[i]),
>> +                          pbdev->fmb.counter[i], 8)) {
>> +            return;
>> +        }
>> +    }
>> +
>> +    /* Clear U bit and update the time */
>> +    pbdev->fmb.last_update =3D time2tod(qemu_clock_get_ns(QEMU_CLOCK_=
VIRTUAL));
>> +    pbdev->fmb.last_update *=3D 2;
>> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
>> +                      pbdev->fmb.last_update, 8)) {
>> +        return;
>> +    }
>> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
>> +}
>> +
>=20
> Might be better to use sizeof() instead of hard-coded values when
> calling fmb_do_update()?
>=20
> Otherwise, looks good.
>=20

OK, thanks, I send hopefully the last version with commit message=20
corrected and sizeof instead of hard-coded values.

Regards,
Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
