Received: from eggs.gnu.org ([2001:4830:134:3::10]:57364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fanqG-0001nb-4a
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fanqD-0007Fj-2P
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:53:32 -0400
Date: Wed, 4 Jul 2018 15:53:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180704195327.GB32390@flamenco>
References: <1530568927-4738-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530568927-4738-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH for-2.12.1] target/ppc: set is_jmp on
 ppc_tr_breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org

Cc'ing qemu-stable since the patch below is now in master:
  2a8ceef ("target/ppc: set is_jmp on ppc_tr_breakpoint_check", 2018-07-03)

Please pick up the patch for QEMU 2.12.1 -- it fixes a regression
introduced in 2.12.0.

Thanks,

		Emilio

On Mon, Jul 02, 2018 at 18:02:07 -0400, Emilio G. Cota wrote:
> The use of GDB breakpoints was broken by b0c2d52 ("target/ppc: convert
> to TranslatorOps", 2018-02-16).
> 
> Fix it by setting is_jmp, so that we break from the translation loop
> as originally intended.
> 
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
> (I'll send this to qemu-stable (for 2.12) once it's on master.)
> ---
>  target/ppc/translate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3a215a1..99c2731 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7314,6 +7314,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>  
>      gen_debug_exception(ctx);
> +    dcbase->is_jmp = DISAS_NORETURN;
>      /* The address covered by the breakpoint must be included in
>         [tb->pc, tb->pc + tb->size) in order to for it to be
>         properly cleared -- thus we increment the PC here so that
> -- 
> 2.7.4
> 
