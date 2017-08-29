Received: from eggs.gnu.org ([2001:4830:134:3::10]:49203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmYJ6-0002o8-Q1
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmYJ2-0006MS-Sj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:39:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmYJ2-0006M0-JS
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:39:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T4d9Lp017206
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:39:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmsrsyjv1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:39:14 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 00:39:13 -0400
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-4-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828173324.5723a231.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 12:39:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170828173324.5723a231.cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <681b6a4f-f727-8f0c-47f8-84514e02c7e2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] s390x/pci: fixup ind_offset of msix
 routing entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org



=E5=9C=A8 2017/8/28 =E4=B8=8B=E5=8D=8811:33, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Mon, 28 Aug 2017 10:04:46 +0200
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> The aibvo of zpci device should be constant after issued mpcifc
>> registering irqs instruction. Each msix vector should offset from the
>> aibvo. But for flic adapter interrupt, we should use the absolute
>> offset within the aibv. So let's use the aibvo+vector to fixup msix
>> routing entry.
> This makes sense, but I would tweak the description a bit.
>
> "The guest uses the mpcifc instruction to register the aibvo of a zpci
> device, which is the starting offset of indicators in the indicator
> area and thus remains constant. Each msix vector is an offset from the
> aibvo. When we map a msix route to an adapter route, we should not
> modify the starting offset, but instead add the vector to the starting
> offset to get the absolute offset in the specific route."
Much better. Thanks!
>
> I'm wondering how this was ever supposed to work?
I investigated this. Linux kernel always uses 0 as starting offset for
aibvo. And each msix entry is only registered one time. So we didn't
encounter any problem. But the logic here is not right obviously. It
is just a coincidence.

>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   target/s390x/kvm.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index e348bfb7cc..c08b7757e7 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2515,14 +2515,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_ro=
uting_entry *route,
>>           return -ENODEV;
>>       }
>>  =20
>> -    pbdev->routes.adapter.ind_offset =3D vec;
>> -
>>       route->type =3D KVM_IRQ_ROUTING_S390_ADAPTER;
>>       route->flags =3D 0;
>>       route->u.adapter.summary_addr =3D pbdev->routes.adapter.summary_=
addr;
>>       route->u.adapter.ind_addr =3D pbdev->routes.adapter.ind_addr;
>>       route->u.adapter.summary_offset =3D pbdev->routes.adapter.summar=
y_offset;
>> -    route->u.adapter.ind_offset =3D pbdev->routes.adapter.ind_offset;
>> +    route->u.adapter.ind_offset =3D pbdev->routes.adapter.ind_offset =
+ vec;
>>       route->u.adapter.adapter_id =3D pbdev->routes.adapter.adapter_id=
;
>>       return 0;
>>   }
>
