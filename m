Received: from eggs.gnu.org ([209.51.188.92]:36202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9m3-0003lT-5B
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9m0-0005MF-Qb
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:16:31 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gn9ls-0005FA-Uc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:16:22 -0500
Received: by mail-pl1-x642.google.com with SMTP id w4so5178994plz.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:16:17 -0800 (PST)
References: <20190123225705.28963-1-richard.henderson@linaro.org>
	<20190123225705.28963-9-richard.henderson@linaro.org>
From: Alistair <alistair23@gmail.com>
Message-ID: <ec37df14-eee4-9220-43b5-76bbcad547e9@gmail.com>
Date: Fri, 25 Jan 2019 14:16:14 -0800
MIME-Version: 1.0
In-Reply-To: <20190123225705.28963-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/13] tcg/riscv: enable dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

On 1/23/19 2:57 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   tcg/riscv/tcg-target.h     |   2 +-
>   tcg/riscv/tcg-target.inc.c | 126 ++++++++++++++++---------------------
>   2 files changed, 56 insertions(+), 72 deletions(-)
> 
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 1eb032626c..83b123ca03 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -33,7 +33,7 @@
>   
>   #define TCG_TARGET_INSN_UNIT_SIZE 4
>   #define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
> -#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
> +#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
>   #define TCG_TARGET_NB_REGS 32
>   
>   typedef enum {
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 6cf8de32b5..b785f4acb7 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -958,6 +958,17 @@ static void * const qemu_st_helpers[16] = {
>       [MO_BEQ]  = helper_be_stq_mmu,
>   };
>   
> +/* We don't support oversize guests */
> +QEMU_BUILD_BUG_ON(TCG_TARGET_REG_BITS < TARGET_LONG_BITS);
> +
> +/* We expect tlb_mask to be before tlb_table.  */
> +QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
> +                  offsetof(CPUArchState, tlb_mask));
> +
> +/* We expect tlb_mask to be "near" tlb_table.  */
> +QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) -
> +                  offsetof(CPUArchState, tlb_mask) >= 0x800);
> +
>   static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
>                                TCGReg addrh, TCGMemOpIdx oi,
>                                tcg_insn_unit **label_ptr, bool is_load)
> @@ -965,94 +976,67 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
>       TCGMemOp opc = get_memop(oi);
>       unsigned s_bits = opc & MO_SIZE;
>       unsigned a_bits = get_alignment_bits(opc);
> -    target_ulong mask;
> +    tcg_target_long compare_mask;
>       int mem_index = get_mmuidx(oi);
> -    int cmp_off
> -        = (is_load
> -           ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
> -           : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
> -    int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
> -    RISCVInsn load_cmp_op = (TARGET_LONG_BITS == 64 ? OPC_LD :
> -                             TCG_TARGET_REG_BITS == 64 ? OPC_LWU : OPC_LW);
> -    RISCVInsn load_add_op = TCG_TARGET_REG_BITS == 64 ? OPC_LD : OPC_LW;
> -    TCGReg base = TCG_AREG0;
> +    int mask_off, table_off;
> +    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
>   
> -    /* We don't support oversize guests */
> -    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
> -        g_assert_not_reached();
> +    mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
> +    table_off = offsetof(CPUArchState, tlb_table[mem_index]);
> +    if (table_off > 0x7ff) {
> +        int mask_hi = mask_off - sextreg(mask_off, 0, 12);
> +        int table_hi = table_off - sextreg(table_off, 0, 12);
> +
> +        if (likely(mask_hi == table_hi)) {
> +            mask_base = table_base = TCG_REG_TMP1;
> +            tcg_out_opc_upper(s, OPC_LUI, mask_base, mask_hi);
> +            tcg_out_opc_reg(s, OPC_ADD, mask_base, mask_base, TCG_AREG0);
> +            mask_off -= mask_hi;
> +            table_off -= mask_hi;
> +        } else {
> +            mask_base = TCG_REG_TMP0;
> +            table_base = TCG_REG_TMP1;
> +            tcg_out_opc_upper(s, OPC_LUI, mask_base, mask_hi);
> +            tcg_out_opc_reg(s, OPC_ADD, mask_base, mask_base, TCG_AREG0);
> +            table_off -= mask_off;
> +            mask_off -= mask_hi;
> +            tcg_out_opc_imm(s, OPC_ADDI, table_base, mask_base, mask_off);
> +        }
>       }
>   
> +    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_off);
> +    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_off);
> +
> +    tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addrl,
> +                    TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
> +    tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
> +    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
> +
> +    /* Load the tlb comparator and the addend.  */
> +    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP0, TCG_REG_TMP2,
> +               is_load ? offsetof(CPUTLBEntry, addr_read)
> +               : offsetof(CPUTLBEntry, addr_write));
> +    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
> +               offsetof(CPUTLBEntry, addend));
> +
>       /* We don't support unaligned accesses. */
>       if (a_bits < s_bits) {
>           a_bits = s_bits;
>       }
> -    mask = (target_ulong)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
> -
> -
> -    /* Compensate for very large offsets.  */
> -    if (add_off >= 0x1000) {
> -        int adj;
> -        base = TCG_REG_TMP2;
> -        if (cmp_off <= 2 * 0xfff) {
> -            adj = 0xfff;
> -            tcg_out_opc_imm(s, OPC_ADDI, base, TCG_AREG0, adj);
> -        } else {
> -            adj = cmp_off - sextreg(cmp_off, 0, 12);
> -            tcg_debug_assert(add_off - adj >= -0x1000
> -                             && add_off - adj < 0x1000);
> -
> -            tcg_out_opc_upper(s, OPC_LUI, base, adj);
> -            tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_AREG0);
> -        }
> -        add_off -= adj;
> -        cmp_off -= adj;
> -    }
> -
> -    /* Extract the page index.  */
> -    if (CPU_TLB_BITS + CPU_TLB_ENTRY_BITS < 12) {
> -        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, addrl,
> -                        TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
> -        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP0, TCG_REG_TMP0,
> -                        MAKE_64BIT_MASK(CPU_TLB_ENTRY_BITS, CPU_TLB_BITS));
> -    } else if (TARGET_PAGE_BITS >= 12) {
> -        tcg_out_opc_upper(s, OPC_LUI, TCG_REG_TMP0,
> -                          MAKE_64BIT_MASK(TARGET_PAGE_BITS, CPU_TLB_BITS));
> -        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP0, TCG_REG_TMP0, addrl);
> -        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, TCG_REG_TMP0,
> -                        CPU_TLB_BITS - CPU_TLB_ENTRY_BITS);
> -    } else {
> -        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, addrl, TARGET_PAGE_BITS);
> -        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP0, TCG_REG_TMP0,
> -                        MAKE_64BIT_MASK(0, CPU_TLB_BITS));
> -        tcg_out_opc_imm(s, OPC_SLLI, TCG_REG_TMP0, TCG_REG_TMP0,
> -                        CPU_TLB_ENTRY_BITS);
> -    }
> -
> -    /* Add that to the base address to index the tlb.  */
> -    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, base, TCG_REG_TMP0);
> -    base = TCG_REG_TMP2;
> -
> -    /* Load the tlb comparator and the addend.  */
> -    tcg_out_ldst(s, load_cmp_op, TCG_REG_TMP0, base, cmp_off);
> -    tcg_out_ldst(s, load_add_op, TCG_REG_TMP2, base, add_off);
> -
>       /* Clear the non-page, non-alignment bits from the address.  */
> -    if (mask == sextreg(mask, 0, 12)) {
> -        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addrl, mask);
> +    compare_mask = (tcg_target_long)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
> +    if (compare_mask == sextreg(compare_mask, 0, 12)) {
> +        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addrl, compare_mask);
>       } else {
> -        tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, mask);
> +        tcg_out_movi(s, TCG_TYPE_TL, TCG_REG_TMP1, compare_mask);
>           tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP1, TCG_REG_TMP1, addrl);
> -     }
> +    }
>   
>       /* Compare masked address with the TLB entry. */
>       label_ptr[0] = s->code_ptr;
>       tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
>       /* NOP to allow patching later */
>       tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
> -    /* TODO: Move this out of line
> -     * see:
> -     *   https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02234.html
> -     */
>   
>       /* TLB Hit - translate address using addend.  */
>       if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
> 
