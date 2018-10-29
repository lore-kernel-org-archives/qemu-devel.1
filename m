Received: from eggs.gnu.org ([2001:4830:134:3::10]:41501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH5FI-0001LT-Qq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH5FH-0006jg-TZ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:58:08 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:33702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH5FH-0006iV-HL
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:58:07 -0400
Received: by mail-oi1-x232.google.com with SMTP id c25-v6so6637720oiy.0
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 03:58:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540498768-8736-3-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540498768-8736-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 10:57:46 +0000
Message-ID: <CAFEAcA9H9gWbdcxvfJqcubAR0xaGaZfHTnBu-99KEWbV+uqxbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 2/3] target/mips: Implement emulation of
 nanoMIPS EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 25 October 2018 at 21:19, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Dimitrije Nikolic <dnikolic@wavecomp.com>
>
> Implement emulation of nanoMIPS EVA instructions. They are all
> part of P.LS.E0 instruction pool, or one of its subpools.
>
> Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> --

Hi; Coverity points out (CID 1396475) that the switch
cases for NM_LLWPE and NM_SCWPE fall through without
either a 'break' statement or a '/* fall through */' comment:

> +                case NM_P_LLE:
> +                    switch (extract32(ctx->opcode, 2, 2)) {
> +                    case NM_LLE:
> +                        check_xnp(ctx);
> +                        check_eva(ctx);
> +                        check_cp0_enabled(ctx);
> +                        gen_ld(ctx, OPC_LLE, rt, rs, s);
> +                        break;
> +                    case NM_LLWPE:
> +                        check_xnp(ctx);
> +                        check_eva(ctx);
> +                        check_cp0_enabled(ctx);
> +                        gen_llwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
> +                    default:
> +                        generate_exception_end(ctx, EXCP_RI);
> +                        break;
> +                    }
> +                    break;
> +                case NM_P_SCE:
> +                    switch (extract32(ctx->opcode, 2, 2)) {
> +                    case NM_SCE:
> +                        check_xnp(ctx);
> +                        check_eva(ctx);
> +                        check_cp0_enabled(ctx);
> +                        gen_st_cond(ctx, OPC_SCE, rt, rs, s);
> +                        break;
> +                    case NM_SCWPE:
> +                        check_xnp(ctx);
> +                        check_eva(ctx);
> +                        check_cp0_enabled(ctx);
> +                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
> +                    default:
> +                        generate_exception_end(ctx, EXCP_RI);
> +                        break;
> +                    }
> +                    break;
> +                }
> +                break;
>              case NM_P_LS_WM:
>              case NM_P_LS_UAWM:
>                  check_nms(ctx);

Could you send a patch which adds whichever of the two is correct, please?

thanks
-- PMM
