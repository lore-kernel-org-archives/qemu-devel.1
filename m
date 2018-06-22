Received: from eggs.gnu.org ([2001:4830:134:3::10]:47873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWELj-0003lH-LQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWELg-0004dl-Fq
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:11:07 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWELg-0004dJ-9Y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:11:04 -0400
Received: by mail-pf0-x244.google.com with SMTP id c22-v6so2626636pfi.2
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 22:11:04 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-8-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4310f06-3c26-7f50-c70b-d890a0a7db76@linaro.org>
Date: Thu, 21 Jun 2018 22:11:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-8-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/35] target/mips: Add nanoMIPS save and
 restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:05 AM, Yongbok Kim wrote:
> +static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
> +                        uint8_t gp, uint16_t u)
> +{
> +    int counter = 0;
> +    TCGv va = tcg_temp_new();
> +    TCGv t0 = tcg_temp_new();
> +
> +    while (counter != count) {

Better written as a for loop?

> +        bool use_gp = gp && (counter == count - 1);
> +        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
> +        int this_offset = u - ((counter + 1) << 2);
> +        gen_base_offset_addr(ctx, va, 29, this_offset);
> +        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TESL |
> +                        ctx->default_tcg_memop_mask);

Indentation.

> +        tcg_gen_ext32s_tl(t0, t0);

You do not need to sign-extend; you've just loaded a sign-extended 32-bit value
via MO_TESL.


r~
