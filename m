Received: from eggs.gnu.org ([2001:4830:134:3::10]:38638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSKOu-0002qO-0b
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSKOq-0004ke-GY
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:45:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dSKOq-0004jm-1a
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:45:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v649iU76022400
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 05:45:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg4r8ewyq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 05:45:37 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 05:45:36 -0400
References: <20170704083231.98056-1-haoqf@linux.vnet.ibm.com>
	<20170704083231.98056-2-haoqf@linux.vnet.ibm.com>
	<20170704113419.1218ce97@dhcp-192-215.str.redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue, 4 Jul 2017 17:45:26 +0800
MIME-Version: 1.0
In-Reply-To: <20170704113419.1218ce97@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <04b9d776-b821-91db-c99e-95b59a0b1323@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/1] virtio-scsi-ccw: use ioeventfd even
 when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com



=D4=DA 2017/7/4 17:34, Cornelia Huck =D0=B4=B5=C0:
> On Tue,  4 Jul 2017 10:32:31 +0200
> QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
>
>> This patch is based on a similar patch from Stefan Hajnoczi -
>> commit c324fd0a39c (" virtio-pci: use ioeventfd even when KVM is disab=
led)
>>
>> Do not check kvm_eventfds_enabled() when KVM is disabled since it
>> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a=
6f
>> ("memory: emulate ioeventfd") it has been possible to use ioeventfds i=
n
>> qtest or TCG mode.
>>
>> This patch makes -device virtio-scsi-ccw,iothread=3Diothread0 work eve=
n
>> when KVM is disabled.
> It might be good to add a sentence that we don't have an equivalent to
> "memory: emulate ioeventfd" for ccw yet, but that this doesn't hurt.
Ok, I'll add it. thanks.
>
>> I have tested that virtio-scsi-ccw works under tcg both with and witho=
ut
>> iothread.
>>
>> This patch fixes qemu-iotests 068, which was accidentally merged early
>> despite the dependency on ioeventfd.
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/virtio-ccw.c | 2 +-
>>   target/s390x/cpu.h    | 6 +++++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index 90d37cb9ff..35896eb007 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -711,7 +711,7 @@ static void virtio_ccw_device_realize(VirtioCcwDev=
ice *dev, Error **errp)
>>           sch->cssid, sch->ssid, sch->schid, sch->devno,
>>           ccw_dev->devno.valid ? "user-configured" : "auto-configured"=
);
>>  =20
>> -    if (!kvm_eventfds_enabled()) {
>> +    if (kvm_enabled() && !kvm_eventfds_enabled()) {
>>           dev->flags &=3D ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
>>       }
>>  =20
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 9faca04b52..bdb9bdbc9d 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -1264,7 +1264,11 @@ static inline int s390_assign_subch_ioeventfd(E=
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
>>  =20
>>   static inline void s390_crypto_reset(void)
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Thanks!
>

--=20
Regards
QingFeng Hao
