Received: from eggs.gnu.org ([2001:4830:134:3::10]:52809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNO3Z-0005BB-D8
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNO3V-0002tW-Ey
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:43:49 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:50715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNO3V-0002s4-8k
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:43:45 -0400
Received: from player158.ha.ovh.net (unknown [10.109.105.25])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 646FA17A3D8
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 21:43:43 +0200 (CEST)
Date: Mon, 28 May 2018 21:43:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180528214333.5f3b2f8f@bahia.lan>
In-Reply-To: <1527531079-32717-1-git-send-email-thuth@redhat.com>
References: <1527531079-32717-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Use proper logging
 function for possible guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Mon, 28 May 2018 20:11:19 +0200
Thomas Huth <thuth@redhat.com> wrote:

> fprintf() and qemu_log_separate() are frowned upon these days for printing
> logging information in QEMU. Accessing the wrong SPRs indicates wrong guest
> behaviour in most cases, and we've got a proper way to log such situations,
> which is the qemu_log_mask(LOG_GUEST_ERROR, ...) function. So use this
> function now for logging the bad SPR accesses instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

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
