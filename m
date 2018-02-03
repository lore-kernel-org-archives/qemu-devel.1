Received: from eggs.gnu.org ([2001:4830:134:3::10]:45187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ei4Lc-0004wj-Nk
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ei4LY-0005AL-4g
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:23:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ei4LX-00059t-SW
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:23:36 -0500
References: <20180203084315.20497-1-armbru@redhat.com>
	<20180203084315.20497-15-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bbc2cc63-c192-020c-b9ff-78461c0efced@redhat.com>
Date: Sat, 3 Feb 2018 21:23:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180203084315.20497-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 14/14] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, alistair.francis@xilinx.com

On 03.02.2018 09:43, Markus Armbruster wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
>=20
> Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
> target/ppc/translate.c were manually remove. A fprintf() in
> target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 and
> fflush() was removed around the unimplemented log in
> target/sh4/translate.c as well.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> [Trivial conflict with 6f1c2af641d resolved]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/cris/translate.c      |  2 +-
>  target/ppc/translate.c       | 36 ++++++++++--------------------------
>  target/sh4/translate.c       |  7 ++-----
>  target/unicore32/translate.c |  2 +-
>  4 files changed, 14 insertions(+), 33 deletions(-)
>=20
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index f51a731db9..ff31311ed0 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -137,7 +137,7 @@ typedef struct DisasContext {
> =20
>  static void gen_BUG(DisasContext *dc, const char *file, int line)
>  {
> -    fprintf(stderr, "BUG: pc=3D%x %s %d\n", dc->pc, file, line);
> +    qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>      if (qemu_log_separate()) {
>          qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>      }

This one is still logging twice now.

> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4132f67bb1..172c9f2001 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3933,12 +3933,8 @@ static inline void gen_op_mfspr(DisasContext *ct=
x)
>               * allowing userland application to read the PVR
>               */
>              if (sprn !=3D SPR_PVR) {
> -                fprintf(stderr, "Trying to read privileged spr %d (0x%=
03x) at "
> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> -                if (qemu_log_separate()) {
> -                    qemu_log("Trying to read privileged spr %d (0x%03x=
) at "
> -                             TARGET_FMT_lx "\n", sprn, sprn, ctx->nip =
- 4);
> -                }
> +                qemu_log("Trying to read privileged spr %d (0x%03x) at=
 "
> +                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4)=
;

I wonder whether that should maybe rather be a
qemu_log_mask(LOG_GUEST_ERROR, ...) instead? Well, but maybe that's
subject to another patch...

>              }
>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
>          }
> @@ -3950,12 +3946,8 @@ static inline void gen_op_mfspr(DisasContext *ct=
x)
>              return;
>          }
>          /* Not defined */
> -        fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> -        if (qemu_log_separate()) {
> -            qemu_log("Trying to read invalid spr %d (0x%03x) at "
> -                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> -        }
> +        qemu_log("Trying to read invalid spr %d (0x%03x) at "
> +                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);

dito.

>          /* The behaviour depends on MSR:PR and SPR# bit 0x10,
>           * it can generate a priv, a hv emu or a no-op
> @@ -4096,12 +4088,8 @@ static void gen_mtspr(DisasContext *ctx)
>              (*write_cb)(ctx, sprn, rS(ctx->opcode));
>          } else {
>              /* Privilege exception */
> -            fprintf(stderr, "Trying to write privileged spr %d (0x%03x=
) at "
> -                    TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> -            if (qemu_log_separate()) {
> -                qemu_log("Trying to write privileged spr %d (0x%03x) a=
t "
> -                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4)=
;
> -            }
> +            qemu_log("Trying to write privileged spr %d (0x%03x) at "
> +                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);

dito.

>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
>          }
>      } else {
> @@ -4113,12 +4101,8 @@ static void gen_mtspr(DisasContext *ctx)
>          }
> =20
>          /* Not defined */
> -        if (qemu_log_separate()) {
> -            qemu_log("Trying to write invalid spr %d (0x%03x) at "
> -                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> -        }
> -        fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> +        qemu_log("Trying to write invalid spr %d (0x%03x) at "
> +                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);

dito.

> =20
>          /* The behaviour depends on MSR:PR and SPR# bit 0x10,
> @@ -7381,8 +7365,8 @@ void gen_intermediate_code(CPUState *cs, struct T=
ranslationBlock *tb)
>              break;
>          }
>          if (tcg_check_temp_count()) {
> -            fprintf(stderr, "Opcode %02x %02x %02x %02x (%08x) leaked =
"
> -                    "temporaries\n", opc1(ctx.opcode), opc2(ctx.opcode=
),
> +            qemu_log("Opcode %02x %02x %02x %02x (%08x) leaked "
> +                     "temporaries\n", opc1(ctx.opcode), opc2(ctx.opcod=
e),
>                      opc3(ctx.opcode), opc4(ctx.opcode), ctx.opcode);
>              exit(1);
>          }
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 012156b97b..6c2dca5cf2 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1827,11 +1827,8 @@ static void _decode_opc(DisasContext * ctx)
>          }
>          break;
>      }
> -#if 0
> -    fprintf(stderr, "unknown instruction 0x%04x at pc 0x%08x\n",
> -            ctx->opcode, ctx->base.pc_next);
> -    fflush(stderr);
> -#endif
> +    qemu_log_mask(LOG_UNIMP, "unknown instruction 0x%04x at pc 0x%08x\=
n",
> +                  ctx->opcode, ctx->base.pc_next);
>   do_illegal:
>      if (ctx->envflags & DELAY_SLOT_MASK) {
>   do_illegal_slot:
> diff --git a/target/unicore32/translate.c b/target/unicore32/translate.=
c
> index 5b51f2166d..4b3c0463da 100644
> --- a/target/unicore32/translate.c
> +++ b/target/unicore32/translate.c
> @@ -1936,7 +1936,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
>          disas_uc32_insn(env, dc);
> =20
>          if (num_temps) {
> -            fprintf(stderr, "Internal resource leak before %08x\n", dc=
->pc);
> +            qemu_log("Internal resource leak before %08x\n", dc->pc);
>              num_temps =3D 0;
>          }

 Thomas
