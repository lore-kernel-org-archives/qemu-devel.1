Received: from eggs.gnu.org ([2001:4830:134:3::10]:42315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh4Q-0005RU-Sr
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh4N-0006qv-Mf
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:15:02 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh4N-0006ql-IE
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:14:59 -0500
Received: by mail-qt0-x244.google.com with SMTP id s58so26137062qtc.2
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 21:14:59 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170209045154.16868-1-rth@twiddle.net>
	<20170209045154.16868-7-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bf74ca15-db04-185c-8a55-e1199e63c992@gmail.com>
Date: Thu, 9 Feb 2017 02:14:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170209045154.16868-7-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/22] target/openrisc: Tidy insn dumping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, shorne@gmail.com



On 02/09/2017 01:51 AM, Richard Henderson wrote:
> Avoids warnings from unused variables etc.
>
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/translate.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index c207875..ac0c409 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -34,14 +34,8 @@
>  #include "trace-tcg.h"
>  #include "exec/log.h"
>
> -
> -#define OPENRISC_DISAS
> -
> -#ifdef OPENRISC_DISAS
> -#  define LOG_DIS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__)
> -#else
> -#  define LOG_DIS(...) do { } while (0)
> -#endif
> +#define LOG_DIS(str, ...) \
> +    qemu_log_mask(CPU_LOG_TB_IN_ASM, "%08x: " str, dc->pc, ## __VA_ARGS__)
>
>  typedef struct DisasContext {
>      TranslationBlock *tb;
> @@ -766,9 +760,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
>  {
>      uint32_t op0, op1;
>      uint32_t ra, rb, rd;
> -#ifdef OPENRISC_DISAS
>      uint32_t L6, K5;
> -#endif
>      uint32_t I16, I5, I11, N26, tmp;
>      TCGMemOp mop;
>
> @@ -777,10 +769,8 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
>      ra = extract32(insn, 16, 5);
>      rb = extract32(insn, 11, 5);
>      rd = extract32(insn, 21, 5);
> -#ifdef OPENRISC_DISAS
>      L6 = extract32(insn, 5, 6);
>      K5 = extract32(insn, 0, 5);
> -#endif
>      I16 = extract32(insn, 0, 16);
>      I5 = extract32(insn, 21, 5);
>      I11 = extract32(insn, 0, 11);
> @@ -1387,13 +1377,10 @@ static void dec_compi(DisasContext *dc, uint32_t insn)
>  static void dec_sys(DisasContext *dc, uint32_t insn)
>  {
>      uint32_t op0;
> -#ifdef OPENRISC_DISAS
>      uint32_t K16;
> -#endif
> +
>      op0 = extract32(insn, 16, 10);
> -#ifdef OPENRISC_DISAS
>      K16 = extract32(insn, 0, 16);
> -#endif
>
>      switch (op0) {
>      case 0x000:    /* l.sys */
> @@ -1723,6 +1710,13 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
>          max_insns = TCG_MAX_INSNS;
>      }
>
> +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
> +        && qemu_log_in_addr_range(pc_start)) {
> +        qemu_log_lock();
> +        qemu_log("----------------\n");
> +        qemu_log("IN: %s\n", lookup_symbol(pc_start));
> +    }
> +
>      gen_tb_start(tb);
>
>      do {
> @@ -1807,18 +1801,12 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
>      tb->size = dc->pc - pc_start;
>      tb->icount = num_insns;
>
> -#ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(pc_start)) {
> -        qemu_log_lock();
> -        qemu_log("----------------\n");
> -        qemu_log("IN: %s\n", lookup_symbol(pc_start));
> -        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
> -        qemu_log("\nisize=%d osize=%d\n",
> -                 dc->pc - pc_start, tcg_op_buf_count());
> +        log_target_disas(cs, pc_start, tb->size, 0);
> +        qemu_log("\n");
>          qemu_log_unlock();
>      }
> -#endif
>  }
>
>  void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
>
