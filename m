Received: from eggs.gnu.org ([2001:4830:134:3::10]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dV0nv-0007cx-Lm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dV0nr-00028z-MW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:26:39 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dV0nr-00028m-F7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:26:35 -0400
Received: by mail-wr0-f177.google.com with SMTP id k67so2510720wrc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 12:26:35 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942810176.8972.2271168155656858925.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149942810176.8972.2271168155656858925.stgit@frigg.lan>
Date: Tue, 11 Jul 2017 20:25:32 +0100
Message-ID: <87d196ai8j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 02/27] cpu-exec: Avoid global variables
 in icount-related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>

I guess. I assume this is also something Emilio is targeting with his
multi-threaded translation work.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  include/exec/gen-icount.h |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 62d462e494..6c28ef59c3 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -19,7 +19,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
>          count = tcg_temp_new_i32();
>      }
>
> -    tcg_gen_ld_i32(count, cpu_env,
> +    tcg_gen_ld_i32(count, tcg_ctx.tcg_env,
>                     -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
>
>      if (tb->cflags & CF_USE_ICOUNT) {
> @@ -37,7 +37,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
>      tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
>
>      if (tb->cflags & CF_USE_ICOUNT) {
> -        tcg_gen_st16_i32(count, cpu_env,
> +        tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
>                           -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
>      }
>
> @@ -62,14 +62,16 @@ static void gen_tb_end(TranslationBlock *tb, int num_insns)
>  static inline void gen_io_start(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(1);
> -    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
> +    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
> +                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
>      tcg_temp_free_i32(tmp);
>  }
>
>  static inline void gen_io_end(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(0);
> -    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
> +    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
> +                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
>      tcg_temp_free_i32(tmp);
>  }
>


--
Alex Bennée
