Received: from eggs.gnu.org ([2001:4830:134:3::10]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm1ee-0007nr-TV
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm1ea-0004ks-11
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:15:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cm1eZ-0004jq-PF
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:15:03 -0500
References: <CAGd9JPiCvSpZ6wGT-Fci+f7odP4t9SHUwSw3vqOMDVWdyJeR3w@mail.gmail.com>
	<20170309151923.GG2480@work-vm>
	<CAGd9JPgb1oAprD7MN+dUBJDPeLB_=9u6_2pfq5tOi-yA1SOvqg@mail.gmail.com>
	<20170309170605.GL2480@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed8ce0e8-da53-7011-480c-32ee40a668f6@redhat.com>
Date: Thu, 9 Mar 2017 18:15:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170309170605.GL2480@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU MicroCheckpointing Pause & Resume Latency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "FENG, Jiasheng" <nikofeng@connect.hku.hk>
Cc: qemu-devel@nongnu.org, Wang Cheng <wangch.will@gmail.com>, "YE, Chen" <u3534845@connect.hku.hk>, "CHEN, XUSHENG" <chenxus@connect.hku.hk>, Heming Cui <heming@cs.hku.hk>



On 09/03/2017 18:06, Dr. David Alan Gilbert wrote:
> (cc'ing in Paolo since he knows our barrier code)
>=20
> * FENG, Jiasheng (nikofeng@connect.hku.hk) wrote:
>> Dear David,
>>
>> Really appreciate your feedback.
>>
>> I have proceeded the experiments in both conditions, and no matter the
>> vCPUs are in idle or busy situation, there is no difference that smp_w=
mb()
>> will consume a lot of time to proceed its work.
>>
>> In your opinion, may I know that what is the alternative way to minimi=
ze
>> the time consumption of smp_wmb() or any other system setting could sp=
eed
>> up smp_wmb()?
>>
>> Thanks in advance for your assistance and hope to receive your feedbac=
k soon
>=20
> Just checking, is this on a normal x86 PC?
> Your numbers of 3-5ms just seem quite high to me but I've not tried tim=
ing that
> code.

smp_wmb does not produce a single machine instruction, so this is
probably a fluke in the profiling tool.

The most expensive part of vm_stop_force_state is going to be
bdrv_drain_all/bdrv_flush_all.  bdrv_flush_all is definitely not needed
for checkpointing purposes.

Paolo

>>>
>>>> Please kindly refer to migration/checkpoint.c file, in function
>>>> capture_checkpoint, I proceeded a test to see the time consumption
>>> between
>>>> vm_stop_force_state and vm_start. I found out that even if the syste=
m is
>>>> idle, there are still 12-20ms latency recorded ( mem=3D2G, vCPU=3D4 =
).
>>>> Moreover, latency will be increased while more cpus equipped by my
>>> virtual
>>>> machine. I have done some research on that and I realized that it is
>>>> related to the Memory Barrier in KVM kernel. Each cpu will proceed a
>>>> smp_wmb() request during pause & resume and it takes about  3-5ms to
>>> finish
>>>> the request ( mem=3D2G, vCPU=3D4 ).
>>>>
>>>>
>>>>
>>>> Therefore, I would like to ask 3 questions regarding on the above is=
sue:
>>>>
>>>>
>>>> 1. What is your consideration with calling smp_wmb() in checkpoint
>>> period;
>>>>
>>>> 2. Is it any other solution to minimize the latency to improve the
>>>> performance in checkpoint period;
>>>>
>>>> 3. Is smp_wmb() able to be safely disabled during the checkpoint per=
iod
>>>
>>> Well you'd have to understand where it's used; but for example, when =
taking
>>> a checkpoint you'd want to be sure that the checkpoint data contained
>>> a consistent copy of the last write data from all of the vCPUs; so I =
think
>>> a wmb would be needed to make sure it's consistent.
>>>
>>> I'm surprised that the smp_wmb is such a big chunk of your total chec=
kpoint
>>> time, and that it's quite so long.
>>> Are the vCPUs idle or are they busy - does it make difference?
>>>
>>> Dave
>>>
>>>> Really appreciate your help with my problems and hope to receive you=
r
>>>> feedback soon.
>>>>
>>>>
>>>> Thanks again for your contribution to QEMU and it is such a masterpi=
ece.
>>>
>>> Dave
>>>
>>>>
>>>>
>>>>
>>>> Thanks and best regards,
>>>>
>>>> Niko Jiasheng Feng
>>>>
>>>> University of Hong Kong
>>>>
>>>> --
>>>> *Niko Jiasheng *
>>>> *Feng **Computer Science(General Stream), Faculty of Engineering, Th=
e
>>>> University of Hong Kong*
>>>> Contact:  =EF=BC=88852=EF=BC=8997908620
>>>> Address: Pokfulam Road, The University of Hong Kong
>>>> Email:      nikofeng@hku.hk / niko_jiasheng@163.com
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>
>>
>>
>> --=20
>> *Niko Jiasheng *
>> *Feng **Computer Science(General Stream), Faculty of Engineering, The
>> University of Hong Kong*
>> Contact:  =EF=BC=88852=EF=BC=8997908620
>> Address: Pokfulam Road, The University of Hong Kong
>> Email:      nikofeng@hku.hk / niko_jiasheng@163.com
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
