Received: from eggs.gnu.org ([2001:4830:134:3::10]:35328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmVN-0002qE-Jf
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmVG-0000zH-NI
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:23:04 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSmVG-0000vo-Ck
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:22:58 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so6014531wrt.11
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:22:58 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-10-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-10-richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 17:22:55 +0000
Message-ID: <87sgzi32fk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 09/37] tcg/i386: Use
 TCG_TARGET_NEED_LDST_OOL_LABELS
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

> Move the entire memory operation out of line.

Given Emilio's numbers is it likely we will want to support both options
given the variability on x86?

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |   2 +-
>  tcg/i386/tcg-target.inc.c | 391 ++++++++++++++++----------------------
>  2 files changed, 162 insertions(+), 231 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 2441658865..1b2d4e1b0d 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -220,7 +220,7 @@ static inline void tb_target_set_jmp_target(uintptr_t=
 tc_ptr,
>  #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
>
>  #ifdef CONFIG_SOFTMMU
> -#define TCG_TARGET_NEED_LDST_LABELS
> +#define TCG_TARGET_NEED_LDST_OOL_LABELS
>  #endif
>  #define TCG_TARGET_NEED_POOL_LABELS
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 50e5dc31b3..5c68cbd43d 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -1643,7 +1643,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
>  }
>
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "tcg-ldst-ool.inc.c"
>
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     int mmu_idx, uintptr_t ra)
> @@ -1656,6 +1656,14 @@ static void * const qemu_ld_helpers[16] =3D {
>      [MO_BEUW] =3D helper_be_lduw_mmu,
>      [MO_BEUL] =3D helper_be_ldul_mmu,
>      [MO_BEQ]  =3D helper_be_ldq_mmu,
> +
> +    [MO_SB]   =3D helper_ret_ldsb_mmu,
> +    [MO_LESW] =3D helper_le_ldsw_mmu,
> +    [MO_BESW] =3D helper_be_ldsw_mmu,
> +#if TCG_TARGET_REG_BITS =3D=3D 64
> +    [MO_LESL] =3D helper_le_ldsl_mmu,
> +    [MO_BESL] =3D helper_be_ldsl_mmu,
> +#endif

Can we mention why these are added in the commit message please?

 rth: why has qemu_ld_helpers been filled out? Did those loads not
    happen before?
<rth> stsquad, previously we performed sign-extensions inline after
    returning from the helper; with the change to a tail call we can't
    do that anymore.
 rth: maybe that could go in the commit message then...


>  };
>
>  /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
> @@ -1765,18 +1773,18 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCG=
Reg addrlo, TCGReg addrhi,
>      }
>
>      /* jne slow_path */
> -    tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
> +    tcg_out_opc(s, OPC_JCC_short + JCC_JNE, 0, 0, 0);
>      label_ptr[0] =3D s->code_ptr;
> -    s->code_ptr +=3D 4;
> +    s->code_ptr +=3D 1;
>
>      if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
>          /* cmp 4(r0), addrhi */
>          tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, 4);
>
>          /* jne slow_path */
> -        tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
> +        tcg_out_opc(s, OPC_JCC_short + JCC_JNE, 0, 0, 0);
>          label_ptr[1] =3D s->code_ptr;
> -        s->code_ptr +=3D 4;
> +        s->code_ptr +=3D 1;
>      }
>
>      /* TLB Hit.  */
> @@ -1788,181 +1796,6 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCG=
Reg addrlo, TCGReg addrhi,
>      return base;
>  }
>
> -/*
> - * Record the context of a call to the out of line helper code for the s=
low path
> - * for a load or store, so that we can later generate the correct helper=
 code
> - */
> -static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx o=
i,
> -                                TCGReg datalo, TCGReg datahi,
> -                                TCGReg addrlo, TCGReg addrhi,
> -                                tcg_insn_unit *raddr,
> -                                tcg_insn_unit **label_ptr)
> -{
> -    TCGLabelQemuLdst *label =3D new_ldst_label(s);
> -
> -    label->is_ld =3D is_ld;
> -    label->oi =3D oi;
> -    label->datalo_reg =3D datalo;
> -    label->datahi_reg =3D datahi;
> -    label->addrlo_reg =3D addrlo;
> -    label->addrhi_reg =3D addrhi;
> -    label->raddr =3D raddr;
> -    label->label_ptr[0] =3D label_ptr[0];
> -    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> -        label->label_ptr[1] =3D label_ptr[1];
> -    }
> -}
> -
> -/*
> - * Generate code for the slow path for a load at the end of block
> - */
> -static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
> -{
> -    TCGMemOpIdx oi =3D l->oi;
> -    TCGMemOp opc =3D get_memop(oi);
> -    TCGReg data_reg;
> -    tcg_insn_unit **label_ptr =3D &l->label_ptr[0];
> -
> -    /* resolve label address */
> -    tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
> -    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> -        tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
> -    }
> -
> -    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> -        int ofs =3D 0;
> -
> -        tcg_out_st(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP, ofs);
> -        ofs +=3D 4;
> -
> -        tcg_out_st(s, TCG_TYPE_I32, l->addrlo_reg, TCG_REG_ESP, ofs);
> -        ofs +=3D 4;
> -
> -        if (TARGET_LONG_BITS =3D=3D 64) {
> -            tcg_out_st(s, TCG_TYPE_I32, l->addrhi_reg, TCG_REG_ESP, ofs);
> -            ofs +=3D 4;
> -        }
> -
> -        tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, ofs);
> -        ofs +=3D 4;
> -
> -        tcg_out_sti(s, TCG_TYPE_PTR, (uintptr_t)l->raddr, TCG_REG_ESP, o=
fs);
> -    } else {
> -        tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_A=
REG0);
> -        /* The second argument is already loaded with addrlo.  */
> -        tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[2], oi);
> -        tcg_out_movi(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[3],
> -                     (uintptr_t)l->raddr);
> -    }
> -
> -    tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)]);
> -
> -    data_reg =3D l->datalo_reg;
> -    switch (opc & MO_SSIZE) {
> -    case MO_SB:
> -        tcg_out_ext8s(s, data_reg, TCG_REG_EAX, P_REXW);
> -        break;
> -    case MO_SW:
> -        tcg_out_ext16s(s, data_reg, TCG_REG_EAX, P_REXW);
> -        break;
> -#if TCG_TARGET_REG_BITS =3D=3D 64
> -    case MO_SL:
> -        tcg_out_ext32s(s, data_reg, TCG_REG_EAX);
> -        break;
> -#endif
> -    case MO_UB:
> -    case MO_UW:
> -        /* Note that the helpers have zero-extended to tcg_target_long. =
 */
> -    case MO_UL:
> -        tcg_out_mov(s, TCG_TYPE_I32, data_reg, TCG_REG_EAX);
> -        break;
> -    case MO_Q:
> -        if (TCG_TARGET_REG_BITS =3D=3D 64) {
> -            tcg_out_mov(s, TCG_TYPE_I64, data_reg, TCG_REG_RAX);
> -        } else if (data_reg =3D=3D TCG_REG_EDX) {
> -            /* xchg %edx, %eax */
> -            tcg_out_opc(s, OPC_XCHG_ax_r32 + TCG_REG_EDX, 0, 0, 0);
> -            tcg_out_mov(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_EAX);
> -        } else {
> -            tcg_out_mov(s, TCG_TYPE_I32, data_reg, TCG_REG_EAX);
> -            tcg_out_mov(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_EDX);
> -        }
> -        break;
> -    default:
> -        tcg_abort();
> -    }
> -
> -    /* Jump to the code corresponding to next IR of qemu_st */
> -    tcg_out_jmp(s, l->raddr);
> -}
> -
> -/*
> - * Generate code for the slow path for a store at the end of block
> - */
> -static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
> -{
> -    TCGMemOpIdx oi =3D l->oi;
> -    TCGMemOp opc =3D get_memop(oi);
> -    TCGMemOp s_bits =3D opc & MO_SIZE;
> -    tcg_insn_unit **label_ptr =3D &l->label_ptr[0];
> -    TCGReg retaddr;
> -
> -    /* resolve label address */
> -    tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
> -    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> -        tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
> -    }
> -
> -    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> -        int ofs =3D 0;
> -
> -        tcg_out_st(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP, ofs);
> -        ofs +=3D 4;
> -
> -        tcg_out_st(s, TCG_TYPE_I32, l->addrlo_reg, TCG_REG_ESP, ofs);
> -        ofs +=3D 4;
> -
> -        if (TARGET_LONG_BITS =3D=3D 64) {
> -            tcg_out_st(s, TCG_TYPE_I32, l->addrhi_reg, TCG_REG_ESP, ofs);
> -            ofs +=3D 4;
> -        }
> -
> -        tcg_out_st(s, TCG_TYPE_I32, l->datalo_reg, TCG_REG_ESP, ofs);
> -        ofs +=3D 4;
> -
> -        if (s_bits =3D=3D MO_64) {
> -            tcg_out_st(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_ESP, ofs);
> -            ofs +=3D 4;
> -        }
> -
> -        tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, ofs);
> -        ofs +=3D 4;
> -
> -        retaddr =3D TCG_REG_EAX;
> -        tcg_out_movi(s, TCG_TYPE_PTR, retaddr, (uintptr_t)l->raddr);
> -        tcg_out_st(s, TCG_TYPE_PTR, retaddr, TCG_REG_ESP, ofs);
> -    } else {
> -        tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_A=
REG0);
> -        /* The second argument is already loaded with addrlo.  */
> -        tcg_out_mov(s, (s_bits =3D=3D MO_64 ? TCG_TYPE_I64 : TCG_TYPE_I3=
2),
> -                    tcg_target_call_iarg_regs[2], l->datalo_reg);
> -        tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[3], oi);
> -
> -        if (ARRAY_SIZE(tcg_target_call_iarg_regs) > 4) {
> -            retaddr =3D tcg_target_call_iarg_regs[4];
> -            tcg_out_movi(s, TCG_TYPE_PTR, retaddr, (uintptr_t)l->raddr);
> -        } else {
> -            retaddr =3D TCG_REG_RAX;
> -            tcg_out_movi(s, TCG_TYPE_PTR, retaddr, (uintptr_t)l->raddr);
> -            tcg_out_st(s, TCG_TYPE_PTR, retaddr, TCG_REG_ESP,
> -                       TCG_TARGET_CALL_STACK_OFFSET);
> -        }
> -    }
> -
> -    /* "Tail call" to the helper, with the return address back inline.  =
*/
> -    tcg_out_push(s, retaddr);
> -    tcg_out_jmp(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
> -}
>  #elif defined(__x86_64__) && defined(__linux__)
>  # include <asm/prctl.h>
>  # include <sys/prctl.h>
> @@ -2091,7 +1924,6 @@ static void tcg_out_qemu_ld(TCGContext *s, const TC=
GArg *args, bool is64)
>      TCGReg datahi __attribute__((unused)) =3D -1;
>      TCGReg addrhi __attribute__((unused)) =3D -1;
>      TCGMemOpIdx oi;
> -    TCGMemOp opc;
>      int i =3D -1;
>
>      datalo =3D args[++i];
> @@ -2103,35 +1935,25 @@ static void tcg_out_qemu_ld(TCGContext *s, const =
TCGArg *args, bool is64)
>          addrhi =3D args[++i];
>      }
>      oi =3D args[++i];
> -    opc =3D get_memop(oi);
>
>  #if defined(CONFIG_SOFTMMU)
> -    {
> -        int mem_index =3D get_mmuidx(oi);
> -        tcg_insn_unit *label_ptr[2];
> -        TCGReg base;
> -
> -        tcg_debug_assert(datalo =3D=3D softmmu_arg(ARG_LDVAL, is64, 0));
> -        if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> -            tcg_debug_assert(datahi =3D=3D softmmu_arg(ARG_LDVAL, is64, =
1));
> -        }
> -        tcg_debug_assert(addrlo =3D=3D softmmu_arg(ARG_ADDR, 0, 0));
> -        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> -            tcg_debug_assert(addrhi =3D=3D softmmu_arg(ARG_ADDR, 0, 1));
> -        }
> -
> -        base =3D tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
> -                                label_ptr, offsetof(CPUTLBEntry, addr_re=
ad));
> -
> -        /* TLB Hit.  */
> -        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, opc);
> -
> -        /* Record the current context of a load into ldst label */
> -        add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
> -                            s->code_ptr, label_ptr);
> +    /* Assert that we've set up the constraints properly.  */
> +    tcg_debug_assert(datalo =3D=3D softmmu_arg(ARG_LDVAL, is64, 0));
> +    if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> +        tcg_debug_assert(datahi =3D=3D softmmu_arg(ARG_LDVAL, is64, 1));
>      }
> +    tcg_debug_assert(addrlo =3D=3D softmmu_arg(ARG_ADDR, 0, 0));
> +    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +        tcg_debug_assert(addrhi =3D=3D softmmu_arg(ARG_ADDR, 0, 1));
> +    }
> +
> +    /* Call to thunk.  */
> +    tcg_out8(s, OPC_CALL_Jz);
> +    add_ldst_ool_label(s, true, is64, oi, R_386_PC32, -4);
> +    s->code_ptr +=3D 4;
>  #else
>      {
> +        TCGMemOp opc =3D get_memop(oi);
>          int32_t offset =3D guest_base;
>          TCGReg base =3D addrlo;
>          int index =3D -1;
> @@ -2246,7 +2068,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TC=
GArg *args, bool is64)
>      TCGReg datahi __attribute__((unused)) =3D -1;
>      TCGReg addrhi __attribute__((unused)) =3D -1;
>      TCGMemOpIdx oi;
> -    TCGMemOp opc;
>      int i =3D -1;
>
>      datalo =3D args[++i];
> @@ -2258,35 +2079,25 @@ static void tcg_out_qemu_st(TCGContext *s, const =
TCGArg *args, bool is64)
>          addrhi =3D args[++i];
>      }
>      oi =3D args[++i];
> -    opc =3D get_memop(oi);
>
>  #if defined(CONFIG_SOFTMMU)
> -    {
> -        int mem_index =3D get_mmuidx(oi);
> -        tcg_insn_unit *label_ptr[2];
> -        TCGReg base;
> -
> -        tcg_debug_assert(datalo =3D=3D softmmu_arg(ARG_STVAL, is64, 0));
> -        if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> -            tcg_debug_assert(datahi =3D=3D softmmu_arg(ARG_STVAL, is64, =
1));
> -        }
> -        tcg_debug_assert(addrlo =3D=3D softmmu_arg(ARG_ADDR, 0, 0));
> -        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> -            tcg_debug_assert(addrhi =3D=3D softmmu_arg(ARG_ADDR, 0, 1));
> -        }
> -
> -        base =3D tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
> -                                label_ptr, offsetof(CPUTLBEntry, addr_wr=
ite));
> -
> -        /* TLB Hit.  */
> -        tcg_out_qemu_st_direct(s, datalo, datahi, base, 0, 0, opc);
> -
> -        /* Record the current context of a store into ldst label */
> -        add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
> -                            s->code_ptr, label_ptr);
> +    /* Assert that we've set up the constraints properly.  */
> +    tcg_debug_assert(datalo =3D=3D softmmu_arg(ARG_STVAL, is64, 0));
> +    if (TCG_TARGET_REG_BITS =3D=3D 32 && is64) {
> +        tcg_debug_assert(datahi =3D=3D softmmu_arg(ARG_STVAL, is64, 1));
>      }
> +    tcg_debug_assert(addrlo =3D=3D softmmu_arg(ARG_ADDR, 0, 0));
> +    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +        tcg_debug_assert(addrhi =3D=3D softmmu_arg(ARG_ADDR, 0, 1));
> +    }
> +
> +    /* Call to thunk.  */
> +    tcg_out8(s, OPC_CALL_Jz);
> +    add_ldst_ool_label(s, false, is64, oi, R_386_PC32, -4);
> +    s->code_ptr +=3D 4;
>  #else
>      {
> +        TCGMemOp opc =3D get_memop(oi);
>          int32_t offset =3D guest_base;
>          TCGReg base =3D addrlo;
>          int seg =3D 0;
> @@ -2321,6 +2132,126 @@ static void tcg_out_qemu_st(TCGContext *s, const =
TCGArg *args, bool is64)
>  #endif
>  }
>
> +#if defined(CONFIG_SOFTMMU)
> +/*
> + * Generate code for an out-of-line thunk performing a load.
> + */
> +static tcg_insn_unit *tcg_out_qemu_ldst_ool(TCGContext *s, bool is_ld,
> +                                            bool is_64, TCGMemOpIdx oi)
> +{
> +    TCGMemOp opc =3D get_memop(oi);
> +    int mem_index =3D get_mmuidx(oi);
> +    tcg_insn_unit *label_ptr[2], *thunk;
> +    TCGReg datalo, addrlo, base;
> +    TCGReg datahi __attribute__((unused)) =3D -1;
> +    TCGReg addrhi __attribute__((unused)) =3D -1;
> +    int i;
> +
> +    /* Since we're amortizing the cost, align the thunk.  */
> +    thunk =3D QEMU_ALIGN_PTR_UP(s->code_ptr, 16);
> +    if (thunk !=3D s->code_ptr) {
> +        memset(s->code_ptr, 0x90, thunk - s->code_ptr);
> +        s->code_ptr =3D thunk;
> +    }
> +
> +    /* Discover where the inputs are held.  */
> +    addrlo =3D softmmu_arg(ARG_ADDR, 0, 0);
> +    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +        addrhi =3D softmmu_arg(ARG_ADDR, 0, 1);
> +    }
> +    datalo =3D softmmu_arg(is_ld ? ARG_LDVAL : ARG_STVAL, is_64, 0);
> +    if (TCG_TARGET_REG_BITS =3D=3D 32 && is_64) {
> +        datahi =3D softmmu_arg(is_ld ? ARG_LDVAL : ARG_STVAL, is_64, 1);
> +    }
> +
> +    base =3D tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc, label_p=
tr,
> +                            is_ld ? offsetof(CPUTLBEntry, addr_read)
> +                            : offsetof(CPUTLBEntry, addr_write));
> +
> +    /* TLB Hit.  */
> +    if (is_ld) {
> +        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, opc);
> +    } else {
> +        tcg_out_qemu_st_direct(s, datalo, datahi, base, 0, 0, opc);
> +    }
> +    tcg_out_opc(s, OPC_RET, 0, 0, 0);
> +
> +    /* TLB Miss.  */
> +
> +    /* resolve label address */
> +    tcg_patch8(label_ptr[0], s->code_ptr - label_ptr[0] - 1);
> +    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> +        tcg_patch8(label_ptr[1], s->code_ptr - label_ptr[1] - 1);
> +    }
> +
> +    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> +        /* Copy the return address into a temporary.  */
> +        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_ESP, 0);
> +        i =3D 4;
> +
> +        tcg_out_st(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP, i);
> +        i +=3D 4;
> +
> +        tcg_out_st(s, TCG_TYPE_I32, addrlo, TCG_REG_ESP, i);
> +        i +=3D 4;
> +
> +        if (TARGET_LONG_BITS =3D=3D 64) {
> +            tcg_out_st(s, TCG_TYPE_I32, addrhi, TCG_REG_ESP, i);
> +            i +=3D 4;
> +        }
> +
> +        if (!is_ld) {
> +            tcg_out_st(s, TCG_TYPE_I32, datalo, TCG_REG_ESP, i);
> +            i +=3D 4;
> +
> +            if (is_64) {
> +                tcg_out_st(s, TCG_TYPE_I32, datahi, TCG_REG_ESP, i);
> +                i +=3D 4;
> +            }
> +        }
> +
> +        tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, i);
> +        i +=3D 4;
> +
> +        tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_ESP, i);
> +    } else {
> +        tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_A=
REG0);
> +
> +        /* The address and data values have been placed by constraints. =
 */
> +        tcg_debug_assert(addrlo =3D=3D tcg_target_call_iarg_regs[1]);
> +        if (is_ld) {
> +            i =3D 2;
> +        } else {
> +            tcg_debug_assert(datalo =3D=3D tcg_target_call_iarg_regs[2]);
> +            i =3D 3;
> +        }
> +
> +        tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[i++], oi=
);
> +
> +        /* Copy the return address from the stack to the rvalue argument.
> +         * WIN64 runs out of argument registers for stores.
> +         */
> +        if (i < (int)ARRAY_SIZE(tcg_target_call_iarg_regs)) {
> +            tcg_out_ld(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[i],
> +                       TCG_REG_ESP, 0);
> +        } else {
> +            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_RAX, TCG_REG_ESP, 0);
> +            tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_RAX, TCG_REG_ESP,
> +                       TCG_TARGET_CALL_STACK_OFFSET + 8);
> +        }
> +    }
> +
> +    /* Tail call to the helper.  */
> +    if (is_ld) {
> +        tcg_out_jmp(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
> +    } else {
> +        tcg_out_jmp(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
> +    }
> +
> +    return thunk;
> +}
> +#endif
> +
>  static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>                                const TCGArg *args, const int *const_args)
>  {

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--
Alex Benn=C3=A9e
