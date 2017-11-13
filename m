Received: from eggs.gnu.org ([2001:4830:134:3::10]:35165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eENbp-000297-2K
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eENbk-0005oT-5J
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:53:41 -0500
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:48405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eENbk-0005oL-15
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:53:36 -0500
Received: by mail-qt0-x22a.google.com with SMTP id f8so21663518qta.5
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 14:53:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAFEAcA95abAHYQ=FpS_n4Aqiui7uQCF=ONEPkUCXGOv-joSDtw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <61f7169d-e017-9ae6-de5e-836dcd0a0fdc@amsat.org>
Date: Mon, 13 Nov 2017 19:53:27 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95abAHYQ=FpS_n4Aqiui7uQCF=ONEPkUCXGOv-joSDtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] how do we determine correct guest PC for segfaults
 in atomic helpers for linux-user mode?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi Peter,

On 11/13/2017 04:59 PM, Peter Maydell wrote:
> I've been investigating a bug (a javac crash). I'm not sure if it's
> the root cause, but I can't figure out how, if we get a guest SEGV in
> an atomic helper we report the right faulting PC to the guest.
> 
> Specifically, if you get a SEGV here:
> 
> #0  0x000000006003c22b in helper_atomic_cmpxchgl_le (env=0x63caf680,
>     addr=275041819628, cmpv=0, newv=1)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:65
> #1  0x0000000061002f61 in static_code_gen_buffer ()
> #2  0x0000000060035d6b in cpu_tb_exec (cpu=0x63ca73e0,
>     itb=0x6119d000 <static_code_gen_buffer+9080960>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:167
> #3  0x0000000060036945 in cpu_loop_exec_tb (cpu=0x63ca73e0,
>     tb=0x6119d000 <static_code_gen_buffer+9080960>, last_tb=0x7f01b213dbd8,
>     tb_exit=0x7f01b213dbd0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:611
> #4  0x0000000060036bc2 in cpu_exec (cpu=0x63ca73e0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:723
> #5  0x000000006003da13 in cpu_loop (env=0x63caf680)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:809
> #6  0x000000006004c627 in clone_func (arg=0x7ffe028f0a10)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c:6241
> #7  0x00000000602fcc25 in start_thread (arg=0x7f01b213e700)
>     at pthread_create.c:333
> #8  0x00000000603949a9 in clone ()
> 
> then the code in handle_cpu_signal() is passed a pc of 0x6003c22b
> (the location in the helper function that does the memory access).
> This is outside generated code, so the call to cpu_restore_state()
> in handle_cpu_signal() will do nothing. However as far as I can tell,
> there isn't any syncing of the PC etc state to the CPU before calling
> this helper (at least, env->pc is completely wrong for the insn that
> I think is causing this helper call).

I'm not sure this is related, but last week I hit a similar problem when
my laptop ran Out Of Memory using the xlnx-zcu102 machine; but I wasn't
getting a SEGV but various SIGBUS in different places, and my backtraces
don't show atomic_template.h but softmmu_template.h.

I found it is easier to understand a such OOM using the -mem-prealloc
option, I now get a more OOM-related error:

Thread 12 "qemu-system-aar" received signal SIGBUS, Bus error.
0x0000555555de1bd4 in do_touch_pages (arg=0x555556cc0210) at
util/oslib-posix.c:331
331            *(volatile char *)addr = *addr;

Regards,

Phil.
