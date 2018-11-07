Received: from eggs.gnu.org ([2001:4830:134:3::10]:38456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gKSWY-0006Ok-NQ
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gKSWT-0002RA-SU
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:25:54 -0500
Received: from chuckie.co.uk ([82.165.15.123]:35074
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gKSWQ-0001eF-7Y
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:25:46 -0500
References: <20181030122134.11055.15711.stgit@pasha-VirtualBox>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <2024ff61-7744-3ea5-f017-a48340fd5c36@ilande.co.uk>
Date: Wed, 7 Nov 2018 18:25:19 +0000
MIME-Version: 1.0
In-Reply-To: <20181030122134.11055.15711.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] This patch fixes processing of rfi
 instructions in icount mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, agraf@suse.de, david@gibson.dropbear.id.au

On 30/10/2018 12:21, Pavel Dovgalyuk wrote:

> From: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> 
> In this mode writing to interrupt/peripheral state is controlled
> by can_do_io flag. This flag must be set explicitly before helper
> function invocation.
> 
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  target/ppc/translate.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 987ce6e..980862c 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3878,9 +3878,15 @@ static void gen_rfi(DisasContext *ctx)
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
> @@ -3892,9 +3898,15 @@ static void gen_rfid(DisasContext *ctx)
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

I've given this patch a spin on top of ppc-for-3.1 and it allows my test images to
boot with icount enabled without asserting, so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
