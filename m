Received: from eggs.gnu.org ([2001:4830:134:3::10]:53249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJdR-0008FC-JM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJdO-0002O9-EE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:33:05 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJdO-0002L5-7F
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:33:02 -0400
Received: by mail-wr0-x22c.google.com with SMTP id r103so38357939wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:33:02 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-17-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-17-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 16:32:59 +0100
Message-ID: <87a8498yc4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/22] tcg: keep a list of TCGContext's
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

Really? Not allocated for each thread that needs it?

> Once that is done, iterating
> over all TCG contexts will be quite useful; for instance we
> will need it to gather profiling info from each TCGContext.

How often will we need to do this and how performance sensitive will it be?

>
> A possible alternative would be to keep an array of TCGContext pointers.
> However this option however is not that trivial, because vCPUs are spawned in
> parallel. So let's just keep it simple and use a list protected by a
> lock.

Given we are protecting with a lock I don't see why it wouldn't be as
equally trivial.

>
> Note that this lock will soon be used for other purposes, hence the
> generic "tcg_lock" name.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tcg/tcg.h |  3 +++
>  tcg/tcg.c | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 534ead5..8e1cd45 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -725,6 +725,8 @@ struct TCGContext {
>
>      uint16_t gen_insn_end_off[TCG_MAX_INSNS];
>      target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
> +
> +    QSIMPLEQ_ENTRY(TCGContext) entry;
>  };
>
>  extern TCGContext tcg_ctx;
> @@ -773,6 +775,7 @@ static inline void *tcg_malloc(int size)
>
>  void tcg_context_init(TCGContext *s);
>  void tcg_prologue_init(TCGContext *s);
> +void tcg_register_thread(void);
>  void tcg_func_start(TCGContext *s);
>
>  int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d9b083a..0da7c61 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -115,7 +115,16 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
>  static void tcg_out_tb_init(TCGContext *s);
>  static bool tcg_out_tb_finalize(TCGContext *s);
>
> +static QemuMutex tcg_lock;
>
> +/*
> + * List of TCGContext's in the system. Protected by tcg_lock.
> + * Once vcpu threads have been inited, there will be no further modifications
> + * to the list (vcpu threads never return) so we can safely traverse the list
> + * without synchronization.
> + */
> +static QSIMPLEQ_HEAD(, TCGContext) ctx_list =
> +    QSIMPLEQ_HEAD_INITIALIZER(ctx_list);
>
>  static TCGRegSet tcg_target_available_regs[2];
>  static TCGRegSet tcg_target_call_clobber_regs;
> @@ -324,6 +333,17 @@ static GHashTable *helper_table;
>  static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
>  static void process_op_defs(TCGContext *s);
>
> +/*
> + * Child TCG threads, i.e. the ones that do not call tcg_context_init, must call
> + * this function before initiating translation.
> + */
> +void tcg_register_thread(void)
> +{
> +    qemu_mutex_lock(&tcg_lock);
> +    QSIMPLEQ_INSERT_TAIL(&ctx_list, &tcg_ctx, entry);
> +    qemu_mutex_unlock(&tcg_lock);
> +}
> +
>  void tcg_context_init(TCGContext *s)
>  {
>      int op, total_args, n, i;
> @@ -381,6 +401,9 @@ void tcg_context_init(TCGContext *s)
>      for (; i < ARRAY_SIZE(tcg_target_reg_alloc_order); ++i) {
>          indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
>      }
> +
> +    qemu_mutex_init(&tcg_lock);
> +    tcg_register_thread();
>  }
>
>  /*


--
Alex Bennée
