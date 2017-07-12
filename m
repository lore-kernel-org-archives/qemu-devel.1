Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVK6j-0004Pj-Ok
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVK6f-0007eD-SE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:03:21 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVK6f-0007cL-Kb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:03:17 -0400
Received: by mail-wr0-f179.google.com with SMTP id k67so39255218wrc.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:03:15 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-20-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-20-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 17:02:12 +0100
Message-ID: <8737a18wzf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/22] tcg: introduce tcg_context_clone
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
> ---
>  tcg/tcg.h |  1 +
>  tcg/tcg.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 2a64ee2..be5f3fd 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -778,6 +778,7 @@ static inline void *tcg_malloc(int size)
>  }
>
>  void tcg_context_init(TCGContext *s);
> +void tcg_context_clone(TCGContext *s);
>  void tcg_prologue_init(TCGContext *s);
>  void tcg_register_thread(void);
>  void tcg_func_start(TCGContext *s);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 2f003a0..8febf53 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -117,6 +117,7 @@ static bool tcg_out_tb_finalize(TCGContext *s);
>
>  #define TCG_HIGHWATER 1024
>
> +static const TCGContext *tcg_init_ctx;
>  static QemuMutex tcg_lock;
>
>  /*
> @@ -353,6 +354,7 @@ void tcg_context_init(TCGContext *s)
>      TCGArgConstraint *args_ct;
>      int *sorted_args;
>
> +    tcg_init_ctx = s;
>      memset(s, 0, sizeof(*s));
>      s->nb_globals = 0;
>
> @@ -409,6 +411,18 @@ void tcg_context_init(TCGContext *s)
>  }
>
>  /*
> + * Clone the initial TCGContext. Used by TCG threads to copy the TCGContext
> + * set up by their parent thread via tcg_context_init().
> + */
> +void tcg_context_clone(TCGContext *s)
> +{
> +    if (unlikely(tcg_init_ctx == NULL || tcg_init_ctx == s)) {
> +        tcg_abort();
> +    }
> +    memcpy(s, tcg_init_ctx, sizeof(*s));
> +}
> +

Why a copy approach as opposed to a plain tcg_context_new() with the
appropriate init cleanup. Is is it just because of the extra shared
stuff in:

#if defined(CONFIG_SOFTMMU)
    /* There's no guest base to take into account, so go ahead and
       initialize the prologue now.  */
    tcg_prologue_init(&tcg_ctx);
    code_gen_set_region_size(&tcg_ctx);
#endif

?

> +/*
>   * Allocate TBs right before their corresponding translated code, making
>   * sure that TBs and code are on different cache lines.
>   */


--
Alex Bennée
