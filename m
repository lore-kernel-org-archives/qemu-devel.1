Received: from eggs.gnu.org ([2001:4830:134:3::10]:37436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvP1Z-000536-6d
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvP1U-0005D2-Ms
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:33:49 -0400
References: <20170630183736.13222-1-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1bcf9642-dcd0-148e-eda7-f3e7c33508bd@redhat.com>
Date: Fri, 22 Sep 2017 16:33:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170630183736.13222-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Use tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30.06.2017 20:37, Richard Henderson wrote:
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/ppc/translate.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index c0cd64d..9aa66f5 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3419,7 +3419,7 @@ static inline bool use_goto_tb(DisasContext *ctx,=
 target_ulong dest)
>  }
> =20
>  /***                                Branch                            =
     ***/
> -static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong =
dest)
> +static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>  {
>      if (NARROW_MODE(ctx)) {
>          dest =3D (uint32_t) dest;
> @@ -3441,7 +3441,7 @@ static inline void gen_goto_tb(DisasContext *ctx,=
 int n, target_ulong dest)
>                  gen_debug_exception(ctx);
>              }
>          }
> -        tcg_gen_exit_tb(0);
> +        tcg_gen_lookup_and_goto_ptr(cpu_nip);
>      }
>  }
> =20
> @@ -3479,7 +3479,7 @@ static void gen_b(DisasContext *ctx)
>  #define BCOND_CTR 2
>  #define BCOND_TAR 3
> =20
> -static inline void gen_bcond(DisasContext *ctx, int type)
> +static void gen_bcond(DisasContext *ctx, int type)
>  {
>      uint32_t bo =3D BO(ctx->opcode);
>      TCGLabel *l1;
> @@ -3543,26 +3543,19 @@ static inline void gen_bcond(DisasContext *ctx,=
 int type)
>          } else {
>              gen_goto_tb(ctx, 0, li);
>          }
> -        if ((bo & 0x14) !=3D 0x14) {
> -            gen_set_label(l1);
> -            gen_goto_tb(ctx, 1, ctx->nip);
> -        }
>      } else {
>          if (NARROW_MODE(ctx)) {
>              tcg_gen_andi_tl(cpu_nip, target, (uint32_t)~3);
>          } else {
>              tcg_gen_andi_tl(cpu_nip, target, ~3);
>          }
> -        tcg_gen_exit_tb(0);
> -        if ((bo & 0x14) !=3D 0x14) {
> -            gen_set_label(l1);
> -            gen_update_nip(ctx, ctx->nip);
> -            tcg_gen_exit_tb(0);
> -        }
> -    }
> -    if (type =3D=3D BCOND_LR || type =3D=3D BCOND_CTR || type =3D=3D B=
COND_TAR) {
> +        tcg_gen_lookup_and_goto_ptr(cpu_nip);
>          tcg_temp_free(target);
>      }
> +    if ((bo & 0x14) !=3D 0x14) {
> +        gen_set_label(l1);
> +        gen_goto_tb(ctx, 1, ctx->nip);
> +    }
>  }
> =20
>  static void gen_bc(DisasContext *ctx)
>=20

Using this patch increases the speed of the SLOF firmware boot quite a
bit! The following simple test finishes at least 4 seconds faster when
I've got this patch applied:

time ppc64-softmmu/qemu-system-ppc64 -nographic -vga none \
 -prom-env 'boot-command=3Dpower-off'

I also can still run my big endian and my little endian pseries guest
images successfully, so feel free to add my:

Tested-by: Thomas Huth <thuth@redhat.com>
