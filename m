Received: from eggs.gnu.org ([2001:4830:134:3::10]:49186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSPst-0007s6-Pg
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSPsq-0005WB-K7
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:13:51 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSPsq-0005Vv-4C
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:13:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so2684822wra.6
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:13:48 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-8-richard.henderson@linaro.org>
Date: Thu, 29 Nov 2018 17:13:45 +0000
Message-ID: <87va4f3iye.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 07/37] tcg/i386: Change
 TCG_REG_L[01] to not overlap function arguments
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

> We will shortly be forcing qemu_ld/st arguments into registers
> that match the function call abi of the host, which means that
> the temps must be elsewhere.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.inc.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 3234a8d8bf..07df4b2b12 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -121,12 +121,16 @@ static const int tcg_target_call_oarg_regs[] =3D {
>  #define TCG_CT_CONST_I32 0x400
>  #define TCG_CT_CONST_WSZ 0x800
>
> -/* Registers used with L constraint, which are the first argument
> -   registers on x86_64, and two random call clobbered registers on
> -   i386. */
> +/* Registers used with L constraint, which are two random
> + * call clobbered registers.  These should be free.
> + */

"These should be free by the time we have committed to making a procedure
call and won't be needed afterwards."?

>  #if TCG_TARGET_REG_BITS =3D=3D 64
> -# define TCG_REG_L0 tcg_target_call_iarg_regs[0]
> -# define TCG_REG_L1 tcg_target_call_iarg_regs[1]

I guess we don't need this type of assignment enough to have a
tcg_target_call_clobber_regs array we can fill from?

/me digs deeper

ahh I see we have tcg_target_call_clobber_regs but that's a bitmap for
use by the register allocator... never mind.

> +# define TCG_REG_L0   TCG_REG_RAX
> +# ifdef _WIN64
> +#  define TCG_REG_L1  TCG_REG_R10
> +# else
> +#  define TCG_REG_L1  TCG_REG_RDI
> +# endif
>  #else
>  # define TCG_REG_L0 TCG_REG_EAX
>  # define TCG_REG_L1 TCG_REG_EDX
> @@ -1628,6 +1632,7 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGRe=
g addrlo, TCGReg addrhi,
>      unsigned a_mask =3D (1 << a_bits) - 1;
>      unsigned s_mask =3D (1 << s_bits) - 1;
>      target_ulong tlb_mask;
> +    TCGReg base;
>
>      if (TCG_TARGET_REG_BITS =3D=3D 64) {
>          if (TARGET_LONG_BITS =3D=3D 64) {
> @@ -1674,7 +1679,12 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGR=
eg addrlo, TCGReg addrhi,
>         before the fastpath ADDQ below.  For 64-bit guest and x32 host, M=
OVQ
>         copies the entire guest address for the slow path, while truncati=
on
>         for the 32-bit host happens with the fastpath ADDL below.  */
> -    tcg_out_mov(s, ttype, r1, addrlo);
> +    if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        base =3D tcg_target_call_iarg_regs[1];
> +    } else {
> +        base =3D r1;
> +    }
> +    tcg_out_mov(s, ttype, base, addrlo);
>
>      /* jne slow_path */
>      tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
> @@ -1693,11 +1703,11 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCG=
Reg addrlo, TCGReg addrhi,
>
>      /* TLB Hit.  */
>
> -    /* add addend(r0), r1 */
> -    tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
> +    /* add addend(r0), base */
> +    tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, base, r0,
>                           offsetof(CPUTLBEntry, addend) - which);
>
> -    return r1;
> +    return base;
>  }
>
>  /*

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
