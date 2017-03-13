Received: from eggs.gnu.org ([2001:4830:134:3::10]:47851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnTIA-0005zW-Sy
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnTI7-0006tr-1T
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:57:54 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnTI6-0006sS-R8
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:57:50 -0400
Received: by mail-wm0-x22b.google.com with SMTP id v186so45357015wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 09:57:50 -0700 (PDT)
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-12-alex.bennee@linaro.org>
	<f7a4cba9-12da-fbb3-684f-68b4a11fbe97@vivier.eu>
	<87y3wr8zs2.fsf@linaro.org>
	<e3f645d0-ea92-b28d-bb2b-9c831dd8b264@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e3f645d0-ea92-b28d-bb2b-9c831dd8b264@vivier.eu>
Date: Mon, 13 Mar 2017 16:58:04 +0000
Message-ID: <87zigpp10j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 11/24] tcg: enable thread-per-vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: peter.maydell@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>, Richard Henderson <rth@twiddle.net>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 27/02/2017 à 15:38, Alex Bennée a écrit :
>>
>> Laurent Vivier <laurent@vivier.eu> writes:
>>
>>> Le 24/02/2017 à 12:20, Alex Bennée a écrit :
>>>> There are a couple of changes that occur at the same time here:
>>>>
>>>>   - introduce a single vCPU qemu_tcg_cpu_thread_fn
>>>>
>>>>   One of these is spawned per vCPU with its own Thread and Condition
>>>>   variables. qemu_tcg_rr_cpu_thread_fn is the new name for the old
>>>>   single threaded function.
>>>>
>>>>   - the TLS current_cpu variable is now live for the lifetime of MTTCG
>>>>     vCPU threads. This is for future work where async jobs need to know
>>>>     the vCPU context they are operating in.
>>>>
>>>> The user to switch on multi-thread behaviour and spawn a thread
>>>> per-vCPU. For a simple test kvm-unit-test like:
>>>>
>>>>   ./arm/run ./arm/locking-test.flat -smp 4 -accel tcg,thread=multi
>>>>
>>>> Will now use 4 vCPU threads and have an expected FAIL (instead of the
>>>> unexpected PASS) as the default mode of the test has no protection when
>>>> incrementing a shared variable.
>>>>
>>>> We enable the parallel_cpus flag to ensure we generate correct barrier
>>>> and atomic code if supported by the front and backends. This doesn't
>>>> automatically enable MTTCG until default_mttcg_enabled() is updated to
>>>> check the configuration is supported.
>>>
>>> This commit breaks linux-user mode:
>>>
>>> debian-8 with qemu-ppc on x86_64 with ltp-full-20170116
>>>
>>> cd /opt/ltp
>>> ./runltp -p -l "qemu-$(date +%FT%T).log" -f /opt/ltp/runtest/syscalls -s
>>> setgroups03
>>>
>>> setgroups03    1  TPASS  :  setgroups(65537) fails, Size is >
>>> sysconf(_SC_NGROUPS_MAX), errno=22
>>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>>> ...
>>
>> Interesting. I can only think the current_cpu change has broken it
>> because most of the changes in this commit affect softmmu targets only
>> (linux-user has its own run loop).
>>
>> Thanks for the report - I'll look into it.
>
> After:
>
>      95b0eca Merge remote-tracking branch
> 'remotes/stsquad/tags/pull-mttcg-fixups-090317-1' into staging
>
> [Tested with my HEAD on:
> b1616fe Merge remote-tracking branch
> 'remotes/famz/tags/docker-pull-request' into staging]
>
> I have now:
>
> <<<test_start>>>
> tag=setgroups03 stime=1489413401
> cmdline="setgroups03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> **
> ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
> failed: (cpu == current_cpu)
> **

So I think this is saying that we were outside the tcg_exec_loop for
this cpu and somehow longjmp'ed back into the loop.

I'll start setting up LTP on my system but in the meantime you might
find it useful adding the cpu == current_cpu assert into all the places
in cpu-exec-common.c before siglongjmp is called. Then a backtrace of
the offending call will be easier to follow.

>
> Laurent


--
Alex Bennée
