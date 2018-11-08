Received: from eggs.gnu.org ([2001:4830:134:3::10]:60476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKkC2-0005o5-Sx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKkBz-000066-Ii
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:17:54 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:50712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gKkBz-0008O8-8m
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:17:51 -0500
Received: from player788.ha.ovh.net (unknown [10.109.143.183])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4F0611970B3
	for <qemu-devel@nongnu.org>; Thu,  8 Nov 2018 14:17:45 +0100 (CET)
Date: Thu, 8 Nov 2018 14:17:33 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181108141733.5ee0e7be@bahia.lan>
In-Reply-To: <20181108121646.26173-21-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
	<20181108121646.26173-21-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 20/22] This patch fixes processing of rfi
 instructions in icount mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, lvivier@redhat.com, agraf@suse.de, qemu-devel@nongnu.org, Maria Klimushenkova <maria.klimushenkova@ispras.ru>, qemu-ppc@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Thu,  8 Nov 2018 23:16:44 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> 
> In this mode writing to interrupt/peripheral state is controlled
> by can_do_io flag. This flag must be set explicitly before helper
> function invocation.
> 
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

The 'This patch fixes ...' wording in the commit title looks weird, and
it doesn't even mention the target/ppc subsystem...

What about this ?

target/ppc: fix processing of rfi instructions in icount mode

>  target/ppc/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index fb18cedcf0..2b37910248 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3919,9 +3919,15 @@ static void gen_rfi(DisasContext *ctx)
>      }
>      /* Restore CPU state */
>      CHK_SV;
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
>      gen_update_cfar(ctx, ctx->base.pc_next - 4);
>      gen_helper_rfi(cpu_env);
>      gen_sync_exception(ctx);
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_end();
> +    }
>  #endif
>  }
>  
> @@ -3933,9 +3939,15 @@ static void gen_rfid(DisasContext *ctx)
>  #else
>      /* Restore CPU state */
>      CHK_SV;
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
>      gen_update_cfar(ctx, ctx->base.pc_next - 4);
>      gen_helper_rfid(cpu_env);
>      gen_sync_exception(ctx);
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_end();
> +    }
>  #endif
>  }
>  
