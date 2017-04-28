Received: from eggs.gnu.org ([2001:4830:134:3::10]:56512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d445q-0007e7-GJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d445m-0004Lj-5d
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:29:46 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d445l-0004Kj-UT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:29:42 -0400
Received: by mail-wm0-x235.google.com with SMTP id r190so44029204wme.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 04:29:41 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-9-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-9-rth@twiddle.net>
Date: Fri, 28 Apr 2017 12:30:11 +0100
Message-ID: <87tw587osc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 08/19] target/arm: optimize cross-page
 direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Instead of unconditionally exiting to the exec loop, use the
> lookup_and_goto_ptr helper to jump to the target if it is valid.
>
> Perf impact: see next commit's log.
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Message-Id: <1493263764-18657-7-git-send-email-cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/translate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0b5a0bc..facb52f 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -4153,8 +4153,12 @@ static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
>          gen_set_pc_im(s, dest);
>          tcg_gen_exit_tb((uintptr_t)s->tb + n);
>      } else {
> +        TCGv addr = tcg_temp_new();
> +
>          gen_set_pc_im(s, dest);
> -        tcg_gen_exit_tb(0);
> +        tcg_gen_extu_i32_tl(addr, cpu_R[15]);
> +        tcg_gen_lookup_and_goto_ptr(addr);
> +        tcg_temp_free(addr);
>      }
>  }


--
Alex Bennée
