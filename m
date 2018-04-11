Received: from eggs.gnu.org ([2001:4830:134:3::10]:56792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f6Ncf-0007nq-8Y
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f6Ncd-00080c-Uc
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:49:45 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f6Ncd-00080F-Ln
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:49:43 -0400
Received: by mail-ot0-x244.google.com with SMTP id m22-v6so3711954otf.8
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 14:49:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523377186-32578-2-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<1523377186-32578-2-git-send-email-cota@braap.org>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 12 Apr 2018 09:49:42 +1200
Message-ID: <CAHNT7Ntqg_G21Wieh-AvV7fjvo0bcLTsJGwdJy0fYFU6qsmPfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/10] target/riscv: avoid integer overflow
 in next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, Apr 11, 2018 at 4:19 AM, Emilio G. Cota <cota@braap.org> wrote:

> If the PC is in the last page of the address space, next_page_start
> overflows to 0. Fix it.
>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  target/riscv/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 808eab7..d2d2e5e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1849,11 +1849,11 @@ void gen_intermediate_code(CPUState *cs,
> TranslationBlock *tb)
>      CPURISCVState *env = cs->env_ptr;
>      DisasContext ctx;
>      target_ulong pc_start;
> -    target_ulong next_page_start;
> +    target_ulong page_start;
>      int num_insns;
>      int max_insns;
>      pc_start = tb->pc;
> -    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +    page_start = pc_start & TARGET_PAGE_MASK;
>      ctx.pc = pc_start;
>
>      /* once we have GDB, the rest of the translate.c implementation
> should be
> @@ -1903,7 +1903,7 @@ void gen_intermediate_code(CPUState *cs,
> TranslationBlock *tb)
>          if (cs->singlestep_enabled) {
>              break;
>          }
> -        if (ctx.pc >= next_page_start) {
> +        if (ctx.pc - page_start >= TARGET_PAGE_SIZE) {
>              break;
>          }
>          if (tcg_op_buf_full()) {
> --
> 2.7.4
>
>
