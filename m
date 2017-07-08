Received: from eggs.gnu.org ([2001:4830:134:3::10]:59722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt6k-0001wa-ON
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt6g-0002XW-K3
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:01:25 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt6g-0002UK-Fi
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:01:22 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so7909352qta.2
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 10:01:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-21-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13fc50d3-1aea-6c60-f11c-403b5a19778e@amsat.org>
Date: Sat, 8 Jul 2017 14:01:15 -0300
MIME-Version: 1.0
In-Reply-To: <20170707022111.21836-21-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 20/27] target/sh4: Unify code for
 CHECK_FPU_ENABLED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: bruno@clisp.org, laurent@vivier.eu, aurelien@aurel32.net, glaubitz@debian.org

On 07/06/2017 11:21 PM, Richard Henderson wrote:
> We do not need to emit N copies of raising an exception.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/sh4/translate.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index dd14b43..a4370c6 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -386,16 +386,9 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
>           goto do_illegal;                    \
>       }
>   
> -#define CHECK_FPU_ENABLED                                            \
> -    if (ctx->tbflags & (1u << SR_FD)) {                              \
> -        gen_save_cpu_state(ctx, true);                               \
> -        if (ctx->envflags & DELAY_SLOT_MASK) {                       \
> -            gen_helper_raise_slot_fpu_disable(cpu_env);              \
> -        } else {                                                     \
> -            gen_helper_raise_fpu_disable(cpu_env);                   \
> -        }                                                            \
> -        ctx->bstate = BS_EXCP;                                       \
> -        return;                                                      \
> +#define CHECK_FPU_ENABLED \
> +    if (ctx->tbflags & (1u << SR_FD)) {     \
> +        goto do_fpu_disabled;               \
>       }
>   
>   static void _decode_opc(DisasContext * ctx)
> @@ -1820,6 +1813,17 @@ static void _decode_opc(DisasContext * ctx)
>           gen_helper_raise_illegal_instruction(cpu_env);
>       }
>       ctx->bstate = BS_EXCP;
> +    return;
> +
> + do_fpu_disabled:
> +    gen_save_cpu_state(ctx, true);
> +    if (ctx->envflags & DELAY_SLOT_MASK) {
> +        gen_helper_raise_slot_fpu_disable(cpu_env);
> +    } else {
> +        gen_helper_raise_fpu_disable(cpu_env);
> +    }
> +    ctx->bstate = BS_EXCP;
> +    return;
>   }
>   
>   static void decode_opc(DisasContext * ctx)
> 
