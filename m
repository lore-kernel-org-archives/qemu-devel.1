Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fndVS-0003P0-OJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fndVR-0002J4-Tx
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:29:06 -0400
MIME-Version: 1.0
In-Reply-To: <20180809034033.10579-9-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-9-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 9 Aug 2018 07:29:04 +0200
Message-ID: <CABoDooMo8RUN_zN224jOzvGCE5vg9g5UenL3KCNbn+V7_bUkUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/11] target/arm: Fix offset scaling for
 LD_zprr and ST_zprr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org

On Thu, Aug 9, 2018 at 5:40 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The scaling should be solely on the memory operation size; the number
> of registers being loaded does not come in to the initial computation.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Laurent

> ---
>  target/arm/translate-sve.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index f635822a61..d27bc8c946 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4665,8 +4665,7 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
>      }
>      if (sve_access_check(s)) {
>          TCGv_i64 addr = new_tmp_a64(s);
> -        tcg_gen_muli_i64(addr, cpu_reg(s, a->rm),
> -                         (a->nreg + 1) << dtype_msz(a->dtype));
> +        tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
>          tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
>          do_ld_zpa(s, a->rd, a->pg, addr, a->dtype, a->nreg);
>      }
> @@ -4899,7 +4898,7 @@ static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a, uint32_t insn)
>      }
>      if (sve_access_check(s)) {
>          TCGv_i64 addr = new_tmp_a64(s);
> -        tcg_gen_muli_i64(addr, cpu_reg(s, a->rm), (a->nreg + 1) << a->msz);
> +        tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->msz);
>          tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
>          do_st_zpa(s, a->rd, a->pg, addr, a->msz, a->esz, a->nreg);
>      }
> --
> 2.17.1
>
