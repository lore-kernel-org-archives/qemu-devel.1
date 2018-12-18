Received: from eggs.gnu.org ([2001:4830:134:3::10]:53738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gZJ2e-0007Cq-VQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gZJ2a-0000SA-N7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:20:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gZJ2Y-0000Py-F9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:20:18 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBIHK0Vq057427
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:20:13 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pf4yygh30-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:20:13 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 18 Dec 2018 17:20:10 -0000
Reply-To: pmorel@linux.ibm.com
References: <1544806422-21418-1-git-send-email-pmorel@linux.ibm.com>
	<1544806422-21418-2-git-send-email-pmorel@linux.ibm.com>
	<20181218105518.2574fa64.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 18 Dec 2018 18:20:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181218105518.2574fa64.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <47e239cf-3e84-58af-9baa-9e67611cefca@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390x/pci: add common function
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

On 18/12/2018 10:55, Cornelia Huck wrote:
> On Fri, 14 Dec 2018 17:53:42 +0100
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
>> at an interval time set to 4s by default.
>=20
> Hm, is there any way to change the interval? If not, just drop the "by
> default"?
>=20
>>
>> An error while attemping to update the FMB, would generated an error
>=20
> s/generated/generate/
>=20
>> event to the guest.
>>
>> The pcilg/stg/stb and rpcit interception handlers issue, increase
>> the related counter on success.
>=20
> "When the ... handlers are called, ..." ?
>=20
>> The guest shall pass a null FMBA (FMB address) in the FIB (Function
>> Information Block) when it issues a Modify PCI Function Control
>> instrcuction to switch off FMB and stop the corresponding timer.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  |   4 +-
>>   hw/s390x/s390-pci-bus.h  |  29 ++++++++++
>>   hw/s390x/s390-pci-inst.c | 141 +++++++++++++++++++++++++++++++++++++=
+++++++++-
>>   hw/s390x/s390-pci-inst.h |   1 +
>>   4 files changed, 171 insertions(+), 4 deletions(-)
>>
>=20
>> +static int fmb_do_update64(S390PCIBusDevice *pbdev, int offset, int c=
nt)
>> +{
>> +    MemTxResult ret =3D MEMTX_OK;
>> +    uint64_t dst =3D pbdev->fmb_addr + offset;
>> +    uint64_t *src =3D (uint64_t *) ((unsigned long)(&pbdev->fmb) + of=
fset);
>> +    int i;
>> +
>> +    for (i =3D 0; i < cnt; i++, dst +=3D 8, src++) {
>> +        address_space_stq_be(&address_space_memory, dst, *src,
>> +                             MEMTXATTRS_UNSPECIFIED, &ret);
>> +        if (ret !=3D MEMTX_OK) {
>> +            s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, =
pbdev->fid,
>> +                                          pbdev->fmb_addr, 0);
>> +            fmb_timer_free(pbdev);
>> +            return ret;
>> +        }
>> +    }
>> +    return ret;
>> +}
>> +
>> +static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, int val=
, int len)
>> +{
>> +    MemTxResult ret;
>> +    uint64_t dst =3D pbdev->fmb_addr + offset;
>> +
>> +    switch (len) {
>> +    case 4:
>> +        address_space_stl_be(&address_space_memory, dst, val,
>> +                             MEMTXATTRS_UNSPECIFIED,
>> +                             &ret);
>> +        break;
>> +    case 2:
>> +        address_space_stw_be(&address_space_memory, dst, val,
>> +                             MEMTXATTRS_UNSPECIFIED,
>> +                             &ret);
>> +        break;
>> +    case 1:
>> +        address_space_stb(&address_space_memory, dst, val,
>> +                          MEMTXATTRS_UNSPECIFIED,
>> +                          &ret);
>> +        break;
>> +    default:
>> +        ret =3D MEMTX_ERROR;
>> +        break;
>> +    }
>> +    if (ret !=3D MEMTX_OK) {
>> +        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbde=
v->fid,
>> +                                      pbdev->fmb_addr, 0);
>> +        fmb_timer_free(pbdev);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void fmb_update(void *opaque)
>> +{
>> +    S390PCIBusDevice *pbdev =3D opaque;
>> +    int64_t t =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>> +    uint8_t offset;
>> +
>> +    /* Update U bit */
>> +    pbdev->fmb.last_update |=3D UPDATE_U_BIT;
>> +    offset =3D offsetof(ZpciFmb, last_update);
>> +    if (fmb_do_update64(pbdev, offset, 1)) {
>> +        return;
>> +    }
>> +
>> +    /* Update FMB sample count */
>> +    offset =3D offsetof(ZpciFmb, sample);
>> +    if (fmb_do_update(pbdev, offset, pbdev->fmb.sample++,
>> +                      sizeof(pbdev->fmb.sample))) {
>=20
> This is the only caller of fmb_do_update(), right? Any chance that a
> new format of the block would introduce new callers?
>=20
>> +        return;
>> +    }
>> +    /* Update FMB counters */
>> +    offset =3D offsetof(ZpciFmb, counter);
>> +    if (fmb_do_update64(pbdev, offset, ZPCI_FMB_CNT_MAX)) {
>> +        return;
>> +    }
>> +
>> +    /* Clear U bit and update the time */
>> +    pbdev->fmb.last_update =3D time2tod(qemu_clock_get_ns(QEMU_CLOCK_=
VIRTUAL));
>> +    pbdev->fmb.last_update <<=3D 1;
>> +    offset =3D offsetof(ZpciFmb, last_update);
>> +    if (fmb_do_update64(pbdev, offset, 1)) {
>> +        return;
>> +    }
>=20
> Hm, one thing that I don't quite like about the update code is the odd
> split between fmb_do_update() (which always updates one value) and
> fmb_do_update64() (which may update multiple values).
>=20
> What does the code look like if you:
> - have a fmb_do_update() that can also handle 64bit values,
> - have the update of the counters loop and break out if you get an
>    error?
>=20
> Of course, you may have already tried that ;) If it looks ugly, I don't
> have a real issue with this code, either.

It looks better.
I change it for this simpler form: same fmb_do_update() for all sizes.
I do not know why I chose the hard way.
Must be some kind of Wile E. Coyote complex.

I post a V4

>=20
>> +
>> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
>> +}
>> +
>>   int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uin=
t8_t ar,
>>                           uintptr_t ra)
>>   {
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
