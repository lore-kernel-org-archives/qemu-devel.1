Received: from eggs.gnu.org ([2001:4830:134:3::10]:34797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXkmV-0003f5-CU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXkmS-0005qU-3J
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:56:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dXkmR-0005pM-PE
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:56:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J8sbm4093709
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:56:26 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bt1uv6f1j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:56:25 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 19 Jul 2017 02:56:25 -0600
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-5-cohuck@redhat.com>
	<5f8a2315-9224-f20c-7524-11f9a8ac8efd@de.ibm.com>
	<20170719100007.1071ce70@gondolin>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 16:56:18 +0800
MIME-Version: 1.0
In-Reply-To: <20170719100007.1071ce70@gondolin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <8eadfe2a-7923-6c10-287e-06ad9eaffead@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/9] s390x/pci: do not advertise pci
 on non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com



=E5=9C=A8 2017/7/19 =E4=B8=8B=E5=8D=884:00, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Tue, 18 Jul 2017 21:56:26 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> On 07/18/2017 04:24 PM, Cornelia Huck wrote:
>>> Only set the zpci and aen feature bits on builds that actually
>>> support pci.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>   target/s390x/kvm.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index 831492f9a2..880eccd58a 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -2685,8 +2685,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel =
*model, Error **errp)
>>>       }
>>>
>>>       /* set zpci and aen facilities */
>>> +#ifdef CONFIG_PCI
>>>       set_bit(S390_FEAT_ZPCI, model->features);
>>>       set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
>>> +#endif
>>>
>>>       if (s390_known_cpu_type(cpu_type)) {
>>>           /* we want the exact model, even if some features are missi=
ng */
>>>   =20
>> Not strictly necessary but do you also want to ifdef this
>>
>>   kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>>
>> call?
>>
>> If not you could actually even allow AEN but not PCI for !CONFIG_PCI.
> I'm a bit unsure about the relationship of ais and aen with pci. I
> remember that only adapters for pci currently support suppression,
> although it could spread to other adapter types in the future. Not sure
> about aen.
>
> So I'd keep the ais enablement call, even though it won't have much of
> an effect as no pci adapters will be registered.
>
> As I don't quite remember what aen governed, I need to rely on your
> feedback here.
>
>
My understanding is that zpci replies on aen. But aen could exist=20
independently.
After all, there is other device type using aen. I think only wrapping=20
zpci is
enough.
