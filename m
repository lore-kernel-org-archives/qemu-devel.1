Received: from eggs.gnu.org ([2001:4830:134:3::10]:54120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1gErSu-0005jC-Kt
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1gErSr-0000X7-F5
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:51:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1gErSr-0000Uf-07
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:50:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9N7iW1B145242
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 03:50:54 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n9xmktj0f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 03:50:53 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 23 Oct 2018 01:50:53 -0600
Received: from b03ledav004.gho.boulder.ibm.com
	(b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w9N7ooTD23593140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:50:51 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0E517805E
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 07:50:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54C7E7805F
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 07:50:50 +0000 (GMT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.192.238])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 07:50:50 +0000 (GMT)
References: <20181022090255.19671-1-zyimin@linux.ibm.com>
	<698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Tue, 23 Oct 2018 15:50:48 +0800
MIME-Version: 1.0
In-Reply-To: <698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ea0d4408-7cef-5ce9-feb2-dcd2c5321919@linux.ibm.com>
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
To: qemu-devel@nongnu.org



=E5=9C=A8 2018/10/22 =E4=B8=8B=E5=8D=888:17, Thomas Huth =E5=86=99=E9=81=93=
:
> On 2018-10-22 10:02, Yi Min Zhao wrote:
>> Common function measurement block is used to report counters of
>> successfully issued pcilg/stg/stb and rpcit instructions. This patch
>> introduces a new struct ZpciFmb and schedules a timer callback to
>> copy fmb to the guest memory at a interval time which is set to
>> 4s by default. While attemping to update fmb failed, an event error
>> would be generated. After pcilg/stg/stb and rpcit interception
>> handlers issue successfully, increase the related counter. The guest
>> could pass null address to switch off FMB and stop corresponding
>> timer.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
> [...]
>> +static int fmb_do_update(S390PCIBusDevice *pbdev, uint8_t offset, int=
 len)
>> +{
>> +    MemTxResult ret;
>> +
>> +    ret =3D address_space_write(&address_space_memory,
>> +                              pbdev->fmb_addr + (uint64_t)offset,
>> +                              MEMTXATTRS_UNSPECIFIED,
>> +                              (uint8_t *)&pbdev->fmb + offset,
>> +                              len);
>> +    if (ret) {
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
>> +    uint8_t offset =3D offsetof(ZpciFmb, last_update);
>> +
>> +    /* Update U bit */
>> +    pbdev->fmb.last_update |=3D UPDATE_U_BIT;
>> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
>> +        return;
>> +    }
>> +
>> +    /* Update FMB counters */
>> +    pbdev->fmb.sample++;
>> +    if (fmb_do_update(pbdev, 0, sizeof(ZpciFmb))) {
>> +        return;
>> +    }
>> +
>> +    /* Clear U bit and update the time */
>> +    pbdev->fmb.last_update =3D time2tod(qemu_clock_get_ns(QEMU_CLOCK_=
VIRTUAL));
>> +    pbdev->fmb.last_update &=3D ~UPDATE_U_BIT;
>> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
>> +        return;
>> +    }
>> +
>> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
>> +}
> Sorry for noticing this in v1 already, but is this code endianess-safe?
> I.e. can this also work with qemu-system-s390x running with TCG on a x8=
6
> host? I think you might have to use something like this here instead:
>
>    pbdev->fmb.sample =3D cpu_to_be32(be32_to_cpu(pbdev->fmb.sample) + 1=
);
>
> etc.
>
>   Thomas
>
>
Aha!!! Yes, I think you're right. Indeed, we should consider endianess.

--=20
Yi Min
