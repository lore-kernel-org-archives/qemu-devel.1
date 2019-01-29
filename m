Received: from eggs.gnu.org ([209.51.188.92]:44036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gocSE-0007wi-Q8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 18:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gocSD-0004F7-Vs
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 18:06:06 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gocSC-0004D3-0s
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 18:06:05 -0500
Received: by mail-oi1-x236.google.com with SMTP id x202so17633655oif.13
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 15:06:01 -0800 (PST)
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
	<20190129191746.14868-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6cb56e8a-384b-03b9-1e83-04bfe3157ee0@linaro.org>
Date: Tue, 29 Jan 2019 15:05:56 -0800
MIME-Version: 1.0
In-Reply-To: <20190129191746.14868-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/8] target/ppc: rework vmrg{l, h}{b, h,
 w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 1/29/19 11:17 AM, Mark Cave-Ayland wrote:
> +#define VMRG_DO(name, element, access, ofs)                             \
>      void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>      {                                                                   \
>          ppc_avr_t result;                                               \
>          int i;                                                          \
>                                                                          \
> +        for (i = 0; i < ARRAY_SIZE(r->element) / 2; i++) {              \
> +            result.access(i * 2 + 0) = a->access(i + ofs);              \
> +            result.access(i * 2 + 1) = b->access(i + ofs);              \
>          }                                                               \
>          *r = result;                                                    \
>      }
> +
> +#define VMRG(suffix, element, access, half)        \
> +    VMRG_DO(mrgl##suffix, element, access, half)   \
> +    VMRG_DO(mrgh##suffix, element, access, 0)
> +VMRG(b, u8, VsrB, 8)
> +VMRG(h, u16, VsrH, 4)
> +VMRG(w, u32, VsrW, 2)

So... the point of "half" was to not replicate knowledge out to VMRG.
Just use

    int i, half = ARRAY_SIZE(r->element) / 2;
    for (i = 0; i < half; i++) {

within VMRG_DO.


r~
