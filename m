Received: from eggs.gnu.org ([209.51.188.92]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0uKJ-00082f-7f
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0uKH-0005ol-IP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:36:42 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0uKE-0005ln-I8
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:36:39 -0500
Received: by mail-pg1-x543.google.com with SMTP id i130so3895739pgd.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 12:36:37 -0800 (PST)
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551712405-2530-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <26f214cc-b330-ca06-b94a-ceca322fd11c@linaro.org>
Date: Mon, 4 Mar 2019 12:36:33 -0800
MIME-Version: 1.0
In-Reply-To: <1551712405-2530-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/13] target/mips: Add emulation of MMI
 instruction PCPYH
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
> +        uint64_t mask = (1ULL << 16) - 1;
> +
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
> +        tcg_gen_movi_i64(t1, 0);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);

I have suggested a better way to write this, twice,
the third time is surely the charm...

  tcg_gen_deposit_i64(t0, cpu_gpr[rt], cpu_gpr[rt], 16, 48);
  tcg_gen_deposit_i64(t0, t0, t0, 32, 32);


r~
