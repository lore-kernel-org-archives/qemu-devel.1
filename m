Received: from eggs.gnu.org ([208.118.235.92]:32980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbsTo-0005tB-He
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 14:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbsTk-0000F2-Jc
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 14:35:04 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbsTk-0000Ec-5g
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 14:35:00 -0500
Received: by mail-pf1-x443.google.com with SMTP id c123so7045394pfb.0
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 11:34:59 -0800 (PST)
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
	<20181217200444.14812-6-aleksandar.markovic@rt-rk.com>
	<CAL1e-=gUE7KPL+MwBOd_sb2KocHox-4Davo_SN2fwozBoOa20Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eface3ff-cafd-da6f-3f6d-30496f168cd9@linaro.org>
Date: Wed, 26 Dec 2018 06:34:48 +1100
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gUE7KPL+MwBOd_sb2KocHox-4Davo_SN2fwozBoOa20Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/mips: MXU: Add handlers for
 max/min instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, "Janeczek, Craig" <jancraig@amazon.com>

Sorry I missed the original post, but:

> +    } else if (unlikely((XRb == 0) && (XRc == 0))) {
> +        /* both operands zero registers -> just set destination to zero */
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
> +    } else if (unlikely((XRb == 0) || (XRc == 0))) {
> +        /* exactly one operand is zero register - find which one is not...*/
> +        uint32_t XRx = XRb ? XRb : XRc;
> +        /* ...and do max/min operation with one operand 0 */
> +        if (opc == OPC_MXU_S32MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
> +        }
> +    } else if (unlikely(XRb == XRc)) {
> +        /* both operands same -> just set destination to one of them */
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);

You should not special case unlikely events, especially when ...

> +    } else {
> +        /* the most general case */
> +        if (opc == OPC_MXU_S32MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
> +                                               mxu_gpr[XRc - 1]);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
> +                                               mxu_gpr[XRc - 1]);
> +        }

... the normal case will handle those special cases just fine.
