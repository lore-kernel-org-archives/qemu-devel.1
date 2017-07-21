Received: from eggs.gnu.org ([2001:4830:134:3::10]:53276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgZy-0004vx-Fh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgZv-0008TT-By
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:39:26 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:41366)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgZu-0008TH-W2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:39:23 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-8-rth@twiddle.net>
Date: Sat, 22 Jul 2017 01:39:12 +0300
In-Reply-To: <20170715094243.28371-8-rth@twiddle.net> (Richard Henderson's
	message of "Fri, 14 Jul 2017 23:42:16 -1000")
Message-ID: <87o9sdife7.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com

Richard Henderson writes:

> We have generated an exception, so use DISAS_NORETURN.

Shouldn't this be folded into patch 4?

Thanks,
  Lluis


> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate-a64.c | 1 +
>  target/arm/translate.c     | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 342ff7c..657684b 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11285,6 +11285,7 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
dc-> is_jmp = DISAS_UPDATE;
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
dc-> is_jmp = DISAS_UPDATE;
>                      } else {
>                          gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
> +                        dc->is_jmp = DISAS_NORETURN;
>                          /* The address covered by the breakpoint must be
>                             included in [tb->pc, tb->pc + tb->size) in order
>                             to for it to be properly cleared -- thus we
> @@ -11986,7 +11987,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>              assert(num_insns == 1);
>              gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
>                            default_exception_el(dc));
> -            goto done_generating;
> +            dc->is_jmp = DISAS_NORETURN;
> +            break;
>          }
 
>          if (dc->thumb) {
> -- 
> 2.9.4
