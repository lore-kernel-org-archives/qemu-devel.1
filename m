Received: from eggs.gnu.org ([2001:4830:134:3::10]:38030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZxe-0005cY-H5
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZxb-0005BH-8g
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:08:22 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edZxa-0005Ak-Re
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:08:19 -0500
Received: by mail-wr0-x241.google.com with SMTP id z48so8178667wrz.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 03:08:18 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-9-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 11:08:15 +0000
Message-ID: <87wp0ajgm8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/16] target/arm: Expand vector
 registers for SVE
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

> Change vfp.regs as a uint64_t to vfp.zregs as an ARMVectorReg.
> The previous patches have made the change in representation
> relatively painless.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           | 57 ++++++++++++++++++++++++++++++----------=
------
>  target/arm/machine.c       | 35 +++++++++++++++++++++++++++-
>  target/arm/translate-a64.c |  8 +++----
>  target/arm/translate.c     |  7 +++---
>  4 files changed, 79 insertions(+), 28 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 7d396606f3..57d805b5d8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -153,6 +153,40 @@ typedef struct {
>      uint32_t base_mask;
>  } TCR;
>
> +/* Define a maximum sized vector register.
> + * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
> + * For 64-bit, this is a 2048-bit SVE register.
> + *
> + * Note that the mapping between S, D, and Q views of the register bank
> + * differs between AArch64 and AArch32.
> + * In AArch32:
> + *  Qn =3D regs[n].d[1]:regs[n].d[0]
> + *  Dn =3D regs[n / 2].d[n & 1]
> + *  Sn =3D regs[n / 4].d[n % 4 / 2],
> + *       bits 31..0 for even n, and bits 63..32 for odd n
> + *       (and regs[16] to regs[31] are inaccessible)
> + * In AArch64:
> + *  Zn =3D regs[n].d[*]
> + *  Qn =3D regs[n].d[1]:regs[n].d[0]
> + *  Dn =3D regs[n].d[0]
> + *  Sn =3D regs[n].d[0] bits 31..0
> + *
> + * This corresponds to the architecturally defined mapping between
> + * the two execution states, and means we do not need to explicitly
> + * map these registers when changing states.

It might be worth prompting to use the helper functions to get the right
offsets here.

> + */
> +
> +#ifdef TARGET_AARCH64
> +# define ARM_MAX_VQ    16
> +#else
> +# define ARM_MAX_VQ    1
> +#endif
> +
> +typedef struct ARMVectorReg {
> +    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
> +} ARMVectorReg;
> +

The QEMU_ALIGNED also deserves a comment either here or in the comment
block above.

> +
>  typedef struct CPUARMState {
>      /* Regs for current mode.  */
>      uint32_t regs[16];
> @@ -477,22 +511,7 @@ typedef struct CPUARMState {
>
>      /* VFP coprocessor state.  */
>      struct {
> -        /* VFP/Neon register state. Note that the mapping between S, D a=
nd Q
> -         * views of the register bank differs between AArch64 and AArch3=
2:
> -         * In AArch32:
> -         *  Qn =3D regs[2n+1]:regs[2n]
> -         *  Dn =3D regs[n]
> -         *  Sn =3D regs[n/2] bits 31..0 for even n, and bits 63..32 for =
odd n
> -         * (and regs[32] to regs[63] are inaccessible)
> -         * In AArch64:
> -         *  Qn =3D regs[2n+1]:regs[2n]
> -         *  Dn =3D regs[2n]
> -         *  Sn =3D regs[2n] bits 31..0
> -         * This corresponds to the architecturally defined mapping betwe=
en
> -         * the two execution states, and means we do not need to explici=
tly
> -         * map these registers when changing states.
> -         */
> -        uint64_t regs[64];
> +        ARMVectorReg zregs[32];
>
>          uint32_t xregs[16];
>          /* We store these fpcsr fields separately for convenience.  */
> @@ -2891,7 +2910,7 @@ static inline void *arm_get_el_change_hook_opaque(A=
RMCPU *cpu)
>   */
>  static inline uint64_t *aa32_vfp_dreg(CPUARMState *env, unsigned regno)
>  {
> -    return &env->vfp.regs[regno];
> +    return &env->vfp.zregs[regno >> 1].d[regno & 1];
>  }
>
>  /**
> @@ -2900,7 +2919,7 @@ static inline uint64_t *aa32_vfp_dreg(CPUARMState *=
env, unsigned regno)
>   */
>  static inline uint64_t *aa32_vfp_qreg(CPUARMState *env, unsigned regno)
>  {
> -    return &env->vfp.regs[2 * regno];
> +    return &env->vfp.zregs[regno].d[0];
>  }
>
>  /**
> @@ -2909,7 +2928,7 @@ static inline uint64_t *aa32_vfp_qreg(CPUARMState *=
env, unsigned regno)
>   */
>  static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
>  {
> -    return &env->vfp.regs[2 * regno];
> +    return &env->vfp.zregs[regno].d[0];
>  }
>
>  #endif
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index a85c2430d3..cb0e1c92bb 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -50,7 +50,40 @@ static const VMStateDescription vmstate_vfp =3D {
>      .minimum_version_id =3D 3,
>      .needed =3D vfp_needed,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT64_ARRAY(env.vfp.regs, ARMCPU, 64),
> +        /* For compatibility, store Qn out of Zn here.  */
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[1].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[2].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[3].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[4].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[5].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[6].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[7].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[8].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[9].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[10].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[11].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[12].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[13].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[14].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[15].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[16].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[17].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[18].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[19].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[20].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[21].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[22].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[23].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[24].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[25].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[26].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[27].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[28].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[29].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[30].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[31].d, ARMCPU, 0, 2),
> +
>          /* The xregs array is a little awkward because element 1 (FPSCR)
>           * requires a specific accessor, so we have to split it up in
>           * the vmstate:
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index eed64c73e5..10eef870fe 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -517,8 +517,8 @@ static inline int vec_reg_offset(DisasContext *s, int=
 regno,
>  {
>      int offs =3D 0;
>  #ifdef HOST_WORDS_BIGENDIAN
> -    /* This is complicated slightly because vfp.regs[2n] is
> -     * still the low half and  vfp.regs[2n+1] the high half
> +    /* This is complicated slightly because vfp.zregs[n].d[0] is
> +     * still the low half and vfp.zregs[n].d[1] the high half
>       * of the 128 bit vector, even on big endian systems.
>       * Calculate the offset assuming a fully bigendian 128 bits,
>       * then XOR to account for the order of the two 64 bit halves.
> @@ -528,7 +528,7 @@ static inline int vec_reg_offset(DisasContext *s, int=
 regno,
>  #else
>      offs +=3D element * (1 << size);
>  #endif
> -    offs +=3D offsetof(CPUARMState, vfp.regs[regno * 2]);
> +    offs +=3D offsetof(CPUARMState, vfp.zregs[regno]);
>      assert_fp_access_checked(s);
>      return offs;
>  }
> @@ -537,7 +537,7 @@ static inline int vec_reg_offset(DisasContext *s, int=
 regno,
>  static inline int vec_full_reg_offset(DisasContext *s, int regno)
>  {
>      assert_fp_access_checked(s);
> -    return offsetof(CPUARMState, vfp.regs[regno * 2]);
> +    return offsetof(CPUARMState, vfp.zregs[regno]);
>  }
>
>  /* Return a newly allocated pointer to the vector register.  */
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 55826b7e5a..a8c13d3758 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1512,13 +1512,12 @@ static inline void gen_vfp_st(DisasContext *s, in=
t dp, TCGv_i32 addr)
>      }
>  }
>
> -static inline long
> -vfp_reg_offset (int dp, int reg)
> +static inline long vfp_reg_offset(bool dp, unsigned reg)
>  {
>      if (dp) {
> -        return offsetof(CPUARMState, vfp.regs[reg]);
> +        return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
>      } else {
> -        long ofs =3D offsetof(CPUARMState, vfp.regs[reg >> 1]);
> +        long ofs =3D offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >>=
 1) & 1]);
>          if (reg & 1) {
>              ofs +=3D offsetof(CPU_DoubleU, l.upper);
>          } else {

Other than the minor comment notes it looks good:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
