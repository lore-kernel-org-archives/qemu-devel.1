Received: from eggs.gnu.org ([2001:4830:134:3::10]:52098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEVq0-0007VZ-BV
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEVpx-00028A-3W
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:40:52 -0500
References: <cover.1510612380.git.alistair.francis@xilinx.com>
	<d297d74fd53f91e25e4ffb980ea40d4032beaf0b.1510612380.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7a185bec-43b3-7fcd-d419-9af143b2e3f9@redhat.com>
Date: Tue, 14 Nov 2017 08:40:43 +0100
MIME-Version: 1.0
In-Reply-To: <d297d74fd53f91e25e4ffb980ea40d4032beaf0b.1510612380.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 29/29] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com, qemu-ppc@nongnu.org

On 13.11.2017 23:36, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
[...]
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 998fbed848..8eafe30624 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3945,11 +3945,11 @@ static inline void gen_op_mfspr(DisasContext *c=
tx)
>               * allowing userland application to read the PVR
>               */
>              if (sprn !=3D SPR_PVR) {
> -                fprintf(stderr, "Trying to read privileged spr %d (0x%=
03x) at "
> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> +                qemu_log("Trying to read privileged spr %d (0x%03x) at=
 "
> +                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4)=
;
>                  if (qemu_log_separate()) {
>                      qemu_log("Trying to read privileged spr %d (0x%03x=
) at "
> -                             TARGET_FMT_lx "\n", sprn, sprn, ctx->nip =
- 4);
> +                              TARGET_FMT_lx "\n", sprn, sprn, ctx->nip=
 - 4);

Unnecessary and wrong white space change. Please fix that line.

>                  }
>              }
>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
> @@ -3962,8 +3962,8 @@ static inline void gen_op_mfspr(DisasContext *ctx=
)
>              return;
>          }
>          /* Not defined */
> -        fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> +        qemu_log("Trying to read invalid spr %d (0x%03x) at "
> +                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
>          if (qemu_log_separate()) {
>              qemu_log("Trying to read invalid spr %d (0x%03x) at "
>                       TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);

Now that looks wrong, too: If qemu_log_separate() returns true, the same
message is printed out again?

> @@ -4108,8 +4108,8 @@ static void gen_mtspr(DisasContext *ctx)
>              (*write_cb)(ctx, sprn, rS(ctx->opcode));
>          } else {
>              /* Privilege exception */
> -            fprintf(stderr, "Trying to write privileged spr %d (0x%03x=
) at "
> -                    TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> +            qemu_log("Trying to write privileged spr %d (0x%03x) at "
> +                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
>              if (qemu_log_separate()) {
>                  qemu_log("Trying to write privileged spr %d (0x%03x) a=
t "
>                           TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4)=
;

dito

> @@ -4129,8 +4129,8 @@ static void gen_mtspr(DisasContext *ctx)
>              qemu_log("Trying to write invalid spr %d (0x%03x) at "
>                       TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
>          }
> -        fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> +        qemu_log("Trying to write invalid spr %d (0x%03x) at "
> +                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);

dito

> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 703020fe87..32b72b4701 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -427,7 +427,7 @@ static void _decode_opc(DisasContext * ctx)
>  	}
> =20
>  #if 0
> -    fprintf(stderr, "Translating opcode 0x%04x\n", ctx->opcode);
> +    qemu_log("Translating opcode 0x%04x\n", ctx->opcode);

That looks like a debug statement for the develepers ... why should that
be a qemu_log() ?

>  #endif
> =20
>      switch (ctx->opcode) {
> @@ -1788,7 +1788,7 @@ static void _decode_opc(DisasContext * ctx)
>          break;
>      }
>  #if 0
> -    fprintf(stderr, "unknown instruction 0x%04x at pc 0x%08x\n",
> +    qemu_log_mask(LOG_UNIMP, "unknown instruction 0x%04x at pc 0x%08x\=
n",
>  	    ctx->opcode, ctx->pc);

Since this is now only logged conditionally if UNIMP logging is enabled,
I think you should remove the "#if 0" in front of it now.

>      fflush(stderr);

Since you don't print to stderr anymore, this fflush() also does not
make sense anymore.

>  #endif

 Thomas
