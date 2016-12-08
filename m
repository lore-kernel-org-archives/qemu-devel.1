Received: from eggs.gnu.org ([2001:4830:134:3::10]:57118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF2lC-00064s-56
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF2l8-00028X-OH
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:45:34 -0500
Received: from mail-wj0-f179.google.com ([209.85.210.179]:35941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cF2l8-00028D-5e
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:45:30 -0500
Received: by mail-wj0-f179.google.com with SMTP id tk12so99364713wjb.3
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 09:45:29 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-25-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-25-git-send-email-rth@twiddle.net>
Date: Thu, 08 Dec 2016 17:44:26 +0000
Message-ID: <874m2ez56t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 24/64] tcg: Add clz and ctz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg-runtime.c            |  20 +++++++
>  tcg/README               |   8 +++
>  tcg/aarch64/tcg-target.h |   4 ++
>  tcg/arm/tcg-target.h     |   2 +
>  tcg/i386/tcg-target.h    |   4 ++
>  tcg/ia64/tcg-target.h    |   4 ++
>  tcg/mips/tcg-target.h    |   2 +
>  tcg/optimize.c           |  36 ++++++++++++
>  tcg/ppc/tcg-target.h     |   4 ++
>  tcg/s390/tcg-target.h    |   4 ++
>  tcg/sparc/tcg-target.h   |   4 ++
>  tcg/tcg-op.c             | 143 +++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op.h             |  16 ++++++
>  tcg/tcg-opc.h            |   4 ++
>  tcg/tcg-runtime.h        |   5 ++
>  tcg/tcg.h                |   2 +
>  tcg/tci/tcg-target.h     |   4 ++
>  17 files changed, 266 insertions(+)
>
> diff --git a/tcg-runtime.c b/tcg-runtime.c
> index 9327b6f..eb3bade 100644
> --- a/tcg-runtime.c
> +++ b/tcg-runtime.c
> @@ -101,6 +101,26 @@ int64_t HELPER(mulsh_i64)(int64_t arg1, int64_t arg2)
>      return h;
>  }
>
> +uint32_t HELPER(clz_i32)(uint32_t arg, uint32_t zero_val)
> +{
> +    return arg ? clz32(arg) : zero_val;
> +}
> +
> +uint32_t HELPER(ctz_i32)(uint32_t arg, uint32_t zero_val)
> +{
> +    return arg ? ctz32(arg) : zero_val;
> +}
> +
> +uint64_t HELPER(clz_i64)(uint64_t arg, uint64_t zero_val)
> +{
> +    return arg ? clz64(arg) : zero_val;
> +}
> +
> +uint64_t HELPER(ctz_i64)(uint64_t arg, uint64_t zero_val)
> +{
> +    return arg ? ctz64(arg) : zero_val;
> +}
> +
>  void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
> diff --git a/tcg/README b/tcg/README
> index 065d9c2..f5ccf04 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -246,6 +246,14 @@ t0=~(t1|t2)
>
>  t0=t1|~t2
>
> +* clz_i32/i64 t0, t1, t2
> +
> +t0 = t1 ? clz(t1) : t2
> +
> +* ctz_i32/i64 t0, t1, t2
> +
> +t0 = t1 ? ctz(t1) : t2
> +
>  ********* Shifts/Rotates
>
>  * shl_i32/i64 t0, t1, t2
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 4a74bd8..976f493 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -62,6 +62,8 @@ typedef enum {
>  #define TCG_TARGET_HAS_eqv_i32          1
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_ctz_i32          0
>  #define TCG_TARGET_HAS_deposit_i32      1
>  #define TCG_TARGET_HAS_extract_i32      1
>  #define TCG_TARGET_HAS_sextract_i32     1
> @@ -94,6 +96,8 @@ typedef enum {
>  #define TCG_TARGET_HAS_eqv_i64          1
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
> +#define TCG_TARGET_HAS_clz_i64          0
> +#define TCG_TARGET_HAS_ctz_i64          0
>  #define TCG_TARGET_HAS_deposit_i64      1
>  #define TCG_TARGET_HAS_extract_i64      1
>  #define TCG_TARGET_HAS_sextract_i64     1
> diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
> index 4e30728..02cc242 100644
> --- a/tcg/arm/tcg-target.h
> +++ b/tcg/arm/tcg-target.h
> @@ -110,6 +110,8 @@ extern bool use_idiv_instructions;
>  #define TCG_TARGET_HAS_eqv_i32          0
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_ctz_i32          0
>  #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
>  #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
>  #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index dc19c47..f2d9955 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -93,6 +93,8 @@ extern bool have_bmi1;
>  #define TCG_TARGET_HAS_eqv_i32          0
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_ctz_i32          0
>  #define TCG_TARGET_HAS_deposit_i32      1
>  #define TCG_TARGET_HAS_extract_i32      1
>  #define TCG_TARGET_HAS_sextract_i32     1
> @@ -125,6 +127,8 @@ extern bool have_bmi1;
>  #define TCG_TARGET_HAS_eqv_i64          0
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
> +#define TCG_TARGET_HAS_clz_i64          0
> +#define TCG_TARGET_HAS_ctz_i64          0
>  #define TCG_TARGET_HAS_deposit_i64      1
>  #define TCG_TARGET_HAS_extract_i64      1
>  #define TCG_TARGET_HAS_sextract_i64     0
> diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
> index 8856dc8..9a829ae 100644
> --- a/tcg/ia64/tcg-target.h
> +++ b/tcg/ia64/tcg-target.h
> @@ -140,6 +140,10 @@ typedef enum {
>  #define TCG_TARGET_HAS_nand_i32         1
>  #define TCG_TARGET_HAS_nand_i64         1
>  #define TCG_TARGET_HAS_nor_i32          1
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_clz_i64          0
> +#define TCG_TARGET_HAS_ctz_i32          0
> +#define TCG_TARGET_HAS_ctz_i64          0
>  #define TCG_TARGET_HAS_nor_i64          1
>  #define TCG_TARGET_HAS_orc_i32          1
>  #define TCG_TARGET_HAS_orc_i64          1
> diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
> index f1c3137..f133684 100644
> --- a/tcg/mips/tcg-target.h
> +++ b/tcg/mips/tcg-target.h
> @@ -109,6 +109,8 @@ extern bool use_mips32r2_instructions;
>  #define TCG_TARGET_HAS_rem_i32          1
>  #define TCG_TARGET_HAS_not_i32          1
>  #define TCG_TARGET_HAS_nor_i32          1
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_ctz_i32          0
>  #define TCG_TARGET_HAS_andc_i32         0
>  #define TCG_TARGET_HAS_orc_i32          0
>  #define TCG_TARGET_HAS_eqv_i32          0
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 9e26bb7..e7ecce4 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -296,6 +296,18 @@ static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
>      CASE_OP_32_64(nor):
>          return ~(x | y);
>
> +    case INDEX_op_clz_i32:
> +        return (uint32_t)x ? clz32(x) : y;
> +
> +    case INDEX_op_clz_i64:
> +        return x ? clz64(x) : y;
> +
> +    case INDEX_op_ctz_i32:
> +        return (uint32_t)x ? ctz32(x) : y;
> +
> +    case INDEX_op_ctz_i64:
> +        return x ? ctz64(x) : y;
> +
>      CASE_OP_32_64(ext8s):
>          return (int8_t)x;
>
> @@ -896,6 +908,16 @@ void tcg_optimize(TCGContext *s)
>              mask = temps[args[1]].mask | temps[args[2]].mask;
>              break;
>
> +        case INDEX_op_clz_i32:
> +        case INDEX_op_ctz_i32:
> +            mask = temps[args[2]].mask | 31;
> +            break;
> +
> +        case INDEX_op_clz_i64:
> +        case INDEX_op_ctz_i64:
> +            mask = temps[args[2]].mask | 63;
> +            break;
> +
>          CASE_OP_32_64(setcond):
>          case INDEX_op_setcond2_i32:
>              mask = 1;
> @@ -1052,6 +1074,20 @@ void tcg_optimize(TCGContext *s)
>              }
>              goto do_default;
>
> +        CASE_OP_32_64(clz):
> +        CASE_OP_32_64(ctz):
> +            if (temp_is_const(args[1])) {
> +                TCGArg v = temps[args[1]].val;
> +                if (v != 0) {
> +                    tmp = do_constant_folding(opc, v, 0);
> +                    tcg_opt_gen_movi(s, op, args, args[0], tmp);
> +                } else {
> +                    tcg_opt_gen_mov(s, op, args, args[0], args[2]);
> +                }
> +                break;
> +            }
> +            goto do_default;
> +
>          CASE_OP_32_64(deposit):
>              if (temp_is_const(args[1]) && temp_is_const(args[2])) {
>                  tmp = deposit64(temps[args[1]].val, args[3], args[4],
> diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
> index b42c57a..698a599 100644
> --- a/tcg/ppc/tcg-target.h
> +++ b/tcg/ppc/tcg-target.h
> @@ -68,6 +68,8 @@ typedef enum {
>  #define TCG_TARGET_HAS_eqv_i32          1
>  #define TCG_TARGET_HAS_nand_i32         1
>  #define TCG_TARGET_HAS_nor_i32          1
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_ctz_i32          0
>  #define TCG_TARGET_HAS_deposit_i32      1
>  #define TCG_TARGET_HAS_extract_i32      1
>  #define TCG_TARGET_HAS_sextract_i32     0
> @@ -101,6 +103,8 @@ typedef enum {
>  #define TCG_TARGET_HAS_eqv_i64          1
>  #define TCG_TARGET_HAS_nand_i64         1
>  #define TCG_TARGET_HAS_nor_i64          1
> +#define TCG_TARGET_HAS_clz_i64          0
> +#define TCG_TARGET_HAS_ctz_i64          0
>  #define TCG_TARGET_HAS_deposit_i64      1
>  #define TCG_TARGET_HAS_extract_i64      1
>  #define TCG_TARGET_HAS_sextract_i64     0
> diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
> index e9ac12e..3ac2dc9 100644
> --- a/tcg/s390/tcg-target.h
> +++ b/tcg/s390/tcg-target.h
> @@ -77,6 +77,8 @@ extern uint64_t s390_facilities;
>  #define TCG_TARGET_HAS_eqv_i32        0
>  #define TCG_TARGET_HAS_nand_i32       0
>  #define TCG_TARGET_HAS_nor_i32        0
> +#define TCG_TARGET_HAS_clz_i32        0
> +#define TCG_TARGET_HAS_ctz_i32        0
>  #define TCG_TARGET_HAS_deposit_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
>  #define TCG_TARGET_HAS_extract_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
>  #define TCG_TARGET_HAS_sextract_i32   0
> @@ -108,6 +110,8 @@ extern uint64_t s390_facilities;
>  #define TCG_TARGET_HAS_eqv_i64        0
>  #define TCG_TARGET_HAS_nand_i64       0
>  #define TCG_TARGET_HAS_nor_i64        0
> +#define TCG_TARGET_HAS_clz_i64        0
> +#define TCG_TARGET_HAS_ctz_i64        0
>  #define TCG_TARGET_HAS_deposit_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
>  #define TCG_TARGET_HAS_extract_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
>  #define TCG_TARGET_HAS_sextract_i64   0
> diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
> index a212167..340837a 100644
> --- a/tcg/sparc/tcg-target.h
> +++ b/tcg/sparc/tcg-target.h
> @@ -110,6 +110,8 @@ extern bool use_vis3_instructions;
>  #define TCG_TARGET_HAS_eqv_i32          0
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_ctz_i32          0
>  #define TCG_TARGET_HAS_deposit_i32      0
>  #define TCG_TARGET_HAS_extract_i32      0
>  #define TCG_TARGET_HAS_sextract_i32     0
> @@ -142,6 +144,8 @@ extern bool use_vis3_instructions;
>  #define TCG_TARGET_HAS_eqv_i64          0
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
> +#define TCG_TARGET_HAS_clz_i64          0
> +#define TCG_TARGET_HAS_ctz_i64          0
>  #define TCG_TARGET_HAS_deposit_i64      0
>  #define TCG_TARGET_HAS_extract_i64      0
>  #define TCG_TARGET_HAS_sextract_i64     0
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 1927e53..2b520c1 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -457,6 +457,85 @@ void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>      }
>  }
>
> +void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
> +{
> +    if (TCG_TARGET_HAS_clz_i32) {
> +        tcg_gen_op3_i32(INDEX_op_clz_i32, ret, arg1, arg2);
> +    } else if (TCG_TARGET_HAS_clz_i64) {
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +        TCGv_i64 t2 = tcg_temp_new_i64();
> +        tcg_gen_extu_i32_i64(t1, arg1);
> +        tcg_gen_extu_i32_i64(t2, arg2);
> +        tcg_gen_addi_i64(t2, t2, 32);
> +        tcg_gen_clz_i64(t1, t1, t2);
> +        tcg_gen_extrl_i64_i32(ret, t1);
> +        tcg_temp_free_i64(t1);
> +        tcg_temp_free_i64(t2);
> +        tcg_gen_subi_i32(ret, ret, 32);
> +    } else {
> +        gen_helper_clz_i32(ret, arg1, arg2);
> +    }
> +}
> +
> +void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
> +{
> +    TCGv_i32 t = tcg_const_i32(arg2);
> +    tcg_gen_clz_i32(ret, arg1, t);
> +    tcg_temp_free_i32(t);
> +}
> +
> +void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
> +{
> +    if (TCG_TARGET_HAS_ctz_i32) {
> +        tcg_gen_op3_i32(INDEX_op_ctz_i32, ret, arg1, arg2);
> +    } else if (TCG_TARGET_HAS_ctz_i64) {
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +        TCGv_i64 t2 = tcg_temp_new_i64();
> +        tcg_gen_extu_i32_i64(t1, arg1);
> +        tcg_gen_extu_i32_i64(t2, arg2);
> +        tcg_gen_ctz_i64(t1, t1, t2);
> +        tcg_gen_extrl_i64_i32(ret, t1);
> +        tcg_temp_free_i64(t1);
> +        tcg_temp_free_i64(t2);
> +    } else if (TCG_TARGET_HAS_clz_i32) {
> +        TCGv_i32 t1 = tcg_temp_new_i32();
> +        TCGv_i32 t2 = tcg_temp_new_i32();
> +        tcg_gen_neg_i32(t1, arg1);
> +        tcg_gen_xori_i32(t2, arg2, 31);
> +        tcg_gen_and_i32(t1, t1, arg1);
> +        tcg_gen_clz_i32(ret, t1, t2);
> +        tcg_temp_free_i32(t1);
> +        tcg_temp_free_i32(t2);
> +        tcg_gen_xori_i32(ret, ret, 31);
> +    } else if (TCG_TARGET_HAS_clz_i64) {
> +        TCGv_i32 t1 = tcg_temp_new_i32();
> +        TCGv_i32 t2 = tcg_temp_new_i32();
> +        TCGv_i64 x1 = tcg_temp_new_i64();
> +        TCGv_i64 x2 = tcg_temp_new_i64();
> +        tcg_gen_neg_i32(t1, arg1);
> +        tcg_gen_xori_i32(t2, arg2, 63);
> +        tcg_gen_and_i32(t1, t1, arg1);
> +        tcg_gen_extu_i32_i64(x1, t1);
> +        tcg_gen_extu_i32_i64(x2, t2);
> +        tcg_temp_free_i32(t1);
> +        tcg_temp_free_i32(t2);
> +        tcg_gen_clz_i64(x1, x1, x2);
> +        tcg_gen_extrl_i64_i32(ret, x1);
> +        tcg_temp_free_i64(x1);
> +        tcg_temp_free_i64(x2);
> +        tcg_gen_xori_i32(ret, ret, 63);
> +    } else {
> +        gen_helper_ctz_i32(ret, arg1, arg2);
> +    }
> +}
> +
> +void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
> +{
> +    TCGv_i32 t = tcg_const_i32(arg2);
> +    tcg_gen_ctz_i32(ret, arg1, t);
> +    tcg_temp_free_i32(t);
> +}
> +
>  void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>  {
>      if (TCG_TARGET_HAS_rot_i32) {
> @@ -1703,6 +1782,70 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>      }
>  }
>
> +void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
> +{
> +    if (TCG_TARGET_HAS_clz_i64) {
> +        tcg_gen_op3_i64(INDEX_op_clz_i64, ret, arg1, arg2);
> +    } else {
> +        gen_helper_clz_i64(ret, arg1, arg2);
> +    }
> +}
> +
> +void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
> +{
> +    if (TCG_TARGET_REG_BITS == 32
> +        && TCG_TARGET_HAS_clz_i32
> +        && arg2 <= 0xffffffffu) {
> +        TCGv_i32 t = tcg_const_i32((uint32_t)arg2 - 32);
> +        tcg_gen_clz_i32(t, TCGV_LOW(arg1), t);
> +        tcg_gen_addi_i32(t, t, 32);
> +        tcg_gen_clz_i32(TCGV_LOW(ret), TCGV_HIGH(arg1), t);
> +        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
> +        tcg_temp_free_i32(t);
> +    } else {
> +        TCGv_i64 t = tcg_const_i64(arg2);
> +        tcg_gen_clz_i64(ret, arg1, t);
> +        tcg_temp_free_i64(t);
> +    }
> +}
> +
> +void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
> +{
> +    if (TCG_TARGET_HAS_ctz_i64) {
> +        tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
> +    } else if (TCG_TARGET_HAS_clz_i64) {
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +        TCGv_i64 t2 = tcg_temp_new_i64();
> +        tcg_gen_neg_i64(t1, arg1);
> +        tcg_gen_xori_i64(t2, arg2, 63);
> +        tcg_gen_and_i64(t1, t1, arg1);
> +        tcg_gen_clz_i64(ret, t1, t2);
> +        tcg_temp_free_i64(t1);
> +        tcg_temp_free_i64(t2);
> +        tcg_gen_xori_i64(ret, ret, 63);
> +    } else {
> +        gen_helper_ctz_i64(ret, arg1, arg2);
> +    }
> +}
> +
> +void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
> +{
> +    if (TCG_TARGET_REG_BITS == 32
> +        && TCG_TARGET_HAS_ctz_i32
> +        && arg2 <= 0xffffffffu) {
> +        TCGv_i32 t32 = tcg_const_i32((uint32_t)arg2 - 32);
> +        tcg_gen_ctz_i32(t32, TCGV_HIGH(arg1), t32);
> +        tcg_gen_addi_i32(t32, t32, 32);
> +        tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
> +        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
> +        tcg_temp_free_i32(t32);
> +    } else {
> +        TCGv_i64 t64 = tcg_const_i64(arg2);
> +        tcg_gen_ctz_i64(ret, arg1, t64);
> +        tcg_temp_free_i64(t64);
> +    }
> +}
> +
>  void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>  {
>      if (TCG_TARGET_HAS_rot_i64) {
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index d42fd0d..7a24e84 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -286,6 +286,10 @@ void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> +void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> +void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> +void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
> +void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
>  void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
>  void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> @@ -469,6 +473,10 @@ void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> +void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> +void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> +void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
> +void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
>  void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
>  void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> @@ -958,6 +966,10 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
>  #define tcg_gen_nand_tl tcg_gen_nand_i64
>  #define tcg_gen_nor_tl tcg_gen_nor_i64
>  #define tcg_gen_orc_tl tcg_gen_orc_i64
> +#define tcg_gen_clz_tl tcg_gen_clz_i64
> +#define tcg_gen_ctz_tl tcg_gen_ctz_i64
> +#define tcg_gen_clzi_tl tcg_gen_clzi_i64
> +#define tcg_gen_ctzi_tl tcg_gen_ctzi_i64
>  #define tcg_gen_rotl_tl tcg_gen_rotl_i64
>  #define tcg_gen_rotli_tl tcg_gen_rotli_i64
>  #define tcg_gen_rotr_tl tcg_gen_rotr_i64
> @@ -1049,6 +1061,10 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
>  #define tcg_gen_nand_tl tcg_gen_nand_i32
>  #define tcg_gen_nor_tl tcg_gen_nor_i32
>  #define tcg_gen_orc_tl tcg_gen_orc_i32
> +#define tcg_gen_clz_tl tcg_gen_clz_i32
> +#define tcg_gen_ctz_tl tcg_gen_ctz_i32
> +#define tcg_gen_clzi_tl tcg_gen_clzi_i32
> +#define tcg_gen_ctzi_tl tcg_gen_ctzi_i32
>  #define tcg_gen_rotl_tl tcg_gen_rotl_i32
>  #define tcg_gen_rotli_tl tcg_gen_rotli_i32
>  #define tcg_gen_rotr_tl tcg_gen_rotr_i32
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index 11563ac..d00db4f 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -104,6 +104,8 @@ DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_i32))
>  DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv_i32))
>  DEF(nand_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nand_i32))
>  DEF(nor_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nor_i32))
> +DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz_i32))
> +DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
>
>  DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
>  DEF(movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
> @@ -171,6 +173,8 @@ DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc_i64))
>  DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv_i64))
>  DEF(nand_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nand_i64))
>  DEF(nor_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nor_i64))
> +DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz_i64))
> +DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz_i64))
>
>  DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
>  DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
> diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
> index 1deb86a..eb1cd76 100644
> --- a/tcg/tcg-runtime.h
> +++ b/tcg/tcg-runtime.h
> @@ -15,6 +15,11 @@ DEF_HELPER_FLAGS_2(sar_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
>  DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
>  DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>
> +DEF_HELPER_FLAGS_2(clz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
> +DEF_HELPER_FLAGS_2(ctz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
> +DEF_HELPER_FLAGS_2(clz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> +DEF_HELPER_FLAGS_2(ctz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> +
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
>  #ifdef CONFIG_SOFTMMU
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 144bdab..e026282 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -111,6 +111,8 @@ typedef uint64_t TCGRegSet;
>  #define TCG_TARGET_HAS_eqv_i64          0
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
> +#define TCG_TARGET_HAS_clz_i64          0
> +#define TCG_TARGET_HAS_ctz_i64          0
>  #define TCG_TARGET_HAS_deposit_i64      0
>  #define TCG_TARGET_HAS_extract_i64      0
>  #define TCG_TARGET_HAS_sextract_i64     0
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 2065042..0646444 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -74,6 +74,8 @@
>  #define TCG_TARGET_HAS_eqv_i32          0
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> +#define TCG_TARGET_HAS_clz_i32          0
> +#define TCG_TARGET_HAS_ctz_i32          0
>  #define TCG_TARGET_HAS_neg_i32          1
>  #define TCG_TARGET_HAS_not_i32          1
>  #define TCG_TARGET_HAS_orc_i32          0
> @@ -104,6 +106,8 @@
>  #define TCG_TARGET_HAS_eqv_i64          0
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
> +#define TCG_TARGET_HAS_clz_i64          0
> +#define TCG_TARGET_HAS_ctz_i64          0
>  #define TCG_TARGET_HAS_neg_i64          1
>  #define TCG_TARGET_HAS_not_i64          1
>  #define TCG_TARGET_HAS_orc_i64          0


--
Alex Bennée
