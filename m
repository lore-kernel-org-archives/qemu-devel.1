Received: from eggs.gnu.org ([2001:4830:134:3::10]:43584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWWz-0002Pe-6O
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWWv-000283-WF
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:21:49 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWWv-00027r-PI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:21:45 -0400
Received: by mail-pg0-x242.google.com with SMTP id x145-v6so2955225pgx.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:21:45 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-37-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7298efee-21de-cac1-f009-ea53a3ade3f9@linaro.org>
Date: Wed, 9 May 2018 14:21:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-37-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/36] target-microblaze: Use
 tcg_gen_movcond in eval_cond_jmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Cleanup eval_cond_jmp to use tcg_gen_movcond_i64().
> No functional change.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 256acce876..a4f6b307d3 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1167,12 +1167,9 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
>  
>  static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
>  {
> -    TCGLabel *l1 = gen_new_label();
> -    /* Conditional jmp.  */
> -    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
> -    tcg_gen_brcondi_i64(TCG_COND_EQ, env_btaken, 0, l1);
> -    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_true);
> -    gen_set_label(l1);
> +    tcg_gen_movcond_i64(TCG_COND_NE, cpu_SR[SR_PC],
> +                        env_btaken, tcg_const_i64(0),
> +                        pc_true, pc_false);

Ah.  I would probably just extend env_btaken here instead of the previous patch.


r~
