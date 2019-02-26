Received: from eggs.gnu.org ([209.51.188.92]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygIy-0006xX-N8
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygIw-0008P2-VN
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:14:08 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gygIw-0008Nu-Md
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:14:06 -0500
Received: by mail-pg1-x542.google.com with SMTP id h8so5998467pgp.6
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:14:06 -0800 (PST)
References: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551183797-13570-7-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6fe88c6-3b20-7f3f-4274-d4a37102d40d@linaro.org>
Date: Tue, 26 Feb 2019 09:14:02 -0800
MIME-Version: 1.0
In-Reply-To: <1551183797-13570-7-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] target/mips: Add emulation of MMI
 instruction PEXCW
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
> +    } else if (rt == rd) {
> +        TCGv_i64 t0 = tcg_temp_new();
> +        TCGv_i64 t1 = tcg_temp_new();
> +        uint64_t mask0 = (1ULL << 32) - 1;
> +        uint64_t mask1 = mask0 << 32;
> +
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
> +        tcg_gen_shri_i64(t0, t0, 32);
> +        tcg_gen_andi_i64(t1, cpu_mmr[rt], mask0);
> +        tcg_gen_shli_i64(t1, t1, 32);
> +
> +        tcg_gen_and_i64(cpu_mmr[rd], cpu_mmr[rd], mask1);
> +        tcg_gen_or_i64(cpu_mmr[rd], cpu_mmr[rd], t0);
> +
> +        tcg_gen_and_i64(cpu_gpr[rd], cpu_gpr[rd], mask0);
> +        tcg_gen_or_i64(cpu_gpr[rd], cpu_gpr[rd], t1);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    } else {
> +        TCGv_i64 t0 = tcg_temp_new();
> +        TCGv_i64 t1 = tcg_temp_new();
> +        uint64_t mask0 = (1ULL << 32) - 1;
> +        uint64_t mask1 = mask0 << 32;
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask1);
> +        tcg_gen_shri_i64(t1, t1, 32);
> +        tcg_gen_or_i64(cpu_mmr[rd], t0, t1);
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);
> +        tcg_gen_shli_i64(t0, t0, 32);
> +        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask0);
> +        tcg_gen_or_i64(cpu_gpr[rd], t0, t1);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    }

Likewise, why are you duplicating cases?

Also, this can be simplified with deposit:

    tcg_gen_shri_i64(t0, cpu_gpr[rt], 32);
    tcg_gen_deposit_i64(cpu_gpr[rd], cpu_gpr[rt], cpu_mmu[rt], 32, 32);
    tcg_gen_deposit_i64(cpu_mmu[rd], cpu_mmu[rt], t0, 0, 32);


r~
