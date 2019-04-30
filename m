Received: from eggs.gnu.org ([209.51.188.92]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW7R-0000UY-B1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW7P-0004q3-DM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:00:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW7P-0004l5-7G
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:00:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id d9so7015986pls.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:00:23 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-15-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c05b552-a692-e439-fc28-90ad69767cf2@linaro.org>
Date: Tue, 30 Apr 2019 10:00:12 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/14] target/ppc: improve VSX_FMADD with
 new GEN_VSX_HELPER_VSX_MADD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>  #define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)              \
>  void helper_##op(CPUPPCState *env, uint32_t opcode,                           \
> -                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)                 \
> +                 ppc_vsr_t *xt, ppc_vsr_t *xa,                                \
> +                 ppc_vsr_t *b, ppc_vsr_t *c)                                  \
>  {                                                                             \
> -    ppc_vsr_t *b, *c;                                                         \
>      int i;                                                                    \
>                                                                                \
> -    if (afrm) { /* AxB + T */                                                 \
> -        b = xb;                                                               \
> -        c = xt;                                                               \
> -    } else { /* AxT + B */                                                    \
> -        b = xt;                                                               \
> -        c = xb;                                                               \
> -    }                                                                         \

The afrm argument is no longer used.
This also means that e.g.

VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)

are redundant.  Similarly with all of the other pairs.


r~
