Received: from eggs.gnu.org ([2001:4830:134:3::10]:36587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fWAP8-0001PV-3L
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fWAP7-0005gF-6Y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:58:22 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180621223946.20738-2-clg@kaod.org>
References: <20180621223946.20738-1-clg@kaod.org>
	<20180621223946.20738-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 22 Jun 2018 10:27:59 +0930
Message-ID: <CACPK8XevZ-n9+M+zYmnnZPqb35SxCZjb8TB6fp17jZ+DZ1mPiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] aspeed/scu: introduce clock frequencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>

On 22 June 2018 at 08:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> All Aspeed SoC clocks are driven by an input source clock which can
> have different frequencies : 24MHz or 25MHz, and also, on the Aspeed
> AST2400 SoC, 48MHz. The H-PLL (CPU) clock is defined from a
> calculation using parameters in the H-PLL Parameter register or from a
> predefined set of frequencies if the setting is strapped by hardware
> (Aspeed AST2400 SoC). The other clocks of the SoC are then defined
> from the H-PLL using dividers.
>
> We introduce first the APB clock because it drives the timer.

Looks good! One small issue below.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/misc/aspeed_scu.h |  70 ++++++++++++++++++++++++++--
>  hw/misc/aspeed_scu.c         | 106 +++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 172 insertions(+), 4 deletions(-)
>

> +static uint32_t aspeed_scu_calc_hpll_ast2400(AspeedSCUState *s)
> +{
> +    uint32_t hpll_reg =3D s->regs[HPLL_PARAM];
> +    uint8_t freq_select;
> +    bool clk_25m_in;
> +
> +    if (hpll_reg & SCU_AST2400_H_PLL_OFF) {
> +        return 0;
> +    }
> +
> +    if (hpll_reg & SCU_AST2400_H_PLL_PROGRAMMED) {
> +        uint32_t multiplier =3D 1;
> +
> +        if (!(hpll_reg & SCU_AST2400_H_PLL_BYPASS_EN)) {
> +            uint32_t n  =3D (hpll_reg >> 5) & 0x3f;
> +            uint32_t od =3D (hpll_reg >> 4) & 0x1;
> +            uint32_t d  =3D hpll_reg & 0xf;
> +
> +            multiplier =3D (2 - od) * ((n + 2) / (d + 1));
> +        }
> +
> +        return s->clkin * multiplier;
> +    }
> +
> +    /* HW strapping */
> +    clk_25m_in =3D (s->hw_strap1 & SCU_HW_STRAP_CLK_25M_IN);

I think you want to do !! to this result, or shift it down. Otherwise
you are getting 1 << 23 or zero, when I think you want 1 or 0.

> +    freq_select =3D SCU_AST2400_HW_STRAP_GET_H_PLL_CLK(s->hw_strap1);
> +
> +    return hpll_ast2400_freqs[clk_25m_in][freq_select] * 1000000;
> +}
