Received: from eggs.gnu.org ([209.51.188.92]:47690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyOYE-0005Am-JD
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyOYD-00031M-Bs
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:16:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:43190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyOYB-0002xT-C9
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:16:41 -0500
Received: by mail-pl1-x636.google.com with SMTP id m10so5125843plt.10
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 14:16:35 -0800 (PST)
References: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551111037-23411-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <781179ad-b271-7cc6-4e59-bc81c478b9d0@linaro.org>
Date: Mon, 25 Feb 2019 14:16:31 -0800
MIME-Version: 1.0
In-Reply-To: <1551111037-23411-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/mips: Add emulation of MMI
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

On 2/25/19 8:10 AM, Mateja Marjanovic wrote:
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);

tcg_gen_ext16u_i64.

> +        tcg_gen_movi_i64(t1, 0);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);

Much better as

  tcg_gen_deposit(t0, t0, t0, 16, 48);
  tcg_gen_deposit(t1, t0, t0, 32, 32);


r~
