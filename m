Received: from eggs.gnu.org ([2001:4830:134:3::10]:38306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJVPJ-0004d2-LV
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJVPH-0000y5-PV
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:46:13 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:40528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fJVPH-0000wW-Gp
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:46:11 -0400
Received: by mail-oi0-x232.google.com with SMTP id c203-v6so5865385oib.7
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 19:46:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-5-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-5-richard.henderson@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 18 May 2018 14:46:09 +1200
Message-ID: <CAHNT7NuEQWdG8hxvGpJDCVk3RN=S=CVznM7xXyQm-S6D4FshfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/9] target/riscv: Introduce
 cpu_riscv_get_fcsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Fri, May 11, 2018 at 3:52 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

I'm not against this change but it conflicts with changes in the riscv
repo. I should post my patch queue to the list...

We have made a somewhat medium sized change and have unraveled two
monolithic switch statements out of csr_read_helper switch and
csr_write_helper into clearly decomposed functions for modifying control
and status registers, along with an interface to allow CPUs to hook custom
control and status registers. This was done to support atomic
read/modify/write CSRs which was not possible to achieve with the current
helpers which separately called via the csr_read_helper followed by
csr_write_helper. Given the only way to modify CSRs was via the switch
statements, we needed to move them out to provide a mechanism for CSRs that
wish to be truly atomic. e.g. 'mip'. The CSR functions are defined in The
RISC-V Instruction Set Manual Volume I: User-Level ISA Document Version 2.2
as "atomic" instructions:

- CSRRW (Atomic Read/Write CSR)
- CSRRS (Atomic Read and Set Bits in CSR)
- CSRRC (Atomic Read and Clear Bits in CSR)

We have thus changed QEMU to allow truly atomic CSR implementations. The
new implementation replaces the compiler doing compare/branch vs jump table
switch codegen for a sparse CSR address space with a single array of
function pointers. i.e. load, indirect jump. Along with this change we have
also renamed functions in target/riscv to use riscv_ prefix and added a
public interface to hook custom CSRs. The CSR changes will allow out of
tree code to hook custom CSRs without needing to change target/riscv code.

- riscv_cpu_ won over cpu_riscv_ given the number of functions conforming
with the former riscv_ prefix and the desire for consistency in target/riscv

In the riscv tree we now have riscv_csr_read(env, CSR_FCSR)
and riscv_csr_write(env, CSR_FCSR, fcsr) as the method to read and write
the composite. There is also a user in linux-user/riscv/signal.c that
should probably use the new interface. We could change
linux-user/riscv/signal.c to use your new interface however your interface
only provides a read method and no write method, so the write interface
remains in the (current) big CSR switch statement, leaving an inconsitency
between the encapsulation of read and write. We currently have the new fcsr
read and write encapsulated in static functions read_fcsr and write_fcsr in
a new csr module (which should perhaps be called csr_helper.c).

See:

- https://github.com/riscv/riscv-qemu/commits/qemu-2.13-for-upstream
-
https://github.com/riscv/riscv-qemu/commit/0783ce5ea580552b1f8e2f16a3e3cc1af19db69b
-
https://github.com/riscv/riscv-qemu/commit/fa17549fbc726e83a3c163b1534c7465147c6718


> ---
>  target/riscv/cpu.h        | 1 +
>  target/riscv/fpu_helper.c | 6 ++++++
>  target/riscv/op_helper.c  | 3 +--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 34abc383e3..f2bc243b95 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -265,6 +265,7 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState
> *env,
>                                            uint32_t exception, uintptr_t
> pc);
>
>  target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
> +target_ulong cpu_riscv_get_fcsr(CPURISCVState *env);
>  void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
>
>  #define TB_FLAGS_MMU_MASK  3
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index abbadead5c..41c7352115 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -37,6 +37,12 @@ target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
>      return hard;
>  }
>
> +target_ulong cpu_riscv_get_fcsr(CPURISCVState *env)
> +{
> +    return (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
> +         | (env->frm << FSR_RD_SHIFT);
> +}
> +
>  void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong hard)
>  {
>      int soft = 0;
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 3abf52453c..fd2d8c0a9d 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -423,8 +423,7 @@ target_ulong csr_read_helper(CPURISCVState *env,
> target_ulong csrno)
>          return env->frm;
>      case CSR_FCSR:
>          validate_mstatus_fs(env, GETPC());
> -        return (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
> -                | (env->frm << FSR_RD_SHIFT);
> +        return cpu_riscv_get_fcsr(env);
>      /* rdtime/rdtimeh is trapped and emulated by bbl in system mode */
>  #ifdef CONFIG_USER_ONLY
>      case CSR_TIME:
> --
> 2.17.0
>
>
