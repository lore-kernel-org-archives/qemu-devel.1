Received: from eggs.gnu.org ([2001:4830:134:3::10]:38132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXEvG-0003J4-AQ
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXEvB-0003j0-Ew
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:59:58 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXEvA-0003id-WE
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:59:53 -0400
Received: by mail-pg0-x242.google.com with SMTP id c9-v6so5256984pgf.5
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 16:59:52 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-12-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7aa4798b-cd2d-669e-0aae-e90e004b2b2b@linaro.org>
Date: Sun, 24 Jun 2018 16:59:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-12-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/35] target/mips: Add nanoMIPS pool32a0
 instructions
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
> +    case NM_SOV:
> +    {
> +        TCGv t0 = tcg_temp_local_new();
> +        TCGv t1 = tcg_temp_new();
> +        TCGv t2 = tcg_temp_new();
> +        TCGLabel *l1 = gen_new_label();
> +
> +        gen_load_gpr(t1, rs);
> +        gen_load_gpr(t2, rt);
> +        tcg_gen_add_tl(t0, t1, t2);
> +        tcg_gen_ext32s_tl(t0, t0);
> +        tcg_gen_xor_tl(t1, t1, t2);
> +        tcg_gen_xor_tl(t2, t0, t2);
> +        tcg_gen_andc_tl(t1, t2, t1);
> +
> +        tcg_gen_movi_tl(t0, 0);
> +        tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
> +        /* operands of same sign, result different sign */
> +
> +        tcg_gen_movi_tl(t0, 1);
> +        gen_set_label(l1);
> +        gen_store_gpr(t0, rd);

No need for branch.  This is just extracting the sign bit, so

  tcg_gen_shri_tl(t0, t1, TARGET_LONG_BITS - 1);


r~
