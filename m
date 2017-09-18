Received: from eggs.gnu.org ([2001:4830:134:3::10]:38910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtwbA-0002WZ-0b
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtwb5-0001sE-VL
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:00:32 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:50405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtwb5-0001qx-KL
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:00:27 -0400
Received: by mail-wr0-x22a.google.com with SMTP id w12so568878wrc.7
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:00:26 -0700 (PDT)
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-23-alex.bennee@linaro.org>
	<7468f944-914c-de89-66fb-f8ad49eb59c1@gmail.com>
	<87poapbgt0.fsf@linaro.org>
	<e511a895-b1e3-150f-6555-12ba1fa16273@gmail.com>
	<87a81sjp15.fsf@linaro.org>
	<70057789-ab76-1150-ab2e-b5a3239a0209@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <70057789-ab76-1150-ab2e-b5a3239a0209@gmail.com>
Date: Mon, 18 Sep 2017 15:00:23 +0100
Message-ID: <87d16ods3s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Dmitry Osipenko <digetx@gmail.com>
Cc: peter.maydell@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org


Dmitry Osipenko <digetx@gmail.com> writes:

> On 18.09.2017 13:10, Alex Bennée wrote:
>>
>> Dmitry Osipenko <digetx@gmail.com> writes:
>>
>>> On 17.09.2017 16:22, Alex Bennée wrote:
>>>>
>>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>>
>>>>> On 24.02.2017 14:21, Alex Bennée wrote:
>>>>>> Previously flushes on other vCPUs would only get serviced when they
>>>>>> exited their TranslationBlocks. While this isn't overly problematic it
>>>>>> violates the semantics of TLB flush from the point of view of source
>>>>>> vCPU.
>>>>>>
>>>>>> To solve this we call the cputlb *_all_cpus_synced() functions to do
>>>>>> the flushes which ensures all flushes are completed by the time the
>>>>>> vCPU next schedules its own work. As the TLB instructions are modelled
>>>>>> as CP writes the TB ends at this point meaning cpu->exit_request will
>>>>>> be checked before the next instruction is executed.
>>>>>>
>>>>>> Deferring the work until the architectural sync point is a possible
>>>>>> future optimisation.
>>>>>>
>>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>>>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>> ---
>>>>>>  target/arm/helper.c | 165 ++++++++++++++++++++++------------------------------
>>>>>>  1 file changed, 69 insertions(+), 96 deletions(-)
>>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> I have an issue with Linux kernel stopping to boot on a SMP 32bit ARM (haven't
>>>>> checked 64bit) in a single-threaded TCG mode. Kernel reaches point where it
>>>>> should mount rootfs over NFS and vCPUs stop. This issue is reproducible with any
>>>>> 32bit ARM machine type. Kernel boots fine with a MTTCG accel, only
>>>>> single-threaded TCG is affected. Git bisection lead to this patch, any
>>>>> ideas?
>>>>
>>>> It shouldn't cause a problem but can you obtain a backtrace of the
>>>> system when hung?
>>>>
>>>
>>> Actually, it looks like TCG enters infinite loop. Do you mean backtrace of QEMU
>>> by 'backtrace of the system'? If so, here it is:
>>>
>>> Thread 4 (Thread 0x7ffa37f10700 (LWP 20716)):
>>>
>>> #0  0x00007ffa601888bd in poll () at ../sysdeps/unix/syscall-template.S:84
>>>
>>> #1  0x00007ffa5e3aa561 in poll (__timeout=-1, __nfds=2, __fds=0x7ffa30006dc0) at
>>> /usr/include/bits/poll2.h:46
>>> #2  poll_func (ufds=0x7ffa30006dc0, nfds=2, timeout=-1, userdata=0x557bd603eae0)
>>> at
>>> /var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/thread-mainloop.c:69
>>> #3  0x00007ffa5e39bbb1 in pa_mainloop_poll (m=m@entry=0x557bd60401f0) at
>>> /var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/mainloop.c:844
>>> #4  0x00007ffa5e39c24e in pa_mainloop_iterate (m=0x557bd60401f0,
>>> block=<optimized out>, retval=0x0) at
>>> /var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/mainloop.c:926
>>> #5  0x00007ffa5e39c300 in pa_mainloop_run (m=0x557bd60401f0,
>>> retval=retval@entry=0x0) at
>>> /var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/mainloop.c:944
>>>
>>> #6  0x00007ffa5e3aa4a9 in thread (userdata=0x557bd60400f0) at
>>> /var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulse/thread-mainloop.c:100
>>>
>>> #7  0x00007ffa599eea38 in internal_thread_func (userdata=0x557bd603e090) at
>>> /var/tmp/portage/media-sound/pulseaudio-10.0/work/pulseaudio-10.0/src/pulsecore/thread-posix.c:81
>>>
>>> #8  0x00007ffa60453657 in start_thread (arg=0x7ffa37f10700) at
>>> pthread_create.c:456
>>>
>>> #9  0x00007ffa60193c5f in clone () at
>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:97
>>>
>>>
>>>
>>>
>>>
>>> Thread 3 (Thread 0x7ffa4adff700 (LWP 20715)):
>>>
>>>
>>> #0  0x00007ffa53e51caf in code_gen_buffer ()
>>>
>>
>> Well it's not locked up in servicing any flush tasks as it's executing
>> code. Maybe the guest code is spinning on something?
>>
>
> Indeed, I should have used 'exec' instead of 'in_asm'.
>
>> In the monitor:
>>
>>   info registers
>>
>> Will show you where things are, see if the ip is moving each time. Also
>> you can do a disassemble dump from there to see what code it is stuck
>> on.
>>
>
> I've attached with GDB to QEMU to see where it got stuck. Turned out it is
> caused by CONFIG_STRICT_KERNEL_RWX=y of the Linux kernel. Upon boot completion
> kernel changes memory permissions and that changing is executed on a dedicated
> CPU, while other CPUs are 'stopped' in a busy loop.
>
> This patch just introduced a noticeable performance regression for a
> single-threaded TCG, which is probably fine since MTTCG is the default now.
> Thank you very much for the suggestions and all your work on MTTCG!

Hmm well it would be nice to know the exact mechanism for that failure.
If we just end up with a very long list of tasks in
cpu->queued_work_first then I guess that explains it but it would be
nice to quantify the problem.

I had trouble seeing where this loop is in the kernel code, got a pointer?

--
Alex Bennée
