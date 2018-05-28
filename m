Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNMza-0001vd-Fm
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNMzX-00085h-B5
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:35:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527531079-32717-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <90f9685c-8407-6ffc-922c-8dd1221c33cf@amsat.org>
Date: Mon, 28 May 2018 15:35:28 -0300
MIME-Version: 1.0
In-Reply-To: <1527531079-32717-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] target/ppc: Use proper
 logging function for possible guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 05/28/2018 03:11 PM, Thomas Huth wrote:
> fprintf() and qemu_log_separate() are frowned upon these days for printing
> logging information in QEMU. Accessing the wrong SPRs indicates wrong guest
> behaviour in most cases, and we've got a proper way to log such situations,
> which is the qemu_log_mask(LOG_GUEST_ERROR, ...) function. So use this
> function now for logging the bad SPR accesses instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/ppc/translate.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e30d99f..0806ee0 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3933,13 +3933,9 @@ static inline void gen_op_mfspr(DisasContext *ctx)
>               * allowing userland application to read the PVR
>               */
>              if (sprn != SPR_PVR) {
> -                fprintf(stderr, "Trying to read privileged spr %d (0x%03x) at "
> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> -                if (qemu_log_separate()) {
> -                    qemu_log("Trying to read privileged spr %d (0x%03x) at "
> -                             TARGET_FMT_lx "\n", sprn, sprn,
> -                             ctx->base.pc_next - 4);
> -                }
> +                qemu_log_mask(LOG_GUEST_ERROR, "Trying to read privileged spr "
> +                              "%d (0x%03x) at " TARGET_FMT_lx "\n", sprn, sprn,
> +                              ctx->base.pc_next - 4);
>              }
>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
>          }
> @@ -3951,12 +3947,9 @@ static inline void gen_op_mfspr(DisasContext *ctx)
>              return;
>          }
>          /* Not defined */
> -        fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> -        if (qemu_log_separate()) {
> -            qemu_log("Trying to read invalid spr %d (0x%03x) at "
> -                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> -        }
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Trying to read invalid spr %d (0x%03x) at "
> +                      TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
>  
>          /* The behaviour depends on MSR:PR and SPR# bit 0x10,
>           * it can generate a priv, a hv emu or a no-op
> @@ -4097,12 +4090,9 @@ static void gen_mtspr(DisasContext *ctx)
>              (*write_cb)(ctx, sprn, rS(ctx->opcode));
>          } else {
>              /* Privilege exception */
> -            fprintf(stderr, "Trying to write privileged spr %d (0x%03x) at "
> -                    TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> -            if (qemu_log_separate()) {
> -                qemu_log("Trying to write privileged spr %d (0x%03x) at "
> -                         TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> -            }
> +            qemu_log_mask(LOG_GUEST_ERROR, "Trying to write privileged spr "
> +                          "%d (0x%03x) at " TARGET_FMT_lx "\n", sprn, sprn,
> +                          ctx->base.pc_next - 4);
>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
>          }
>      } else {
> @@ -4114,12 +4104,9 @@ static void gen_mtspr(DisasContext *ctx)
>          }
>  
>          /* Not defined */
> -        if (qemu_log_separate()) {
> -            qemu_log("Trying to write invalid spr %d (0x%03x) at "
> -                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> -        }
> -        fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Trying to write invalid spr %d (0x%03x) at "
> +                      TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
>  
>  
>          /* The behaviour depends on MSR:PR and SPR# bit 0x10,
> 
