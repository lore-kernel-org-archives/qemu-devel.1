Received: from eggs.gnu.org ([2001:4830:134:3::10]:49885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IH-000120-T6
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IE-0002jf-4o
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:29 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f73ID-0002jJ-T3
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:26 -0400
Received: by mail-pf0-x242.google.com with SMTP id o16so6504987pfk.9
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:19:25 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-16-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2df70f6-877d-42e5-5fad-2ce5666c77c0@linaro.org>
Date: Thu, 12 Apr 2018 18:24:50 -1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-16-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/17] target/riscv: convert to
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
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/translate.c | 72 +++++++++++++++++++-----------------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -1345,12 +1339,12 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
>              /* always generates U-level ECALL, fixed in do_interrupt handler */
>              generate_exception(ctx, RISCV_EXCP_U_ECALL);
>              tcg_gen_exit_tb(0); /* no chaining */
> -            ctx->bstate = BS_BRANCH;
> +            ctx->is_jmp = DISAS_NORETURN;
>              break;
>          case 0x1: /* EBREAK */
>              generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
>              tcg_gen_exit_tb(0); /* no chaining */
> -            ctx->bstate = BS_BRANCH;
> +            ctx->is_jmp = DISAS_NORETURN;
>              break;

Not for Emilio, but for the RISCV guys as a follow-up, exit_tb after
generate_exception is dead code -- we have already exited via longjmp.  There
are more than these two instances.


r~
