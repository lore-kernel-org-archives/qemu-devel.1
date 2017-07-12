Received: from eggs.gnu.org ([2001:4830:134:3::10]:52030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJa0-0005mY-5t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJZx-0008Ri-0o
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:29:32 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJZw-0008R9-Qa
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:29:28 -0400
Received: by mail-wr0-x235.google.com with SMTP id 77so38325599wrb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:29:28 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-16-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-16-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 16:29:26 +0100
Message-ID: <87bmop8yi1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 15/22] gen-icount: fold exitreq_label into
 TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Before we make TCGContext thread-local.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  include/exec/gen-icount.h | 7 +++----
>  tcg/tcg.h                 | 2 ++
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 9b3cb14..489aff7 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -6,13 +6,12 @@
>  /* Helpers for instruction counting code generation.  */
>
>  static int icount_start_insn_idx;
> -static TCGLabel *exitreq_label;
>
>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
>      TCGv_i32 count, imm;
>
> -    exitreq_label = gen_new_label();
> +    tcg_ctx.exitreq_label = gen_new_label();
>      if (tb->cflags & CF_USE_ICOUNT) {
>          count = tcg_temp_local_new_i32();
>      } else {
> @@ -34,7 +33,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
>          tcg_temp_free_i32(imm);
>      }
>
> -    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
> +    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx.exitreq_label);
>
>      if (tb->cflags & CF_USE_ICOUNT) {
>          tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
> @@ -52,7 +51,7 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
>          tcg_set_insn_param(icount_start_insn_idx, 1, num_insns);
>      }
>
> -    gen_set_label(exitreq_label);
> +    gen_set_label(tcg_ctx.exitreq_label);
>      tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
>
>      /* Terminate the linked list.  */
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 4f57878..534ead5 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -711,6 +711,8 @@ struct TCGContext {
>      /* The TCGBackendData structure is private to tcg-target.inc.c.  */
>      struct TCGBackendData *be;
>
> +    TCGLabel *exitreq_label;
> +
>      TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
>      TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */


--
Alex Bennée
