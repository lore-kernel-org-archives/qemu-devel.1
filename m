Received: from eggs.gnu.org ([2001:4830:134:3::10]:59202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZrt-0002Ua-Fr
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZrp-0005tF-LY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:02:25 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edZrp-0005rW-BZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:02:21 -0500
Received: by mail-wr0-x244.google.com with SMTP id t16so8137342wrc.10
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 03:02:20 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-7-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-7-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 11:02:18 +0000
Message-ID: <87zi56jgw5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/16] target/arm: Add aa{32,
 64}_vfp_{dreg, qreg} helpers
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

> Helpers that return a pointer into env->vfp.regs so that we isolate
> the logic of how to index the regs array for different cpu modes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h           | 27 +++++++++++++++++++++++++++
>  linux-user/signal.c        | 22 ++++++++++++----------
>  target/arm/arch_dump.c     |  8 +++++---
>  target/arm/helper-a64.c    |  5 +++--
>  target/arm/helper.c        | 32 ++++++++++++++++++++------------
>  target/arm/kvm32.c         |  4 ++--
>  target/arm/kvm64.c         | 31 ++++++++++---------------------
>  target/arm/translate-a64.c | 25 ++++++++-----------------
>  target/arm/translate.c     | 16 +++++++++-------
>  9 files changed, 96 insertions(+), 74 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 76ab7953a6..7d396606f3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2885,4 +2885,31 @@ static inline void *arm_get_el_change_hook_opaque(=
ARMCPU *cpu)
>      return cpu->el_change_hook_opaque;
>  }
>
> +/**
> + * aa32_vfp_dreg:
> + * Return a pointer to the Dn register within env in 32-bit mode.
> + */
> +static inline uint64_t *aa32_vfp_dreg(CPUARMState *env, unsigned regno)
> +{
> +    return &env->vfp.regs[regno];
> +}
> +
> +/**
> + * aa32_vfp_qreg:
> + * Return a pointer to the Qn register within env in 32-bit mode.
> + */
> +static inline uint64_t *aa32_vfp_qreg(CPUARMState *env, unsigned regno)
> +{
> +    return &env->vfp.regs[2 * regno];
> +}
> +
> +/**
> + * aa64_vfp_qreg:
> + * Return a pointer to the Qn register within env in 64-bit mode.
> + */
> +static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
> +{
> +    return &env->vfp.regs[2 * regno];
> +}
> +
>  #endif
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index f85f0dd780..5321f9e795 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1487,12 +1487,13 @@ static int target_setup_sigframe(struct target_rt=
_sigframe *sf,
>      }
>
>      for (i =3D 0; i < 32; i++) {
> +        uint64_t *q =3D aa64_vfp_qreg(env, i);
>  #ifdef TARGET_WORDS_BIGENDIAN
> -        __put_user(env->vfp.regs[i * 2], &aux->fpsimd.vregs[i * 2 + 1]);
> -        __put_user(env->vfp.regs[i * 2 + 1], &aux->fpsimd.vregs[i * 2]);
> +        __put_user(q[0], &aux->fpsimd.vregs[i * 2 + 1]);
> +        __put_user(q[1], &aux->fpsimd.vregs[i * 2]);
>  #else
> -        __put_user(env->vfp.regs[i * 2], &aux->fpsimd.vregs[i * 2]);
> -        __put_user(env->vfp.regs[i * 2 + 1], &aux->fpsimd.vregs[i * 2 + =
1]);
> +        __put_user(q[0], &aux->fpsimd.vregs[i * 2]);
> +        __put_user(q[1], &aux->fpsimd.vregs[i * 2 + 1]);
>  #endif
>      }
>      __put_user(vfp_get_fpsr(env), &aux->fpsimd.fpsr);
> @@ -1539,12 +1540,13 @@ static int target_restore_sigframe(CPUARMState *e=
nv,
>      }
>
>      for (i =3D 0; i < 32; i++) {
> +        uint64_t *q =3D aa64_vfp_qreg(env, i);
>  #ifdef TARGET_WORDS_BIGENDIAN
> -        __get_user(env->vfp.regs[i * 2], &aux->fpsimd.vregs[i * 2 + 1]);
> -        __get_user(env->vfp.regs[i * 2 + 1], &aux->fpsimd.vregs[i * 2]);
> +        __get_user(q[0], &aux->fpsimd.vregs[i * 2 + 1]);
> +        __get_user(q[1], &aux->fpsimd.vregs[i * 2]);
>  #else
> -        __get_user(env->vfp.regs[i * 2], &aux->fpsimd.vregs[i * 2]);
> -        __get_user(env->vfp.regs[i * 2 + 1], &aux->fpsimd.vregs[i * 2 + =
1]);
> +        __get_user(q[0], &aux->fpsimd.vregs[i * 2]);
> +        __get_user(q[1], &aux->fpsimd.vregs[i * 2 + 1]);
>  #endif
>      }
>      __get_user(fpsr, &aux->fpsimd.fpsr);
> @@ -1903,7 +1905,7 @@ static abi_ulong *setup_sigframe_v2_vfp(abi_ulong *=
regspace, CPUARMState *env)
>      __put_user(TARGET_VFP_MAGIC, &vfpframe->magic);
>      __put_user(sizeof(*vfpframe), &vfpframe->size);
>      for (i =3D 0; i < 32; i++) {
> -        __put_user(float64_val(env->vfp.regs[i]), &vfpframe->ufp.fpregs[=
i]);
> +        __put_user(*aa32_vfp_dreg(env, i), &vfpframe->ufp.fpregs[i]);
>      }
>      __put_user(vfp_get_fpscr(env), &vfpframe->ufp.fpscr);
>      __put_user(env->vfp.xregs[ARM_VFP_FPEXC], &vfpframe->ufp_exc.fpexc);
> @@ -2210,7 +2212,7 @@ static abi_ulong *restore_sigframe_v2_vfp(CPUARMSta=
te *env, abi_ulong *regspace)
>          return 0;
>      }
>      for (i =3D 0; i < 32; i++) {
> -        __get_user(float64_val(env->vfp.regs[i]), &vfpframe->ufp.fpregs[=
i]);
> +        __get_user(*aa32_vfp_dreg(env, i), &vfpframe->ufp.fpregs[i]);
>      }
>      __get_user(fpscr, &vfpframe->ufp.fpscr);
>      vfp_set_fpscr(env, fpscr);
> diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
> index 0c43e0eef8..26a2c09868 100644
> --- a/target/arm/arch_dump.c
> +++ b/target/arm/arch_dump.c
> @@ -99,8 +99,10 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpFu=
nction f,
>
>      aarch64_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.vfp));
>
> -    for (i =3D 0; i < 64; ++i) {
> -        note.vfp.vregs[i] =3D cpu_to_dump64(s, env->vfp.regs[i]);
> +    for (i =3D 0; i < 32; ++i) {
> +        uint64_t *q =3D aa64_vfp_qreg(env, i);
> +        note.vfp.vregs[2*i + 0] =3D cpu_to_dump64(s, q[0]);
> +        note.vfp.vregs[2*i + 1] =3D cpu_to_dump64(s, q[1]);
>      }
>
>      if (s->dump_info.d_endian =3D=3D ELFDATA2MSB) {
> @@ -229,7 +231,7 @@ static int arm_write_elf32_vfp(WriteCoreDumpFunction =
f, CPUARMState *env,
>      arm_note_init(&note, s, "LINUX", 6, NT_ARM_VFP, sizeof(note.vfp));
>
>      for (i =3D 0; i < 32; ++i) {
> -        note.vfp.vregs[i] =3D cpu_to_dump64(s, env->vfp.regs[i]);
> +        note.vfp.vregs[i] =3D cpu_to_dump64(s, *aa32_vfp_dreg(env, i));
>      }
>
>      note.vfp.fpscr =3D cpu_to_dump32(s, vfp_get_fpscr(env));
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 3e00a9ead1..06fd321fae 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -153,13 +153,14 @@ uint64_t HELPER(simd_tbl)(CPUARMState *env, uint64_=
t result, uint64_t indices,
>          if (index < 16 * numregs) {
>              /* Convert index (a byte offset into the virtual table
>               * which is a series of 128-bit vectors concatenated)
> -             * into the correct vfp.regs[] element plus a bit offset
> +             * into the correct register element plus a bit offset
>               * into that element, bearing in mind that the table
>               * can wrap around from V31 to V0.
>               */
>              int elt =3D (rn * 2 + (index >> 3)) % 64;
>              int bitidx =3D (index & 7) * 8;
> -            uint64_t val =3D extract64(env->vfp.regs[elt], bitidx, 8);
> +            uint64_t *q =3D aa64_vfp_qreg(env, elt >> 1);
> +            uint64_t val =3D extract64(q[elt & 1], bitidx, 8);
>
>              result =3D deposit64(result, shift, 8, val);
>          }
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8fda797582..6705903301 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -64,15 +64,16 @@ static int vfp_gdb_get_reg(CPUARMState *env, uint8_t =
*buf, int reg)
>      /* VFP data registers are always little-endian.  */
>      nregs =3D arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        stq_le_p(buf, env->vfp.regs[reg]);
> +        stq_le_p(buf, *aa32_vfp_dreg(env, reg));
>          return 8;
>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          /* Aliases for Q regs.  */
>          nregs +=3D 16;
>          if (reg < nregs) {
> -            stq_le_p(buf, env->vfp.regs[(reg - 32) * 2]);
> -            stq_le_p(buf + 8, env->vfp.regs[(reg - 32) * 2 + 1]);
> +            uint64_t *q =3D aa32_vfp_qreg(env, reg - 32);
> +            stq_le_p(buf, q[0]);
> +            stq_le_p(buf + 8, q[1]);
>              return 16;
>          }
>      }
> @@ -90,14 +91,15 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t =
*buf, int reg)
>
>      nregs =3D arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        env->vfp.regs[reg] =3D ldq_le_p(buf);
> +        *aa32_vfp_dreg(env, reg) =3D ldq_le_p(buf);
>          return 8;
>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          nregs +=3D 16;
>          if (reg < nregs) {
> -            env->vfp.regs[(reg - 32) * 2] =3D ldq_le_p(buf);
> -            env->vfp.regs[(reg - 32) * 2 + 1] =3D ldq_le_p(buf + 8);
> +            uint64_t *q =3D aa32_vfp_qreg(env, reg - 32);
> +            q[0] =3D ldq_le_p(buf);
> +            q[1] =3D ldq_le_p(buf + 8);
>              return 16;
>          }
>      }
> @@ -114,9 +116,12 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env,=
 uint8_t *buf, int reg)
>      switch (reg) {
>      case 0 ... 31:
>          /* 128 bit FP register */
> -        stq_le_p(buf, env->vfp.regs[reg * 2]);
> -        stq_le_p(buf + 8, env->vfp.regs[reg * 2 + 1]);
> -        return 16;
> +        {
> +            uint64_t *q =3D aa64_vfp_qreg(env, reg);
> +            stq_le_p(buf, q[0]);
> +            stq_le_p(buf + 8, q[1]);
> +            return 16;
> +        }
>      case 32:
>          /* FPSR */
>          stl_p(buf, vfp_get_fpsr(env));
> @@ -135,9 +140,12 @@ static int aarch64_fpu_gdb_set_reg(CPUARMState *env,=
 uint8_t *buf, int reg)
>      switch (reg) {
>      case 0 ... 31:
>          /* 128 bit FP register */
> -        env->vfp.regs[reg * 2] =3D ldq_le_p(buf);
> -        env->vfp.regs[reg * 2 + 1] =3D ldq_le_p(buf + 8);
> -        return 16;
> +        {
> +            uint64_t *q =3D aa64_vfp_qreg(env, reg);
> +            q[0] =3D ldq_le_p(buf);
> +            q[1] =3D ldq_le_p(buf + 8);
> +            return 16;
> +        }
>      case 32:
>          /* FPSR */
>          vfp_set_fpsr(env, ldl_p(buf));
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index f925a21481..f77c9c494b 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -358,7 +358,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>      /* VFP registers */
>      r.id =3D KVM_REG_ARM | KVM_REG_SIZE_U64 | KVM_REG_ARM_VFP;
>      for (i =3D 0; i < 32; i++) {
> -        r.addr =3D (uintptr_t)(&env->vfp.regs[i]);
> +        r.addr =3D (uintptr_t)aa32_vfp_dreg(env, i);
>          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
>          if (ret) {
>              return ret;
> @@ -445,7 +445,7 @@ int kvm_arch_get_registers(CPUState *cs)
>      /* VFP registers */
>      r.id =3D KVM_REG_ARM | KVM_REG_SIZE_U64 | KVM_REG_ARM_VFP;
>      for (i =3D 0; i < 32; i++) {
> -        r.addr =3D (uintptr_t)(&env->vfp.regs[i]);
> +        r.addr =3D (uintptr_t)aa32_vfp_dreg(env, i);
>          ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
>          if (ret) {
>              return ret;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 6554c30007..ac728494a4 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -696,21 +696,16 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          }
>      }
>
> -    /* Advanced SIMD and FP registers
> -     * We map Qn =3D regs[2n+1]:regs[2n]
> -     */
> +    /* Advanced SIMD and FP registers. */
>      for (i =3D 0; i < 32; i++) {
> -        int rd =3D i << 1;
> -        uint64_t fp_val[2];
> +        uint64_t *q =3D aa64_vfp_qreg(env, i);
>  #ifdef HOST_WORDS_BIGENDIAN
> -        fp_val[0] =3D env->vfp.regs[rd + 1];
> -        fp_val[1] =3D env->vfp.regs[rd];
> +        uint64_t fp_val[2] =3D { q[1], q[0] };
> +        reg.addr =3D (uintptr_t)fp_val;
>  #else
> -        fp_val[1] =3D env->vfp.regs[rd + 1];
> -        fp_val[0] =3D env->vfp.regs[rd];
> +        reg.addr =3D (uintptr_t)q;
>  #endif
>          reg.id =3D AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> -        reg.addr =3D (uintptr_t)(&fp_val);
>          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret) {
>              return ret;
> @@ -837,24 +832,18 @@ int kvm_arch_get_registers(CPUState *cs)
>          env->spsr =3D env->banked_spsr[i];
>      }
>
> -    /* Advanced SIMD and FP registers
> -     * We map Qn =3D regs[2n+1]:regs[2n]
> -     */
> +    /* Advanced SIMD and FP registers */
>      for (i =3D 0; i < 32; i++) {
> -        uint64_t fp_val[2];
> +        uint64_t *q =3D aa64_vfp_qreg(env, i);
>          reg.id =3D AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> -        reg.addr =3D (uintptr_t)(&fp_val);
> +        reg.addr =3D (uintptr_t)q;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>          if (ret) {
>              return ret;
>          } else {
> -            int rd =3D i << 1;
>  #ifdef HOST_WORDS_BIGENDIAN
> -            env->vfp.regs[rd + 1] =3D fp_val[0];
> -            env->vfp.regs[rd] =3D fp_val[1];
> -#else
> -            env->vfp.regs[rd + 1] =3D fp_val[1];
> -            env->vfp.regs[rd] =3D fp_val[0];
> +            uint64_t t;
> +            t =3D q[0], q[0] =3D q[1], q[1] =3D t;
>  #endif
>          }
>      }
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index c14fb4185c..eed64c73e5 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -164,15 +164,12 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>
>      if (flags & CPU_DUMP_FPU) {
>          int numvfpregs =3D 32;
> -        for (i =3D 0; i < numvfpregs; i +=3D 2) {
> -            uint64_t vlo =3D env->vfp.regs[i * 2];
> -            uint64_t vhi =3D env->vfp.regs[(i * 2) + 1];
> -            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 " ",
> -                        i, vhi, vlo);
> -            vlo =3D env->vfp.regs[(i + 1) * 2];
> -            vhi =3D env->vfp.regs[((i + 1) * 2) + 1];
> -            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 "\n",
> -                        i + 1, vhi, vlo);
> +        for (i =3D 0; i < numvfpregs; i++) {
> +            uint64_t *q =3D aa64_vfp_qreg(env, i);
> +            uint64_t vlo =3D q[0];
> +            uint64_t vhi =3D q[1];
> +            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 "%c",
> +                        i, vhi, vlo, (i & 1 ? '\n' : ' '));
>          }
>          cpu_fprintf(f, "FPCR: %08x  FPSR: %08x\n",
>                      vfp_get_fpcr(env), vfp_get_fpsr(env));
> @@ -558,19 +555,13 @@ static TCGv_ptr vec_full_reg_ptr(DisasContext *s, i=
nt regno)
>   */
>  static inline int fp_reg_offset(DisasContext *s, int regno, TCGMemOp siz=
e)
>  {
> -    int offs =3D offsetof(CPUARMState, vfp.regs[regno * 2]);
> -#ifdef HOST_WORDS_BIGENDIAN
> -    offs +=3D (8 - (1 << size));
> -#endif
> -    assert_fp_access_checked(s);
> -    return offs;
> +    return vec_reg_offset(s, regno, 0, size);
>  }
>
>  /* Offset of the high half of the 128 bit vector Qn */
>  static inline int fp_reg_hi_offset(DisasContext *s, int regno)
>  {
> -    assert_fp_access_checked(s);
> -    return offsetof(CPUARMState, vfp.regs[regno * 2 + 1]);
> +    return vec_reg_offset(s, regno, 1, MO_64);
>  }
>
>  /* Convenience accessors for reading and writing single and double
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index cfe49bf579..55826b7e5a 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1515,14 +1515,16 @@ static inline void gen_vfp_st(DisasContext *s, in=
t dp, TCGv_i32 addr)
>  static inline long
>  vfp_reg_offset (int dp, int reg)
>  {
> -    if (dp)
> +    if (dp) {
>          return offsetof(CPUARMState, vfp.regs[reg]);
> -    else if (reg & 1) {
> -        return offsetof(CPUARMState, vfp.regs[reg >> 1])
> -          + offsetof(CPU_DoubleU, l.upper);
>      } else {
> -        return offsetof(CPUARMState, vfp.regs[reg >> 1])
> -          + offsetof(CPU_DoubleU, l.lower);
> +        long ofs =3D offsetof(CPUARMState, vfp.regs[reg >> 1]);
> +        if (reg & 1) {
> +            ofs +=3D offsetof(CPU_DoubleU, l.upper);
> +        } else {
> +            ofs +=3D offsetof(CPU_DoubleU, l.lower);
> +        }
> +        return ofs;
>      }
>  }
>
> @@ -12572,7 +12574,7 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fp=
rintf_function cpu_fprintf,
>              numvfpregs +=3D 16;
>          }
>          for (i =3D 0; i < numvfpregs; i++) {
> -            uint64_t v =3D env->vfp.regs[i];
> +            uint64_t v =3D *aa32_vfp_dreg(env, i);
>              cpu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRIx=
64 "\n",
>                          i * 2, (uint32_t)v,
>                          i * 2 + 1, (uint32_t)(v >> 32),


--
Alex Benn=C3=A9e
