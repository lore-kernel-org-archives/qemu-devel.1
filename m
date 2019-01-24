Received: from eggs.gnu.org ([209.51.188.92]:46693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gmg5b-0001KC-HU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gmg5Q-0000bc-LR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:34:37 -0500
Received: from mail-eopbgr720114.outbound.protection.outlook.com
	([40.107.72.114]:27466
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gmg5Q-0000UW-8w
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:34:32 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Thu, 24 Jan 2019 14:34:25 +0000
Message-ID: <DM5PR22MB165810163D508F85C68A03F9D29A0@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1548242160-16039-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548242160-16039-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/9] target/mips: nanoMIPS: Fix branch
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, January 23, 2019 12:15 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v2 7/9] target/mips: nanoMIPS: Fix branch handling
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Fix nanoMIPS branch handling.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

This should be tested well. Still:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


>  target/mips/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index aaf7dff..e9b5d1d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -19758,6 +19758,10 @@ static void gen_compute_imm_branch(DisasContext =
*ctx, uint32_t opc,
>          goto out;
>      }
>
> +    /* branch completion */
> +    clear_branch_hflags(ctx);
> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> +
>      if (bcond_compute =3D=3D 0) {
>          /* Uncoditional compact branch */
>          gen_goto_tb(ctx, 0, ctx->btarget);
> @@ -19798,6 +19802,10 @@ static void gen_compute_nanomips_pbalrsc_branch(=
DisasContext *ctx, int rs,
>      tcg_gen_movi_tl(t1, ctx->base.pc_next + 4);
>      gen_op_addr_add(ctx, btarget, t1, t0);
>
> +    /* branch completion */
> +    clear_branch_hflags(ctx);
> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> +
>      /* unconditional branch to register */
>      tcg_gen_mov_tl(cpu_PC, btarget);
>      tcg_gen_lookup_and_goto_ptr();
> @@ -19936,6 +19944,10 @@ static void gen_compute_compact_branch_nm(DisasC=
ontext *ctx, uint32_t opc,
>              goto out;
>          }
>
> +        /* branch completion */
> +        clear_branch_hflags(ctx);
> +        ctx->base.is_jmp =3D DISAS_NORETURN;
> +
>          /* Generating branch here as compact branches don't have delay s=
lot */
>          gen_goto_tb(ctx, 1, ctx->btarget);
>          gen_set_label(fs);
> --
> 2.7.4
