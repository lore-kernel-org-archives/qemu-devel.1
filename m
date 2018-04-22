Received: from eggs.gnu.org ([2001:4830:134:3::10]:55335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAL1v-0000nU-Mk
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAL1s-0002SO-JV
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:52:11 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:34427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAL1s-0002Rf-CB
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:52:08 -0400
Received: by mail-pg0-x233.google.com with SMTP id p10so6872108pgn.1
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:52:08 -0700 (PDT)
References: <1524250517-28032-1-git-send-email-cota@braap.org>
	<1524250517-28032-8-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <95862bc8-ef04-2755-60ca-3ba0e2ac9fd9@linaro.org>
Date: Sun, 22 Apr 2018 09:52:02 -1000
MIME-Version: 1.0
In-Reply-To: <1524250517-28032-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/18] target/mips: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/20/2018 08:55 AM, Emilio G. Cota wrote:
> +#define DISAS_STOP       DISAS_TARGET_0
> +#define DISAS_EXCP       DISAS_TARGET_1
> +#define DISAS_EXIT       DISAS_TARGET_2

DISAS_EXCP should be unused and therefore not exist.

> @@ -8301,7 +8298,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
>                  check_insn(ctx, ISA_MIPS2);
>                  gen_helper_eret(cpu_env);
>              }
> -            ctx->bstate = BS_EXCP;
> +            ctx->is_jmp = DISAS_EXCP;

Should be DISAS_EXIT -- helper_eret has changed both PC and hflags.

> @@ -8316,7 +8313,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
>              generate_exception_end(ctx, EXCP_RI);
>          } else {
>              gen_helper_deret(cpu_env);
> -            ctx->bstate = BS_EXCP;
> +            ctx->is_jmp = DISAS_EXCP;

Likewise.

>          }
>          break;
>      case OPC_WAIT:
> @@ -8331,7 +8328,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
>          save_cpu_state(ctx, 1);
>          ctx->pc -= 4;
>          gen_helper_wait(cpu_env);
> -        ctx->bstate = BS_EXCP;
> +        ctx->is_jmp = DISAS_EXCP;

Should be DISAS_NORETURN, since helper_wait exits via raise_exception.

> -    if (cs->singlestep_enabled && ctx.bstate != BS_BRANCH) {
> -        save_cpu_state(&ctx, ctx.bstate != BS_EXCP);
> +    if (cs->singlestep_enabled && ctx.is_jmp != DISAS_NORETURN) {
> +        save_cpu_state(&ctx, ctx.is_jmp != DISAS_EXCP);

Should be != DISAS_EXIT here, since for exit we have ensured that PC has
already been updated.  C.f. the switch below...

> +        case DISAS_EXIT:
>              tcg_gen_exit_tb(0);
>              break;

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
