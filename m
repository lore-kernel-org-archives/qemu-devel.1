Received: from eggs.gnu.org ([2001:4830:134:3::10]:49271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KJ5-0000LJ-2r
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KJ4-00034U-1V
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:49:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-5-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5eb7e467-fd16-b487-c8a6-3a1a4a62f375@amsat.org>
Date: Fri, 12 May 2017 20:48:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170512033543.6789-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/ppc: using various functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

This patch is also incorrect, please see v4.

On 05/12/2017 12:35 AM, Philippe Mathieu-Daudé wrote:
> Patch created mechanically using Coccinelle script via:
>
>     $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
>         --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>
> David I did not add your Reviewed-by as suggested by Laurent Vivier after
> Nikunj A Dadhania review.
>
>  target/ppc/translate.c              |  9 +++------
>  target/ppc/translate/vsx-impl.inc.c | 15 +++++----------
>  2 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f40b5a1abf..64ab412bf3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -868,8 +868,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
>              }
>              tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w/ carry */
>              tcg_temp_free(t1);
> -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
> -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
>              if (is_isa300(ctx)) {
>                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>              }
> @@ -1399,8 +1398,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>              tcg_temp_free(inv1);
>              tcg_gen_xor_tl(cpu_ca, t0, t1);         /* bits changes w/ carry */
>              tcg_temp_free(t1);
> -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
> -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
>              if (is_isa300(ctx)) {
>                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>              }
> @@ -5383,8 +5381,7 @@ static void gen_mfsri(DisasContext *ctx)
>      CHK_SV;
>      t0 = tcg_temp_new();
>      gen_addr_reg_index(ctx, t0);
> -    tcg_gen_shri_tl(t0, t0, 28);
> -    tcg_gen_andi_tl(t0, t0, 0xF);
> +    tcg_gen_extract_tl(t0, t0, 28, 0xF);

WRONG

>      gen_helper_load_sr(cpu_gpr[rd], cpu_env, t0);
>      tcg_temp_free(t0);
>      if (ra != 0 && ra != rd)
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
> index 7f12908029..9faffd2ddc 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1262,8 +1262,7 @@ static void gen_xsxexpqp(DisasContext *ctx)
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> -    tcg_gen_shri_i64(xth, xbh, 48);
> -    tcg_gen_andi_i64(xth, xth, 0x7FFF);
> +    tcg_gen_extract_i64(xth, xbh, 48, 0x7FFF);

WRONG

>      tcg_gen_movi_i64(xtl, 0);
>  }
>
> @@ -1448,10 +1447,8 @@ static void gen_xvxexpdp(DisasContext *ctx)
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> -    tcg_gen_shri_i64(xth, xbh, 52);
> -    tcg_gen_andi_i64(xth, xth, 0x7FF);
> -    tcg_gen_shri_i64(xtl, xbl, 52);
> -    tcg_gen_andi_i64(xtl, xtl, 0x7FF);
> +    tcg_gen_extract_i64(xth, xbh, 52, 0x7FF);
> +    tcg_gen_extract_i64(xtl, xbl, 52, 0x7FF);

WRONG

>  }
>
>  GEN_VSX_HELPER_2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
> @@ -1474,16 +1471,14 @@ static void gen_xvxsigdp(DisasContext *ctx)
>      zr = tcg_const_i64(0);
>      nan = tcg_const_i64(2047);
>
> -    tcg_gen_shri_i64(exp, xbh, 52);
> -    tcg_gen_andi_i64(exp, exp, 0x7FF);
> +    tcg_gen_extract_i64(exp, xbh, 52, 0x7FF);

WRONG

>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
>      tcg_gen_andi_i64(xth, xbh, 0x000FFFFFFFFFFFFF);
>      tcg_gen_or_i64(xth, xth, t0);
>
> -    tcg_gen_shri_i64(exp, xbl, 52);
> -    tcg_gen_andi_i64(exp, exp, 0x7FF);
> +    tcg_gen_extract_i64(exp, xbl, 52, 0x7FF);

WRONG

>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
>
