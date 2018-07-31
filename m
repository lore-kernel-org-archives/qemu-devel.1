Received: from eggs.gnu.org ([2001:4830:134:3::10]:60283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkS9U-0007GH-4Y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkS9Q-0006Pk-T4
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:45:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fkS9Q-0006Ot-IL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:45:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id h14-v6so16122077wrw.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 03:45:12 -0700 (PDT)
References: <20180730201553.32423-1-richard.henderson@linaro.org>
	<20180730201553.32423-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180730201553.32423-3-richard.henderson@linaro.org>
Date: Tue, 31 Jul 2018 11:45:09 +0100
Message-ID: <87wotb8z0q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] linux-user: Pass the parent env to
 cpu_clone_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com


Richard Henderson <richard.henderson@linaro.org> writes:

> Implementing clone for sparc requires that we make modifications
> to both the parent and child cpu state.  In all other cases, the
> new argument can be ignored.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/aarch64/target_cpu.h    | 3 ++-
>  linux-user/alpha/target_cpu.h      | 3 ++-
>  linux-user/arm/target_cpu.h        | 3 ++-
>  linux-user/cris/target_cpu.h       | 3 ++-
>  linux-user/hppa/target_cpu.h       | 3 ++-
>  linux-user/i386/target_cpu.h       | 3 ++-
>  linux-user/m68k/target_cpu.h       | 3 ++-
>  linux-user/microblaze/target_cpu.h | 3 ++-
>  linux-user/mips/target_cpu.h       | 3 ++-
>  linux-user/nios2/target_cpu.h      | 3 ++-
>  linux-user/openrisc/target_cpu.h   | 4 +++-
>  linux-user/ppc/target_cpu.h        | 3 ++-
>  linux-user/riscv/target_cpu.h      | 3 ++-
>  linux-user/s390x/target_cpu.h      | 3 ++-
>  linux-user/sh4/target_cpu.h        | 3 ++-
>  linux-user/sparc/target_cpu.h      | 3 ++-
>  linux-user/tilegx/target_cpu.h     | 3 ++-
>  linux-user/xtensa/target_cpu.h     | 3 ++-
>  linux-user/syscall.c               | 2 +-
>  19 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_=
cpu.h
> index a021c95fa4..130177115e 100644
> --- a/linux-user/aarch64/target_cpu.h
> +++ b/linux-user/aarch64/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef AARCH64_TARGET_CPU_H
>  #define AARCH64_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUARMState *env, CPUARMState *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->xregs[31] =3D newsp;
> diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
> index ac4d255ae7..750ffb50d7 100644
> --- a/linux-user/alpha/target_cpu.h
> +++ b/linux-user/alpha/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef ALPHA_TARGET_CPU_H
>  #define ALPHA_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUAlphaState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUAlphaState *env, CPUAlphaState *old=
_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->ir[IR_SP] =3D newsp;
> diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
> index 8a3764919a..5538b6cb29 100644
> --- a/linux-user/arm/target_cpu.h
> +++ b/linux-user/arm/target_cpu.h
> @@ -23,7 +23,8 @@
>     See validate_guest_space in linux-user/elfload.c.  */
>  #define MAX_RESERVED_VA  0xffff0000ul
>
> -static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUARMState *env, CPUARMState *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[13] =3D newsp;
> diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
> index 2309343979..baf842b400 100644
> --- a/linux-user/cris/target_cpu.h
> +++ b/linux-user/cris/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef CRIS_TARGET_CPU_H
>  #define CRIS_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUCRISState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUCRISState *env, CPUCRISState *old_e=
nv,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[14] =3D newsp;
> diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
> index 1c539bdbd6..7cd8d168a7 100644
> --- a/linux-user/hppa/target_cpu.h
> +++ b/linux-user/hppa/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef HPPA_TARGET_CPU_H
>  #define HPPA_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUHPPAState *env, CPUHPPAState *old_e=
nv,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->gr[30] =3D newsp;
> diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
> index ece04d0966..8fbe36670f 100644
> --- a/linux-user/i386/target_cpu.h
> +++ b/linux-user/i386/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef I386_TARGET_CPU_H
>  #define I386_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUX86State *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUX86State *env, CPUX86State *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[R_ESP] =3D newsp;
> diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
> index 611df065ca..1f0939aea7 100644
> --- a/linux-user/m68k/target_cpu.h
> +++ b/linux-user/m68k/target_cpu.h
> @@ -21,7 +21,8 @@
>  #ifndef M68K_TARGET_CPU_H
>  #define M68K_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUM68KState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUM68KState *env, CPUM68KState *old_e=
nv,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->aregs[7] =3D newsp;
> diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/t=
arget_cpu.h
> index 73e139938c..3394e98918 100644
> --- a/linux-user/microblaze/target_cpu.h
> +++ b/linux-user/microblaze/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef MICROBLAZE_TARGET_CPU_H
>  #define MICROBLAZE_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUMBState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUMBState *env, CPUMBState *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[R_SP] =3D newsp;
> diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
> index 02cf5eeff7..109348a5c9 100644
> --- a/linux-user/mips/target_cpu.h
> +++ b/linux-user/mips/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef MIPS_TARGET_CPU_H
>  #define MIPS_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUMIPSState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUMIPSState *env, CPUMIPSState *old_e=
nv,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->active_tc.gpr[29] =3D newsp;
> diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
> index 14f63338fa..09d2db74dc 100644
> --- a/linux-user/nios2/target_cpu.h
> +++ b/linux-user/nios2/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef TARGET_CPU_H
>  #define TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUNios2State *env, CPUNios2State *old=
_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[R_SP] =3D newsp;
> diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/targe=
t_cpu.h
> index d1ea4506e2..5ea3e1b1a6 100644
> --- a/linux-user/openrisc/target_cpu.h
> +++ b/linux-user/openrisc/target_cpu.h
> @@ -20,7 +20,9 @@
>  #ifndef OPENRISC_TARGET_CPU_H
>  #define OPENRISC_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong ne=
wsp)
> +static inline void cpu_clone_regs(CPUOpenRISCState *env,
> +                                  CPUOpenRISCState *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          cpu_set_gpr(env, 1, newsp);
> diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
> index c4641834e7..f42e266047 100644
> --- a/linux-user/ppc/target_cpu.h
> +++ b/linux-user/ppc/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef PPC_TARGET_CPU_H
>  #define PPC_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUPPCState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUPPCState *env, CPUPPCState *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->gpr[1] =3D newsp;
> diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
> index 7e090f376a..b112832d95 100644
> --- a/linux-user/riscv/target_cpu.h
> +++ b/linux-user/riscv/target_cpu.h
> @@ -1,7 +1,8 @@
>  #ifndef TARGET_CPU_H
>  #define TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPURISCVState *env, CPURISCVState *old=
_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->gpr[xSP] =3D newsp;
> diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
> index 66ef8aa8c2..b31b9ad09d 100644
> --- a/linux-user/s390x/target_cpu.h
> +++ b/linux-user/s390x/target_cpu.h
> @@ -22,7 +22,8 @@
>  #ifndef S390X_TARGET_CPU_H
>  #define S390X_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUS390XState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUS390XState *env, CPUS390XState *old=
_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[15] =3D newsp;
> diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
> index 1a647ddb98..7f09ed4c3a 100644
> --- a/linux-user/sh4/target_cpu.h
> +++ b/linux-user/sh4/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef SH4_TARGET_CPU_H
>  #define SH4_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUSH4State *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUSH4State *env, CPUSH4State *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->gregs[15] =3D newsp;
> diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
> index 1ffc0ae9f2..a92748cae3 100644
> --- a/linux-user/sparc/target_cpu.h
> +++ b/linux-user/sparc/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef SPARC_TARGET_CPU_H
>  #define SPARC_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUSPARCState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUSPARCState *env, CPUSPARCState *old=
_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regwptr[22] =3D newsp;
> diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cp=
u.h
> index d1aa5824f2..35100a3d43 100644
> --- a/linux-user/tilegx/target_cpu.h
> +++ b/linux-user/tilegx/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef TILEGX_TARGET_CPU_H
>  #define TILEGX_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUTLGState *env, target_ulong newsp)
> +static inline void cpu_clone_regs(CPUTLGState *env, CPUTLGState *old_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[TILEGX_R_SP] =3D newsp;
> diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cp=
u.h
> index e31efe3ea0..0e9681e9f9 100644
> --- a/linux-user/xtensa/target_cpu.h
> +++ b/linux-user/xtensa/target_cpu.h
> @@ -4,7 +4,8 @@
>  #ifndef XTENSA_TARGET_CPU_H
>  #define XTENSA_TARGET_CPU_H
>
> -static inline void cpu_clone_regs(CPUXtensaState *env, target_ulong news=
p)
> +static inline void cpu_clone_regs(CPUXtensaState *env, CPUXtensaState *o=
ld_env,
> +                                  target_ulong newsp)
>  {
>      if (newsp) {
>          env->regs[1] =3D newsp;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5bf8d13de7..7273a2fe54 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6442,7 +6442,7 @@ static int do_fork(CPUArchState *env, unsigned int =
flags, abi_ulong newsp,
>          /* we create a new CPU instance. */
>          new_env =3D cpu_copy(env);
>          /* Init regs that differ from the parent.  */
> -        cpu_clone_regs(new_env, newsp);
> +        cpu_clone_regs(new_env, env, newsp);
>          new_cpu =3D ENV_GET_CPU(new_env);
>          new_cpu->opaque =3D ts;
>          ts->bprm =3D parent_ts->bprm;


--
Alex Benn=C3=A9e
