Received: from eggs.gnu.org ([209.51.188.92]:37993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygCC-00033u-6r
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygCB-0000aO-5h
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:07:08 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gygCA-0008Uq-Ri
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:07:07 -0500
Received: by mail-pg1-x543.google.com with SMTP id h8so5988068pgp.6
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:06:41 -0800 (PST)
References: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551183797-13570-6-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a61d447c-1454-6c6b-7209-1fa8813bebc0@linaro.org>
Date: Tue, 26 Feb 2019 09:06:38 -0800
MIME-Version: 1.0
In-Reply-To: <1551183797-13570-6-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] target/mips: Add emulation of MMI
 instruction PEXCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 2/26/19 4:23 AM, Mateja Marjanovic wrote:
> +    } else if (rd == rt) {
> +        TCGv_i64 t0 = tcg_temp_new();
> +        TCGv_i64 t1 = tcg_temp_new();
> +        uint64_t mask0 = (1ULL << 16) - 1;
> +        uint64_t mask1 = mask0 << 16;
> +        uint64_t mask2 = mask1 << 16;
> +        uint64_t mask3 = (mask2 << 16) | mask0;
> +
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +
> +        tcg_gen_andi_i64(cpu_gpr[rt], cpu_gpr[rt], mask3);
> +        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t0);
> +        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t1);
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +
> +        tcg_gen_andi_i64(cpu_mmr[rt], cpu_mmr[rt], mask3);
> +        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t0);
> +        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t1);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    } else {
> +        TCGv_i64 t0 = tcg_temp_new();
> +        TCGv_i64 t1 = tcg_temp_new();
> +        uint64_t mask0 = (1ULL << 16) - 1;
> +        uint64_t mask1 = mask0 << 16;
> +        uint64_t mask2 = mask1 << 16;
> +        uint64_t mask3 = mask2 << 16;
> +
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask3);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask1);
> +        tcg_gen_shli_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask0);
> +        tcg_gen_or_i64(t0, t0, t1);
> +
> +        tcg_gen_mov_i64(cpu_gpr[rd], t0);
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask3);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask2);
> +        tcg_gen_shri_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask1);
> +        tcg_gen_shli_i64(t1, t1, 16);
> +        tcg_gen_or_i64(t0, t0, t1);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask0);
> +        tcg_gen_or_i64(t0, t0, t1);
> +
> +        tcg_gen_mov_i64(cpu_mmr[rd], t0);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    }

The code for rd != rt will work just fine for rd == rt.
Why are you doubling the amount of code you are writing?


r~
