Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPcuW-0005mU-Rd
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPcuT-0003bY-0V
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:55:12 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPcuS-0003al-Rg
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:55:08 -0400
Received: by mail-qt0-x234.google.com with SMTP id r30so12904245qtc.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 15:55:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170626220330.6785-1-laurent@vivier.eu>
	<20170626220330.6785-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7661ca3e-6e2b-4522-b2b2-a2b81c72261d@twiddle.net>
Date: Mon, 26 Jun 2017 15:55:03 -0700
MIME-Version: 1.0
In-Reply-To: <20170626220330.6785-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/7] target/m68k: add fscc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/26/2017 03:03 PM, Laurent Vivier wrote:
>       case 12: /* Unordered or Less Than A || (N && !Z) */
>       case 28: /* Not Greater than or Equal A || (N && !Z) */
> -        assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
> -        tmp = tcg_temp_new();
> -        tcg_gen_xori_i32(tmp, fpsr, FPSR_CC_Z);
> -        tcg_gen_shli_i32(tmp, tmp, 1);
> -        tcg_gen_ori_i32(tmp, tmp, FPSR_CC_A);
> -        tcg_gen_and_i32(tmp, tmp, fpsr);
> -        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_A | FPSR_CC_N);
> -        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
> +        g_assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
> +        c->v1 = tcg_temp_new();
> +        c->g1 = 0;
> +        tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_Z);
> +        tcg_gen_shli_i32(c->v1, c->v1, 1);
> +        tcg_gen_ori_i32(c->v1, c->v1, FPSR_CC_A);
> +        tcg_gen_and_i32(c->v1, c->v1, fpsr);
> +        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
> +        c->tcond = TCG_COND_NE;

I think you're making a mistake wrt all of these shifts, in that you haven't 
masked out the other bits in FPSR.  Eventually you'll add support for the FPSR 
quotient and the byte below CC won't be zero.

Of course, one possibility is to deconstruct FPSR into pieces so that you can 
avoid extra masking.  Whether that's worthwhile, I don't know.

Another possibility for this one is

	tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_Z);
	tcg_gen_shli_i32(tmp, tmp, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
	tcg_gen_andc_i32(tmp, fpsr, tmp);
	tcg_gen_andi_i32(tmp, tmp, FPSR_CC_A | FPSR_CC_N);


r~
