Received: from eggs.gnu.org ([2001:4830:134:3::10]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKsE-0008Tw-VK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKsB-000084-Jz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:11:46 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqKs9-0008V5-Qp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:11:42 -0400
Received: by mail-pl0-x244.google.com with SMTP id f6-v6so2323963plo.1
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:11:39 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-29-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b24b204-ed70-2708-97b5-47014af250d6@linaro.org>
Date: Thu, 16 Aug 2018 09:11:35 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-29-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 28/84] target/mips: Add emulation of
 some common nanoMIPS 32-bit instructions
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
> +            imm = extract32(ctx->opcode, 0, 16);
> +            if (rs != 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rs], imm);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +            } else {
> +                tcg_gen_movi_tl(cpu_gpr[rt], imm);
> +            }

The nanomips pseudocode says ADDIU always sign-extends from 32-bit.

I'm hoping for the sake of nanomips64 that the legacy "inputs to 32-bit
instructions must always be sign-extended" rule has gone?

> +                    } else if (rt == 0 && shift == 5) {
> +                        /* PAUSE */
> +                        if (ctx->hflags & MIPS_HFLAG_BMASK) {
> +                            generate_exception_end(ctx, EXCP_RI);
> +                        }

No delay slots for nanomips, so no BMASK.
Probably best to comment that we're implementing PAUSE as a nop.


r~
