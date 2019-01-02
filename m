Received: from eggs.gnu.org ([208.118.235.92]:60020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geaJO-0003Mw-Jg
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 01:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geaJL-0000m8-9b
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 01:47:30 -0500
Date: Wed, 2 Jan 2019 17:35:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102063516.GS27457@umbus.fritz.box>
References: <20181223111525.581-1-mark.cave-ayland@ilande.co.uk>
	<20181223111525.581-9-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="daC8KDjlMyCcZyAo"
Content-Disposition: inline
In-Reply-To: <20181223111525.581-9-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v4 8/9] target/ppc: move FP and VMX
 registers into aligned vsr register array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--daC8KDjlMyCcZyAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2018 at 11:15:24AM +0000, Mark Cave-Ayland wrote:
> The VSX register array is a block of 64 128-bit registers where the first=
 32
> registers consist of the existing 64-bit FP registers extended to 128-bit
> using new VSR registers, and the last 32 registers are the VMX 128-bit
> registers as show below:
>=20
>             64-bit               64-bit
>     +--------------------+--------------------+
>     |        FP0         |                    |  VSR0
>     +--------------------+--------------------+
>     |        FP1         |                    |  VSR1
>     +--------------------+--------------------+
>     |        ...         |        ...         |  ...
>     +--------------------+--------------------+
>     |        FP30        |                    |  VSR30
>     +--------------------+--------------------+
>     |        FP31        |                    |  VSR31
>     +--------------------+--------------------+
>     |                  VMX0                   |  VSR32
>     +-----------------------------------------+
>     |                  VMX1                   |  VSR33
>     +-----------------------------------------+
>     |                  ...                    |  ...
>     +-----------------------------------------+
>     |                  VMX30                  |  VSR62
>     +-----------------------------------------+
>     |                  VMX31                  |  VSR63
>     +-----------------------------------------+
>=20
> In order to allow for future conversion of VSX instructions to use TCG ve=
ctor
> operations, recreate the same layout using an aligned version of the exis=
ting
> vsr register array.
>=20
> Since the old fpr and avr register arrays are removed, the existing calle=
rs
> must also be updated to use the correct offset in the vsr register array.=
 This
> also includes switching the relevant VMState fields over to using subarra=
ys
> to make sure that migration is preserved.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Sorry, I had to pull this out of ppc-for-4.0 again (and I pulled all
the later patches in the series out for safety as well).  It breaks
build on a ppc host - looks like you haven't updated the code to push
pull the VSX state to KVM.

> ---
>  linux-user/ppc/signal.c             | 28 ++++++++-------
>  target/ppc/arch_dump.c              | 15 ++++----
>  target/ppc/cpu.h                    | 25 +++++++++----
>  target/ppc/gdbstub.c                |  8 ++---
>  target/ppc/internal.h               | 18 +++-------
>  target/ppc/machine.c                | 72 +++++++++++++++++++++++++++++++=
+++---
>  target/ppc/monitor.c                |  4 +--
>  target/ppc/translate.c              | 14 ++++----
>  target/ppc/translate/dfp-impl.inc.c |  2 +-
>  target/ppc/translate/vmx-impl.inc.c |  7 +++-
>  target/ppc/translate/vsx-impl.inc.c |  4 +--
>  target/ppc/translate_init.inc.c     | 26 +++++++-------
>  12 files changed, 151 insertions(+), 72 deletions(-)
>=20
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index 2ae120a2bc..619a56950d 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -258,8 +258,8 @@ static void save_user_regs(CPUPPCState *env, struct t=
arget_mcontext *frame)
>      /* Save Altivec registers if necessary.  */
>      if (env->insns_flags & PPC_ALTIVEC) {
>          uint32_t *vrsave;
> -        for (i =3D 0; i < ARRAY_SIZE(env->avr); i++) {
> -            ppc_avr_t *avr =3D &env->avr[i];
> +        for (i =3D 0; i < 32; i++) {
> +            ppc_avr_t *avr =3D cpu_avr_ptr(env, i);
>              ppc_avr_t *vreg =3D (ppc_avr_t *)&frame->mc_vregs.altivec[i];
> =20
>              __put_user(avr->u64[PPC_VEC_HI], &vreg->u64[0]);
> @@ -281,15 +281,17 @@ static void save_user_regs(CPUPPCState *env, struct=
 target_mcontext *frame)
>      /* Save VSX second halves */
>      if (env->insns_flags2 & PPC2_VSX) {
>          uint64_t *vsregs =3D (uint64_t *)&frame->mc_vregs.altivec[34];
> -        for (i =3D 0; i < ARRAY_SIZE(env->vsr); i++) {
> -            __put_user(env->vsr[i], &vsregs[i]);
> +        for (i =3D 0; i < 32; i++) {
> +            uint64_t *vsrl =3D cpu_vsrl_ptr(env, i);
> +            __put_user(*vsrl, &vsregs[i]);
>          }
>      }
> =20
>      /* Save floating point registers.  */
>      if (env->insns_flags & PPC_FLOAT) {
> -        for (i =3D 0; i < ARRAY_SIZE(env->fpr); i++) {
> -            __put_user(env->fpr[i], &frame->mc_fregs[i]);
> +        for (i =3D 0; i < 32; i++) {
> +            uint64_t *fpr =3D cpu_fpr_ptr(env, i);
> +            __put_user(*fpr, &frame->mc_fregs[i]);
>          }
>          __put_user((uint64_t) env->fpscr, &frame->mc_fregs[32]);
>      }
> @@ -373,8 +375,8 @@ static void restore_user_regs(CPUPPCState *env,
>  #else
>          v_regs =3D (ppc_avr_t *)frame->mc_vregs.altivec;
>  #endif
> -        for (i =3D 0; i < ARRAY_SIZE(env->avr); i++) {
> -            ppc_avr_t *avr =3D &env->avr[i];
> +        for (i =3D 0; i < 32; i++) {
> +            ppc_avr_t *avr =3D cpu_avr_ptr(env, i);
>              ppc_avr_t *vreg =3D &v_regs[i];
> =20
>              __get_user(avr->u64[PPC_VEC_HI], &vreg->u64[0]);
> @@ -393,16 +395,18 @@ static void restore_user_regs(CPUPPCState *env,
>      /* Restore VSX second halves */
>      if (env->insns_flags2 & PPC2_VSX) {
>          uint64_t *vsregs =3D (uint64_t *)&frame->mc_vregs.altivec[34];
> -        for (i =3D 0; i < ARRAY_SIZE(env->vsr); i++) {
> -            __get_user(env->vsr[i], &vsregs[i]);
> +        for (i =3D 0; i < 32; i++) {
> +            uint64_t *vsrl =3D cpu_vsrl_ptr(env, i);
> +            __get_user(*vsrl, &vsregs[i]);
>          }
>      }
> =20
>      /* Restore floating point registers.  */
>      if (env->insns_flags & PPC_FLOAT) {
>          uint64_t fpscr;
> -        for (i =3D 0; i < ARRAY_SIZE(env->fpr); i++) {
> -            __get_user(env->fpr[i], &frame->mc_fregs[i]);
> +        for (i =3D 0; i < 32; i++) {
> +            uint64_t *fpr =3D cpu_fpr_ptr(env, i);
> +            __get_user(*fpr, &frame->mc_fregs[i]);
>          }
>          __get_user(fpscr, &frame->mc_fregs[32]);
>          env->fpscr =3D (uint32_t) fpscr;
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index cc1460e4e3..525544de7d 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -140,7 +140,8 @@ static void ppc_write_elf_fpregset(NoteFuncArg *arg, =
PowerPCCPU *cpu)
>      memset(fpregset, 0, sizeof(*fpregset));
> =20
>      for (i =3D 0; i < 32; i++) {
> -        fpregset->fpr[i] =3D cpu_to_dump64(s, cpu->env.fpr[i]);
> +        uint64_t *fpr =3D cpu_fpr_ptr(&cpu->env, i);
> +        fpregset->fpr[i] =3D cpu_to_dump64(s, *fpr);
>      }
>      fpregset->fpscr =3D cpu_to_dump_reg(s, cpu->env.fpscr);
>  }
> @@ -158,6 +159,7 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *arg,=
 PowerPCCPU *cpu)
> =20
>      for (i =3D 0; i < 32; i++) {
>          bool needs_byteswap;
> +        ppc_avr_t *avr =3D cpu_avr_ptr(&cpu->env, i);
> =20
>  #ifdef HOST_WORDS_BIGENDIAN
>          needs_byteswap =3D s->dump_info.d_endian =3D=3D ELFDATA2LSB;
> @@ -166,11 +168,11 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *ar=
g, PowerPCCPU *cpu)
>  #endif
> =20
>          if (needs_byteswap) {
> -            vmxregset->avr[i].u64[0] =3D bswap64(cpu->env.avr[i].u64[1]);
> -            vmxregset->avr[i].u64[1] =3D bswap64(cpu->env.avr[i].u64[0]);
> +            vmxregset->avr[i].u64[0] =3D bswap64(avr->u64[1]);
> +            vmxregset->avr[i].u64[1] =3D bswap64(avr->u64[0]);
>          } else {
> -            vmxregset->avr[i].u64[0] =3D cpu->env.avr[i].u64[0];
> -            vmxregset->avr[i].u64[1] =3D cpu->env.avr[i].u64[1];
> +            vmxregset->avr[i].u64[0] =3D avr->u64[0];
> +            vmxregset->avr[i].u64[1] =3D avr->u64[1];
>          }
>      }
>      vmxregset->vscr.u32[3] =3D cpu_to_dump32(s, cpu->env.vscr);
> @@ -188,7 +190,8 @@ static void ppc_write_elf_vsxregset(NoteFuncArg *arg,=
 PowerPCCPU *cpu)
>      memset(vsxregset, 0, sizeof(*vsxregset));
> =20
>      for (i =3D 0; i < 32; i++) {
> -        vsxregset->vsr[i] =3D cpu_to_dump64(s, cpu->env.vsr[i]);
> +        uint64_t *vsr =3D cpu_vsrl_ptr(&cpu->env, i);
> +        vsxregset->vsr[i] =3D cpu_to_dump64(s, *vsr);
>      }
>  }
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 578641ac20..91951d7730 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1004,8 +1004,6 @@ struct CPUPPCState {
> =20
>      /* Floating point execution context */
>      float_status fp_status;
> -    /* floating point registers */
> -    float64 fpr[32];
>      /* floating point status and control register */
>      target_ulong fpscr;
> =20
> @@ -1055,11 +1053,10 @@ struct CPUPPCState {
>      /* Special purpose registers */
>      target_ulong spr[1024];
>      ppc_spr_t spr_cb[1024];
> -    /* Altivec registers */
> -    ppc_avr_t avr[32];
> +    /* Vector status and control register */
>      uint32_t vscr;
> -    /* VSX registers */
> -    uint64_t vsr[32];
> +    /* VSX registers (including FP and AVR) */
> +    ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
>      /* SPE registers */
>      uint64_t spe_acc;
>      uint32_t spe_fscr;
> @@ -2540,6 +2537,22 @@ static inline bool lsw_reg_in_range(int start, int=
 nregs, int rx)
>             (start + nregs > 32 && (rx >=3D start || rx < start + nregs -=
 32));
>  }
> =20
> +/* Accessors for FP, VMX and VSX registers */
> +static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
> +{
> +    return &env->vsr[i].u64[0];
> +}
> +
> +static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
> +{
> +    return &env->vsr[i].u64[1];
> +}
> +
> +static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
> +{
> +    return &env->vsr[32 + i];
> +}
> +
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
> =20
>  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n);
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index b6f6693583..19565b584d 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -126,7 +126,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *=
mem_buf, int n)
>          gdb_get_regl(mem_buf, env->gpr[n]);
>      } else if (n < 64) {
>          /* fprs */
> -        stfq_p(mem_buf, env->fpr[n-32]);
> +        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
>      } else {
>          switch (n) {
>          case 64:
> @@ -178,7 +178,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, uin=
t8_t *mem_buf, int n)
>          gdb_get_reg64(mem_buf, env->gpr[n]);
>      } else if (n < 64) {
>          /* fprs */
> -        stfq_p(mem_buf, env->fpr[n-32]);
> +        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
>      } else if (n < 96) {
>          /* Altivec */
>          stq_p(mem_buf, n - 64);
> @@ -234,7 +234,7 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t =
*mem_buf, int n)
>          env->gpr[n] =3D ldtul_p(mem_buf);
>      } else if (n < 64) {
>          /* fprs */
> -        env->fpr[n-32] =3D ldfq_p(mem_buf);
> +        *cpu_fpr_ptr(env, n - 32) =3D ldfq_p(mem_buf);
>      } else {
>          switch (n) {
>          case 64:
> @@ -284,7 +284,7 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, ui=
nt8_t *mem_buf, int n)
>          env->gpr[n] =3D ldq_p(mem_buf);
>      } else if (n < 64) {
>          /* fprs */
> -        env->fpr[n-32] =3D ldfq_p(mem_buf);
> +        *cpu_fpr_ptr(env, n - 32) =3D ldfq_p(mem_buf);
>      } else {
>          switch (n) {
>          case 64 + 32:
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index bd247f2504..c7c0f77dd6 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -218,24 +218,14 @@ EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, =
1, 6, 6);
> =20
>  static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
>  {
> -    if (n < 32) {
> -        vsr->VsrD(0) =3D env->fpr[n];
> -        vsr->VsrD(1) =3D env->vsr[n];
> -    } else {
> -        vsr->u64[0] =3D env->avr[n - 32].u64[0];
> -        vsr->u64[1] =3D env->avr[n - 32].u64[1];
> -    }
> +    vsr->VsrD(0) =3D env->vsr[n].u64[0];
> +    vsr->VsrD(1) =3D env->vsr[n].u64[1];
>  }
> =20
>  static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
>  {
> -    if (n < 32) {
> -        env->fpr[n] =3D vsr->VsrD(0);
> -        env->vsr[n] =3D vsr->VsrD(1);
> -    } else {
> -        env->avr[n - 32].u64[0] =3D vsr->u64[0];
> -        env->avr[n - 32].u64[1] =3D vsr->u64[1];
> -    }
> +    env->vsr[n].u64[0] =3D vsr->VsrD(0);
> +    env->vsr[n].u64[1] =3D vsr->VsrD(1);
>  }
> =20
>  void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index e7b3725273..eff30053b0 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -45,7 +45,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int =
version_id)
>              uint64_t l;
>          } u;
>          u.l =3D qemu_get_be64(f);
> -        env->fpr[i] =3D u.d;
> +        *cpu_fpr_ptr(env, i) =3D u.d;
>      }
>      qemu_get_be32s(f, &fpscr);
>      env->fpscr =3D fpscr;
> @@ -138,11 +138,73 @@ static const VMStateInfo vmstate_info_avr =3D {
>  };
> =20
>  #define VMSTATE_AVR_ARRAY_V(_f, _s, _n, _v)                       \
> -    VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_avr, ppc_avr_t)
> +    VMSTATE_SUB_ARRAY(_f, _s, 32, _n, _v, vmstate_info_avr, ppc_avr_t)
> =20
>  #define VMSTATE_AVR_ARRAY(_f, _s, _n)                             \
>      VMSTATE_AVR_ARRAY_V(_f, _s, _n, 0)
> =20
> +static int get_fpr(QEMUFile *f, void *pv, size_t size,
> +                   const VMStateField *field)
> +{
> +    ppc_vsr_t *v =3D pv;
> +
> +    v->u64[0] =3D qemu_get_be64(f);
> +
> +    return 0;
> +}
> +
> +static int put_fpr(QEMUFile *f, void *pv, size_t size,
> +                   const VMStateField *field, QJSON *vmdesc)
> +{
> +    ppc_vsr_t *v =3D pv;
> +
> +    qemu_put_be64(f, v->u64[0]);
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_info_fpr =3D {
> +    .name =3D "fpr",
> +    .get  =3D get_fpr,
> +    .put  =3D put_fpr,
> +};
> +
> +#define VMSTATE_FPR_ARRAY_V(_f, _s, _n, _v)                       \
> +    VMSTATE_SUB_ARRAY(_f, _s, 0, _n, _v, vmstate_info_fpr, ppc_vsr_t)
> +
> +#define VMSTATE_FPR_ARRAY(_f, _s, _n)                             \
> +    VMSTATE_FPR_ARRAY_V(_f, _s, _n, 0)
> +
> +static int get_vsr(QEMUFile *f, void *pv, size_t size,
> +                   const VMStateField *field)
> +{
> +    ppc_vsr_t *v =3D pv;
> +
> +    v->u64[1] =3D qemu_get_be64(f);
> +
> +    return 0;
> +}
> +
> +static int put_vsr(QEMUFile *f, void *pv, size_t size,
> +                   const VMStateField *field, QJSON *vmdesc)
> +{
> +    ppc_vsr_t *v =3D pv;
> +
> +    qemu_put_be64(f, v->u64[1]);
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_info_vsr =3D {
> +    .name =3D "vsr",
> +    .get  =3D get_vsr,
> +    .put  =3D put_vsr,
> +};
> +
> +#define VMSTATE_VSR_ARRAY_V(_f, _s, _n, _v)                       \
> +    VMSTATE_SUB_ARRAY(_f, _s, 0, _n, _v, vmstate_info_vsr, ppc_vsr_t)
> +
> +#define VMSTATE_VSR_ARRAY(_f, _s, _n)                             \
> +    VMSTATE_VSR_ARRAY_V(_f, _s, _n, 0)
> +
>  static bool cpu_pre_2_8_migration(void *opaque, int version_id)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -354,7 +416,7 @@ static const VMStateDescription vmstate_fpu =3D {
>      .minimum_version_id =3D 1,
>      .needed =3D fpu_needed,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_FLOAT64_ARRAY(env.fpr, PowerPCCPU, 32),
> +        VMSTATE_FPR_ARRAY(env.vsr, PowerPCCPU, 32),
>          VMSTATE_UINTTL(env.fpscr, PowerPCCPU),
>          VMSTATE_END_OF_LIST()
>      },
> @@ -373,7 +435,7 @@ static const VMStateDescription vmstate_altivec =3D {
>      .minimum_version_id =3D 1,
>      .needed =3D altivec_needed,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_AVR_ARRAY(env.avr, PowerPCCPU, 32),
> +        VMSTATE_AVR_ARRAY(env.vsr, PowerPCCPU, 32),
>          VMSTATE_UINT32(env.vscr, PowerPCCPU),
>          VMSTATE_END_OF_LIST()
>      },
> @@ -392,7 +454,7 @@ static const VMStateDescription vmstate_vsx =3D {
>      .minimum_version_id =3D 1,
>      .needed =3D vsx_needed,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT64_ARRAY(env.vsr, PowerPCCPU, 32),
> +        VMSTATE_VSR_ARRAY(env.vsr, PowerPCCPU, 32),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 14915119fc..04deec8030 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -123,8 +123,8 @@ int target_get_monitor_def(CPUState *cs, const char *=
name, uint64_t *pval)
> =20
>      /* Floating point registers */
>      if ((qemu_tolower(name[0]) =3D=3D 'f') &&
> -        ppc_cpu_get_reg_num(name + 1, ARRAY_SIZE(env->fpr), &regnum)) {
> -        *pval =3D env->fpr[regnum];
> +        ppc_cpu_get_reg_num(name + 1, 32, &regnum)) {
> +        *pval =3D *cpu_fpr_ptr(env, regnum);
>          return 0;
>      }
> =20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b18ded07b3..e169c43643 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6662,22 +6662,22 @@ GEN_TM_PRIV_NOOP(trechkpt);
> =20
>  static inline void get_fpr(TCGv_i64 dst, int regno)
>  {
> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, fpr[regno]));
> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]=
));
>  }
> =20
>  static inline void set_fpr(int regno, TCGv_i64 src)
>  {
> -    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, fpr[regno]));
> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]=
));
>  }
> =20
>  static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
>  {
>  #ifdef HOST_WORDS_BIGENDIAN
>      tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
> -                                          avr[regno].u64[(high ? 0 : 1)]=
));
> +                                          vsr[32 + regno].u64[(high ? 0 =
: 1)]));
>  #else
>      tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
> -                                          avr[regno].u64[(high ? 1 : 0)]=
));
> +                                          vsr[32 + regno].u64[(high ? 1 =
: 0)]));
>  #endif
>  }
> =20
> @@ -6685,10 +6685,10 @@ static inline void set_avr64(int regno, TCGv_i64 =
src, bool high)
>  {
>  #ifdef HOST_WORDS_BIGENDIAN
>      tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
> -                                          avr[regno].u64[(high ? 0 : 1)]=
));
> +                                          vsr[32 + regno].u64[(high ? 0 =
: 1)]));
>  #else
>      tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
> -                                          avr[regno].u64[(high ? 1 : 0)]=
));
> +                                          vsr[32 + regno].u64[(high ? 1 =
: 0)]));
>  #endif
>  }
> =20
> @@ -7440,7 +7440,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
>              if ((i & (RFPL - 1)) =3D=3D 0) {
>                  cpu_fprintf(f, "FPR%02d", i);
>              }
> -            cpu_fprintf(f, " %016" PRIx64, *((uint64_t *)&env->fpr[i]));
> +            cpu_fprintf(f, " %016" PRIx64, *cpu_fpr_ptr(env, i));
>              if ((i & (RFPL - 1)) =3D=3D (RFPL - 1)) {
>                  cpu_fprintf(f, "\n");
>              }
> diff --git a/target/ppc/translate/dfp-impl.inc.c b/target/ppc/translate/d=
fp-impl.inc.c
> index 634ef73b8a..6c556dc2e1 100644
> --- a/target/ppc/translate/dfp-impl.inc.c
> +++ b/target/ppc/translate/dfp-impl.inc.c
> @@ -3,7 +3,7 @@
>  static inline TCGv_ptr gen_fprp_ptr(int reg)
>  {
>      TCGv_ptr r =3D tcg_temp_new_ptr();
> -    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, fpr[reg]));
> +    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, vsr[reg].u64[0]));
>      return r;
>  }
> =20
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 5e8327e9a3..f99d0284c2 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -10,10 +10,15 @@
>  static inline TCGv_ptr gen_avr_ptr(int reg)
>  {
>      TCGv_ptr r =3D tcg_temp_new_ptr();
> -    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, avr[reg]));
> +    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, vsr[32 + reg].u64=
[0]));
>      return r;
>  }
> =20
> +static inline long avr64_offset(int reg, bool high)
> +{
> +    return offsetof(CPUPPCState, vsr[32 + reg].u64[(high ? 0 : 1)]);
> +}
> +
>  #define GEN_VR_LDX(name, opc2, opc3)                                    =
      \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
              \
>  {                                                                       =
      \
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 7eaa36b4d5..ed4fdceacf 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -2,12 +2,12 @@
> =20
>  static inline void get_vsr(TCGv_i64 dst, int n)
>  {
> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n]));
> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
>  }
> =20
>  static inline void set_vsr(int n, TCGv_i64 src)
>  {
> -    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n]));
> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
>  }
> =20
>  static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 03f1d34a97..ade06cc773 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9486,7 +9486,7 @@ static bool avr_need_swap(CPUPPCState *env)
>  static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> -        stfq_p(mem_buf, env->fpr[n]);
> +        stfq_p(mem_buf, *cpu_fpr_ptr(env, n));
>          ppc_maybe_bswap_register(env, mem_buf, 8);
>          return 8;
>      }
> @@ -9502,7 +9502,7 @@ static int gdb_set_float_reg(CPUPPCState *env, uint=
8_t *mem_buf, int n)
>  {
>      if (n < 32) {
>          ppc_maybe_bswap_register(env, mem_buf, 8);
> -        env->fpr[n] =3D ldfq_p(mem_buf);
> +        *cpu_fpr_ptr(env, n) =3D ldfq_p(mem_buf);
>          return 8;
>      }
>      if (n =3D=3D 32) {
> @@ -9516,12 +9516,13 @@ static int gdb_set_float_reg(CPUPPCState *env, ui=
nt8_t *mem_buf, int n)
>  static int gdb_get_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> +        ppc_avr_t *avr =3D cpu_avr_ptr(env, n);
>          if (!avr_need_swap(env)) {
> -            stq_p(mem_buf, env->avr[n].u64[0]);
> -            stq_p(mem_buf+8, env->avr[n].u64[1]);
> +            stq_p(mem_buf, avr->u64[0]);
> +            stq_p(mem_buf + 8, avr->u64[1]);
>          } else {
> -            stq_p(mem_buf, env->avr[n].u64[1]);
> -            stq_p(mem_buf+8, env->avr[n].u64[0]);
> +            stq_p(mem_buf, avr->u64[1]);
> +            stq_p(mem_buf + 8, avr->u64[0]);
>          }
>          ppc_maybe_bswap_register(env, mem_buf, 8);
>          ppc_maybe_bswap_register(env, mem_buf + 8, 8);
> @@ -9543,14 +9544,15 @@ static int gdb_get_avr_reg(CPUPPCState *env, uint=
8_t *mem_buf, int n)
>  static int gdb_set_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> +        ppc_avr_t *avr =3D cpu_avr_ptr(env, n);
>          ppc_maybe_bswap_register(env, mem_buf, 8);
>          ppc_maybe_bswap_register(env, mem_buf + 8, 8);
>          if (!avr_need_swap(env)) {
> -            env->avr[n].u64[0] =3D ldq_p(mem_buf);
> -            env->avr[n].u64[1] =3D ldq_p(mem_buf+8);
> +            avr->u64[0] =3D ldq_p(mem_buf);
> +            avr->u64[1] =3D ldq_p(mem_buf + 8);
>          } else {
> -            env->avr[n].u64[1] =3D ldq_p(mem_buf);
> -            env->avr[n].u64[0] =3D ldq_p(mem_buf+8);
> +            avr->u64[1] =3D ldq_p(mem_buf);
> +            avr->u64[0] =3D ldq_p(mem_buf + 8);
>          }
>          return 16;
>      }
> @@ -9623,7 +9625,7 @@ static int gdb_set_spe_reg(CPUPPCState *env, uint8_=
t *mem_buf, int n)
>  static int gdb_get_vsx_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> -        stq_p(mem_buf, env->vsr[n]);
> +        stq_p(mem_buf, *cpu_vsrl_ptr(env, n));
>          ppc_maybe_bswap_register(env, mem_buf, 8);
>          return 8;
>      }
> @@ -9634,7 +9636,7 @@ static int gdb_set_vsx_reg(CPUPPCState *env, uint8_=
t *mem_buf, int n)
>  {
>      if (n < 32) {
>          ppc_maybe_bswap_register(env, mem_buf, 8);
> -        env->vsr[n] =3D ldq_p(mem_buf);
> +        *cpu_vsrl_ptr(env, n) =3D ldq_p(mem_buf);
>          return 8;
>      }
>      return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--daC8KDjlMyCcZyAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsW6EACgkQbDjKyiDZ
s5IHKQ//VP1t+raRVW1dEC97gF4BQgdDnUWKp+2Wg42KixDcdcjnjp9J6bAFdUnG
mlxv1KNBH5OI8PnLkyr7Dd4xGzZ4N4k+Fi8EXKVbQf2t1ryXc0cupK8IDtv37hyY
P0lBKbJTXSfvqFhBoimrnW+GZRQH7uHVeh2/i+HtzV73xTtTZnkI2Ux0c+QbHNbo
zJ8RSRybI4SEqClyjjzgns7L/y/Z8HNQVeFKUUkd+i3VfvWCfHJIKxh14T/7UXuf
U2qO+Ve8WCeOnX7RSKNd0QYDmo6vYARrT1kqTp14wiu1/pP/ZdtQD3t2/HJ1QlzN
J+pZf9ImqjisTuHwWi48wQp/rxjoVbrMJN2ckMTcxwMZ9Z742bFuTycvnWiEdhGS
PWdN3gBpH82HP2IbCM5K6wGnMub4EHpg9oyaKTUEbS4rqcdO1Pq6GzSNLj2CWadA
YY+iF11m3+stkIkiJyJ+/0lWK5Wsp3Iue/1fDD3ehcDAuwiig2/HIinInVzSQop/
FEgp0eoqVgV/RKdccC95ZjcFTWiP86joyWPGv7L+f21Azg6gsEZAzLG4U9arjZ93
GCTnSuql4jNrzgzw56/CruLbKTrXCmbwk7Dli6b5QdxLBHy+ezysPMgSNi7/adAa
EdA8kabqPLmJwfbyUxJBi2yI4n3+eapFVm0C+Q8ugbbp28VvHYk=
=aigN
-----END PGP SIGNATURE-----

--daC8KDjlMyCcZyAo--
