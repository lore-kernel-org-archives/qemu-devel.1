Received: from eggs.gnu.org ([2001:4830:134:3::10]:51189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqMEV-0002Pk-Ep
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqMEO-0002wt-J4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:38:50 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqMEM-0002uc-LF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:38:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id y10-v6so2327245pfn.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 10:38:41 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-48-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e277dd47-fe10-4e70-3e0e-58aeabe13153@linaro.org>
Date: Thu, 16 Aug 2018 10:38:37 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-48-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 47/84] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add emulation of DSP ASE instructions for nanoMIPS - part 6.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 420a296..02ae3d9 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -17777,6 +17777,64 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
>      tcg_temp_free(t0);
>  }
>  
> +static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
> +                                          int rt, int rs, int rd)
> +{
> +    TCGv t0;
> +    TCGv rs_t;
> +
> +    if (rt == 0) {
> +        /* Treat as NOP. */
> +        return;
> +    }

This...

> +
> +    t0 = tcg_temp_new();
> +    rs_t = tcg_temp_new();
> +
> +    gen_load_gpr(rs_t, rs);
> +
> +    switch (opc) {
> +    case NM_SHRA_R_QB:
> +        check_dspr2(ctx);

... misses out on these checks.
Better off with the gen_store_gpr calls from the other ASE patches.


r~
