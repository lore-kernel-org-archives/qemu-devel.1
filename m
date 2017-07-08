Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt6V-0001p0-14
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt6S-0002K9-0X
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:01:11 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt6R-0002Jf-SR
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:01:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id 16so8008527qkg.2
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 10:01:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-20-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c777625-b977-0796-6f0a-c9a34bdfcfb9@amsat.org>
Date: Sat, 8 Jul 2017 14:00:03 -0300
MIME-Version: 1.0
In-Reply-To: <20170707022111.21836-20-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 19/27] target/sh4: Unify code for
 CHECK_PRIVILEGED
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
>   target/sh4/translate.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 41157a0..dd14b43 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -381,16 +381,9 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
>           goto do_illegal_slot;               \
>       }
>   
> -#define CHECK_PRIVILEGED                                             \
> -    if (IS_USER(ctx)) {                                              \
> -        gen_save_cpu_state(ctx, true);                               \
> -        if (ctx->envflags & DELAY_SLOT_MASK) {                       \
> -            gen_helper_raise_slot_illegal_instruction(cpu_env);      \
> -        } else {                                                     \
> -            gen_helper_raise_illegal_instruction(cpu_env);           \
> -        }                                                            \
> -        ctx->bstate = BS_EXCP;                                       \
> -        return;                                                      \
> +#define CHECK_PRIVILEGED \
> +    if (IS_USER(ctx)) {                     \
> +        goto do_illegal;                    \
>       }
>   
>   #define CHECK_FPU_ENABLED                                            \
> @@ -1817,6 +1810,7 @@ static void _decode_opc(DisasContext * ctx)
>   	    ctx->opcode, ctx->pc);
>       fflush(stderr);
>   #endif
> + do_illegal:
>       if (ctx->envflags & DELAY_SLOT_MASK) {
>    do_illegal_slot:
>           gen_save_cpu_state(ctx, true);
> 
