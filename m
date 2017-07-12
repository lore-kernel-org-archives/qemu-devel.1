Received: from eggs.gnu.org ([2001:4830:134:3::10]:43684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVEA0-0000Ty-0I
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVE9v-0002pV-9F
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:20 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVE9v-0002p2-1g
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:15 -0400
Received: by mail-wr0-f180.google.com with SMTP id c11so25698147wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:42:14 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149943378206.8972.1141843062606418973.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149943378206.8972.1141843062606418973.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:41:12 +0100
Message-ID: <87tw2i801z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 25/27] target/arm: [tcg] Port to
 disas_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Incrementally paves the way towards using the generic instruction translation
> loop.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/translate.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 00cac01d66..5db381491f 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -12133,6 +12133,15 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>      }
>  }
>
> +static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +
> +    qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
> +    log_target_disas(cpu, dc->base.pc_first, dc->pc - dc->base.pc_first,
> +                     dc->thumb | (dc->sctlr_b << 1));
> +}
> +
>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>  {
> @@ -12236,9 +12245,7 @@ done_generating:
>          qemu_log_in_addr_range(dc->base.pc_first)) {
>          qemu_log_lock();
>          qemu_log("----------------\n");
> -        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
> -        log_target_disas(cs, dc->base.pc_first, dc->pc - dc->base.pc_first,
> -                         dc->thumb | (dc->sctlr_b << 1));
> +        arm_tr_disas_log(&dc->base, cs);
>          qemu_log("\n");
>          qemu_log_unlock();
>      }


--
Alex Bennée
