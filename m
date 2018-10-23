Received: from eggs.gnu.org ([2001:4830:134:3::10]:36612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsAE-0005Li-2n
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsAA-00058i-Iz
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:35:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsAA-0004sU-4M
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:35:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id f17-v6so648429wrs.12
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:35:26 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-18-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a6109dd-7c9e-d808-21c8-47ef757b197f@linaro.org>
Date: Tue, 23 Oct 2018 09:35:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-18-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/29] target/riscv: Convert quadrant 1
 of RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
> --- a/target/riscv/insn_trans/trans_rvc.inc.c
> +++ b/target/riscv/insn_trans/trans_rvc.inc.c
> @@ -23,8 +23,7 @@ static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a,
>  {
>      if (a->nzuimm == 0) {
>          /* Reserved in ISA */
> -        gen_exception_illegal(ctx);
> -        return true;
> +        return false;

Ah, the change for patch 16 got squished to the wrong patch.

> +static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a, uint16_t insn)
> +{
> +    int shamt = a->shamt;
> +    if (shamt == 0) {
> +        /* For RV128 a shamt of 0 means a shift by 64 */
> +        shamt = 64;
> +    }
> +    /* Ensure, that shamt[5] is zero for RV32 */
> +    if (shamt >= TARGET_LONG_BITS) {
> +        return false;
> +    }
> +
> +    arg_srli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
> +    return trans_srli(ctx, &arg, insn);
> +}
> +
> +static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a, uint16_t insn)
> +{
> +    if (a->shamt == 0) {
> +        /* Reserved in ISA */
> +        return false;
> +    }
> +#ifdef TARGET_RISCV32
> +    /* Ensure, that shamt[5] is zero for RV32 */
> +    if (a->shamt >= 32) {
> +        return false;
> +    }
> +#endif

Same change as srli.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
