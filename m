Received: from eggs.gnu.org ([2001:4830:134:3::10]:35146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfDu-00064r-DK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfDq-0000HL-GC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:23:14 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqfDq-0000Gh-AI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:23:10 -0500
Received: by mail-oi0-x242.google.com with SMTP id x12so12810177oie.13
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:23:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-46-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 13:22:49 +0000
Message-ID: <CAFEAcA_x-=F8R20MQW_Ao86+_3eE80Mu-i387JYGr4utaSKtEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 45/67] target/arm: Implement SVE Memory
 Contiguous Store Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  29 +++++++
>  target/arm/sve_helper.c    | 211 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  68 ++++++++++++++-
>  target/arm/sve.decode      |  38 ++++++++
>  4 files changed, 343 insertions(+), 3 deletions(-)

> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index aa8bfd2ae7..fda9a56fd5 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3320,7 +3320,6 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
>
>      tcg_temp_free_ptr(t_pg);
>      tcg_temp_free_i32(desc);
> -    tcg_temp_free_i64(addr);
>  }
>
>  static void do_ld_zpa(DisasContext *s, int zt, int pg,
> @@ -3368,7 +3367,7 @@ static void trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
>          return;
>      }
>
> -    addr = tcg_temp_new_i64();
> +    addr = new_tmp_a64(s);
>      tcg_gen_muli_i64(addr, cpu_reg(s, a->rm),
>                       (a->nreg + 1) << dtype_msz(a->dtype));
>      tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
> @@ -3379,7 +3378,7 @@ static void trans_LD_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
>  {
>      unsigned vsz = vec_full_reg_size(s);
>      unsigned elements = vsz >> dtype_esz[a->dtype];
> -    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 addr = new_tmp_a64(s);
>
>      tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn),
>                       (a->imm * elements * (a->nreg + 1))

These changes to the load functions look like they should have been
in the previous patch ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
