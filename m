Received: from eggs.gnu.org ([2001:4830:134:3::10]:50147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cnQZb-0004s9-Dx
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cnQZX-0003fw-Dj
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:03:43 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cnQZX-0003fC-3E
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:03:39 -0400
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-12-alex.bennee@linaro.org>
	<f7a4cba9-12da-fbb3-684f-68b4a11fbe97@vivier.eu>
	<87y3wr8zs2.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e3f645d0-ea92-b28d-bb2b-9c831dd8b264@vivier.eu>
Date: Mon, 13 Mar 2017 15:03:17 +0100
MIME-Version: 1.0
In-Reply-To: <87y3wr8zs2.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>, Richard Henderson <rth@twiddle.net>

Le 27/02/2017 à 15:38, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Le 24/02/2017 à 12:20, Alex Bennée a écrit :
>>> There are a couple of changes that occur at the same time here:
>>>
>>>   - introduce a single vCPU qemu_tcg_cpu_thread_fn
>>>
>>>   One of these is spawned per vCPU with its own Thread and Condition
>>>   variables. qemu_tcg_rr_cpu_thread_fn is the new name for the old
>>>   single threaded function.
>>>
>>>   - the TLS current_cpu variable is now live for the lifetime of MTTCG
>>>     vCPU threads. This is for future work where async jobs need to know
>>>     the vCPU context they are operating in.
>>>
>>> The user to switch on multi-thread behaviour and spawn a thread
>>> per-vCPU. For a simple test kvm-unit-test like:
>>>
>>>   ./arm/run ./arm/locking-test.flat -smp 4 -accel tcg,thread=multi
>>>
>>> Will now use 4 vCPU threads and have an expected FAIL (instead of the
>>> unexpected PASS) as the default mode of the test has no protection when
>>> incrementing a shared variable.
>>>
>>> We enable the parallel_cpus flag to ensure we generate correct barrier
>>> and atomic code if supported by the front and backends. This doesn't
>>> automatically enable MTTCG until default_mttcg_enabled() is updated to
>>> check the configuration is supported.
>>
>> This commit breaks linux-user mode:
>>
>> debian-8 with qemu-ppc on x86_64 with ltp-full-20170116
>>
>> cd /opt/ltp
>> ./runltp -p -l "qemu-$(date +%FT%T).log" -f /opt/ltp/runtest/syscalls -s
>> setgroups03
>>
>> setgroups03    1  TPASS  :  setgroups(65537) fails, Size is >
>> sysconf(_SC_NGROUPS_MAX), errno=22
>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>> ...
> 
> Interesting. I can only think the current_cpu change has broken it
> because most of the changes in this commit affect softmmu targets only
> (linux-user has its own run loop).
> 
> Thanks for the report - I'll look into it.

After:

     95b0eca Merge remote-tracking branch
'remotes/stsquad/tags/pull-mttcg-fixups-090317-1' into staging

[Tested with my HEAD on:
b1616fe Merge remote-tracking branch
'remotes/famz/tags/docker-pull-request' into staging]

I have now:

<<<test_start>>>
tag=setgroups03 stime=1489413401
cmdline="setgroups03"
contacts=""
analysis=exit
<<<test_output>>>
**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
**

Laurent
