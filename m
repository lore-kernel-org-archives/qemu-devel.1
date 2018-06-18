Received: from eggs.gnu.org ([2001:4830:134:3::10]:33393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUsNP-0004OB-2n
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUsNJ-0000YK-VF
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:31:14 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fUsNJ-0000Xt-Op
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:31:09 -0400
Received: by mail-oi0-x241.google.com with SMTP id 188-v6so14442277oid.12
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 04:31:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180617155309.1653-1-programmingkidx@gmail.com>
References: <20180617155309.1653-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Jun 2018 12:30:48 +0100
Message-ID: <CAFEAcA8Z1J39xTxn+f3K35s88B+x50xNi3WdKG8CxrFg5P1CvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fpu_helper.c: fix helper_fpscr_clrbit()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>

On 17 June 2018 at 16:53, John Arbuckle <programmingkidx@gmail.com> wrote:
> Fix the helper_fpscr_clrbit() function so it correctly
> sets the FEX and VX bits.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  target/ppc/fpu_helper.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index d31a933cbb..7e697a11d0 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -325,6 +325,63 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
>          case FPSCR_RN:
>              fpscr_set_rounding_mode(env);
>              break;
> +        case FPSCR_VXSNAN:
> +        case FPSCR_VXISI:
> +        case FPSCR_VXIDI:
> +        case FPSCR_VXZDZ:
> +        case FPSCR_VXIMZ:
> +        case FPSCR_VXVC:
> +        case FPSCR_VXSOFT:
> +        case FPSCR_VXSQRT:
> +        case FPSCR_VXCVI:
> +        {
> +            int vxsnan, vxisi, vxidi, vxzdz, vximz, vxvc, vxsoft, vxsqrt, vxcvi;
> +            vxsnan = (env->fpscr >> (31 - FPSCR_VXSNAN)) & 1;
> +            vxisi = (env->fpscr >> (31 - FPSCR_VXISI)) & 1;
> +            vxidi = (env->fpscr >> (31 - FPSCR_VXIDI)) & 1;
> +            vxzdz = (env->fpscr >> (31 - FPSCR_VXZDZ)) & 1;
> +            vximz = (env->fpscr >> (31 - FPSCR_VXIMZ)) & 1;
> +            vxvc = (env->fpscr >> (31 - FPSCR_VXVC)) & 1;
> +            vxsoft = (env->fpscr >> (31 - FPSCR_VXSOFT)) & 1;
> +            vxsqrt = (env->fpscr >> (31 - FPSCR_VXSQRT)) & 1;
> +            vxcvi = (env->fpscr >> (31 - FPSCR_VXCVI)) & 1;
> +            if (~(vxsnan & vxisi & vxidi & vxzdz & vximz & vxvc & vxsoft &
> +                  vxsqrt & vxcvi)) {

If all you're doing is checking "are none of these bits set"
then you don't need to laboriously extract every bit and then
AND them together -- you can just use
    if (!(env->fpscr & some_mask))
In fact the headers already define a macro which does that mask
on env->fpscr, so this can just be

    if (!fpscr_ix) {
         env->fpscr &= ~(1 << FPSCR_VX);
    }

> +                /* Set VX bit to zero */
> +                env->fpscr = env->fpscr & ~(1 << FPSCR_VX);
> +            }
> +        }
> +            break;
> +        case FPSCR_VX:
> +        case FPSCR_OX:
> +        case FPSCR_UX:
> +        case FPSCR_ZX:
> +        case FPSCR_XX:
> +        case FPSCR_VE:
> +        case FPSCR_OE:
> +        case FPSCR_UE:
> +        case FPSCR_ZE:
> +        case FPSCR_XE:
> +        {
> +            int vx, ox, ux, zx, xx, ve, oe, ue, ze, xe;
> +            vx = (env->fpscr >> (31 - FPSCR_VX)) & 1;
> +            ox = (env->fpscr >> (31 - FPSCR_OX)) & 1;
> +            ux = (env->fpscr >> (31 - FPSCR_UX)) & 1;
> +            zx = (env->fpscr >> (31 - FPSCR_ZX)) & 1;
> +            xx = (env->fpscr >> (31 - FPSCR_XX)) & 1;
> +            ve = (env->fpscr >> (31 - FPSCR_VE)) & 1;
> +            oe = (env->fpscr >> (31 - FPSCR_OE)) & 1;
> +            ue = (env->fpscr >> (31 - FPSCR_UE)) & 1;
> +            ze = (env->fpscr >> (31 - FPSCR_ZE)) & 1;
> +            xe = (env->fpscr >> (31 - FPSCR_XE)) & 1;
> +            bool fex;
> +            fex = (vx & ve) | (ox & oe) | (ux & ue) | (zx & ze) | (xx & xe);
> +            unsigned int mask;
> +            mask = (1 << FPSCR_FEX);
> +            /* Set the FEX bit */
> +            env->fpscr = (env->fpscr & ~mask) | (-fex & mask);

Similarly I think this is
    if (!fpscr_eex) {
       env->fpscr &= ~(1 << FPSCR_FEX);
    }

> +        }
> +            break;
>          default:
>              break;
>          }
> --
> 2.14.3 (Apple Git-98)
>

thanks
-- PMM
