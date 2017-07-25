Received: from eggs.gnu.org ([2001:4830:134:3::10]:40378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da1EA-0004H0-QG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da1E6-0007GK-SI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:54:26 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1da1E6-0007Fo-J6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:54:22 -0400
Received: by mail-wm0-x231.google.com with SMTP id m85so44493706wma.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:54:22 -0700 (PDT)
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<b64e52eb-47ca-7264-0e09-1dc9b3794e92@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b64e52eb-47ca-7264-0e09-1dc9b3794e92@redhat.com>
Date: Tue, 25 Jul 2017 15:54:19 +0100
Message-ID: <87fudkefdw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1706296] [NEW] Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Bug 1706296 <1706296@bugs.launchpad.net>, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, "Emilio G. Cota" <cota@braap.org>, KONRAD Frederic <fred.konrad@greensocs.com>, Pranith Kumar <bobby.prani@gmail.com>


Thomas Huth <thuth@redhat.com> writes:

> On 25.07.2017 11:30, Richard Jones wrote:
>> ERROR:/home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
>> Aborted (core dumped)
>>
>> The stack trace in the failing thread is:
>>
>> Thread 4 (Thread 0x7fffb0418700 (LWP 21979)):
>> #0  0x00007fffdd89b64b in raise () at /lib64/libc.so.6
>> #1  0x00007fffdd89d450 in abort () at /lib64/libc.so.6
>> #2  0x00007fffdff8c75d in g_assertion_message () at /lib64/libglib-2.0.so.0
>> #3  0x00007fffdff8c7ea in g_assertion_message_expr ()
>>     at /lib64/libglib-2.0.so.0
>> #4  0x00005555557a7d00 in qemu_mutex_lock_iothread ()
>>     at /home/rjones/d/qemu/cpus.c:1580
>> #5  0x00005555557cb429 in io_writex (env=env@entry=0x555556751400, iotlbentry=0x55555675b678,
>>     iotlbentry@entry=0x5aaaaae40c918, val=val@entry=8, addr=addr@entry=2148532220, retaddr=0, retaddr@entry=93825011136120, size=size@entry=4)
>>     at /home/rjones/d/qemu/accel/tcg/cputlb.c:795
>> #6  0x00005555557ce0f7 in io_writel (retaddr=93825011136120, addr=2148532220, val=8, index=255, mmu_idx=21845, env=0x555556751400)
>>     at /home/rjones/d/qemu/softmmu_template.h:265
>> #7  0x00005555557ce0f7 in helper_le_stl_mmu (env=env@entry=0x555556751400, addr=addr@entry=2148532220, val=val@entry=8, oi=<optimized out>, retaddr=93825011136120, retaddr@entry=0) at /home/rjones/d/qemu/softmmu_template.h:300
>> #8  0x000055555587c0a4 in cpu_stl_kernel_ra (env=0x555556751400, ptr=2148532220, v=8, retaddr=0) at /home/rjones/d/qemu/include/exec/cpu_ldst_template.h:182
>> #9  0x0000555555882610 in do_interrupt_protected (is_hw=<optimized
>> out>, next_eip=<optimized out>, error_code=2, is_int=<optimized out>,
>> intno=<optimized out>, env=0x555556751400) at
>> /home/rjones/d/qemu/target/i386/seg_helper.c:758

Erm, what is happening here? I think the seg_helper is writing a stack
frame but for some reason to io memory, triggering the BQL. This just
seems weird.

>> #10 0x0000555555882610 in do_interrupt_all (cpu=cpu@entry=0x555556749170, intno=<optimized out>, is_int=<optimized out>, error_code=2, next_eip=<optimized out>, is_hw=is_hw@entry=0) at /home/rjones/d/qemu/target/i386/seg_helper.c:1252
>> #11 0x00005555558839d3 in x86_cpu_do_interrupt (cs=0x555556749170)
>>     at /home/rjones/d/qemu/target/i386/seg_helper.c:1298
>> #12 0x00005555557d2ccb in cpu_handle_exception (ret=<synthetic pointer>, cpu=0x5555566a4590) at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:465
>> #13 0x00005555557d2ccb in cpu_exec (cpu=cpu@entry=0x555556749170)
>>     at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:670
>> #14 0x00005555557a855a in tcg_cpu_exec (cpu=0x555556749170)
>>     at /home/rjones/d/qemu/cpus.c:1270
>> #15 0x00005555557a855a in qemu_tcg_rr_cpu_thread_fn (arg=<optimized out>)
>>     at /home/rjones/d/qemu/cpus.c:1365
>> #16 0x00007fffddc3d36d in start_thread () at /lib64/libpthread.so.0
>> #17 0x00007fffdd975b9f in clone () at /lib64/libc.so.6
>
> Looks like the iothread lock is taken twice here, one time in
> accel/tcg/cpu-exec.c around line 465 and one time in
> accel/tcg/cputlb.c:795 again.
>
> If I've get that right, the locks have been added by this commit here:
>
>  8d04fb55dec381bc5105cb47f29d918e579e8cbd
>  tcg: drop global lock during TCG code execution
>
> so this looks related to the MTTCG reworks that happened recently. I
> hope one of the MTTCG gurus has some spare time to look at this...

I think I really need an x86 guru to explain what just happened.

--
Alex Bennée
