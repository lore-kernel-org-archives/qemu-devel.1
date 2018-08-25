Received: from eggs.gnu.org ([2001:4830:134:3::10]:34458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftcBx-00023d-TJ
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftcBs-00039X-UJ
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:17:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftcBs-000371-G4
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:17:36 -0400
Received: by mail-pg1-x544.google.com with SMTP id m3-v6so4722215pgp.6
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 10:17:36 -0700 (PDT)
References: <cover.1535133088.git.jancraig@amazon.com>
	<8c9d8af290bc2086b6d685632bc49806cfd40d0a.1535133089.git.jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9066c151-8d7e-7f3e-e93a-88fafc4d2457@linaro.org>
Date: Sat, 25 Aug 2018 10:17:31 -0700
MIME-Version: 1.0
In-Reply-To: <8c9d8af290bc2086b6d685632bc49806cfd40d0a.1535133089.git.jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/mips: Add MXU instruction S8LDD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com

On 08/24/2018 12:44 PM, Craig Janeczek via Qemu-devel wrote:
> +    case OPC_MXU_S8LDD:
> +        gen_load_gpr(t0, opcode->S8LDD.rb);
> +        tcg_gen_movi_tl(t1, opcode->S8LDD.s8);
> +        tcg_gen_ext8s_tl(t1, t1);
> +        tcg_gen_add_tl(t0, t0, t1);

This is

  gen_load_gpr(t0, rb);
  tcg_gen_addi_tl(t0, t0, (int8_t)s8);

> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);

You might want MO_UB so that you don't need

  tcg_gen_andi_tl(t1, t1, 0xff)

in several places.

Hmm.  Of course there's the two sign-extend cases that do want this.  So maybe
some more logic above the load is warranted.

> +        switch (opcode->S8LDD.optn3) {
> +        case 0: /*XRa[7:0] = tmp8 */
> +            tcg_gen_andi_tl(t1, t1, 0xFF);
> +            gen_load_mxu_gpr(t0, opcode->S8LDD.xra);
> +            tcg_gen_andi_tl(t0, t0, 0xFFFFFF00);
> +            tcg_gen_or_tl(t0, t0, t1);

  gen_load_mxu_gpr(t0, xra);
  tcg_gen_deposit_tl(t0, t0, t1, 0, 8);

> +            break;
> +        case 1: /* XRa[15:8] = tmp8 */
> +            tcg_gen_andi_tl(t1, t1, 0xFF);
> +            gen_load_mxu_gpr(t0, opcode->S8LDD.xra);
> +            tcg_gen_andi_tl(t0, t0, 0xFFFF00FF);
> +            tcg_gen_shli_tl(t1, t1, 8);
> +            tcg_gen_or_tl(t0, t0, t1);

  tcg_gen_deposit_tl(t0, t0, t1, 8, 8);

> +        case 4: /* XRa = {8'b0, tmp8, 8'b0, tmp8} */
> +            tcg_gen_andi_tl(t1, t1, 0xFF);
> +            tcg_gen_mov_tl(t0, t1);
> +            tcg_gen_shli_tl(t1, t1, 16);
> +            tcg_gen_or_tl(t0, t0, t1);
> +            break;

  tcg_gen_deposit_tl(t0, t1, t1, 16, 16);

> +        case 5: /* XRa = {tmp8, 8'b0, tmp8, 8'b0} */
> +            tcg_gen_andi_tl(t1, t1, 0xFF);
> +            tcg_gen_shli_tl(t1, t1, 8);
> +            tcg_gen_mov_tl(t0, t1);
> +            tcg_gen_shli_tl(t1, t1, 16);
> +            tcg_gen_or_tl(t0, t0, t1);

  tcg_gen_shli_tl(t1, t1, 8);
  tcg_gen_deposit_tl(t0, t1, t1, 16, 16);

> +        case 7: /* XRa = {tmp8, tmp8, tmp8, tmp8} */
> +            tcg_gen_andi_tl(t1, t1, 0xFF);
> +            tcg_gen_mov_tl(t0, t1);
> +            tcg_gen_shli_tl(t1, t1, 8);
> +            tcg_gen_or_tl(t0, t0, t1);
> +            tcg_gen_shli_tl(t1, t1, 8);
> +            tcg_gen_or_tl(t0, t0, t1);
> +            tcg_gen_shli_tl(t1, t1, 8);
> +            tcg_gen_or_tl(t0, t0, t1);

  tcg_gen_muli_tl(t0, t1, 0x01010101);


r~
