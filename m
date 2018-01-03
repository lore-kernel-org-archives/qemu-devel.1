Received: from eggs.gnu.org ([2001:4830:134:3::10]:48720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWska-0006yY-Ki
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWskW-000446-P0
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:47:12 -0500
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:46201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWskW-00043A-Iw
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:47:08 -0500
Received: by mail-pf0-x22b.google.com with SMTP id c204so5688pfc.13
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 15:47:08 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-11-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9831f4cc-c5ad-a43d-d677-8773f9f7b63e@linaro.org>
Date: Wed, 3 Jan 2018 15:47:04 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-11-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/21] RISC-V Linux User Emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 20f3d8c..178af56 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1272,6 +1272,28 @@ static inline void init_thread(struct target_pt_regs *regs,
>  
>  #endif /* TARGET_TILEGX */
>  
> +#ifdef TARGET_RISCV
> +
> +#define ELF_START_MMAP 0x80000000

For riscv64 too?  Surely closer to ((TASK_SIZE / 3) * 2).

> diff --git a/linux-user/main.c b/linux-user/main.c
> index 71696ed..8900141 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -227,7 +227,7 @@ void cpu_loop(CPUX86State *env)
>          cpu_exec_end(cs);
>          process_queued_cpu_work(cs);
>  
> -        switch(trapnr) {
> +        switch (trapnr) {

Even though the formatting is wrong, don't change unrelated code.

> +        case EXCP_DEBUG:
> +        gdbstep:
> +            signum = gdb_handlesig(cs, TARGET_SIGTRAP);
> +            sigcode = TARGET_TRAP_BRKPT;
> +            break;
> +        default:
> +            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
> +                     trapnr);
> +            exit(EXIT_FAILURE);

You will need to handle the generic EXCP_ATOMIC as well.
Though of course you won't see that until you use tcg_gen_atomic_*.


r~
