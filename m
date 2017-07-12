Received: from eggs.gnu.org ([2001:4830:134:3::10]:38556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDql-00044u-7z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDqh-0002f2-U5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:22:27 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVDqh-0002es-Nn
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:22:23 -0400
Received: by mail-wr0-f180.google.com with SMTP id c11so25011329wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:22:23 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942933722.8972.9785573707546033518.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149942933722.8972.9785573707546033518.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:21:21 +0100
Message-ID: <8760ey9fji.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 07/27] target/i386: [tcg] Port to
 insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Incrementally paves the way towards using the generic instruction translation
> loop.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/i386/translate.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 7819545e37..a4b9e5628f 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8448,6 +8448,13 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>      cpu_cc_srcT = tcg_temp_local_new();
>  }
>
> +static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +
> +    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
> +}
> +
>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>  {
> @@ -8475,7 +8482,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>
>      gen_tb_start(tb);
>      for(;;) {
> -        tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
> +        i386_tr_insn_start(&dc->base, cs);
>          num_insns++;
>
>          /* If RF is set, suppress an internally generated breakpoint.  */


--
Alex Bennée
