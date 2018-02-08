Received: from eggs.gnu.org ([2001:4830:134:3::10]:49898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejukU-0005gy-CN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejukQ-0000pR-EL
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:32:57 -0500
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:38763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejukQ-0000p1-8g
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:32:54 -0500
Received: by mail-pl0-x236.google.com with SMTP id 13so565352plb.5
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:32:54 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6e52f89-a881-cdde-e995-a4fb59ca60b9@linaro.org>
Date: Thu, 8 Feb 2018 14:32:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 18/32] arm/translate-a64: add FP16
 FPRINTx to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> @@ -10727,40 +10727,152 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
>  /* AdvSIMD [scalar] two register miscellaneous (FP16)
>   *
>   *   31  30  29 28  27     24  23 22 21       17 16    12 11 10 9    5 4    0
> - * +---+---+---+---+--------+---+-------------+--------+-----+------+------+
> + * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
>   * | 0 | Q | U | S | 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
> - * +---+---+---+---+--------+---+-------------+--------+-----+------+------+
> + * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
>   *   mask: 1000 1111 0111 1110 0000 1100 0000 0000 0x8f7e 0c00
>   *   val:  0000 1110 0111 1000 0000 1000 0000 0000 0x0e78 0800
>   *
> - * ???While the group is listed with bit 28 always set to 1 this is not
> - * always the case.????
> - *
> - * This actually covers two groups,
> + * This actually covers two groups where scalar access is governed by
> + * bit 28. A bunch of the instructions (float to integral) only exist
> + * in the vector form and are un-allocated for the scalar decode. Also
> + * in the scalar decode Q is always 1.
>   */

Fold this hunk back into previous patch.

> 
> +
> +    /* Check additional constraints for the scalar encoding */
> +    if (is_scalar) {
> +        if (!is_q) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        /* FRINTxx is only in the vector form */
> +        if (only_in_vector && is_scalar) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +    }

Testing is_scalar twice.
Otherwise it looks good.


r~
