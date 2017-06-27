Received: from eggs.gnu.org ([2001:4830:134:3::10]:52521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPwfA-0003Ns-HZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPwf6-0003wP-Jc
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:00:40 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:35952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPwf6-0003wH-Ds
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:00:36 -0400
Received: by mail-qk0-x22b.google.com with SMTP id p21so34668623qke.3
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 13:00:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170627191221.31650-1-laurent@vivier.eu>
	<20170627191221.31650-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0d870134-fd3e-67ca-9112-94672cf7e742@twiddle.net>
Date: Tue, 27 Jun 2017 13:00:31 -0700
MIME-Version: 1.0
In-Reply-To: <20170627191221.31650-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] target/m68k: add fscc.
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

On 06/27/2017 12:12 PM, Laurent Vivier wrote:
>       case 3:  /* Ordered Greater than or Equal Z || !(A || N) */
>       case 19: /* Greater than or Equal Z || !(A || N) */
> +        g_assert(FPSR_CC_A == (FPSR_CC_N >> 3));
> +        c->v1 = tcg_temp_new();
> +        c->g1 = 0;
> +        tcg_gen_shli_i32(c->v1, fpsr, 3);
> +        tcg_gen_or_i32(c->v1, c->v1, fpsr);
> +        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
> +        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_N | FPSR_CC_Z);
> +        c->tcond = TCG_COND_NE;

Still with the unmasked shift.

	tcg_gen_not_i32(c->v1, fpsr);
	tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
	tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_Z);
	tcg_gen_or_i32(c->v1, c->v1, fpsr);


>       case 5:  /* Ordered Less than or Equal Z || (N && !A) */
>       case 21: /* Less than or Equal Z || (N && !A) */
> +        g_assert(FPSR_CC_A == (FPSR_CC_N >> 3));
> +        c->v1 = tcg_temp_new();
> +        c->g1 = 0;
> +        tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_A);
> +        tcg_gen_shli_i32(c->v1, c->v1, 3);
> +        tcg_gen_ori_i32(c->v1, c->v1, FPSR_CC_Z);
> +        tcg_gen_and_i32(c->v1, c->v1, fpsr);
> +        c->tcond = TCG_COND_NE;

Likewise.

	tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
	tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
	tcg_gen_andc_i32(c->v1, fpsr, c->v1);
	tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_Z | FPSR_CC_N);


>       case 10: /* Unordered or Greater Than A || !(N || Z)) */
>       case 26: /* Not Less or Equal A || !(N || Z)) */
> +        g_assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
> +        c->v1 = tcg_temp_new();
> +        c->g1 = 0;
> +        tcg_gen_shli_i32(c->v1, fpsr, 1);
> +        tcg_gen_or_i32(c->v1, c->v1, fpsr);
> +        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
> +        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_N | FPSR_CC_A);
> +        c->tcond = TCG_COND_NE;

Likewise.

	tcg_gen_not_i32(c->v1, fpsr);
	tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_Z | FPSR_CC_N);
	tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_A);
	tcg_gen_or_i32(c->v1, c->v1, fpsr);


>       case 12: /* Unordered or Less Than A || (N && !Z) */
>       case 28: /* Not Greater than or Equal A || (N && !Z) */
> +        c->v1 = tcg_temp_new();
> +        c->g1 = 0;
> +        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
> +        tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
> +        tcg_gen_andc_i32(c->v1, fpsr, c->v1);
> +        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
> +        c->tcond = TCG_COND_NE;

I hadn't meant that this was the only one to fix.


r~
