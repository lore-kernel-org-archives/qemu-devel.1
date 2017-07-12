Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVIks-00075A-Fv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVIkp-0003Ib-UL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:36:42 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVIkp-0003HW-N2
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:36:39 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c11so36208152wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:36:39 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-5-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-5-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 15:36:36 +0100
Message-ID: <87o9sp90y3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Whenever there is an overflow in code_gen_buffer (e.g. we run out
> of space in it and have to flush it), the code_time profiling counter
> ends up with an invalid value (that is, code_time -= profile_getclock(),
> without later on getting += profile_getclock() due to the goto).
>
> Fix it by using the ti variable, so that we only update code_time
> when there is no overflow. Note that in case there is an overflow
> we fail to account for the elapsed coding time, but this is quite rare
> so we can probably live with it.
>
<snip>
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a936a5f..72ce445 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1293,7 +1293,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>  #ifdef CONFIG_PROFILER
>      tcg_ctx.tb_count++;
>      tcg_ctx.interm_time += profile_getclock() - ti;
> -    tcg_ctx.code_time -= profile_getclock();
> +    ti = profile_getclock();
>  #endif
>
>      /* ??? Overflow could be handled better here.  In particular, we
> @@ -1311,7 +1311,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      }
>
>  #ifdef CONFIG_PROFILER
> -    tcg_ctx.code_time += profile_getclock();
> +    tcg_ctx.code_time += profile_getclock() - ti;
>      tcg_ctx.code_in_len += tb->size;
>      tcg_ctx.code_out_len += gen_code_size;
>      tcg_ctx.search_out_len += search_size;


--
Alex Bennée
