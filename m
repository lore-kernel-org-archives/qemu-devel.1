Received: from eggs.gnu.org ([209.51.188.92]:46849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0adg-0000rW-3m
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0adf-0005cL-86
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:35:24 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:46232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0ade-0005bj-Ut
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:35:23 -0500
Received: by mail-pg1-x52d.google.com with SMTP id 196so1667084pgf.13
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 15:35:22 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-9-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c37085e-2c33-32d0-235c-76a9100d4bbf@linaro.org>
Date: Sun, 3 Mar 2019 15:35:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190303172343.13406-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/8] target/ppc: simplify get_cpu_vsrh()
 and get_cpu_vsrl() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
>  static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
>  {
> -    if (n < 32) {
> -        get_fpr(dst, n);
> -    } else {
> -        get_avr64(dst, n - 32, true);
> -    }
> +    tcg_gen_ld_i64(dst, cpu_env, vsrh_offset(n));
>  }
>  
>  static inline void get_cpu_vsrl(TCGv_i64 dst, int n)
>  {
> -    if (n < 32) {
> -        get_vsrl(dst, n);
> -    } else {
> -        get_avr64(dst, n - 32, false);
> -    }
> +    tcg_gen_ld_i64(dst, cpu_env, vsrl_offset(n));
>  }
>  
>  static inline void set_cpu_vsrh(int n, TCGv_i64 src)
>  {
> -    if (n < 32) {
> -        set_fpr(n, src);
> -    } else {
> -        set_avr64(n - 32, src, true);
> -    }
> +    tcg_gen_st_i64(src, cpu_env, vsrh_offset(n));
>  }

I think these ought to have a "high" parameter, like set/get_avr64.


r~
