Received: from eggs.gnu.org ([2001:4830:134:3::10]:36328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSPHJ-0005vt-N7
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSPHE-0004v1-O5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:35:01 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSPHE-0004rh-Gm
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:34:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so2532049wrt.13
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 08:34:56 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-7-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-7-richard.henderson@linaro.org>
Date: Thu, 29 Nov 2018 16:34:40 +0000
Message-ID: <87woov3krj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 06/37] tcg/i386: Return a base
 register from tcg_out_tlb_load
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

> We will shortly be asking the hot path not to assume TCG_REG_L1
> for the host base address.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/i386/tcg-target.inc.c | 56 ++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 8aef66e430..3234a8d8bf 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -1614,9 +1614,9 @@ static void * const qemu_st_helpers[16] =3D {
>
>     First argument register is clobbered.  */
>
> -static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg=
 addrhi,
> -                                    int mem_index, TCGMemOp opc,
> -                                    tcg_insn_unit **label_ptr, int which)
> +static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addr=
hi,
> +                               int mem_index, TCGMemOp opc,
> +                               tcg_insn_unit **label_ptr, int which)
>  {
>      const TCGReg r0 =3D TCG_REG_L0;
>      const TCGReg r1 =3D TCG_REG_L1;
> @@ -1696,6 +1696,8 @@ static inline void tcg_out_tlb_load(TCGContext *s, =
TCGReg addrlo, TCGReg addrhi,
>      /* add addend(r0), r1 */
>      tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
>                           offsetof(CPUTLBEntry, addend) - which);
> +
> +    return r1;
>  }
>
>  /*
> @@ -2001,10 +2003,6 @@ static void tcg_out_qemu_ld(TCGContext *s, const T=
CGArg *args, bool is64)
>      TCGReg addrhi __attribute__((unused));
>      TCGMemOpIdx oi;
>      TCGMemOp opc;
> -#if defined(CONFIG_SOFTMMU)
> -    int mem_index;
> -    tcg_insn_unit *label_ptr[2];
> -#endif
>
>      datalo =3D *args++;
>      datahi =3D (TCG_TARGET_REG_BITS =3D=3D 32 && is64 ? *args++ : 0);
> @@ -2014,17 +2012,21 @@ static void tcg_out_qemu_ld(TCGContext *s, const =
TCGArg *args, bool is64)
>      opc =3D get_memop(oi);
>
>  #if defined(CONFIG_SOFTMMU)
> -    mem_index =3D get_mmuidx(oi);
> +    {
> +        int mem_index =3D get_mmuidx(oi);
> +        tcg_insn_unit *label_ptr[2];
> +        TCGReg base;
>
> -    tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
> -                     label_ptr, offsetof(CPUTLBEntry, addr_read));
> +        base =3D tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
> +                                label_ptr, offsetof(CPUTLBEntry, addr_re=
ad));
>
> -    /* TLB Hit.  */
> -    tcg_out_qemu_ld_direct(s, datalo, datahi, TCG_REG_L1, -1, 0, 0, opc);
> +        /* TLB Hit.  */
> +        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, opc);
>
> -    /* Record the current context of a load into ldst label */
> -    add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
> -                        s->code_ptr, label_ptr);
> +        /* Record the current context of a load into ldst label */
> +        add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
> +                            s->code_ptr, label_ptr);
> +    }
>  #else
>      {
>          int32_t offset =3D guest_base;
> @@ -2141,10 +2143,6 @@ static void tcg_out_qemu_st(TCGContext *s, const T=
CGArg *args, bool is64)
>      TCGReg addrhi __attribute__((unused));
>      TCGMemOpIdx oi;
>      TCGMemOp opc;
> -#if defined(CONFIG_SOFTMMU)
> -    int mem_index;
> -    tcg_insn_unit *label_ptr[2];
> -#endif
>
>      datalo =3D *args++;
>      datahi =3D (TCG_TARGET_REG_BITS =3D=3D 32 && is64 ? *args++ : 0);
> @@ -2154,17 +2152,21 @@ static void tcg_out_qemu_st(TCGContext *s, const =
TCGArg *args, bool is64)
>      opc =3D get_memop(oi);
>
>  #if defined(CONFIG_SOFTMMU)
> -    mem_index =3D get_mmuidx(oi);
> +    {
> +        int mem_index =3D get_mmuidx(oi);
> +        tcg_insn_unit *label_ptr[2];
> +        TCGReg base;
>
> -    tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
> -                     label_ptr, offsetof(CPUTLBEntry, addr_write));
> +        base =3D tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
> +                                label_ptr, offsetof(CPUTLBEntry, addr_wr=
ite));
>
> -    /* TLB Hit.  */
> -    tcg_out_qemu_st_direct(s, datalo, datahi, TCG_REG_L1, 0, 0, opc);
> +        /* TLB Hit.  */
> +        tcg_out_qemu_st_direct(s, datalo, datahi, base, 0, 0, opc);
>
> -    /* Record the current context of a store into ldst label */
> -    add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
> -                        s->code_ptr, label_ptr);
> +        /* Record the current context of a store into ldst label */
> +        add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
> +                            s->code_ptr, label_ptr);
> +    }
>  #else
>      {
>          int32_t offset =3D guest_base;


--
Alex Benn=C3=A9e
