Received: from eggs.gnu.org ([2001:4830:134:3::10]:52865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJQM-0002Ct-QH
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJQJ-0004oa-OJ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:58:30 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJQJ-0004oQ-KK
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:58:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id l132-v6so3658717qke.3
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 06:58:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-29-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d8c3a2fb-ad7b-50a4-72af-9f8effb0e47e@amsat.org>
Date: Thu, 17 May 2018 10:58:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-29-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 28/38] target-microblaze: dec_msr: Plug
 a temp leak
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
> Plug a temp leak.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/microblaze/translate.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 03a0289858..cf1b87c09e 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -516,12 +516,17 @@ static void dec_msr(DisasContext *dc)
>  #if !defined(CONFIG_USER_ONLY)
>      /* Catch read/writes to the mmu block.  */
>      if ((sr & ~0xff) == 0x1000) {
> +        TCGv_i32 tmp_sr;
> +
>          sr &= 7;
> +        tmp_sr = tcg_const_i32(sr);
>          LOG_DIS("m%ss sr%d r%d imm=%x\n", to ? "t" : "f", sr, dc->ra, dc->imm);
> -        if (to)
> -            gen_helper_mmu_write(cpu_env, tcg_const_i32(sr), cpu_R[dc->ra]);
> -        else
> -            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tcg_const_i32(sr));
> +        if (to) {
> +            gen_helper_mmu_write(cpu_env, tmp_sr, cpu_R[dc->ra]);
> +        } else {
> +            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tmp_sr);
> +        }
> +        tcg_temp_free_i32(tmp_sr);
>          return;
>      }
>  #endif
> 
