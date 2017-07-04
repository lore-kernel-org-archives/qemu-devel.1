Received: from eggs.gnu.org ([2001:4830:134:3::10]:47159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSHvV-0007QK-3T
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSHvR-0005UQ-SF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:07:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSHvR-0005Si-Hr
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:07:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v6473oFk140316
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 03:07:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg4ygmfhb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 03:07:07 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 01:07:07 -0600
References: <20170703085107.16547-1-haoqf@linux.vnet.ibm.com>
	<20170703085107.16547-2-haoqf@linux.vnet.ibm.com>
	<fee6eaa0-8132-b3ce-bb3e-0a716eb72064@de.ibm.com>
	<abf0af9b-a5fd-392f-6d12-2fd066589553@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 09:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <abf0af9b-a5fd-392f-6d12-2fd066589553@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Message-Id: <b999b689-92b7-bb01-ccca-fa29ad4a5a30@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio-scsi-ccw: use ioeventfd even
 when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, zyimin@linux.vnet.ibm.com, famz@redhat.com, peterx@redhat.com, stefanha@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>

On 07/04/2017 05:41 AM, QingFeng Hao wrote:
>=20
>=20
> =E5=9C=A8 2017/7/3 18:20, Christian Borntraeger =E5=86=99=E9=81=93:
>> On 07/03/2017 10:51 AM, QingFeng Hao wrote:
>>> This patch is based on a similar patch from Stefan Hajnoczi -
>>> commit c324fd0a39c (" virtio-pci: use ioeventfd even when KVM is disa=
bled)
>>>
>>> Do not check kvm_eventfds_enabled() when KVM is disabled since it
>>> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462=
a6f
>>> ("memory: emulate ioeventfd") it has been possible to use ioeventfds =
in
>>> qtest or TCG mode.
>>>
>>> This patch makes -device virtio-scsi-ccw,iothread=3Diothread0 work ev=
en
>>> when KVM is disabled.
>>>
>>> I have tested that virtio-scsi-ccw works under tcg both with and with=
out
>>> iothread.
>>>
>>> This patch fixes qemu-iotests 068, which was accidentally merged earl=
y
>>> despite the dependency on ioeventfd.
>>>
>>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>> ---
>>>   hw/s390x/virtio-ccw.c | 2 +-
>>>   target/s390x/kvm.c    | 3 +++
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>>> index 90d37cb9ff..35896eb007 100644
>>> --- a/hw/s390x/virtio-ccw.c
>>> +++ b/hw/s390x/virtio-ccw.c
>>> @@ -711,7 +711,7 @@ static void virtio_ccw_device_realize(VirtioCcwDe=
vice *dev, Error **errp)
>>>           sch->cssid, sch->ssid, sch->schid, sch->devno,
>>>           ccw_dev->devno.valid ? "user-configured" : "auto-configured=
");
>>>
>>> -    if (!kvm_eventfds_enabled()) {
>>> +    if (kvm_enabled() && !kvm_eventfds_enabled()) {
>>>           dev->flags &=3D ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
>>>       }
>>>
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index a3d00196f4..c37f9c3b9e 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -2220,6 +2220,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifi=
er *notifier, uint32_t sch,
>>>           .addr =3D sch,
>>>           .len =3D 8,
>>>       };
>>> +    if (!kvm_enabled()) {
>>> +        return 0;
>>> +    }
>> thinking more about it. wouldnt it be better to do something like this=
 instead
>>
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 058ddad..cc47831 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -1240,7 +1240,11 @@ static inline int s390_assign_subch_ioeventfd(E=
ventNotifier *notifier,
>>                                                 uint32_t sch_id, int v=
q,
>>                                                 bool assign)
>>   {
>> -    return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assi=
gn);
>> +    if (kvm_enabled()) {
>> +        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, =
assign);
>> +    } else {
>> +        return 0;
>> +    }
>>   }
> Thanks. It makes sense. I'll change it.
>>   static inline void s390_crypto_reset(void)
>>
>>
>> FWIW, it seems that we (s390) do not have a functional equivalent func=
tion as commit
>> 8c56c1a592b5092d91da8d8943c17777d6462a6f ("memory: emulate ioeventfd")=
 , so we will
>> not use the iothreads.
> Ok, but might s390 have skipped the iothread arguments and passed the t=
est, so we could
> still keep this test case?

Yes, lets just fix the test case. We can implement emulated ioeventfds la=
ter.
