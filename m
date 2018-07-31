Received: from eggs.gnu.org ([2001:4830:134:3::10]:55966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZr7-00055s-Cb
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZr4-0001Vk-17
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:58:49 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkZr3-0001Un-Qu
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:58:45 -0400
Received: by mail-vk0-x244.google.com with SMTP id e139-v6so8038752vkf.6
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 11:58:45 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-44-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3205b1ca-8e79-e040-6ed5-494e1895f99b@linaro.org>
Date: Tue, 31 Jul 2018 14:58:40 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-44-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 43/76] target/mips: Add emulation of DSP
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> +        switch (extract32(ctx->opcode, 12, 1)) {
> +        case 0:
> +            /* NM_SHRA_QB */
> +            check_dspr2(ctx);
> +            gen_helper_shra_qb(cpu_gpr[ret], t0, v1_t);
More unprotected use of cpu_gpr[0].

I think you need some sort of solution that prevents this completely, without
having to think about it.  E.g. global replace cpu_gpr[x] -> read_gpr(ctx, x) /
dest_gpr(ctx, x), where the two functions allocate tcg temporaries on demand.

I think the model used in target/alpha/translate.c is ideal.  However, there
are variations on this theme in target/arm/translate-a64.c,
target/sparc/translate.c, and target/openrisc/translate.c.


r~
