Received: from eggs.gnu.org ([209.51.188.92]:36162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn6u8-00048p-AC
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn6u2-0007fu-63
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:12:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn6tz-0007YV-5f
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:12:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id d15so7812764wmb.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 11:12:15 -0800 (PST)
References: <20190123225705.28963-1-richard.henderson@linaro.org>
	<20190123225705.28963-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190123225705.28963-5-richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 19:12:12 +0000
Message-ID: <87h8dwzh4j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/13] tcg/aarch64: enable dynamic TLB
 sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.h     |   2 +-
>  tcg/aarch64/tcg-target.inc.c | 100 +++++++++++++++++++++--------------
>  2 files changed, 60 insertions(+), 42 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 68868a27eb..5085a81060 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -15,7 +15,7 @@
>
>  #define TCG_TARGET_INSN_UNIT_SIZE  4
>  #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
> -#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
> +#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
>  #undef TCG_TARGET_STACK_GROWSUP
>
>  typedef enum {
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index ee0d5819af..d57f9e500f 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -498,6 +498,9 @@ typedef enum {
>      I3510_EON       =3D 0x4a200000,
>      I3510_ANDS      =3D 0x6a000000,
>
> +    /* Logical shifted register instructions (with a shift).  */
> +    I3502S_AND_LSR  =3D I3510_AND | (1 << 22),
> +
>      /* AdvSIMD copy */
>      I3605_DUP      =3D 0x0e000400,
>      I3605_INS      =3D 0x4e001c00,
> @@ -1448,6 +1451,14 @@ static void add_qemu_ldst_label(TCGContext *s, boo=
l is_ld, TCGMemOpIdx oi,
>      label->label_ptr[0] =3D label_ptr;
>  }
>
> +/* We expect tlb_mask to be before tlb_table.  */
> +QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
> +                  offsetof(CPUArchState, tlb_mask));
> +
> +/* We expect to use a 24-bit unsigned offset from ENV.  */
> +QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1])
> +                  > 0xffffff);
> +
>  /* Load and compare a TLB entry, emitting the conditional jump to the
>     slow path for the failure case, which will be patched later when fina=
lizing
>     the slow path. Generated code returns the host addend in X1,
> @@ -1456,15 +1467,55 @@ static void tcg_out_tlb_read(TCGContext *s, TCGRe=
g addr_reg, TCGMemOp opc,
>                               tcg_insn_unit **label_ptr, int mem_index,
>                               bool is_read)
>  {
> -    int tlb_offset =3D is_read ?
> -        offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
> -        : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write);
> +    int mask_ofs =3D offsetof(CPUArchState, tlb_mask[mem_index]);
> +    int table_ofs =3D offsetof(CPUArchState, tlb_table[mem_index]);
>      unsigned a_bits =3D get_alignment_bits(opc);
>      unsigned s_bits =3D opc & MO_SIZE;
>      unsigned a_mask =3D (1u << a_bits) - 1;
>      unsigned s_mask =3D (1u << s_bits) - 1;
> -    TCGReg base =3D TCG_AREG0, x3;
> -    uint64_t tlb_mask;
> +    TCGReg mask_base =3D TCG_AREG0, table_base =3D TCG_AREG0, x3;
> +    TCGType mask_type;
> +    uint64_t compare_mask;
> +
> +    if (table_ofs > 0xfff) {
> +        int table_hi =3D table_ofs & ~0xfff;
> +        int mask_hi =3D mask_ofs & ~0xfff;

Isn't there a #define for this number here?

> +
> +        table_base =3D TCG_REG_X1;
> +        if (mask_hi =3D=3D table_hi) {
> +            mask_base =3D table_base;
> +        } else if (mask_hi) {
> +            mask_base =3D TCG_REG_X0;
> +            tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64,
> +                         mask_base, TCG_AREG0, mask_hi);
> +        }
> +        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64,
> +                     table_base, TCG_AREG0, table_hi);
> +        mask_ofs -=3D mask_hi;
> +        table_ofs -=3D table_hi;
> +    }
> +
> +    mask_type =3D (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32
> +                 ? TCG_TYPE_I64 : TCG_TYPE_I32);
> +
> +    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
> +    tcg_out_ld(s, mask_type, TCG_REG_X0, mask_base, mask_ofs);
> +    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, table_base, table_ofs);
> +
> +    /* Extract the TLB index from the address into X0.  */
> +    tcg_out_insn(s, 3502S, AND_LSR, mask_type =3D=3D TCG_TYPE_I64,
> +                 TCG_REG_X0, TCG_REG_X0, addr_reg,
> +                 TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
> +
> +    /* Add the tlb_table pointer, creating the CPUTLBEntry address into =
X1.  */
> +    tcg_out_insn(s, 3502, ADD, 1, TCG_REG_X1, TCG_REG_X1, TCG_REG_X0);
> +
> +    /* Load the tlb comparator into X0, and the fast path addend into X1=
.  */
> +    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_X0, TCG_REG_X1, is_read
> +               ? offsetof(CPUTLBEntry, addr_read)
> +               : offsetof(CPUTLBEntry, addr_write));
> +    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, TCG_REG_X1,
> +               offsetof(CPUTLBEntry, addend));
>
>      /* For aligned accesses, we check the first byte and include the ali=
gnment
>         bits within the address.  For unaligned access, we check that we =
don't
> @@ -1476,47 +1527,14 @@ static void tcg_out_tlb_read(TCGContext *s, TCGRe=
g addr_reg, TCGMemOp opc,
>                       TCG_REG_X3, addr_reg, s_mask - a_mask);
>          x3 =3D TCG_REG_X3;
>      }
> -    tlb_mask =3D (uint64_t)TARGET_PAGE_MASK | a_mask;
> -
> -    /* Extract the TLB index from the address into X0.
> -       X0<CPU_TLB_BITS:0> =3D
> -       addr_reg<TARGET_PAGE_BITS+CPU_TLB_BITS:TARGET_PAGE_BITS> */
> -    tcg_out_ubfm(s, TARGET_LONG_BITS =3D=3D 64, TCG_REG_X0, addr_reg,
> -                 TARGET_PAGE_BITS, TARGET_PAGE_BITS + CPU_TLB_BITS);
> +    compare_mask =3D (uint64_t)TARGET_PAGE_MASK | a_mask;
>
>      /* Store the page mask part of the address into X3.  */
>      tcg_out_logicali(s, I3404_ANDI, TARGET_LONG_BITS =3D=3D 64,
> -                     TCG_REG_X3, x3, tlb_mask);
> -
> -    /* Add any "high bits" from the tlb offset to the env address into X=
2,
> -       to take advantage of the LSL12 form of the ADDI instruction.
> -       X2 =3D env + (tlb_offset & 0xfff000) */
> -    if (tlb_offset & 0xfff000) {
> -        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_X2, base,
> -                     tlb_offset & 0xfff000);
> -        base =3D TCG_REG_X2;
> -    }
> -
> -    /* Merge the tlb index contribution into X2.
> -       X2 =3D X2 + (X0 << CPU_TLB_ENTRY_BITS) */
> -    tcg_out_insn(s, 3502S, ADD_LSL, TCG_TYPE_I64, TCG_REG_X2, base,
> -                 TCG_REG_X0, CPU_TLB_ENTRY_BITS);
> -
> -    /* Merge "low bits" from tlb offset, load the tlb comparator into X0.
> -       X0 =3D load [X2 + (tlb_offset & 0x000fff)] */
> -    tcg_out_ldst(s, TARGET_LONG_BITS =3D=3D 32 ? I3312_LDRW : I3312_LDRX,
> -                 TCG_REG_X0, TCG_REG_X2, tlb_offset & 0xfff,
> -                 TARGET_LONG_BITS =3D=3D 32 ? 2 : 3);
> -
> -    /* Load the tlb addend. Do that early to avoid stalling.
> -       X1 =3D load [X2 + (tlb_offset & 0xfff) + offsetof(addend)] */
> -    tcg_out_ldst(s, I3312_LDRX, TCG_REG_X1, TCG_REG_X2,
> -                 (tlb_offset & 0xfff) + (offsetof(CPUTLBEntry, addend)) -
> -                 (is_read ? offsetof(CPUTLBEntry, addr_read)
> -                  : offsetof(CPUTLBEntry, addr_write)), 3);
> +                     TCG_REG_X3, x3, compare_mask);
>
>      /* Perform the address comparison. */
> -    tcg_out_cmp(s, (TARGET_LONG_BITS =3D=3D 64), TCG_REG_X0, TCG_REG_X3,=
 0);
> +    tcg_out_cmp(s, TARGET_LONG_BITS =3D=3D 64, TCG_REG_X0, TCG_REG_X3, 0=
);
>
>      /* If not equal, we jump to the slow path. */
>      *label_ptr =3D s->code_ptr;

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

(running s a very slow MTTCG s390x on my SynQuacer)

--
Alex Benn=C3=A9e
