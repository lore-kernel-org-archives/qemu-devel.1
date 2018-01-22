Received: from eggs.gnu.org ([2001:4830:134:3::10]:57057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZmX-000095-KP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZmU-0001NZ-C8
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:56:53 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edZmU-0001My-2c
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:56:50 -0500
Received: by mail-wm0-x244.google.com with SMTP id 141so15840139wme.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 02:56:49 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-6-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 10:56:47 +0000
Message-ID: <871siikvps.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/16] target/arm: Change the type of
 vfp.regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> All direct users of this field want an integral value.  Drop all
> of the extra casting between uint64_t and float64.

Did the extra casting ever generate superfluous code?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |  2 +-
>  target/arm/arch_dump.c     |  4 ++--
>  target/arm/helper.c        | 20 ++++++++++----------
>  target/arm/machine.c       |  2 +-
>  target/arm/translate-a64.c |  8 ++++----
>  target/arm/translate.c     |  2 +-
>  6 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 96316700dd..76ab7953a6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -492,7 +492,7 @@ typedef struct CPUARMState {
>           * the two execution states, and means we do not need to explici=
tly
>           * map these registers when changing states.
>           */
> -        float64 regs[64];
> +        uint64_t regs[64];
>
>          uint32_t xregs[16];
>          /* We store these fpcsr fields separately for convenience.  */
> diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
> index 9e5b2fb31c..0c43e0eef8 100644
> --- a/target/arm/arch_dump.c
> +++ b/target/arm/arch_dump.c
> @@ -100,7 +100,7 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpF=
unction f,
>      aarch64_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.vfp));
>
>      for (i =3D 0; i < 64; ++i) {
> -        note.vfp.vregs[i] =3D cpu_to_dump64(s, float64_val(env->vfp.regs=
[i]));
> +        note.vfp.vregs[i] =3D cpu_to_dump64(s, env->vfp.regs[i]);
>      }
>
>      if (s->dump_info.d_endian =3D=3D ELFDATA2MSB) {
> @@ -229,7 +229,7 @@ static int arm_write_elf32_vfp(WriteCoreDumpFunction =
f, CPUARMState *env,
>      arm_note_init(&note, s, "LINUX", 6, NT_ARM_VFP, sizeof(note.vfp));
>
>      for (i =3D 0; i < 32; ++i) {
> -        note.vfp.vregs[i] =3D cpu_to_dump64(s, float64_val(env->vfp.regs=
[i]));
> +        note.vfp.vregs[i] =3D cpu_to_dump64(s, env->vfp.regs[i]);
>      }
>
>      note.vfp.fpscr =3D cpu_to_dump32(s, vfp_get_fpscr(env));
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c83c901a86..8fda797582 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -64,15 +64,15 @@ static int vfp_gdb_get_reg(CPUARMState *env, uint8_t =
*buf, int reg)
>      /* VFP data registers are always little-endian.  */
>      nregs =3D arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        stfq_le_p(buf, env->vfp.regs[reg]);
> +        stq_le_p(buf, env->vfp.regs[reg]);
>          return 8;
>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          /* Aliases for Q regs.  */
>          nregs +=3D 16;
>          if (reg < nregs) {
> -            stfq_le_p(buf, env->vfp.regs[(reg - 32) * 2]);
> -            stfq_le_p(buf + 8, env->vfp.regs[(reg - 32) * 2 + 1]);
> +            stq_le_p(buf, env->vfp.regs[(reg - 32) * 2]);
> +            stq_le_p(buf + 8, env->vfp.regs[(reg - 32) * 2 + 1]);
>              return 16;
>          }
>      }
> @@ -90,14 +90,14 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t =
*buf, int reg)
>
>      nregs =3D arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        env->vfp.regs[reg] =3D ldfq_le_p(buf);
> +        env->vfp.regs[reg] =3D ldq_le_p(buf);
>          return 8;
>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          nregs +=3D 16;
>          if (reg < nregs) {
> -            env->vfp.regs[(reg - 32) * 2] =3D ldfq_le_p(buf);
> -            env->vfp.regs[(reg - 32) * 2 + 1] =3D ldfq_le_p(buf + 8);
> +            env->vfp.regs[(reg - 32) * 2] =3D ldq_le_p(buf);
> +            env->vfp.regs[(reg - 32) * 2 + 1] =3D ldq_le_p(buf + 8);
>              return 16;
>          }
>      }
> @@ -114,8 +114,8 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env, =
uint8_t *buf, int reg)
>      switch (reg) {
>      case 0 ... 31:
>          /* 128 bit FP register */
> -        stfq_le_p(buf, env->vfp.regs[reg * 2]);
> -        stfq_le_p(buf + 8, env->vfp.regs[reg * 2 + 1]);
> +        stq_le_p(buf, env->vfp.regs[reg * 2]);
> +        stq_le_p(buf + 8, env->vfp.regs[reg * 2 + 1]);
>          return 16;
>      case 32:
>          /* FPSR */
> @@ -135,8 +135,8 @@ static int aarch64_fpu_gdb_set_reg(CPUARMState *env, =
uint8_t *buf, int reg)
>      switch (reg) {
>      case 0 ... 31:
>          /* 128 bit FP register */
> -        env->vfp.regs[reg * 2] =3D ldfq_le_p(buf);
> -        env->vfp.regs[reg * 2 + 1] =3D ldfq_le_p(buf + 8);
> +        env->vfp.regs[reg * 2] =3D ldq_le_p(buf);
> +        env->vfp.regs[reg * 2 + 1] =3D ldq_le_p(buf + 8);
>          return 16;
>      case 32:
>          /* FPSR */
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 176274629c..a85c2430d3 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -50,7 +50,7 @@ static const VMStateDescription vmstate_vfp =3D {
>      .minimum_version_id =3D 3,
>      .needed =3D vfp_needed,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_FLOAT64_ARRAY(env.vfp.regs, ARMCPU, 64),
> +        VMSTATE_UINT64_ARRAY(env.vfp.regs, ARMCPU, 64),
>          /* The xregs array is a little awkward because element 1 (FPSCR)
>           * requires a specific accessor, so we have to split it up in
>           * the vmstate:
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 6d9b3af64c..c14fb4185c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -165,12 +165,12 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>      if (flags & CPU_DUMP_FPU) {
>          int numvfpregs =3D 32;
>          for (i =3D 0; i < numvfpregs; i +=3D 2) {
> -            uint64_t vlo =3D float64_val(env->vfp.regs[i * 2]);
> -            uint64_t vhi =3D float64_val(env->vfp.regs[(i * 2) + 1]);
> +            uint64_t vlo =3D env->vfp.regs[i * 2];
> +            uint64_t vhi =3D env->vfp.regs[(i * 2) + 1];
>              cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 " ",
>                          i, vhi, vlo);
> -            vlo =3D float64_val(env->vfp.regs[(i + 1) * 2]);
> -            vhi =3D float64_val(env->vfp.regs[((i + 1) * 2) + 1]);
> +            vlo =3D env->vfp.regs[(i + 1) * 2];
> +            vhi =3D env->vfp.regs[((i + 1) * 2) + 1];
>              cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 "\n",
>                          i + 1, vhi, vlo);
>          }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 852d2a75b1..cfe49bf579 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -12572,7 +12572,7 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fp=
rintf_function cpu_fprintf,
>              numvfpregs +=3D 16;
>          }
>          for (i =3D 0; i < numvfpregs; i++) {
> -            uint64_t v =3D float64_val(env->vfp.regs[i]);
> +            uint64_t v =3D env->vfp.regs[i];
>              cpu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRIx=
64 "\n",
>                          i * 2, (uint32_t)v,
>                          i * 2 + 1, (uint32_t)(v >> 32),


--
Alex Benn=C3=A9e
