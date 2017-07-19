Received: from eggs.gnu.org ([2001:4830:134:3::10]:42248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXlGc-00025u-Gr
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXlGX-0007aG-Ki
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:27:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dXlGX-0007Zn-A5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:27:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J9NheM112644
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:27:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsxfjejrn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:27:31 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 19 Jul 2017 05:27:30 -0400
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-5-cohuck@redhat.com>
	<5f8a2315-9224-f20c-7524-11f9a8ac8efd@de.ibm.com>
	<20170719100007.1071ce70@gondolin>
	<8eadfe2a-7923-6c10-287e-06ad9eaffead@linux.vnet.ibm.com>
	<20170719112430.432e66da@gondolin>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 17:27:23 +0800
MIME-Version: 1.0
In-Reply-To: <20170719112430.432e66da@gondolin>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f5d5bff4-4c3c-df91-f10f-d3602a62fe3b@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, thuth@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de



=E5=9C=A8 2017/7/19 =E4=B8=8B=E5=8D=885:24, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Wed, 19 Jul 2017 16:56:18 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/7/19 =E4=B8=8B=E5=8D=884:00, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> On Tue, 18 Jul 2017 21:56:26 +0200
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>  =20
>>>> On 07/18/2017 04:24 PM, Cornelia Huck wrote:
>>>>> Only set the zpci and aen feature bits on builds that actually
>>>>> support pci.
>>>>>
>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>> ---
>>>>>    target/s390x/kvm.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>>> index 831492f9a2..880eccd58a 100644
>>>>> --- a/target/s390x/kvm.c
>>>>> +++ b/target/s390x/kvm.c
>>>>> @@ -2685,8 +2685,10 @@ void kvm_s390_get_host_cpu_model(S390CPUMode=
l *model, Error **errp)
>>>>>        }
>>>>>
>>>>>        /* set zpci and aen facilities */
>>>>> +#ifdef CONFIG_PCI
>>>>>        set_bit(S390_FEAT_ZPCI, model->features);
>>>>>        set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->feature=
s);
>>>>> +#endif
>>>>>
>>>>>        if (s390_known_cpu_type(cpu_type)) {
>>>>>            /* we want the exact model, even if some features are mi=
ssing */
>>>>>      =20
>>>> Not strictly necessary but do you also want to ifdef this
>>>>
>>>>    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>>>>
>>>> call?
>>>>
>>>> If not you could actually even allow AEN but not PCI for !CONFIG_PCI.
>>> I'm a bit unsure about the relationship of ais and aen with pci. I
>>> remember that only adapters for pci currently support suppression,
>>> although it could spread to other adapter types in the future. Not su=
re
>>> about aen.
>>>
>>> So I'd keep the ais enablement call, even though it won't have much o=
f
>>> an effect as no pci adapters will be registered.
>>>
>>> As I don't quite remember what aen governed, I need to rely on your
>>> feedback here.
>>>
>>>  =20
>> My understanding is that zpci replies on aen. But aen could exist
>> independently.
>> After all, there is other device type using aen. I think only wrapping
>> zpci is
>> enough.
> Ah, was aen the indicator bits related support? If yes, I agree that we
> should only turn off zpci.
>
>
Yes, set summary and indicator bits. Related stuff is in flic, but not=20
in zpci.
