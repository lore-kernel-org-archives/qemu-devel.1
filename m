Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJNUh-0007u8-OE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJNUd-0005CB-NC
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:19:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJNUd-0005As-JY
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:19:11 -0400
Received: by mail-qt0-x243.google.com with SMTP id j42-v6so6982241qtj.12
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 11:19:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-32-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3263f5b9-7eb0-ba3c-56a7-af95513bee5a@amsat.org>
Date: Thu, 17 May 2018 15:19:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-32-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 31/38] target-microblaze: Simplify
 address computation using tcg_gen_addi_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On 05/16/2018 03:51 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Simplify address computation using tcg_gen_addi_i32().
> tcg_gen_addi_i32() already optimizes the case when the
> immediate is zero.
> 
> No functional change.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/microblaze/translate.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 39c4d0654e..44395cf189 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -899,12 +899,7 @@ static inline void compute_ldst_addr(DisasContext *dc, bool ea, TCGv t)
>      /* Immediate.  */
>      t32 = tcg_temp_new_i32();
>      if (!extimm) {
> -        if (dc->imm == 0) {
> -            tcg_gen_mov_i32(t32, cpu_R[dc->ra]);
> -        } else {
> -            tcg_gen_movi_i32(t32, (int32_t)((int16_t)dc->imm));
> -            tcg_gen_add_i32(t32, cpu_R[dc->ra], t32);
> -        }
> +        tcg_gen_addi_i32(t32, cpu_R[dc->ra], (int16_t)dc->imm);
>      } else {
>          tcg_gen_add_i32(t32, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
>      }
> 
