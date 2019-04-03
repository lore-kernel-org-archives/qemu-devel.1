Received: from eggs.gnu.org ([209.51.188.92]:33167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBahT-0004QK-5S
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBahS-0002oN-8d
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:52:47 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:34841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBahR-0002nr-Pf
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:52:46 -0400
Received: by mail-io1-xd30.google.com with SMTP id p16so13302568iod.2
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 00:52:45 -0700 (PDT)
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0c2c26f-49e0-1e24-250c-d5585c41fcbd@linaro.org>
Date: Wed, 3 Apr 2019 14:52:39 +0700
MIME-Version: 1.0
In-Reply-To: <1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

On 4/2/19 10:15 PM, Mateja Marjanovic wrote:
> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    const uint64_t mask = 0x00000000ffffffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[ws * 2], 32, 32);

The andi of mask is redundant with the deposit.  Remove it.
This should be just

    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2],
                        msa_wr_d[ws * 2], 32, 32);


r~
