Received: from eggs.gnu.org ([2001:4830:134:3::10]:40517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kOd-0004KX-78
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kOc-0000kQ-7y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:56:39 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kOc-0000jz-1D
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:56:38 -0400
Received: by mail-pf0-x241.google.com with SMTP id p15so7130810pff.11
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:56:37 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-7-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a95ec4d4-72f7-486d-4123-a7bd4740cf03@linaro.org>
Date: Tue, 10 Apr 2018 13:56:25 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-7-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/17] target/mips: convert to
 DisasJumpType
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

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/mips/translate.c | 186 +++++++++++++++++++++++-------------------------
>  1 file changed, 91 insertions(+), 95 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d05ee67..a133205 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -36,6 +36,7 @@
>  
>  #include "target/mips/trace.h"
>  #include "trace-tcg.h"
> +#include "exec/translator.h"
>  #include "exec/log.h"
>  
>  #define MIPS_DEBUG_DISAS 0
> @@ -1439,7 +1440,7 @@ typedef struct DisasContext {
>      int mem_idx;
>      TCGMemOp default_tcg_memop_mask;
>      uint32_t hflags, saved_hflags;
> -    int bstate;
> +    DisasJumpType is_jmp;
>      target_ulong btarget;
>      bool ulri;
>      int kscrexist;
> @@ -1460,13 +1461,8 @@ typedef struct DisasContext {
>      bool abs2008;
>  } DisasContext;
>  
> -enum {
> -    BS_NONE     = 0, /* We go out of the TB without reaching a branch or an
> -                      * exception condition */
> -    BS_STOP     = 1, /* We want to stop translation for any reason */
> -    BS_BRANCH   = 2, /* We reached a branch condition     */
> -    BS_EXCP     = 3, /* We reached an exception condition */
> -};
> +#define DISAS_STOP       DISAS_TARGET_0
> +#define DISAS_EXCP       DISAS_TARGET_1

Ok, well, there are existing bugs within the MIPS translation here, and we
might as well fix them within this patch set.

(1) The description for BS_STOP says we want to stop, but (what will become)
mips_tr_tb_stop calls goto_tb.

That's not correct, since we use that after e.g. helper_mtc0_hwrena,
MIPS_HFLAG_HWRENA_ULR is included in tb->flags, and therefore the next TB is
not fixed but depends on the actual value stored into hwrena.

We should instead use lookup_and_goto_ptr, which does a full lookup of the
processor state every time through.

(2) The BS_EXCP in generate_exception_err should map to DISAS_NORETURN, because
we do not return after raising an exception.

(3) Otherwise, the use of BS_EXCP has nothing to do with an exception; e.g.

>         case 0:
>             save_cpu_state(ctx, 1);
>             gen_helper_mtc0_status(cpu_env, arg);
>             /* BS_STOP isn't good enough here, hflags may have changed. */
>             gen_save_pc(ctx->pc + 4);
>             ctx->bstate = BS_EXCP;
>             rn = "Status";
>             break;

where we are in fact relying on (what will become) mips_tr_tb_stop to emit
exit_tb.  It would be better to name these uses DISAS_EXIT, which would match
e.g. target/arm.



r~
