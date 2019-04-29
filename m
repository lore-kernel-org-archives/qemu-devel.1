Received: from eggs.gnu.org ([209.51.188.92]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7h7-00068c-ME
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7h2-0007IU-1O
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:55:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:47011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7gy-0007EO-CG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:55:42 -0400
Received: by mail-ot1-x344.google.com with SMTP id 77so2699560otu.13
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-36-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:55:21 +0100
Message-ID: <CAFEAcA8u8GgWK=YQ40-OD_eA2JarA7JrOAPsxfrqkbzyT1aoGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 35/36] tcg/aarch64: Use LDP to
 load tlb mask+table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index ac765137ae..979efbcfe4 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1463,14 +1463,11 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
>                               tcg_insn_unit **label_ptr, int mem_index,
>                               bool is_read)
>  {
> -    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
> -    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
> -    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
>      unsigned a_bits = get_alignment_bits(opc);
>      unsigned s_bits = opc & MO_SIZE;
>      unsigned a_mask = (1u << a_bits) - 1;
>      unsigned s_mask = (1u << s_bits) - 1;
> -    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0, x3;
> +    TCGReg x3;
>      TCGType mask_type;
>      uint64_t compare_mask;
>
> @@ -1478,8 +1475,8 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
>                   ? TCG_TYPE_I64 : TCG_TYPE_I32);
>
>      /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */

The field names in this comment are out of date, I think ?

> -    tcg_out_ld(s, mask_type, TCG_REG_X0, mask_base, mask_ofs);
> -    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, table_base, table_ofs);
> +    tcg_out_insn(s, 3314, LDP, TCG_REG_X0, TCG_REG_X1, TCG_AREG0,
> +                 TLB_MASK_TABLE_OFS(mem_index), 1, 0);

Can we have a compile time assert somewhere that the
mask and table fields are at the offsets in CPUTLBDescFast
that we expect them to be?

thanks
-- PMM
