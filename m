Received: from eggs.gnu.org ([208.118.235.92]:39937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbt3M-0005Db-SG
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbt3H-0003Es-WB
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:11:48 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbt3H-0003DK-Ob
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:11:43 -0500
Received: by mail-pl1-x644.google.com with SMTP id p8so6793867plo.2
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:11:43 -0800 (PST)
References: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
	<20181223113859.3675-4-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <189db2ae-9eae-4cdf-d8d5-f7c4a82a6954@linaro.org>
Date: Wed, 26 Dec 2018 07:11:35 +1100
MIME-Version: 1.0
In-Reply-To: <20181223113859.3675-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] target/ppc: rework vmul{e, o}{s, u}{b,
 h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/23/18 10:38 PM, Mark Cave-Ayland wrote:
> -#define VMUL_DO(name, mul_element, prod_element, cast, evenp)           \
> +#define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast)   \
>      void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>      {                                                                   \
>          int i;                                                          \
>                                                                          \
> +        for (i = 0; i < ARRAY_SIZE(r->mul_element); i += 2) {           \
> +            r->prod_access(i >> 1) = (cast)a->mul_access(i) *           \
> +                                     (cast)b->mul_access(i);            \
> +        }                                                               \
> +    }
> +
> +#define VMUL_DO_ODD(name, mul_element, mul_access, prod_access, cast)   \
> +    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
> +    {                                                                   \
> +        int i;                                                          \
> +                                                                        \
> +        for (i = 0; i < ARRAY_SIZE(r->mul_element); i += 2) {           \
> +            r->prod_access(i >> 1) = (cast)a->mul_access(i + 1) *       \
> +                                     (cast)b->mul_access(i + 1);        \
>          }                                                               \
>      }

FWIW,

  for (i = odd; i < ARRAY_SIZE; i += 2) {
    r->pacc(i >> 1) = (cast)a->macc(i) * b->macc(i);
  }

is sufficient to unify these two.  But what you have isn't wrong.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
