Received: from eggs.gnu.org ([2001:4830:134:3::10]:47832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eFOg5-0006dh-AE
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eFOfz-0004uQ-L0
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:14:17 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eFOfz-0004tL-EU
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:14:11 -0500
Received: by mail-wm0-x243.google.com with SMTP id 9so1969338wme.4
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 10:14:11 -0800 (PST)
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-3-david@redhat.com>
	<87375e15vx.fsf@linaro.org>
	<f0fc452d-8229-6eb3-b5d2-1d55b9ba0ee3@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <f0fc452d-8229-6eb3-b5d2-1d55b9ba0ee3@redhat.com>
Date: Thu, 16 Nov 2017 18:14:08 +0000
Message-ID: <87zi7mytu7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 2/3] s390x/tcg: fix DIAG 308
 with > 1 VCPU (single threaded TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>


David Hildenbrand <david@redhat.com> writes:

> On 16.11.2017 18:37, Alex Benn=C3=A9e wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> Currently, single threaded TCG with > 1 VCPU gets stuck during IPL, when
>>> the bios tries to switch to the loaded kernel via DIAG 308.
>>>
>>> pause_all_vcpus()/resume_all_vcpus() should not be called from a VCPU.
>>>
>>> And there is also no need for it. run_on_cpu() will make sure that the
>>> CPUs exit KVM/TCG, where they get stopped. Once stopped, they will no
>>> longer run.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/diag.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>>> index dbbb9e886f..52bc348808 100644
>>> --- a/target/s390x/diag.c
>>> +++ b/target/s390x/diag.c
>>> @@ -27,7 +27,6 @@ static int modified_clear_reset(S390CPU *cpu)
>>>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>>>      CPUState *t;
>>>
>>> -    pause_all_vcpus();
>>>      cpu_synchronize_all_states();
>>>      CPU_FOREACH(t) {
>>>          run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>>
>> I think you also need to fix the run_on_cpu to be a async_run_on_cpu as
>> you would otherwise hang waiting for run_on_cpu to finish on a
>> single-threaded TCG run (as you are in the only vCPU context).
>
> No, it works just fine for single threaded TCG. run_on_cpu() can deal
> with single threaded TCG just fine. (otherwise e.g. SIGP code also
> wouldn't work)
>
> In do_run_on_cpu, the following code always directly triggers for single
> threaded tcg:
>
>     if (qemu_cpu_is_self(cpu)) {
>
>         func(cpu, data);
>
>         return;
>
>     }

Sorry ignore what I said, qemu_cpu_is_self tests the underlying thread
not the vCPU which they all share.


--
Alex Benn=C3=A9e
