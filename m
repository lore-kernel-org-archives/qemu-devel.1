Received: from eggs.gnu.org ([2001:4830:134:3::10]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pnd-0002AB-Uw
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pna-00008h-Po
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:22:41 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:50020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pna-00008Q-La
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:22:38 -0400
Received: by mail-qt0-x243.google.com with SMTP id k31so28809957qta.6
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 20:22:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83bf0768-25b0-b990-70d1-82c7a69e3f57@amsat.org>
Date: Tue, 24 Oct 2017 00:22:34 -0300
MIME-Version: 1.0
In-Reply-To: <20171020232023.15010-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 21/52] tcg: Use offsets not indices for
 TCGv_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

On 10/20/2017 08:19 PM, Richard Henderson wrote:
> Using the offset of a temporary, relative to TCGContext, rather than
> its index means that we don't use 0.  That leaves offset 0 free for
> a NULL representation without having to leave index 0 unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.h | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 8f692bc6cf..7fe0fb9e07 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -429,13 +429,13 @@ typedef TCGv_ptr TCGv_env;
>  #endif
>  
>  /* Dummy definition to avoid compiler warnings.  */
> -#define TCGV_UNUSED_I32(x) (x = (TCGv_i32)-1)
> -#define TCGV_UNUSED_I64(x) (x = (TCGv_i64)-1)
> -#define TCGV_UNUSED_PTR(x) (x = (TCGv_ptr)-1)
> +#define TCGV_UNUSED_I32(x) (x = (TCGv_i32)NULL)
> +#define TCGV_UNUSED_I64(x) (x = (TCGv_i64)NULL)
> +#define TCGV_UNUSED_PTR(x) (x = (TCGv_ptr)NULL)
>  
> -#define TCGV_IS_UNUSED_I32(x) ((x) == (TCGv_i32)-1)
> -#define TCGV_IS_UNUSED_I64(x) ((x) == (TCGv_i64)-1)
> -#define TCGV_IS_UNUSED_PTR(x) ((x) == (TCGv_ptr)-1)
> +#define TCGV_IS_UNUSED_I32(x) ((x) == (TCGv_i32)NULL)
> +#define TCGV_IS_UNUSED_I64(x) ((x) == (TCGv_i64)NULL)
> +#define TCGV_IS_UNUSED_PTR(x) ((x) == (TCGv_ptr)NULL)
>  
>  /* call flags */
>  /* Helper does not read globals (either directly or through an exception). It
> @@ -454,7 +454,7 @@ typedef TCGv_ptr TCGv_env;
>  #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
>  
>  /* used to align parameters */
> -#define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
> +#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
>  
>  /* Conditions.  Note that these are laid out for easy manipulation by
>     the functions below:
> @@ -701,17 +701,20 @@ static inline size_t temp_idx(TCGTemp *ts)
>  
>  static inline TCGArg temp_arg(TCGTemp *ts)
>  {
> -    return temp_idx(ts);
> +    ptrdiff_t a = (void *)ts - (void *)&tcg_ctx;
> +    tcg_debug_assert(a >= offsetof(TCGContext, temps)
> +                     && a < offsetof(TCGContext, temps[tcg_ctx.nb_temps]));
> +    return a;
>  }
>  
>  static inline TCGTemp *arg_temp(TCGArg a)
>  {
> -    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
> -}
> -
> -static inline size_t arg_index(TCGArg a)
> -{
> -    return a;
> +    if (a == TCG_CALL_DUMMY_ARG) {
> +        return NULL;
> +    }
> +    tcg_debug_assert(a >= offsetof(TCGContext, temps)
> +                     && a < offsetof(TCGContext, temps[tcg_ctx.nb_temps]));
> +    return (void *)&tcg_ctx + a;

Hmmm why not cast it as TCGTemp*?

>  }
>  
>  static inline TCGArg tcgv_i32_arg(TCGv_i32 t)
> @@ -746,17 +749,17 @@ static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr t)
>  
>  static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
>  {
> -    return (TCGv_i32)temp_idx(t);
> +    return (TCGv_i32)temp_arg(t);
>  }
>  
>  static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
>  {
> -    return (TCGv_i64)temp_idx(t);
> +    return (TCGv_i64)temp_arg(t);
>  }
>  
>  static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
>  {
> -    return (TCGv_ptr)temp_idx(t);
> +    return (TCGv_ptr)temp_arg(t);
>  }
>  
>  #if TCG_TARGET_REG_BITS == 32
> 
