Received: from eggs.gnu.org ([2001:4830:134:3::10]:47711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cnUbI-0002ZF-D3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cnUbD-00017u-8a
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:21:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cnUbC-00016s-Sr
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:21:39 -0400
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-12-alex.bennee@linaro.org>
	<f7a4cba9-12da-fbb3-684f-68b4a11fbe97@vivier.eu>
	<87y3wr8zs2.fsf@linaro.org>
	<e3f645d0-ea92-b28d-bb2b-9c831dd8b264@vivier.eu>
	<87zigpp10j.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e2cac1ac-c5df-a0e7-9af0-7926fb51f1f4@vivier.eu>
Date: Mon, 13 Mar 2017 19:21:20 +0100
MIME-Version: 1.0
In-Reply-To: <87zigpp10j.fsf@linaro.org>
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

Le 13/03/2017 à 17:58, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Le 27/02/2017 à 15:38, Alex Bennée a écrit :
>>>
>>> Laurent Vivier <laurent@vivier.eu> writes:
>>>
>>>> Le 24/02/2017 à 12:20, Alex Bennée a écrit :
>>>>> There are a couple of changes that occur at the same time here:
>>>>>
>>>>>   - introduce a single vCPU qemu_tcg_cpu_thread_fn
>>>>>
>>>>>   One of these is spawned per vCPU with its own Thread and Condition
>>>>>   variables. qemu_tcg_rr_cpu_thread_fn is the new name for the old
>>>>>   single threaded function.
>>>>>
>>>>>   - the TLS current_cpu variable is now live for the lifetime of MTTCG
>>>>>     vCPU threads. This is for future work where async jobs need to know
>>>>>     the vCPU context they are operating in.
>>>>>
>>>>> The user to switch on multi-thread behaviour and spawn a thread
>>>>> per-vCPU. For a simple test kvm-unit-test like:
>>>>>
>>>>>   ./arm/run ./arm/locking-test.flat -smp 4 -accel tcg,thread=multi
>>>>>
>>>>> Will now use 4 vCPU threads and have an expected FAIL (instead of the
>>>>> unexpected PASS) as the default mode of the test has no protection when
>>>>> incrementing a shared variable.
>>>>>
>>>>> We enable the parallel_cpus flag to ensure we generate correct barrier
>>>>> and atomic code if supported by the front and backends. This doesn't
>>>>> automatically enable MTTCG until default_mttcg_enabled() is updated to
>>>>> check the configuration is supported.
>>>>
>>>> This commit breaks linux-user mode:
>>>>
>>>> debian-8 with qemu-ppc on x86_64 with ltp-full-20170116
>>>>
>>>> cd /opt/ltp
>>>> ./runltp -p -l "qemu-$(date +%FT%T).log" -f /opt/ltp/runtest/syscalls -s
>>>> setgroups03
>>>>
>>>> setgroups03    1  TPASS  :  setgroups(65537) fails, Size is >
>>>> sysconf(_SC_NGROUPS_MAX), errno=22
>>>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>>>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>>>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>>>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>>>> qemu-ppc: /home/laurent/Projects/qemu/include/qemu/rcu.h:89:
>>>> rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed.
>>>> ...
>>>
>>> Interesting. I can only think the current_cpu change has broken it
>>> because most of the changes in this commit affect softmmu targets only
>>> (linux-user has its own run loop).
>>>
>>> Thanks for the report - I'll look into it.
>>
>> After:
>>
>>      95b0eca Merge remote-tracking branch
>> 'remotes/stsquad/tags/pull-mttcg-fixups-090317-1' into staging
>>
>> [Tested with my HEAD on:
>> b1616fe Merge remote-tracking branch
>> 'remotes/famz/tags/docker-pull-request' into staging]
>>
>> I have now:
>>
>> <<<test_start>>>
>> tag=setgroups03 stime=1489413401
>> cmdline="setgroups03"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> **
>> ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
>> failed: (cpu == current_cpu)
>> **
> 
> So I think this is saying that we were outside the tcg_exec_loop for
> this cpu and somehow longjmp'ed back into the loop.
> 
> I'll start setting up LTP on my system but in the meantime you might
> find it useful adding the cpu == current_cpu assert into all the places
> in cpu-exec-common.c before siglongjmp is called. Then a backtrace of
> the offending call will be easier to follow.

If I patch cpu-exec-common.c:
diff --git a/cpu-exec-common.c b/cpu-exec-common.c
index 0504a94..4bdf295 100644
--- a/cpu-exec-common.c
+++ b/cpu-exec-common.c
@@ -29,6 +29,7 @@ void cpu_loop_exit_noexc(CPUState *cpu)
     /* XXX: restore cpu registers saved in host registers */

     cpu->exception_index = -1;
+g_assert(cpu == current_cpu);
     siglongjmp(cpu->jmp_env, 1);
 }

@@ -64,6 +65,7 @@ void cpu_reloading_memory_map(void)

 void cpu_loop_exit(CPUState *cpu)
 {
+g_assert(cpu == current_cpu);
     siglongjmp(cpu->jmp_env, 1);
 }

@@ -72,6 +74,7 @@ void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
     if (pc) {
         cpu_restore_state(cpu, pc);
     }
+g_assert(cpu == current_cpu);
     siglongjmp(cpu->jmp_env, 1);
 }

I have exactly the same trace:

**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)

QEMU_STRACE gives:

6805 close(3) = 0
6805 setgroups(65536,-159891448,0,-150998360,0,0)**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)

and strace gives:

sudo strace -ffff chroot /var/lib/lxc/debian-8-ppc/rootfs
/opt/ltp/testcases/bin/setgroups03
...
[pid  6690] futex(0x7ffce8bc3340, FUTEX_WAIT_PRIVATE, 1, NULL
<unfinished ...>
[pid  6691] --- SIGRT_1 {si_signo=SIGRT_1, si_code=SI_TKILL,
si_pid=6690, si_uid=0} ---
[pid  6691] setgroups(65536, [65534, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]) = 0
[pid  6691] futex(0x7f656a601d1c, FUTEX_WAKE_PRIVATE, 1) = 0
[pid  6691] futex(0x7ffce8bc3340, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
[pid  6690] <... futex resumed> )       = 0
[pid  6691] <... futex resumed> )       = 1
[pid  6690] setgroups(65536, [65534, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
<unfinished ...>
[pid  6691] rt_sigreturn({mask=~[KILL STOP RTMIN RT_1]} <unfinished ...>
[pid  6690] <... setgroups resumed> )   = -1 EPERM (Operation not permitted)
[pid  6691] <... rt_sigreturn resumed> ) = 202
[pid  6690] rt_sigprocmask(SIG_UNBLOCK, [ABRT],  <unfinished ...>
[pid  6691] futex(0x625ffba4, FUTEX_WAIT, 4294967295, NULL <unfinished ...>
[pid  6690] <... rt_sigprocmask resumed> NULL, 8) = 0
[pid  6690] rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0
[pid  6690] getpid()                    = 6690
[pid  6690] gettid()                    = 6690
[pid  6690] tgkill(6690, 6690, SIGABRT) = 0
[pid  6690] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  6690] --- SIGABRT {si_signo=SIGABRT, si_code=SI_TKILL,
si_pid=6690, si_uid=0} ---
[pid  6690] rt_sigreturn({mask=~[BUS SEGV]}) = 0
[pid  6690] rt_sigaction(SIGABRT, {sa_handler=SIG_DFL, sa_mask=~[],
sa_flags=SA_RESTORER, sa_restorer=0x6018b100}, NULL, 8) = 0
[pid  6690] rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], ~[BUS KILL SEGV
STOP], 8) = 0
[pid  6690] getpid()                    = 6690
[pid  6690] gettid()                    = 6690
[pid  6690] tgkill(6690, 6690, SIGABRT) = 0
[pid  6690] rt_sigprocmask(SIG_SETMASK, ~[BUS KILL SEGV STOP], NULL, 8) = 0
[pid  6690] --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL,
si_addr=NULL} ---
[pid  6690] rt_sigprocmask(SIG_SETMASK, ~[BUS KILL SEGV STOP], NULL, 8) = 0
[pid  6690] open("/usr/lib64/charset.alias", O_RDONLY) = -1 ENOENT (No
such file or directory)
[pid  6690] open("/usr/lib64/gconv/gconv-modules.cache", O_RDONLY) = -1
ENOENT (No such file or directory)
[pid  6690] open("/usr/lib64/gconv/gconv-modules", O_RDONLY|O_CLOEXEC) =
-1 ENOENT (No such file or directory)
[pid  6690] futex(0x62605a30, FUTEX_WAKE_PRIVATE, 2147483647) = 0
[pid  6690] brk(0x636dc000)             = 0x636dc000
[pid  6690] write(2, "**\nERROR:/home/laurent/Projects/"..., 101**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
) = 101
[pid  6690] brk(0x636d4000)             = 0x636d4000
[pid  6690] --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL,
si_addr=NULL} ---
[pid  6690] rt_sigprocmask(SIG_SETMASK, ~[BUS KILL SEGV STOP], NULL, 8) = 0
[pid  6690] write(2, "**\nERROR:/home/laurent/Projects/"..., 101**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
) = 101
[pid  6690] --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL,
si_addr=NULL} ---
[pid  6690] rt_sigprocmask(SIG_SETMASK, ~[BUS KILL SEGV STOP], NULL, 8) = 0
[pid  6690] write(2, "**\nERROR:/home/laurent/Projects/"..., 101**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)
) = 101
[pid  6690] --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL,
si_addr=NULL} ---
[pid  6690] rt_sigprocmask(SIG_SETMASK, ~[BUS KILL SEGV STOP], NULL, 8) = 0
[pid  6690] write(2, "**\nERROR:/home/laurent/Projects/"..., 101**
ERROR:/home/laurent/Projects/qemu/cpu-exec.c:656:cpu_exec: assertion
failed: (cpu == current_cpu)

Laurent
