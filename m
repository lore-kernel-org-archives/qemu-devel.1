Received: from eggs.gnu.org ([2001:4830:134:3::10]:51583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhdzD-0003Aw-Sb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhdzC-0005qT-Lo
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:47:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhdzC-0005qE-Bl
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:47:02 -0400
Received: by mail-pg1-x543.google.com with SMTP id z8-v6so779647pgu.8
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:47:02 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-27-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11b032da-d6e7-6d1e-8bfa-2d8e7ad0220a@linaro.org>
Date: Mon, 23 Jul 2018 09:46:58 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-27-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 26/40] target/mips: Implement CP0
 Config0.WR bit functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add testing Config0.WR bit into watch exception handling logic.

Config1, here and in the subject.

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.c    | 12 +++++++++++-
>  target/mips/translate.c | 22 ++++++++++++++++------
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index 9535131..dc8f2a5 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -749,6 +749,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
>          (env->hflags & MIPS_HFLAG_DM)) {
>          cs->exception_index = EXCP_DINT;
>      }
> +
> +    if ((cs->exception_index == EXCP_DWATCH ||
> +        cs->exception_index == EXCP_DFWATCH ||
> +        cs->exception_index == EXCP_IWATCH) &&
> +        (env->CP0_Config1 & (1 << CP0C1_WR))) {
> +        cs->exception_index = EXCP_NONE;
> +    }

This will cause the switch below to abort.

In any case, I think this test is a mistake -- you should have (and probably
did, given a presumed lack of abort during testing) prevent these exceptions
from being triggered in the first place.

>      case EXCP_SRESET:
>          env->CP0_Status |= (1 << CP0St_SR);
> -        memset(env->CP0_WatchLo, 0, sizeof(env->CP0_WatchLo));
> +        if (env->CP0_Config1 & (1 << CP0C1_WR)) {
> +            memset(env->CP0_WatchLo, 0, sizeof(env->CP0_WatchLo));
> +        }

If it's unused/missing, why does it hurt to reset to 0?

> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5622,6 +5622,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_1e0i(mfc0_watchlo, arg, sel);
>              rn = "WatchLo";
>              break;
> @@ -5639,6 +5640,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_1e0i(mfc0_watchhi, arg, sel);
>              rn = "WatchHi";
>              break;
> @@ -6321,6 +6323,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_0e1i(mtc0_watchlo, arg, sel);
>              rn = "WatchLo";
>              break;
> @@ -6338,6 +6341,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_0e1i(mtc0_watchhi, arg, sel);
>              rn = "WatchHi";
>              break;
> @@ -7024,6 +7028,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_1e0i(dmfc0_watchlo, arg, sel);
>              rn = "WatchLo";
>              break;
> @@ -7041,6 +7046,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_1e0i(mfc0_watchhi, arg, sel);
>              rn = "WatchHi";
>              break;
> @@ -7705,6 +7711,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_0e1i(mtc0_watchlo, arg, sel);
>              rn = "WatchLo";
>              break;
> @@ -7722,6 +7729,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 5:
>          case 6:
>          case 7:
> +            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
>              gen_helper_0e1i(mtc0_watchhi, arg, sel);
>              rn = "WatchHi";
>              break;

These are probably the only changes required -- preventing the missing
registers from being set at runtime.


> @@ -25281,14 +25289,16 @@ void cpu_state_reset(CPUMIPSState *env)
>         no performance counters. */
>      env->CP0_IntCtl = 0xe0000000;
>      {
> -        int i;
> +        if (env->CP0_Config1 & (1 << CP0C1_WR)) {
> +            int i;
>  
> -        for (i = 0; i < 7; i++) {
> -            env->CP0_WatchLo[i] = 0;
> -            env->CP0_WatchHi[i] = 0x80000000;
> +            for (i = 0; i < 7; i++) {
> +                env->CP0_WatchLo[i] = 0;
> +                env->CP0_WatchHi[i] = 0x80000000;
> +            }
> +            env->CP0_WatchLo[7] = 0;
> +            env->CP0_WatchHi[7] = 0;
>          }
> -        env->CP0_WatchLo[7] = 0;
> -        env->CP0_WatchHi[7] = 0;
>      }

Again, what difference does the reset value make?


r~
