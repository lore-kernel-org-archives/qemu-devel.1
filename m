Received: from eggs.gnu.org ([2001:4830:134:3::10]:45879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSlSY-00059e-Fj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSlSV-0000HH-PG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:16:06 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSlSV-0000Fj-HD
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:16:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id k198so6289915wmd.3
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:16:03 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-9-richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 16:16:00 +0000
Message-ID: <87tvjy35j3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 08/37] tcg/i386: Force
 qemu_ld/st arguments into fixed registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com


Richard Henderson <richard.henderson@linaro.org> writes:

> This is an incremental step toward moving the qemu_ld/st
> code sequence out of line.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.inc.c | 203 +++++++++++++++++++++++++++++++-------
>  1 file changed, 169 insertions(+), 34 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 07df4b2b12..50e5dc31b3 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -171,6 +171,80 @@ static bool have_lzcnt;
>
>  static tcg_insn_unit *tb_ret_addr;
>
> +typedef enum {
> +    ARG_ADDR,
> +    ARG_STVAL,
> +    ARG_LDVAL,
> +} QemuMemArgType;
> +
> +#ifdef CONFIG_SOFTMMU
> +/*
> + * Constraint to choose a particular register.  This is used for softmmu
> + * loads and stores.  Registers with no assignment get an empty string.
> + */
> +static const char * const one_reg_constraint[TCG_TARGET_NB_REGS] =3D {
> +    [TCG_REG_EAX] =3D "a",
> +    [TCG_REG_EBX] =3D "b",
> +    [TCG_REG_ECX] =3D "c",
> +    [TCG_REG_EDX] =3D "d",
> +    [TCG_REG_ESI] =3D "S",
> +    [TCG_REG_EDI] =3D "D",
> +#if TCG_TARGET_REG_BITS =3D=3D 64
> +    [TCG_REG_R8]  =3D "E",
> +    [TCG_REG_R9]  =3D "N",
> +#endif
> +};
> +
> +/*
> + * Calling convention for the softmmu load and store thunks.
> + *
> + * For 64-bit, we mostly use the host calling convention, therefore the
> + * real first argument is reserved for the ENV parameter that is passed
> + * on to the slow path helpers.
> + *
> + * For 32-bit, the host calling convention is stack based; we invent a
> + * private convention that uses 4 of the 6 available host registers.
> + * We reserve EAX and EDX as temporaries for use by the thunk, we require
> + * INDEX_op_qemu_st_i32 to have a 'q' register from which to store, and
> + * further complicate this last by wanting a call-clobbered for that sto=
re.
> + * The 'q' requirement allows MO_8 stores at all; the call-clobbered part
> + * allows bswap to operate in-place, clobbering the input.
> + */
> +static TCGReg softmmu_arg(QemuMemArgType type, bool is_64, int hi)
> +{
> +    switch (type) {
> +    case ARG_ADDR:
> +        tcg_debug_assert(!hi || TARGET_LONG_BITS > TCG_TARGET_REG_BITS);
> +        if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +            return tcg_target_call_iarg_regs[1];
> +        } else {
> +            return hi ? TCG_REG_EDI : TCG_REG_ESI;
> +        }
> +    case ARG_STVAL:
> +        tcg_debug_assert(!hi || (TCG_TARGET_REG_BITS =3D=3D 32 && is_64)=
);
> +        if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +            return tcg_target_call_iarg_regs[2];
> +        } else {
> +            return hi ? TCG_REG_EBX : TCG_REG_ECX;
> +        }
> +    case ARG_LDVAL:
> +        tcg_debug_assert(!hi || (TCG_TARGET_REG_BITS =3D=3D 32 && is_64)=
);
> +        return tcg_target_call_oarg_regs[hi];
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, =
int hi)
> +{
> +    return one_reg_constraint[softmmu_arg(type, is_64, hi)];
> +}
> +#else
> +static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, =
int hi)
> +{
> +    return "L";
> +}
> +#endif /* CONFIG_SOFTMMU */
> +
>  static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
> @@ -1680,11 +1754,15 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCG=
Reg addrlo, TCGReg addrhi,
>         copies the entire guest address for the slow path, while truncati=
on
>         for the 32-bit host happens with the fastpath ADDL below.  */
>      if (TCG_TARGET_REG_BITS =3D=3D 64) {
> -        base =3D tcg_target_call_iarg_regs[1];
> +        tcg_debug_assert(addrlo =3D=3D tcg_target_call_iarg_regs[1]);
> +        if (TARGET_LONG_BITS =3D=3D 32) {
> +            tcg_out_ext32u(s, addrlo, addrlo);
> +        }
> +        base =3D addrlo;
>      } else {
>          base =3D r1;
> +        tcg_out_mov(s, ttype, base, addrlo);
>      }
> -    tcg_out_mov(s, ttype, base, addrlo);
>
>      /* jne slow_path */
>      tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
> @@ -2009,16 +2087,22 @@ static void tcg_out_qemu_ld_direct(TCGContext *s,=
 TCGReg datalo, TCGReg datahi,
>     common. */
>  static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
>  {
> -    TCGReg datalo, datahi, addrlo;
> -    TCGReg addrhi __attribute__((unused));
> +    TCGReg datalo, addrlo;
> +    TCGReg datahi __attribute__((unused)) =3D -1;
> +    TCGReg addrhi __attribute__((unused)) =3D -1;
>      TCGMemOpIdx oi;
>      TCGMemOp opc;
> +    int i =3D -1;
>
> -    datalo =3D *args++;
> -    datahi =3D (TCG_TARGET_REG_BITS =3D=3D 32 && is64 ? *args++ : 0);
> -    addrlo =3D *args++;
> -    addrhi =3D (TARGET_LONG_BITS > TCG_TARGET_REG_BITS ? *args++ : 0);
> -    oi =3D *args++;
> +    datalo =3D args[++i];

Swapping to i =3D -1 and pre-indexes seems a little unnatural here
compared to a more normal 0 and i++ unless there was a specific reason
to have i in the range of 2-4?

> +    if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> +        datahi =3D args[++i];
> +    }
> +    addrlo =3D args[++i];
> +    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +        addrhi =3D args[++i];
> +    }
> +    oi =3D args[++i];
>      opc =3D get_memop(oi);
>
>  #if defined(CONFIG_SOFTMMU)
> @@ -2027,6 +2111,15 @@ static void tcg_out_qemu_ld(TCGContext *s, const T=
CGArg *args, bool is64)
>          tcg_insn_unit *label_ptr[2];
>          TCGReg base;
>
> +        tcg_debug_assert(datalo =3D=3D softmmu_arg(ARG_LDVAL, is64, 0));
> +        if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> +            tcg_debug_assert(datahi =3D=3D softmmu_arg(ARG_LDVAL, is64, =
1));
> +        }
> +        tcg_debug_assert(addrlo =3D=3D softmmu_arg(ARG_ADDR, 0, 0));
> +        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +            tcg_debug_assert(addrhi =3D=3D softmmu_arg(ARG_ADDR, 0, 1));
> +        }
> +
>          base =3D tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
>                                  label_ptr, offsetof(CPUTLBEntry, addr_re=
ad));
>
> @@ -2149,16 +2242,22 @@ static void tcg_out_qemu_st_direct(TCGContext *s,=
 TCGReg datalo, TCGReg datahi,
>
>  static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
>  {
> -    TCGReg datalo, datahi, addrlo;
> -    TCGReg addrhi __attribute__((unused));
> +    TCGReg datalo, addrlo;
> +    TCGReg datahi __attribute__((unused)) =3D -1;
> +    TCGReg addrhi __attribute__((unused)) =3D -1;
>      TCGMemOpIdx oi;
>      TCGMemOp opc;
> +    int i =3D -1;

And again here

>
> -    datalo =3D *args++;
> -    datahi =3D (TCG_TARGET_REG_BITS =3D=3D 32 && is64 ? *args++ : 0);
> -    addrlo =3D *args++;
> -    addrhi =3D (TARGET_LONG_BITS > TCG_TARGET_REG_BITS ? *args++ : 0);
> -    oi =3D *args++;
> +    datalo =3D args[++i];
> +    if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> +        datahi =3D args[++i];
> +    }
> +    addrlo =3D args[++i];
> +    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +        addrhi =3D args[++i];
> +    }
> +    oi =3D args[++i];
>      opc =3D get_memop(oi);
>
>  #if defined(CONFIG_SOFTMMU)
> @@ -2167,6 +2266,15 @@ static void tcg_out_qemu_st(TCGContext *s, const T=
CGArg *args, bool is64)
>          tcg_insn_unit *label_ptr[2];
>          TCGReg base;
>
> +        tcg_debug_assert(datalo =3D=3D softmmu_arg(ARG_STVAL, is64, 0));
> +        if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> +            tcg_debug_assert(datahi =3D=3D softmmu_arg(ARG_STVAL, is64, =
1));
> +        }
> +        tcg_debug_assert(addrlo =3D=3D softmmu_arg(ARG_ADDR, 0, 0));
> +        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +            tcg_debug_assert(addrhi =3D=3D softmmu_arg(ARG_ADDR, 0, 1));
> +        }
> +
>          base =3D tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
>                                  label_ptr, offsetof(CPUTLBEntry, addr_wr=
ite));
>
> @@ -2836,15 +2944,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCG=
Opcode op)
>      static const TCGTargetOpDef r_r_re =3D { .args_ct_str =3D { "r", "r"=
, "re" } };
>      static const TCGTargetOpDef r_0_re =3D { .args_ct_str =3D { "r", "0"=
, "re" } };
>      static const TCGTargetOpDef r_0_ci =3D { .args_ct_str =3D { "r", "0"=
, "ci" } };
> -    static const TCGTargetOpDef r_L =3D { .args_ct_str =3D { "r", "L" } =
};
> -    static const TCGTargetOpDef L_L =3D { .args_ct_str =3D { "L", "L" } =
};
> -    static const TCGTargetOpDef r_L_L =3D { .args_ct_str =3D { "r", "L",=
 "L" } };
> -    static const TCGTargetOpDef r_r_L =3D { .args_ct_str =3D { "r", "r",=
 "L" } };
> -    static const TCGTargetOpDef L_L_L =3D { .args_ct_str =3D { "L", "L",=
 "L" } };
> -    static const TCGTargetOpDef r_r_L_L
> -        =3D { .args_ct_str =3D { "r", "r", "L", "L" } };
> -    static const TCGTargetOpDef L_L_L_L
> -        =3D { .args_ct_str =3D { "L", "L", "L", "L" } };
>      static const TCGTargetOpDef x_x =3D { .args_ct_str =3D { "x", "x" } =
};
>      static const TCGTargetOpDef x_x_x =3D { .args_ct_str =3D { "x", "x",=
 "x" } };
>      static const TCGTargetOpDef x_x_x_x
> @@ -3026,17 +3125,53 @@ static const TCGTargetOpDef *tcg_target_op_def(TC=
GOpcode op)
>          }
>
>      case INDEX_op_qemu_ld_i32:
> -        return TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
> -    case INDEX_op_qemu_st_i32:
> -        return TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &L_L : &L_L_L;
> +        {
> +            static TCGTargetOpDef ld32;
> +            int i;
> +
> +            ld32.args_ct_str[0] =3D constrain_memop_arg(ARG_LDVAL, 0, 0);
> +            for (i =3D 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS;
>      ++i) {

This formulation is a bit weird to follow, at first I thought it was
going to overflow TCG_MAX_OP_ARGS until I realised what it was doing.
Maybe a helper function would be a little clearer:

               for (src_reg =3D 0; src_reg < tcg_target_regs_for(TARGET_LON=
G_BITS), ++i)

Same comment applies bellow.

> +                ld32.args_ct_str[i + 1] =3D constrain_memop_arg(ARG_ADDR=
, 0, i);
> +            }
> +            return &ld32;
> +        }
>      case INDEX_op_qemu_ld_i64:
> -        return (TCG_TARGET_REG_BITS =3D=3D 64 ? &r_L
> -                : TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &r_r_L
> -                : &r_r_L_L);
> +        {
> +            static TCGTargetOpDef ld64;
> +            int i, j =3D 0;
> +
> +            for (i =3D 0; i * TCG_TARGET_REG_BITS < 64; ++i) {
> +                ld64.args_ct_str[j++] =3D constrain_memop_arg(ARG_LDVAL,=
 1, i);
> +            }
> +            for (i =3D 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS; ++=
i) {
> +                ld64.args_ct_str[j++] =3D constrain_memop_arg(ARG_ADDR, =
0, i);
> +            }
> +            return &ld64;
> +        }
> +    case INDEX_op_qemu_st_i32:
> +        {
> +            static TCGTargetOpDef st32;
> +            int i;
> +
> +            st32.args_ct_str[0] =3D constrain_memop_arg(ARG_STVAL, 0, 0);
> +            for (i =3D 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS; ++=
i) {
> +                st32.args_ct_str[i + 1] =3D constrain_memop_arg(ARG_ADDR=
, 0, i);
> +            }
> +            return &st32;
> +        }
>      case INDEX_op_qemu_st_i64:
> -        return (TCG_TARGET_REG_BITS =3D=3D 64 ? &L_L
> -                : TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &L_L_L
> -                : &L_L_L_L);
> +        {
> +            static TCGTargetOpDef st64;
> +            int i, j =3D 0;
> +
> +            for (i =3D 0; i * TCG_TARGET_REG_BITS < 64; ++i) {
> +                st64.args_ct_str[j++] =3D constrain_memop_arg(ARG_STVAL,=
 1, i);
> +            }
> +            for (i =3D 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS; ++=
i) {
> +                st64.args_ct_str[j++] =3D constrain_memop_arg(ARG_ADDR, =
0, i);
> +            }
> +            return &st64;
> +        }
>
>      case INDEX_op_brcond2_i32:
>          {


--
Alex Benn=C3=A9e
