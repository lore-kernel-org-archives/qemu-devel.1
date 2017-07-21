Received: from eggs.gnu.org ([2001:4830:134:3::10]:43380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfcK-0000M1-3c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfcH-0002UU-1F
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:37:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYfcG-0002U9-KH
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:37:44 -0400
Date: Fri, 21 Jul 2017 17:37:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721213743.GE10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-8-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-8-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 07/34] target/arm: Set is_jmp properly
 after single-stepping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:16 -1000, Richard Henderson wrote:
> We have generated an exception, so use DISAS_NORETURN.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate-a64.c | 1 +
>  target/arm/translate.c     | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 342ff7c..657684b 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11285,6 +11285,7 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
>                          dc->is_jmp = DISAS_UPDATE;
>                      } else {
>                          gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
> +                        dc->is_jmp = DISAS_NORETURN;
>                          /* The address covered by the breakpoint must be
>                             included in [tb->pc, tb->pc + tb->size) in order
>                             to for it to be properly cleared -- thus we
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2ae68ce..83e5491 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11942,6 +11942,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>                          dc->is_jmp = DISAS_UPDATE;
>                      } else {
>                          gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
> +                        dc->is_jmp = DISAS_NORETURN;

gen_exception_internal_insn already sets dc->is_jmp to DISAS_NORETURN,
as per patch 04/34:
@@ -304,7 +304,7 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 {
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp = DISAS_EXC;
+    s->is_jmp = DISAS_NORETURN;
 }

This applies to both arm and a64.

Why do we need to set is_jmp again, then?

		E.
