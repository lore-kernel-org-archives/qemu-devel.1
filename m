Received: from eggs.gnu.org ([2001:4830:134:3::10]:56119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3KOy-0002tk-Iu
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3KOv-0003ci-FD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:42:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3KOv-0003c1-5a
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:42:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QAcumk127353
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:42:24 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebuc6mg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:42:23 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 20:41:32 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3QAfLDA56623212
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 20:41:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3QAeqB0031252
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 20:40:52 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <87k267myv1.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170425104338.31984-1-rth@twiddle.net>
	<87a87468d5.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<4f7766e0-4935-9b2e-8388-ff8f04a43aaf@twiddle.net>
	<87k267myv1.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Wed, 26 Apr 2017 16:10:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fugvmoyq.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize return value after
 exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>

aNikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Richard Henderson <rth@twiddle.net> writes:
>
>> On 04/25/2017 01:21 PM, Nikunj A Dadhania wrote:
>>> Richard Henderson <rth@twiddle.net> writes:
>>> 
>>>> Users of tcg_gen_atomic_cmpxchg and do_atomic_op rightfully utilize
>>>> the output.  Even though this code is dead, it gets translated, and
>>>> without the initialization we encounter a tcg_error.
>>>>
>>>> Reported-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>>> 
>>> With this the tcg_error goes away.
>>> 
>>> But then powernv skiboot code [1] enters into infinite loop. Basically,
>>> in target/ppc/translate.c:gen_conditional_store(), setcond_tl will
>>> always fail, and CRF_EQ_BIT will never be set, the lock will never be
>>> taken.
>>
>> The setcond_tl *shouldn't* always fail.
>
> Correct, in fact we never get here it.
>
>> If that's the case, then we have another bug in the !parallel_cpus
>> code path for gen_conditional_store.
>
> Something interesting is happening, I have instrumented the code such
> that I get some prints for load with reservation and store conditional:
>
> First case is the success case for 32bit atomic_cmpxchg.
>
>     $ ./configure --target-list=ppc64-softmmu  --cc=clang --host-cc=clang
>     $ ./ppc64-softmmu/qemu-system-ppc64  -machine powernv,usb=off  -vga none -nographic
> [lwarx]
>     helper_myprint: t0 cafe0000 t1 cafe0000
>     helper_myprint: t0 cafe0001 t1 cafe0001
>     helper_myprint: t0 cafe0002 t1 cafe0002
>     helper_myprint: t0 f0 t1 0
> [stwcx]
>     helper_myprint: t0 dead0000 t1 dead0000
>     helper_myprint: t0 f0 t1 0
>     helper_myprint: t0 dead0001 t1 dead0001
>     helper_myprint: t0 dead0011 t1 dead0011
>     helper_myprint: t0 0 t1 0
> [success as t0 and cpu_reserve_val is same]
>
> [ldarx]
>     helper_myprint: t0 cafe0000 t1 cafe0000
>     helper_myprint: t0 cafe0001 t1 cafe0001
>     helper_myprint: t0 cafe0002 t1 cafe0002
>     helper_myprint: t0 30200018 t1 0
>
> [ cpu_reserve = 30200018, cpu_reserve_val = 0 after load ]
>
> [stdcx]
>     helper_myprint: t0 dead0000 t1 dead0000
>     helper_myprint: t0 30200018 t1 0
>     helper_myprint: t0 dead0001 t1 dead0001
>
> [ That is before atomic_cmpxchg_tl, and suddenly we exit out, we did
> not reach setcond_tl ]
>
>     helper_myprint: t0 dead0000 t1 dead0000
>
> **** [ re-entering gen_store_conditional() ] ****
>
>     helper_myprint: t0 ffffffffffffffff t1 0
>
> **** [ cpu_reserve is corrupted ] ****
>

That is because of the following:

tcg_gen_atomic_cmpxchg_tl()
 -> gen_helper_exit_atomic()
     -> HELPER(exit_atomic)
         -> cpu_loop_exit_atomic() -> EXCP_ATOMIC
             -> qemu_tcg_cpu_thread_fn() => case EXCP_ATOMIC
                 -> cpu_exec_step_atomic()
                     -> cpu_step_atomic()
                         -> cc->cpu_exec_enter() = ppc_cpu_exec_enter()
                            Sets env->reserve_addr = -1;

So when we re-enter back, reserve_addr is rubbed out. After getting rid
of this reset of reserve_addr, I do get ahead a bit and stdcx is
successful.


[ldarx]
    helper_myprint: t0 cafe0000 t1 cafe0000
    helper_myprint: t0 cafe0001 t1 cafe0001
    helper_myprint: t0 cafe0002 t1 cafe0002
    helper_myprint: t0 30200018 t1 0

[stdcx.]

    helper_myprint: t0 dead0000 t1 dead0000
    helper_myprint: t0 30200018 t1 0
    helper_myprint: t0 dead0001 t1 dead0001

[ re-enters ]

    helper_myprint: t0 dead0000 t1 dead0000

[ cpu_reserve valud is intact now ]

    helper_myprint: t0 30200018 t1 0
    helper_myprint: t0 dead0001 t1 dead0001
    helper_myprint: t0 dead0011 t1 dead0011
    helper_myprint: t0 0 t1 0

[ And there is a match ]

But then the code is getting stuck here.

Regards
Nikunj
         
