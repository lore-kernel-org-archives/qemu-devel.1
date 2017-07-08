Received: from eggs.gnu.org ([2001:4830:134:3::10]:58754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt5g-0001PL-SY
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt5d-0001w6-QN
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:00:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTt5d-0001w0-Lx
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:00:17 -0400
Received: by mail-qt0-f194.google.com with SMTP id m54so7903088qtb.1
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 10:00:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-19-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5debde2c-be50-b809-045d-e9816b888529@amsat.org>
Date: Sat, 8 Jul 2017 13:59:13 -0300
MIME-Version: 1.0
In-Reply-To: <20170707022111.21836-19-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 18/27] target/sh4: Unify code for
 CHECK_NOT_DELAY_SLOT
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
>   target/sh4/translate.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 3453f19..41157a0 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -377,11 +377,8 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
>   #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
>   
>   #define CHECK_NOT_DELAY_SLOT \
> -    if (ctx->envflags & DELAY_SLOT_MASK) {                           \
> -        gen_save_cpu_state(ctx, true);                               \
> -        gen_helper_raise_slot_illegal_instruction(cpu_env);          \
> -        ctx->bstate = BS_EXCP;                                       \
> -        return;                                                      \
> +    if (ctx->envflags & DELAY_SLOT_MASK) {  \
> +        goto do_illegal_slot;               \
>       }
>   
>   #define CHECK_PRIVILEGED                                             \
> @@ -1820,10 +1817,12 @@ static void _decode_opc(DisasContext * ctx)
>   	    ctx->opcode, ctx->pc);
>       fflush(stderr);
>   #endif
> -    gen_save_cpu_state(ctx, true);
>       if (ctx->envflags & DELAY_SLOT_MASK) {
> + do_illegal_slot:
> +        gen_save_cpu_state(ctx, true);
>           gen_helper_raise_slot_illegal_instruction(cpu_env);
>       } else {
> +        gen_save_cpu_state(ctx, true);
>           gen_helper_raise_illegal_instruction(cpu_env);
>       }
>       ctx->bstate = BS_EXCP;
> 
