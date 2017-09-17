Received: from eggs.gnu.org ([2001:4830:134:3::10]:52030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <digetx@gmail.com>) id 1dtZuM-0003ds-Ub
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 09:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <digetx@gmail.com>) id 1dtZuI-0000ko-7U
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 09:46:50 -0400
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-23-alex.bennee@linaro.org>
	<7468f944-914c-de89-66fb-f8ad49eb59c1@gmail.com>
	<87poapbgt0.fsf@linaro.org>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e511a895-b1e3-150f-6555-12ba1fa16273@gmail.com>
Date: Sun, 17 Sep 2017 16:46:41 +0300
MIME-Version: 1.0
In-Reply-To: <87poapbgt0.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 22/24] target-arm: ensure all cross vCPUs
 TLB flushes complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org

On 17.09.2017 16:22, Alex Bennée wrote:
> 
> Dmitry Osipenko <digetx@gmail.com> writes:
> 
>> On 24.02.2017 14:21, Alex Bennée wrote:
>>> Previously flushes on other vCPUs would only get serviced when they
>>> exited their TranslationBlocks. While this isn't overly problematic it
>>> violates the semantics of TLB flush from the point of view of source
>>> vCPU.
>>>
>>> To solve this we call the cputlb *_all_cpus_synced() functions to do
>>> the flushes which ensures all flushes are completed by the time the
>>> vCPU next schedules its own work. As the TLB instructions are modelled
>>> as CP writes the TB ends at this point meaning cpu->exit_request will
>>> be checked before the next instruction is executed.
>>>
>>> Deferring the work until the architectural sync point is a possible
>>> future optimisation.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  target/arm/helper.c | 165 ++++++++++++++++++++++------------------------------
>>>  1 file changed, 69 insertions(+), 96 deletions(-)
>>>
>>
>> Hello,
>>
>> I have an issue with Linux kernel stopping to boot on a SMP 32bit ARM (haven't
>> checked 64bit) in a single-threaded TCG mode. Kernel reaches point where it
>> should mount rootfs over NFS and vCPUs stop. This issue is reproducible with any
>> 32bit ARM machine type. Kernel boots fine with a MTTCG accel, only
>> single-threaded TCG is affected. Git bisection lead to this patch, any
>> ideas?
> 
> It shouldn't cause a problem but can you obtain a backtrace of the
> system when hung?
> 

Actually, it looks like TCG enters infinite loop. Do you mean backtrace of QEMU
by 'backtrace of the system'? If so, here it is:

Thread 4 (Thread 0x7ffa37f10700 (LWP 20716)):

#0  0x00007ffa601888bd in poll () at ../sysdeps/unix/syscall-template.S:84

#1  0x00007ffa5e3aa561 in poll (__timeout=-1, __nfds=2, __fds=0x7ffa30006dc0) at
/usr/include/bits/poll2.h:46
#2  poll_func (ufds=0x7ffa30006dc0, nfds=2, timeout=-1, userdata=0x557bd603eae0)
at
/var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/thread-mainloop.c:69
#3  0x00007ffa5e39bbb1 in pa_mainloop_poll (m=m@entry=0x557bd60401f0) at
/var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/mainloop.c:844
#4  0x00007ffa5e39c24e in pa_mainloop_iterate (m=0x557bd60401f0,
block=<optimized out>, retval=0x0) at
/var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/mainloop.c:926
#5  0x00007ffa5e39c300 in pa_mainloop_run (m=0x557bd60401f0,
retval=retval@entry=0x0) at
/var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/mainloop.c:944

#6  0x00007ffa5e3aa4a9 in thread (userdata=0x557bd60400f0) at
/var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/thread-mainloop.c:100

#7  0x00007ffa599eea38 in internal_thread_func (userdata=0x557bd603e090) at
/var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulsecore/thread-posix.c:81

#8  0x00007ffa60453657 in start_thread (arg=0x7ffa37f10700) at
pthread_create.c:456

#9  0x00007ffa60193c5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:97





Thread 3 (Thread 0x7ffa4adff700 (LWP 20715)):


#0  0x00007ffa53e51caf in code_gen_buffer ()


#1  0x0000557bd2fa7f17 in cpu_tb_exec (cpu=0x557bd56160a0, itb=0x7ffa53e51b80
<code_gen_buffer+15481686>) at /home/dima/vl/qemu-tests/accel/tcg/cpu-exec.c:166

#2  0x0000557bd2fa8e0f in cpu_loop_exec_tb (cpu=0x557bd56160a0,
tb=0x7ffa53e51b80 <code_gen_buffer+15481686>, last_tb=0x7ffa4adfea68,
tb_exit=0x7ffa4adfea64) at /home/dima/vl/qemu-tests/accel/tcg/cpu-exec.c:613
#3  0x0000557bd2fa90ff in cpu_exec (cpu=0x557bd56160a0) at
/home/dima/vl/qemu-tests/accel/tcg/cpu-exec.c:711

#4  0x0000557bd2f6dcba in tcg_cpu_exec (cpu=0x557bd56160a0) at
/home/dima/vl/qemu-tests/cpus.c:1270

#5  0x0000557bd2f6dee1 in qemu_tcg_rr_cpu_thread_fn (arg=0x557bd5598e20) at
/home/dima/vl/qemu-tests/cpus.c:1365

#6  0x00007ffa60453657 in start_thread (arg=0x7ffa4adff700) at
pthread_create.c:456

#7  0x00007ffa60193c5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:97







Thread 2 (Thread 0x7ffa561bf700 (LWP 20714)):



#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38



#1  0x0000557bd34e1eaa in qemu_futex_wait (f=0x557bd4031798
<rcu_call_ready_event>, val=4294967295) at
/home/dima/vl/qemu-tests/include/qemu/futex.h:26


#2  0x0000557bd34e2071 in qemu_event_wait (ev=0x557bd4031798
<rcu_call_ready_event>) at util/qemu-thread-posix.c:442


#3  0x0000557bd34f9b1f in call_rcu_thread (opaque=0x0) at util/rcu.c:249



#4  0x00007ffa60453657 in start_thread (arg=0x7ffa561bf700) at
pthread_create.c:456


#5  0x00007ffa60193c5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:97







Thread 1 (Thread 0x7ffa67502600 (LWP 20713)):



#0  0x00007ffa601889ab in __GI_ppoll (fds=0x557bd5bbf160, nfds=11,
timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:39


#1  0x0000557bd34dc460 in qemu_poll_ns (fds=0x557bd5bbf160, nfds=11,
timeout=29841115) at util/qemu-timer.c:334


#2  0x0000557bd34dd488 in os_host_main_loop_wait (timeout=29841115) at
util/main-loop.c:255


#3  0x0000557bd34dd557 in main_loop_wait (nonblocking=0) at util/main-loop.c:515



#4  0x0000557bd3120f0e in main_loop () at vl.c:1999



#5  0x0000557bd3128d4a in main (argc=17, argv=0x7ffe7de2a248,
envp=0x7ffe7de2a2d8) at vl.c:4877

>>
>> Example:
>>
>> qemu-system-arm -M vexpress-a9 -smp cpus=2 -accel accel=tcg,thread=single
>> -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb -serial
>> stdio -net nic,model=lan9118 -net user -d in_asm,out_asm -D /tmp/qemulog
>>
>> Last TB from the log:
>> ----------------
>> IN:
>> 0xc011a450:  ee080f73      mcr	15, 0, r0, cr8, cr3, {3}
>>
>> OUT: [size=68]
>> 0x7f32d8b93f80:  mov    -0x18(%r14),%ebp
>> 0x7f32d8b93f84:  test   %ebp,%ebp
>> 0x7f32d8b93f86:  jne    0x7f32d8b93fb8
>> 0x7f32d8b93f8c:  mov    %r14,%rdi
>> 0x7f32d8b93f8f:  mov    $0x5620f2aea5d0,%rsi
>> 0x7f32d8b93f99:  mov    (%r14),%edx
>> 0x7f32d8b93f9c:  mov    $0x5620f18107ca,%r10
>> 0x7f32d8b93fa6:  callq  *%r10
>> 0x7f32d8b93fa9:  movl   $0xc011a454,0x3c(%r14)
>> 0x7f32d8b93fb1:  xor    %eax,%eax
>> 0x7f32d8b93fb3:  jmpq   0x7f32d7a4e016
>> 0x7f32d8b93fb8:  lea    -0x14aa07c(%rip),%rax        # 0x7f32d76e9f43
>> 0x7f32d8b93fbf:  jmpq   0x7f32d7a4e016
-- 
Dmitry
