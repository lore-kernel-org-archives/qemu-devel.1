Received: from eggs.gnu.org ([2001:4830:134:3::10]:52604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KR5-0005gN-KZ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KR2-0001kS-J2
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:57:27 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KR2-0001kI-DC
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:57:24 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so9861611qka.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:57:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510182636.17791-1-aurelien@aurel32.net>
	<20170510182636.17791-6-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20a5e40b-b286-9b3a-3da0-13100d18d162@amsat.org>
Date: Fri, 12 May 2017 20:57:20 -0300
MIME-Version: 1.0
In-Reply-To: <20170510182636.17791-6-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 05/15] target/sh4: fix BS_STOP exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/10/2017 03:26 PM, Aurelien Jarno wrote:
> When stopping the translation because the state has changed, goto_tb
> should not be used as it might link TB with different flags.
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 2e29936ad8..04bc18bf7c 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1901,8 +1901,9 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>      } else {
>  	switch (ctx.bstate) {
>          case BS_STOP:
> -            /* gen_op_interrupt_restart(); */
> -            /* fall through */
> +            tcg_gen_movi_i32(cpu_pc, ctx.pc);
> +            tcg_gen_exit_tb(0);
> +            break;
>          case BS_NONE:
>              if (ctx.envflags) {
>                  gen_store_flags(ctx.envflags);
>
