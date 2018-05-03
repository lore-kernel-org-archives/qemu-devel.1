Received: from eggs.gnu.org ([2001:4830:134:3::10]:39943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJVo-0004o6-6A
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJVj-0006va-HL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:03:28 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEJVj-0006ur-8g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:03:23 -0400
Received: by mail-pf0-x244.google.com with SMTP id w129so10031851pfd.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 12:03:23 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-21-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <448d1eaa-2ce9-6ce9-ea98-3d00e091f320@linaro.org>
Date: Thu, 3 May 2018 12:03:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-21-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 20/29] target-microblaze: Make special
 registers 64-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Extend special registers to 64-bits. This is in preparation for
> MFSE/MTSE, moves to and from extended special registers.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -1124,13 +1125,13 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
>      }
>  }
>  
> -static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
> +static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i64 pc_false)
>  {
>      TCGLabel *l1 = gen_new_label();
>      /* Conditional jmp.  */
> -    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_false);
> +    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
>      tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
> -    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_true);
> +    tcg_gen_extu_i32_i64(cpu_SR[SR_PC], pc_true);
>      gen_set_label(l1);
>  }

For future cleanup, this should use tcg_gen_movcond_i32.


r~
