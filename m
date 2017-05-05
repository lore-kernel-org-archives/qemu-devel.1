Received: from eggs.gnu.org ([2001:4830:134:3::10]:45245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6dki-0000IP-OD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6dke-0003a6-5f
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:58:36 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6dkd-0003Zi-Qy
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:58:32 -0400
Received: by mail-wr0-x230.google.com with SMTP id w50so4409940wrc.0
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 06:58:31 -0700 (PDT)
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
	<1486046099-17726-15-git-send-email-batuzovk@ispras.ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1486046099-17726-15-git-send-email-batuzovk@ispras.ru>
Date: Fri, 05 May 2017 14:59:10 +0100
Message-ID: <87wp9vmmkx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2.1 14/21] tcg: do not rely on exact
 values of MO_BSWAP or MO_SIGN in backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>


Kirill Batuzov <batuzovk@ispras.ru> writes:

> Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
> ---
>  tcg/aarch64/tcg-target.inc.c |  4 ++--
>  tcg/arm/tcg-target.inc.c     |  4 ++--
>  tcg/i386/tcg-target.inc.c    |  4 ++--
>  tcg/mips/tcg-target.inc.c    |  4 ++--
>  tcg/ppc/tcg-target.inc.c     |  4 ++--
>  tcg/s390/tcg-target.inc.c    |  4 ++--
>  tcg/sparc/tcg-target.inc.c   | 12 ++++++------
>  tcg/tcg-op.c                 |  4 ++--
>  tcg/tcg.h                    |  1 +
>  9 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 6d227a5..2b0b548 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1032,7 +1032,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     TCGMemOpIdx oi, uintptr_t ra)
>   */
> -static void * const qemu_ld_helpers[16] = {
> +static void * const qemu_ld_helpers[] = {
>      [MO_UB]   = helper_ret_ldub_mmu,
>      [MO_LEUW] = helper_le_lduw_mmu,
>      [MO_LEUL] = helper_le_ldul_mmu,
> @@ -1046,7 +1046,7 @@ static void * const qemu_ld_helpers[16] = {
>   *                                     uintxx_t val, TCGMemOpIdx oi,
>   *                                     uintptr_t ra)
>   */
> -static void * const qemu_st_helpers[16] = {
> +static void * const qemu_st_helpers[] = {
>      [MO_UB]   = helper_ret_stb_mmu,
>      [MO_LEUW] = helper_le_stw_mmu,
>      [MO_LEUL] = helper_le_stl_mmu,
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index e75a6d4..f603f02 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -1058,7 +1058,7 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     int mmu_idx, uintptr_t ra)
>   */
> -static void * const qemu_ld_helpers[16] = {
> +static void * const qemu_ld_helpers[] = {
>      [MO_UB]   = helper_ret_ldub_mmu,
>      [MO_SB]   = helper_ret_ldsb_mmu,
>
> @@ -1078,7 +1078,7 @@ static void * const qemu_ld_helpers[16] = {
>  /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
>   *                                     uintxx_t val, int mmu_idx, uintptr_t ra)
>   */
> -static void * const qemu_st_helpers[16] = {
> +static void * const qemu_st_helpers[] = {
>      [MO_UB]   = helper_ret_stb_mmu,
>      [MO_LEUW] = helper_le_stw_mmu,
>      [MO_LEUL] = helper_le_stl_mmu,
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index d8f0d81..263c15e 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -1334,7 +1334,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     int mmu_idx, uintptr_t ra)
>   */
> -static void * const qemu_ld_helpers[16] = {
> +static void * const qemu_ld_helpers[] = {
>      [MO_UB]   = helper_ret_ldub_mmu,
>      [MO_LEUW] = helper_le_lduw_mmu,
>      [MO_LEUL] = helper_le_ldul_mmu,
> @@ -1347,7 +1347,7 @@ static void * const qemu_ld_helpers[16] = {
>  /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
>   *                                     uintxx_t val, int mmu_idx, uintptr_t ra)
>   */
> -static void * const qemu_st_helpers[16] = {
> +static void * const qemu_st_helpers[] = {
>      [MO_UB]   = helper_ret_stb_mmu,
>      [MO_LEUW] = helper_le_stw_mmu,
>      [MO_LEUL] = helper_le_stl_mmu,
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 01ac7b2..4f2d5d1 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1108,7 +1108,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
>  }
>
>  #if defined(CONFIG_SOFTMMU)
> -static void * const qemu_ld_helpers[16] = {
> +static void * const qemu_ld_helpers[] = {
>      [MO_UB]   = helper_ret_ldub_mmu,
>      [MO_SB]   = helper_ret_ldsb_mmu,
>      [MO_LEUW] = helper_le_lduw_mmu,
> @@ -1125,7 +1125,7 @@ static void * const qemu_ld_helpers[16] = {
>  #endif
>  };
>
> -static void * const qemu_st_helpers[16] = {
> +static void * const qemu_st_helpers[] = {
>      [MO_UB]   = helper_ret_stb_mmu,
>      [MO_LEUW] = helper_le_stw_mmu,
>      [MO_LEUL] = helper_le_stl_mmu,
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 64f67d2..680050b 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -1419,7 +1419,7 @@ static const uint32_t qemu_exts_opc[4] = {
>  /* helper signature: helper_ld_mmu(CPUState *env, target_ulong addr,
>   *                                 int mmu_idx, uintptr_t ra)
>   */
> -static void * const qemu_ld_helpers[16] = {
> +static void * const qemu_ld_helpers[] = {
>      [MO_UB]   = helper_ret_ldub_mmu,
>      [MO_LEUW] = helper_le_lduw_mmu,
>      [MO_LEUL] = helper_le_ldul_mmu,
> @@ -1432,7 +1432,7 @@ static void * const qemu_ld_helpers[16] = {
>  /* helper signature: helper_st_mmu(CPUState *env, target_ulong addr,
>   *                                 uintxx_t val, int mmu_idx, uintptr_t ra)
>   */
> -static void * const qemu_st_helpers[16] = {
> +static void * const qemu_st_helpers[] = {
>      [MO_UB]   = helper_ret_stb_mmu,
>      [MO_LEUW] = helper_le_stw_mmu,
>      [MO_LEUL] = helper_le_stl_mmu,
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index a679280..ec3491a 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -309,7 +309,7 @@ static const uint8_t tcg_cond_to_ltr_cond[] = {
>  };
>
>  #ifdef CONFIG_SOFTMMU
> -static void * const qemu_ld_helpers[16] = {
> +static void * const qemu_ld_helpers[] = {
>      [MO_UB]   = helper_ret_ldub_mmu,
>      [MO_SB]   = helper_ret_ldsb_mmu,
>      [MO_LEUW] = helper_le_lduw_mmu,
> @@ -324,7 +324,7 @@ static void * const qemu_ld_helpers[16] = {
>      [MO_BEQ]  = helper_be_ldq_mmu,
>  };
>
> -static void * const qemu_st_helpers[16] = {
> +static void * const qemu_st_helpers[] = {
>      [MO_UB]   = helper_ret_stb_mmu,
>      [MO_LEUW] = helper_le_stw_mmu,
>      [MO_LEUL] = helper_le_stl_mmu,
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index d1f4c0d..1b115d2 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -840,12 +840,12 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
>  }
>
>  #ifdef CONFIG_SOFTMMU
> -static tcg_insn_unit *qemu_ld_trampoline[16];
> -static tcg_insn_unit *qemu_st_trampoline[16];
> +static tcg_insn_unit *qemu_ld_trampoline[MO_ALL];
> +static tcg_insn_unit *qemu_st_trampoline[MO_ALL];

Minor merge conflict here since
709a340d679d95a0c6cbb9b5f654498f04345b50.

>
>  static void build_trampolines(TCGContext *s)
>  {
> -    static void * const qemu_ld_helpers[16] = {
> +    static void * const qemu_ld_helpers[MO_ALL] = {

Why bother bounding the array here when for the other MO_ indexed arrays
in other backends you changed to []?

>          [MO_UB]   = helper_ret_ldub_mmu,
>          [MO_SB]   = helper_ret_ldsb_mmu,
>          [MO_LEUW] = helper_le_lduw_mmu,
> @@ -857,7 +857,7 @@ static void build_trampolines(TCGContext *s)
>          [MO_BEUL] = helper_be_ldul_mmu,
>          [MO_BEQ]  = helper_be_ldq_mmu,
>      };
> -    static void * const qemu_st_helpers[16] = {
> +    static void * const qemu_st_helpers[MO_ALL] = {
>          [MO_UB]   = helper_ret_stb_mmu,
>          [MO_LEUW] = helper_le_stw_mmu,
>          [MO_LEUL] = helper_le_stl_mmu,
> @@ -870,7 +870,7 @@ static void build_trampolines(TCGContext *s)
>      int i;
>      TCGReg ra;
>
> -    for (i = 0; i < 16; ++i) {
> +    for (i = 0; i < MO_ALL; ++i) {

You could just use ARRAY_SIZE(qemu_ld_helpers) here instead.

>          if (qemu_ld_helpers[i] == NULL) {
>              continue;
>          }
> @@ -898,7 +898,7 @@ static void build_trampolines(TCGContext *s)
>          tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_O7, ra);
>      }
>
> -    for (i = 0; i < 16; ++i) {
> +    for (i = 0; i < MO_ALL; ++i) {

And ARRAY_SIZE here again.

>          if (qemu_st_helpers[i] == NULL) {
>              continue;
>          }
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 8a19eee..0dfe611 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2767,7 +2767,7 @@ typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env, TCGv, TCGv_i64);
>  # define WITH_ATOMIC64(X)
>  #endif
>
> -static void * const table_cmpxchg[16] = {
> +static void * const table_cmpxchg[] = {
>      [MO_8] = gen_helper_atomic_cmpxchgb,
>      [MO_16 | MO_LE] = gen_helper_atomic_cmpxchgw_le,
>      [MO_16 | MO_BE] = gen_helper_atomic_cmpxchgw_be,
> @@ -2985,7 +2985,7 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
>  }
>
>  #define GEN_ATOMIC_HELPER(NAME, OP, NEW)                                \
> -static void * const table_##NAME[16] = {                                \
> +static void * const table_##NAME[] = {                                  \
>      [MO_8] = gen_helper_atomic_##NAME##b,                               \
>      [MO_16 | MO_LE] = gen_helper_atomic_##NAME##w_le,                   \
>      [MO_16 | MO_BE] = gen_helper_atomic_##NAME##w_be,                   \
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index fd43f15..5e0c6da 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -386,6 +386,7 @@ typedef enum TCGMemOp {
>      MO_TEQ   = MO_TE | MO_Q,
>
>      MO_SSIZE = MO_SIZE | MO_SIGN,
> +    MO_ALL   = MO_SIZE | MO_SIGN | MO_BSWAP | MO_AMASK,
>  } TCGMemOp;
>
>  /**


--
Alex Bennée
