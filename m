Received: from eggs.gnu.org ([2001:4830:134:3::10]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddsd-0004Um-QY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddsc-0005mA-JQ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:19:27 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eddsc-0005kw-9j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:19:26 -0500
Received: by mail-oi0-x241.google.com with SMTP id b11so6152620oif.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:19:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119145756.7629-6-luc.michel@greensocs.com>
References: <20180119145756.7629-1-luc.michel@greensocs.com>
	<20180119145756.7629-6-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 15:19:05 +0000
Message-ID: <CAFEAcA8VJAfksRenr_CJauTc2wpfN1fUchixrfGbvjBkeoR-Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/intc/arm_gic: Fix the NS view of
 C_BPR when C_CTRL.CBPR is 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luc.michel@greensocs.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luc MICHEL <luc.michel@git.antfield.fr>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

On 19 January 2018 at 14:57,  <luc.michel@greensocs.com> wrote:
> From: Luc MICHEL <luc.michel@git.antfield.fr>
>
> When C_CTRL.CBPR is 1, the Non-Secure view of C_BPR is altered:
>   - A Non-Secure read of C_BPR should return the BPR value plus 1,
>   saturated to 7,
>   - A Non-Secure write should be ignored.
>
> Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
> ---
>  hw/intc/arm_gic.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index d0a41a89ae..7418b7a082 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1211,8 +1211,13 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>          break;
>      case 0x08: /* Binary Point */
>          if (s->security_extn && !attrs.secure) {
> -            /* BPR is banked. Non-secure copy stored in ABPR. */
> -            *data = s->abpr[cpu];
> +            if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
> +                /* NS view of BPR when CBPR is 1 */
> +                *data = MIN(s->bpr[cpu] + 1, 7);
> +            } else {
> +                /* BPR is banked. Non-secure copy stored in ABPR. */
> +                *data = s->abpr[cpu];
> +            }
>          } else {
>              *data = s->bpr[cpu];
>          }
> @@ -1285,7 +1290,12 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>          break;
>      case 0x08: /* Binary Point */
>          if (s->security_extn && !attrs.secure) {
> -            s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
> +            if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
> +                /* WI when CTLR is 1 */

should be "CBPR", yes?

> +                return MEMTX_OK;
> +            } else {
> +                s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
> +            }
>          } else {
>              s->bpr[cpu] = MAX(value & 0x7, GIC_MIN_BPR);
>          }
> --

thanks
-- PMM
