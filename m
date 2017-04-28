Received: from eggs.gnu.org ([2001:4830:134:3::10]:34702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d49C2-0006l8-Hv
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d49Bz-0008CW-DY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:56:30 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d49Bz-0008CK-6L
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:56:27 -0400
Received: by mail-wm0-x233.google.com with SMTP id u65so47331577wmu.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:56:26 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-12-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-12-rth@twiddle.net>
Date: Fri, 28 Apr 2017 17:56:57 +0100
Message-ID: <87r30c79nq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 11/19] target/i386: optimize cross-page
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
> gen_jr helper to jump to the target if it is valid.
>
> Perf impact: see next commit's log.
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Message-Id: <1493263764-18657-10-git-send-email-cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/i386/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index f0e48dc..ea113fe 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -2154,9 +2154,9 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num, target_ulong eip)
>          gen_jmp_im(eip);
>          tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
>      } else {
> -        /* jump to another page: currently not optimized */
> +        /* jump to another page */
>          gen_jmp_im(eip);
> -        gen_eob(s);
> +        gen_jr(s, cpu_tmp0);


I had to look up what was going on with cpu_tmp0 there. Is there a
particular reason i386 has these global temps with implied setting
rules? It does seem somewhat hacky.

Given cmp_tmp0 seems to be a heavily used across i386 I guess it keeps
to the style of the translator :-/


>      }
>  }


--
Alex Bennée
