Received: from eggs.gnu.org ([2001:4830:134:3::10]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCNse-00089X-HW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCNsd-0003vW-L6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:46:48 -0500
Date: Wed, 8 Nov 2017 10:46:36 +0000
From: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20171108104636.GC8971@e103592.cambridge.arm.com>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171107150558.22131-10-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171107150558.22131-10-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 09/10] risu_reginfo_aarch64: add
 reginfo_copy_sve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On Tue, Nov 07, 2017 at 03:05:57PM +0000, Alex Benn=E9e wrote:
> Add the ability to save SVE registers from the signal context. This is
> controlled with an optional flag --test-sve. The whole thing is
> conditionally compiled when SVE support is in the sigcontext headers.
>=20
> Technically SVE registers could be beyond an EXTRA_MAGIC section. I've
> not seen this on the model so currently we abort() if we encounter the
> EXTRA_MAGIC section.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  risu_reginfo_aarch64.c | 74 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  risu_reginfo_aarch64.h |  8 ++++++
>  2 files changed, 82 insertions(+)
>=20
> diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
> index 38ad338..7c97790 100644
> --- a/risu_reginfo_aarch64.c
> +++ b/risu_reginfo_aarch64.c
> @@ -13,12 +13,78 @@
>  #include <stdio.h>
>  #include <ucontext.h>
>  #include <string.h>
> +#include <getopt.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> =20
>  #include "risu.h"
>  #include "risu_reginfo_aarch64.h"
> =20
> +#ifndef SVE_MAGIC
>  void *arch_long_opts;
>  char *arch_extra_help;
> +#else
> +/* Should we test SVE register state */
> +static int test_sve;
> +static struct option extra_opts[] =3D {
> +    {"test-sve", no_argument, &test_sve, 1},
> +    {0, 0, 0, 0}
> +};
> +
> +void *arch_long_opts =3D &extra_opts[0];
> +char *arch_extra_help =3D "  --test-sve        Compare SVE registers\n=
";
> +
> +/* Extra SVE copy function, only called with --test-sve */
> +static void reginfo_copy_sve(struct reginfo *ri, struct _aarch64_ctx *=
ctx)
> +{
> +    struct sve_context *sve;
> +    int r, vq;
> +    bool found =3D false;
> +
> +    while (!found) {
> +       switch (ctx->magic)
> +       {
> +          case SVE_MAGIC:
> +             found =3D true;
> +             break;
> +          case EXTRA_MAGIC:
> +             fprintf(stderr, "%s: found EXTRA_MAGIC\n", __func__);
> +             abort();
> +          case 0:
> +             /* We might not have an SVE context */
> +             fprintf(stderr, "%s: reached end of ctx, no joy (%d)\n", =
__func__, ctx->size);
> +             return;
> +          default:
> +             ctx =3D (struct _aarch64_ctx *)((void *)ctx + ctx->size);
> +             break;
> +       }
> +
> +    }
> +
> +    sve =3D (struct sve_context *) ctx;
> +    ri->vl =3D sve->vl;
> +    vq =3D sve_vq_from_vl(sve->vl); /* number of quads for whole vl */
> +
> +    /* Copy ZREG's one at a time */
> +    for (r =3D 0; r < SVE_NUM_ZREGS; r++) {
> +        memcpy(&ri->zregs[r],
> +               (char *)sve + SVE_SIG_ZREG_OFFSET(vq, r),
> +               SVE_SIG_ZREG_SIZE(vq));
> +    }
> +
> +    /* Copy PREG's one at a time */
> +    for (r =3D 0; r < SVE_NUM_PREGS; r++) {
> +        memcpy(&ri->pregs[r],
> +               (char *)sve + SVE_SIG_PREG_OFFSET(vq, r),
> +               SVE_SIG_PREG_SIZE(vq));
> +    }
> +
> +    /* Finally the FFR */
> +    memcpy(&ri->ffr,(char *)sve + SVE_SIG_FFR_OFFSET(vq),
> +               SVE_SIG_FFR_SIZE(vq));
> +
> +}
> +#endif
> =20
>  /* reginfo_init: initialize with a ucontext */
>  void reginfo_init(struct reginfo *ri, ucontext_t *uc)
> @@ -26,6 +92,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>      int i;
>      struct _aarch64_ctx *ctx;
>      struct fpsimd_context *fp;
> +
>      /* necessary to be able to compare with memcmp later */
>      memset(ri, 0, sizeof(*ri));
> =20
> @@ -59,6 +126,13 @@ void reginfo_init(struct reginfo *ri, ucontext_t *u=
c)
>      for (i =3D 0; i < 32; i++) {
>          ri->vregs[i] =3D fp->vregs[i];
>      }
> +

Where do you get uc from?

If it comes straight out of a signal frame that's OK, but if it's copied
around as a ucontext_t or manipulated by getcontext() etc this is going
to go wrong when extra_context is present.

This code may get used by people as a reference, so at least adding a
comment to the effect that this only works on the signal frame would be
a good idea.


When you add support for extra_context, you should probably add a
sanity-check to ensure that the datap pointer really does point to the
right place -- see <asm/sigcontext.h>.

Even though the kernel _should_ never violate this, it can be violated
by ucontext_t manipulation in userspace, so any function that doesn't
know where its ucontext_t came from should do this check.

[...]

Cheers
---Dave
