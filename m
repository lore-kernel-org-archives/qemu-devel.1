Received: from eggs.gnu.org ([2001:4830:134:3::10]:41614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmvg-0000Gl-CP
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmvc-0006Qn-C7
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:50:16 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSmvb-0006Pn-Pj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:50:12 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so6086577wrt.13
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:50:11 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-12-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-12-richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 17:50:08 +0000
Message-ID: <87pnum3167.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 11/37] tcg/aarch64: Parameterize
 the temps for tcg_out_tlb_read
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

> When moving the qemu_ld/st arguments to the right place for
> a function call, we'll need to move the temps out of the way.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.inc.c | 74 +++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 34 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 148de0b7f2..c0ba9a6d50 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1467,13 +1467,15 @@ static void add_qemu_ldst_label(TCGContext *s, bo=
ol is_ld, TCGMemOpIdx oi,
>      label->label_ptr[0] =3D label_ptr;
>  }
>
> -/* Load and compare a TLB entry, emitting the conditional jump to the
> -   slow path for the failure case, which will be patched later when fina=
lizing
> -   the slow path. Generated code returns the host addend in X1,
> -   clobbers X0,X2,X3,TMP. */
> -static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp op=
c,
> -                             tcg_insn_unit **label_ptr, int mem_index,
> -                             bool is_read)
> +/*
> + * Load and compare a TLB entry, emitting the conditional jump to the
> + * slow path on failure.  Returns the register for the host addend.
> + * Clobbers t0, t1, t2, t3.
> + */
> +static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp =
opc,
> +                               tcg_insn_unit **label_ptr, int mem_index,
> +                               bool is_read, TCGReg t0, TCGReg t1,
> +                               TCGReg t2, TCGReg t3)
>  {
>      int tlb_offset =3D is_read ?
>          offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
> @@ -1491,55 +1493,56 @@ static void tcg_out_tlb_read(TCGContext *s, TCGRe=
g addr_reg, TCGMemOp opc,
>      if (a_bits >=3D s_bits) {
>          x3 =3D addr_reg;
>      } else {
> +        x3 =3D t3;
>          tcg_out_insn(s, 3401, ADDI, TARGET_LONG_BITS =3D=3D 64,
> -                     TCG_REG_X3, addr_reg, s_mask - a_mask);
> -        x3 =3D TCG_REG_X3;
> +                     x3, addr_reg, s_mask - a_mask);
>      }
>      tlb_mask =3D (uint64_t)TARGET_PAGE_MASK | a_mask;
>
> -    /* Extract the TLB index from the address into X0.
> -       X0<CPU_TLB_BITS:0> =3D
> +    /* Extract the TLB index from the address into T0.
> +       T0<CPU_TLB_BITS:0> =3D
>         addr_reg<TARGET_PAGE_BITS+CPU_TLB_BITS:TARGET_PAGE_BITS> */
> -    tcg_out_ubfm(s, TARGET_LONG_BITS =3D=3D 64, TCG_REG_X0, addr_reg,
> +    tcg_out_ubfm(s, TARGET_LONG_BITS =3D=3D 64, t0, addr_reg,
>                   TARGET_PAGE_BITS, TARGET_PAGE_BITS + CPU_TLB_BITS);
>
> -    /* Store the page mask part of the address into X3.  */
> +    /* Store the page mask part of the address into T3.  */
>      tcg_out_logicali(s, I3404_ANDI, TARGET_LONG_BITS =3D=3D 64,
> -                     TCG_REG_X3, x3, tlb_mask);
> +                     t3, x3, tlb_mask);
>
> -    /* Add any "high bits" from the tlb offset to the env address into X=
2,
> +    /* Add any "high bits" from the tlb offset to the env address into T=
2,
>         to take advantage of the LSL12 form of the ADDI instruction.
> -       X2 =3D env + (tlb_offset & 0xfff000) */
> +       T2 =3D env + (tlb_offset & 0xfff000) */
>      if (tlb_offset & 0xfff000) {
> -        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_X2, base,
> +        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, t2, base,
>                       tlb_offset & 0xfff000);
> -        base =3D TCG_REG_X2;
> +        base =3D t2;
>      }
>
> -    /* Merge the tlb index contribution into X2.
> -       X2 =3D X2 + (X0 << CPU_TLB_ENTRY_BITS) */
> -    tcg_out_insn(s, 3502S, ADD_LSL, TCG_TYPE_I64, TCG_REG_X2, base,
> -                 TCG_REG_X0, CPU_TLB_ENTRY_BITS);
> +    /* Merge the tlb index contribution into T2.
> +       T2 =3D T2 + (T0 << CPU_TLB_ENTRY_BITS) */
> +    tcg_out_insn(s, 3502S, ADD_LSL, TCG_TYPE_I64,
> +                 t2, base, t0, CPU_TLB_ENTRY_BITS);
>
> -    /* Merge "low bits" from tlb offset, load the tlb comparator into X0.
> -       X0 =3D load [X2 + (tlb_offset & 0x000fff)] */
> +    /* Merge "low bits" from tlb offset, load the tlb comparator into T0.
> +       T0 =3D load [T2 + (tlb_offset & 0x000fff)] */
>      tcg_out_ldst(s, TARGET_LONG_BITS =3D=3D 32 ? I3312_LDRW : I3312_LDRX,
> -                 TCG_REG_X0, TCG_REG_X2, tlb_offset & 0xfff,
> -                 TARGET_LONG_BITS =3D=3D 32 ? 2 : 3);
> +                 t0, t2, tlb_offset & 0xfff, TARGET_LONG_BITS =3D=3D 32 =
? 2 : 3);
>
>      /* Load the tlb addend. Do that early to avoid stalling.
> -       X1 =3D load [X2 + (tlb_offset & 0xfff) + offsetof(addend)] */
> -    tcg_out_ldst(s, I3312_LDRX, TCG_REG_X1, TCG_REG_X2,
> +       T1 =3D load [T2 + (tlb_offset & 0xfff) + offsetof(addend)] */
> +    tcg_out_ldst(s, I3312_LDRX, t1, t2,
>                   (tlb_offset & 0xfff) + (offsetof(CPUTLBEntry, addend)) -
>                   (is_read ? offsetof(CPUTLBEntry, addr_read)
>                    : offsetof(CPUTLBEntry, addr_write)), 3);
>
>      /* Perform the address comparison. */
> -    tcg_out_cmp(s, (TARGET_LONG_BITS =3D=3D 64), TCG_REG_X0, TCG_REG_X3,=
 0);
> +    tcg_out_cmp(s, (TARGET_LONG_BITS =3D=3D 64), t0, t3, 0);
>
>      /* If not equal, we jump to the slow path. */
>      *label_ptr =3D s->code_ptr;
>      tcg_out_goto_cond_noaddr(s, TCG_COND_NE);
> +
> +    return t1;
>  }
>
>  #endif /* CONFIG_SOFTMMU */
> @@ -1644,10 +1647,12 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg=
 data_reg, TCGReg addr_reg,
>  #ifdef CONFIG_SOFTMMU
>      unsigned mem_index =3D get_mmuidx(oi);
>      tcg_insn_unit *label_ptr;
> +    TCGReg base;
>
> -    tcg_out_tlb_read(s, addr_reg, memop, &label_ptr, mem_index, 1);
> +    base =3D tcg_out_tlb_read(s, addr_reg, memop, &label_ptr, mem_index,=
 1,
> +                            TCG_REG_X0, TCG_REG_X1, TCG_REG_X2, TCG_REG_=
X3);
>      tcg_out_qemu_ld_direct(s, memop, ext, data_reg,
> -                           TCG_REG_X1, otype, addr_reg);
> +                           base, otype, addr_reg);
>      add_qemu_ldst_label(s, true, oi, ext, data_reg, addr_reg,
>                          s->code_ptr, label_ptr);
>  #else /* !CONFIG_SOFTMMU */
> @@ -1669,10 +1674,11 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg=
 data_reg, TCGReg addr_reg,
>  #ifdef CONFIG_SOFTMMU
>      unsigned mem_index =3D get_mmuidx(oi);
>      tcg_insn_unit *label_ptr;
> +    TCGReg base;
>
> -    tcg_out_tlb_read(s, addr_reg, memop, &label_ptr, mem_index, 0);
> -    tcg_out_qemu_st_direct(s, memop, data_reg,
> -                           TCG_REG_X1, otype, addr_reg);
> +    base =3D tcg_out_tlb_read(s, addr_reg, memop, &label_ptr, mem_index,=
 0,
> +                            TCG_REG_X0, TCG_REG_X1, TCG_REG_X2, TCG_REG_=
X3);
> +    tcg_out_qemu_st_direct(s, memop, data_reg, base, otype, addr_reg);
>      add_qemu_ldst_label(s, false, oi, (memop & MO_SIZE)=3D=3D MO_64,
>                          data_reg, addr_reg, s->code_ptr, label_ptr);
>  #else /* !CONFIG_SOFTMMU */


--
Alex Benn=C3=A9e
