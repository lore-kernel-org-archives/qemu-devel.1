Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1gFAK0-0000G2-2y
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 23:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1gFAJr-0003y0-S9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 23:59:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1gFAJj-0003gI-IF
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 23:58:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9O3sULq122851
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 23:58:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nacgubrs7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 23:58:40 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 23 Oct 2018 21:58:39 -0600
References: <20181022090255.19671-1-zyimin@linux.ibm.com>
	<698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
	<20181023232517.6b93085b.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Wed, 24 Oct 2018 11:58:33 +0800
MIME-Version: 1.0
In-Reply-To: <20181023232517.6b93085b.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <494ff50b-8b0f-1393-fbc5-bf5033a246ce@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.ibm.com, qemu-s390x@nongnu.org



=D4=DA 2018/10/24 =C9=CF=CE=E75:25, Cornelia Huck =D0=B4=B5=C0:
> On Mon, 22 Oct 2018 13:17:34 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>
>> On 2018-10-22 10:02, Yi Min Zhao wrote:
>>> Common function measurement block is used to report counters of
>>> successfully issued pcilg/stg/stb and rpcit instructions. This patch
>>> introduces a new struct ZpciFmb and schedules a timer callback to
>>> copy fmb to the guest memory at a interval time which is set to
>>> 4s by default. While attemping to update fmb failed, an event error
>>> would be generated. After pcilg/stg/stb and rpcit interception
>>> handlers issue successfully, increase the related counter. The guest
>>> could pass null address to switch off FMB and stop corresponding
>>> timer.
>>>
>>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>> [...]
>>> +static int fmb_do_update(S390PCIBusDevice *pbdev, uint8_t offset, in=
t len)
>>> +{
>>> +    MemTxResult ret;
>>> +
>>> +    ret =3D address_space_write(&address_space_memory,
>>> +                              pbdev->fmb_addr + (uint64_t)offset,
>>> +                              MEMTXATTRS_UNSPECIFIED,
>>> +                              (uint8_t *)&pbdev->fmb + offset,
>>> +                              len);
>>> +    if (ret) {
>>> +        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbd=
ev->fid,
>>> +                                      pbdev->fmb_addr, 0);
>>> +        fmb_timer_free(pbdev);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void fmb_update(void *opaque)
>>> +{
>>> +    S390PCIBusDevice *pbdev =3D opaque;
>>> +    int64_t t =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>>> +    uint8_t offset =3D offsetof(ZpciFmb, last_update);
>>> +
>>> +    /* Update U bit */
>>> +    pbdev->fmb.last_update |=3D UPDATE_U_BIT;
>>> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Update FMB counters */
>>> +    pbdev->fmb.sample++;
>>> +    if (fmb_do_update(pbdev, 0, sizeof(ZpciFmb))) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Clear U bit and update the time */
>>> +    pbdev->fmb.last_update =3D time2tod(qemu_clock_get_ns(QEMU_CLOCK=
_VIRTUAL));
>>> +    pbdev->fmb.last_update &=3D ~UPDATE_U_BIT;
>>> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
>>> +        return;
>>> +    }
>>> +
>>> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
>>> +}
>> Sorry for noticing this in v1 already, but is this code endianess-safe=
?
>> I.e. can this also work with qemu-system-s390x running with TCG on a x=
86
>> host? I think you might have to use something like this here instead:
>>
>>    pbdev->fmb.sample =3D cpu_to_be32(be32_to_cpu(pbdev->fmb.sample) + =
1);
>>
>> etc.
> Agreed, that may need some endianness handling.
>
> I would test this with tcg on a LE host, but how can I verify this? Yi
> Min, do you have some kind of test tooling you can share?
>
>
There's no tool now. You could startup a guest. And then in the guest,=20
install
PCI driver and read FMB values from /sys/kernel/debug/pci/****/statistics.

If endianness has error, I think the values must looks wrong.
The right thing is that values increase from 0 and intervally.

--=20
Yi Min
