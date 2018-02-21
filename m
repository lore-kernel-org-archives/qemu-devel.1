Received: from eggs.gnu.org ([2001:4830:134:3::10]:52041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoZ2l-0007IO-5G
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoZ2h-0003da-Up
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:23:03 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eoZ2h-0003cM-JE
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:22:59 -0500
Received: by mail-pf0-x243.google.com with SMTP id s24so995463pfm.4
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:22:59 -0800 (PST)
References: <1518917557-12063-1-git-send-email-cota@braap.org>
	<1518917557-12063-2-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a5ab077-e033-2a89-a3a2-43d2dcaeed8e@linaro.org>
Date: Wed, 21 Feb 2018 10:22:55 -0800
MIME-Version: 1.0
In-Reply-To: <1518917557-12063-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/openrisc: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>

On 02/17/2018 05:32 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/openrisc/translate.c | 87 ++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 44 deletions(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 2747b24..0450144 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -36,7 +36,8 @@
>  #include "exec/log.h"
>  
>  #define LOG_DIS(str, ...) \
> -    qemu_log_mask(CPU_LOG_TB_IN_ASM, "%08x: " str, dc->pc, ## __VA_ARGS__)
> +    qemu_log_mask(CPU_LOG_TB_IN_ASM, "%08x: " str, dc->base.pc_next,    \
> +                  ## __VA_ARGS__)
>  
>  /* is_jmp field values */
>  #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
> @@ -44,13 +45,10 @@
>  #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
>  
>  typedef struct DisasContext {
> -    TranslationBlock *tb;
> -    target_ulong pc;
> -    uint32_t is_jmp;
> +    DisasContextBase base;
>      uint32_t mem_idx;
>      uint32_t tb_flags;
>      uint32_t delayed_branch;
> -    bool singlestep_enabled;
>  } DisasContext;
>  
>  static TCGv cpu_sr;
> @@ -126,9 +124,9 @@ static void gen_exception(DisasContext *dc, unsigned int excp)
>  
>  static void gen_illegal_exception(DisasContext *dc)
>  {
> -    tcg_gen_movi_tl(cpu_pc, dc->pc);
> +    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
>      gen_exception(dc, EXCP_ILLEGAL);
> -    dc->is_jmp = DISAS_UPDATE;
> +    dc->base.is_jmp = DISAS_UPDATE;

Should be NORETURN.

> @@ -1254,14 +1252,14 @@ static void dec_sys(DisasContext *dc, uint32_t insn)
>      switch (op0) {
>      case 0x000:    /* l.sys */
>          LOG_DIS("l.sys %d\n", K16);
> -        tcg_gen_movi_tl(cpu_pc, dc->pc);
> +        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
>          gen_exception(dc, EXCP_SYSCALL);
> -        dc->is_jmp = DISAS_UPDATE;
> +        dc->base.is_jmp = DISAS_UPDATE;

Likewise.


r~
