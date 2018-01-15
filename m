Received: from eggs.gnu.org ([2001:4830:134:3::10]:46675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1hK-0003dB-7Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1hJ-0001zR-50
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:08:58 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:36540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb1hI-0001z9-Ug
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:08:57 -0500
Received: by mail-oi0-x233.google.com with SMTP id w135so7925000oie.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 02:08:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180112210613.14124-1-richard.henderson@linaro.org>
References: <20180112210613.14124-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 10:08:35 +0000
Message-ID: <CAFEAcA8AhkmVhJHNgGRzfhUqBjLwHTaiCfUEAw0_zRfL4wbEcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] TCG queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 12 January 2018 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This includes a fix for the tcg/arm bug exposed by the ppc64 code change
> for comparisons.
>
> It also includes improvements to tcg/arm and tcg/ppc to allow for larger
> CPUFooState structures, as exposed by expanding CPUARMState for 2048-bit
> vector registers.

> ----------------------------------------------------------------
> Queued tcg patches
>
> ----------------------------------------------------------------
> Richard Henderson (4):
>       tcg/arm: Fix double-word comparisons
>       tcg/arm: Support tlb offsets larger than 64k
>       tcg/ppc: Support tlb offsets larger than 64k
>       tcg/ppc: Allow a 32-bit offset to the constant pool

This seems to crash on arm32 hosts with a sparc64 guest:

$ ./sparc64-softmmu/qemu-system-sparc64  -display none
Segmentation fault

Here's a backtrace:

Thread 3 "qemu-system-spa" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xe8cb8e10 (LWP 25876)]
0x000325a0 in tcg_out32 (s=0xe8300470, v=<optimised out>) at
/home/peter.maydell/qemu/tcg/tcg.c:193
193             *s->code_ptr++ = v;
(gdb) bt
#0  0x000325a0 in tcg_out32 (s=0xe8300470, v=<optimised out>) at
/home/peter.maydell/qemu/tcg/tcg.c:193
#1  tcg_out_dat_imm (im=<optimised out>, rn=<optimised out>, rd=2,
opc=8388608, cond=14, s=0xe8300470)
    at /home/peter.maydell/qemu/tcg/arm/tcg-target.inc.c:451
#2  tcg_out_tlb_read (s=s@entry=0xe8300470,
addrlo=addrlo@entry=TCG_REG_R4, addrhi=addrhi@entry=TCG_REG_R5,
opc=opc@entry=MO_8,
    mem_index=mem_index@entry=5, is_load=is_load@entry=true) at
/home/peter.maydell/qemu/tcg/arm/tcg-target.inc.c:1320
#3  0x00033144 in tcg_out_qemu_ld (s=0xe8300470, args=<optimised out>,
is64=<optimised out>)
    at /home/peter.maydell/qemu/tcg/arm/tcg-target.inc.c:1648
#4  0x00033b06 in tcg_out_op (s=s@entry=0xe8300470, opc=<optimised
out>, args=args@entry=0xe8cb85fc,
    const_args=const_args@entry=0xe8cb863c) at
/home/peter.maydell/qemu/tcg/arm/tcg-target.inc.c:2059
#5  0x000360b6 in tcg_reg_alloc_op (op=0xe83076b8, s=<optimised out>)
at /home/peter.maydell/qemu/tcg/tcg.c:2893
#6  tcg_gen_code (s=<optimised out>, tb=tb@entry=0xe8e9d680
<code_gen_buffer+1636>) at /home/peter.maydell/qemu/tcg/tcg.c:3279
#7  0x000757b8 in tb_gen_code (cpu=cpu@entry=0xaf3ee8,
pc=2198754869620, cs_base=cs_base@entry=2198754869624,
flags=flags@entry=69,
    cflags=0) at /home/peter.maydell/qemu/accel/tcg/translate-all.c:1319
#8  0x000747fc in tb_find (cf_mask=<optimised out>, tb_exit=<optimised
out>, last_tb=0x0, cpu=0xf000c178)
    at /home/peter.maydell/qemu/accel/tcg/cpu-exec.c:404
#9  cpu_exec (cpu=cpu@entry=0xaf3ee8) at
/home/peter.maydell/qemu/accel/tcg/cpu-exec.c:731
#10 0x00052f60 in tcg_cpu_exec (cpu=0xaf3ee8) at
/home/peter.maydell/qemu/cpus.c:1300
#11 qemu_tcg_rr_cpu_thread_fn (arg=<optimised out>) at
/home/peter.maydell/qemu/cpus.c:1396
#12 0xec9235b4 in start_thread (arg=0x0) at pthread_create.c:335
#13 0xec8c4bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:89
from /lib/arm-linux-gnueabihf/libc.so.6

Writing off the end of the codegen buffer?

thanks
-- PMM
