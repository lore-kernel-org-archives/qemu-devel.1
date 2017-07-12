Received: from eggs.gnu.org ([2001:4830:134:3::10]:57323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVL8X-0000Pr-Rb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVL8U-0004Ya-Kt
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:09:17 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVL8U-0004YS-Ge
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:09:14 -0400
Received: by mail-qt0-x243.google.com with SMTP id m54so2877608qtb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 10:09:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-5-git-send-email-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <551e5233-c92a-dd65-e09f-8c20a139df77@amsat.org>
Date: Wed, 12 Jul 2017 14:09:11 -0300
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-5-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/22] tcg: fix corruption of code_time
 profiling counter upon tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/09/2017 04:49 AM, Emilio G. Cota wrote:
> Whenever there is an overflow in code_gen_buffer (e.g. we run out
> of space in it and have to flush it), the code_time profiling counter
> ends up with an invalid value (that is, code_time -= profile_getclock(),
> without later on getting += profile_getclock() due to the goto).
[...]
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   accel/tcg/translate-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a936a5f..72ce445 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1293,7 +1293,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>   #ifdef CONFIG_PROFILER
>       tcg_ctx.tb_count++;
>       tcg_ctx.interm_time += profile_getclock() - ti;
> -    tcg_ctx.code_time -= profile_getclock();
> +    ti = profile_getclock();
>   #endif
>   
>       /* ??? Overflow could be handled better here.  In particular, we
> @@ -1311,7 +1311,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       }
>   
>   #ifdef CONFIG_PROFILER
> -    tcg_ctx.code_time += profile_getclock();
> +    tcg_ctx.code_time += profile_getclock() - ti;
>       tcg_ctx.code_in_len += tb->size;
>       tcg_ctx.code_out_len += gen_code_size;
>       tcg_ctx.search_out_len += search_size;
> 
