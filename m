Received: from eggs.gnu.org ([2001:4830:134:3::10]:45623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eMhjS-0003CX-Jr
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 16:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eMhjR-0006fT-Me
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 16:59:58 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:49216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eMhjR-0006Kf-FJ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 16:59:57 -0500
Date: Wed, 6 Dec 2017 22:59:44 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20171206215944.GA16343@aurel32.net>
References: <20171205170013.22337-1-f4bug@amsat.org>
	<20171205170013.22337-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171205170013.22337-2-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] target/sh4: add missing
 tcg_temp_free() in gen_conditional_jump()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Vladimir Prus <vladimir.prus@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On 2017-12-05 14:00, Philippe Mathieu-Daud=E9 wrote:
> missed in c55497ecb8c.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  target/sh4/translate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 703020fe87..5aeaabdd8d 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -322,13 +322,16 @@ static void gen_delayed_conditional_jump(DisasConte=
xt * ctx)
>          gen_jump(ctx);
> =20
>          gen_set_label(l1);
> -        return;
> +        goto done;
>      }
> =20
>      tcg_gen_brcondi_i32(TCG_COND_NE, ds, 0, l1);
>      gen_goto_tb(ctx, 1, ctx->pc + 2);
>      gen_set_label(l1);
>      gen_jump(ctx);
> +
> +done:
> +    tcg_temp_free(ds);
>  }
> =20
>  static inline void gen_load_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)

AFAIR, temps are not preserved across a branch (contrary to local
temps), so I am not sure they need to be freed.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
