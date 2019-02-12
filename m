Received: from eggs.gnu.org ([209.51.188.92]:37134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPiL-0004Vk-Jb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPiK-0003Kr-Eh
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:30:33 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtPiG-00037d-AO
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:30:30 -0500
Received: by mail-pf1-x443.google.com with SMTP id c123so674671pfb.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:30:15 -0800 (PST)
References: <20190211181907.2219-2-svens@stackframe.org>
	<20190211181907.2219-4-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c43bc5ed-9107-9c1e-993e-0bebb5a39826@linaro.org>
Date: Mon, 11 Feb 2019 20:30:11 -0800
MIME-Version: 1.0
In-Reply-To: <20190211181907.2219-4-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] target/hppa: fix log conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <rth@twiddle.net>

On 2/11/19 10:19 AM, Sven Schnelle wrote:
>      switch (cf >> 1) {
> -    case 4: case 5: case 6:
> -        cf &= 1;
> +    case 0: /* never */
> +        cond = cond_make_f();
> +        break;
> +    case 1: /* = all bits are zero */
> +        cond = cond_make_0(TCG_COND_EQ, res);
> +        break;
> +    case 2: /* < leftmost bit is 1 */
> +        cond = cond_make_0(TCG_COND_LT, res);
> +        break;
> +    case 3: /* <= leftmost bit is 1 or all bits 0 */
> +        cond = cond_make_0(TCG_COND_LE, res);
> +        break;
> +    case 7: /* OD rightmost bit is 1 */
> +        tmp = tcg_temp_new();
> +        tcg_gen_andi_reg(tmp, res, 1);
> +        cond = cond_make_0(TCG_COND_NE, tmp);
> +        tcg_temp_free(tmp);
> +        break;
> +    default:
>          break;
>      }

You can't do nothing for cases 4,5,6.  That lets a bad guest crash qemu, since
cond will be uninitialized.  Also, this patch has to be sorted before the
previous, as otherwise you introduce a regression during bisection.

I've fixed this up locally.


r~
