Received: from eggs.gnu.org ([209.51.188.92]:48335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyOc6-00065u-Np
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyOc4-0005T7-R8
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:20:42 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyOc4-0005Ls-3e
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:20:40 -0500
Received: by mail-pg1-x543.google.com with SMTP id h11so5157842pgl.0
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 14:20:33 -0800 (PST)
References: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551111037-23411-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a9e03d9e-b449-4244-af29-cd38f98726ad@linaro.org>
Date: Mon, 25 Feb 2019 14:20:29 -0800
MIME-Version: 1.0
In-Reply-To: <1551111037-23411-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/mips: Add emulation of MMI
 instruction PCPYLD
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

On 2/25/19 8:10 AM, Mateja Marjanovic wrote:
> +    if (rd == 0) {
> +        /* nop */
> +    } else if ((rt == 0) && (rs == 0)) {
> +        tcg_gen_movi_i64(cpu_gpr[rt], 0);
> +        tcg_gen_movi_i64(cpu_mmr[rt], 0);
> +    } else if (rt == 0) {
> +        tcg_gen_movi_i64(cpu_gpr[rd], 0);
> +        tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
> +    } else if (rs == 0) {
> +        tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
> +        tcg_gen_movi_i64(cpu_mmr[rd], 0);
> +    } else {
> +        tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
> +        tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
> +    }

You should avoid multiplying the cases this way.
The same results can be had with

  if (rd != 0) {
      gen_load_gpr(cpu_gpr[rd], rt);
      gen_load_gpr(cpu_mmr[rd], rs);
  }


r~
