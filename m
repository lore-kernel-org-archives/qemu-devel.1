Received: from eggs.gnu.org ([2001:4830:134:3::10]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eEOCF-0006Ta-Az
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eEOCC-00066f-4v
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:31:19 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eEOCB-00066O-UG
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:31:16 -0500
Received: by mail-wr0-x242.google.com with SMTP id y9so15944533wrb.2
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 15:31:15 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA95abAHYQ=FpS_n4Aqiui7uQCF=ONEPkUCXGOv-joSDtw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b4c558f5-3b8e-52f0-4b66-c40519bc0500@twiddle.net>
Date: Tue, 14 Nov 2017 00:31:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95abAHYQ=FpS_n4Aqiui7uQCF=ONEPkUCXGOv-joSDtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>

On 11/13/2017 08:59 PM, Peter Maydell wrote:
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
> 
> Am I misreading my debugger entrails (entirely possible)? How is this
> code intended to get the right guest PC for segfaults in these helpers?

It looks like we can't.

We get it right for system mode, but not linux-user.

I suppose it would be fixable with a tls variable that is set by the helper,
which could then be used by the signal handler in preference to the host pc
indicated by the frame.  That seems kinda kludgy.

Looking forward, we're going to need a way to catch these faults for the SVE
FFR.  Perhaps a tls pointer to a jmp_buf can do both.  If the pointer is
non-null, host_signal_handler does nothing for SIGSEGV, SIGBUS.  For SVE, we
end the first-faulting load sequence.  For atomic linux-user, we call into a
version of handle_cpu_signal with the proper code_gen_buffer return address.

Thoughts?

r~
