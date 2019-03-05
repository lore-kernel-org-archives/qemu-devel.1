Received: from eggs.gnu.org ([209.51.188.92]:52882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h19Fo-0005gh-CR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h19Fm-0003Uo-LD
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:33:04 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h19Fm-0003Qg-8w
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:33:02 -0500
Received: by mail-pg1-x542.google.com with SMTP id r124so5557545pgr.3
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 04:33:02 -0800 (PST)
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551712405-2530-8-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <467c2597-c0c1-7a59-bc90-080a74be2935@linaro.org>
Date: Tue, 5 Mar 2019 04:32:57 -0800
MIME-Version: 1.0
In-Reply-To: <1551712405-2530-8-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/13] target/mips: Add emulation of MMI
 instruction PEXEW
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

On 3/4/19 7:13 AM, Mateja Marjanovic wrote:
> +    } else {
> +        TCGv_i64 t0 = tcg_temp_new();
> +        TCGv_i64 t1 = tcg_temp_new();
> +        TCGv_i64 t2 = tcg_temp_new();
> +        uint64_t mask0 = (1ULL << 32) - 1;
> +        uint64_t mask1 = mask0 << 32;
> +
> +        tcg_gen_movi_i64(t1, 0);
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);
> +        tcg_gen_shri_i64(t0, t0, 64);

This line should abort, since the shift count is out of range.
Are you testing with --enable-debug-tcg?

> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_mov_i64(t2, t1);

But again, this whole thing is two deposit operations:

    tcg_gen_mov_i64(t0, cpu_gpr[rt]);
    tcg_gen_deposit_i64(cpu_gpr[rd], cpu_gpr[rt], cpu_mmr[rt], 0, 32);
    tcg_gen_deposit_i64(cpu_mmr[rd], cpu_mmr[rt], t0, 0, 32);


r~
