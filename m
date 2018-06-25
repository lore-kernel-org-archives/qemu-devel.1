Received: from eggs.gnu.org ([2001:4830:134:3::10]:44699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXFlr-0004Kt-Sx
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXFlq-0002RU-7T
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:54:19 -0400
Message-Id: <1529888049.2193270.1418936912.0077240B@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20180622075700.5923-2-clg@kaod.org>
Date: Mon, 25 Jun 2018 10:24:09 +0930
References: <20180622075700.5923-1-clg@kaod.org>
	<20180622075700.5923-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] aspeed/scu: introduce clock
 frequencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>

On Fri, 22 Jun 2018, at 17:26, C=C3=A9dric Le Goater wrote:
> All Aspeed SoC clocks are driven by an input source clock which can
> have different frequencies : 24MHz or 25MHz, and also, on the Aspeed
> AST2400 SoC, 48MHz. The H-PLL (CPU) clock is defined from a
> calculation using parameters in the H-PLL Parameter register or from a
> predefined set of frequencies if the setting is strapped by hardware
> (Aspeed AST2400 SoC). The other clocks of the SoC are then defined
> from the H-PLL using dividers.
>=20
> We introduce first the APB clock because it should be used to drive
> the Aspeed timer model.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  include/hw/misc/aspeed_scu.h |  70 ++++++++++++++++++++++++++--
>  hw/misc/aspeed_scu.c         | 106 +++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 172 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index d70cc0aeca61..f662c38188f4 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -30,6 +30,10 @@ typedef struct AspeedSCUState {
>      uint32_t hw_strap1;
>      uint32_t hw_strap2;
>      uint32_t hw_prot_key;
> +
> +    uint32_t clkin;
> +    uint32_t hpll;
> +    uint32_t apb_freq;
>  } AspeedSCUState;
>=20=20
>  #define AST2400_A0_SILICON_REV   0x02000303U
> @@ -58,7 +62,64 @@ extern bool is_supported_silicon_rev(uint32_t silicon_=
rev);
>   *       1. 2012/12/29 Ryan Chen Create
>   */
>=20=20
> -/* Hardware Strapping Register definition (for Aspeed AST2400 SOC)
> +/* SCU08   Clock Selection Register
> + *
> + *  31     Enable Video Engine clock dynamic slow down
> + *  30:28  Video Engine clock slow down setting
> + *  27     2D Engine GCLK clock source selection
> + *  26     2D Engine GCLK clock throttling enable
> + *  25:23  APB PCLK divider selection
> + *  22:20  LPC Host LHCLK divider selection
> + *  19     LPC Host LHCLK clock generation/output enable control
> + *  18:16  MAC AHB bus clock divider selection
> + *  15     SD/SDIO clock running enable
> + *  14:12  SD/SDIO divider selection
> + *  11     Reserved
> + *  10:8   Video port output clock delay control bit
> + *  7      ARM CPU/AHB clock slow down enable
> + *  6:4    ARM CPU/AHB clock slow down setting
> + *  3:2    ECLK clock source selection
> + *  1      CPU/AHB clock slow down idle timer
> + *  0      CPU/AHB clock dynamic slow down enable (defined in bit[6:4])
> + */
> +#define SCU_CLK_GET_PCLK_DIV(x)                    (((x) >> 23) & 0x7)
> +
> +/* SCU24   H-PLL Parameter Register (for Aspeed AST2400 SOC)
> + *
> + *  18     H-PLL parameter selection
> + *           0: Select H-PLL by strapping resistors
> + *           1: Select H-PLL by the programmed registers (SCU24[17:0])
> + *  17     Enable H-PLL bypass mode
> + *  16     Turn off H-PLL
> + *  10:5   H-PLL Numerator
> + *  4      H-PLL Output Divider
> + *  3:0    H-PLL Denumerator
> + *
> + *  (Output frequency) =3D 24MHz * (2-OD) * [(Numerator+2) / (Denumerator
> +1)]
> + */
> +
> +#define SCU_AST2400_H_PLL_PROGRAMMED               (0x1 << 18)
> +#define SCU_AST2400_H_PLL_BYPASS_EN                (0x1 << 17)
> +#define SCU_AST2400_H_PLL_OFF                      (0x1 << 16)
> +
> +/* SCU24   H-PLL Parameter Register (for Aspeed AST2500 SOC)
> + *
> + *  21     Enable H-PLL reset
> + *  20     Enable H-PLL bypass mode
> + *  19     Turn off H-PLL
> + *  18:13  H-PLL Post Divider
> + *  12:5   H-PLL Numerator (M)
> + *  4:0    H-PLL Denumerator (N)
> + *
> + *  (Output frequency) =3D CLKIN(24MHz) * [(M+1) / (N+1)] / (P+1)
> + *
> + * The default frequency is 792Mhz when CLKIN =3D 24MHz
> + */
> +
> +#define SCU_H_PLL_BYPASS_EN                        (0x1 << 20)
> +#define SCU_H_PLL_OFF                              (0x1 << 19)
> +
> +/* SCU70  Hardware Strapping Register definition (for Aspeed AST2400=20
> SOC)
>   *
>   * 31:29  Software defined strapping registers
>   * 28:27  DRAM size setting (for VGA driver use)
> @@ -107,12 +168,13 @@ extern bool is_supported_silicon_rev(uint32_t=20
> silicon_rev);
>  #define SCU_AST2400_HW_STRAP_GET_CLK_SOURCE(x)     (((((x) >> 23) &=20
> 0x1) << 1) \
>                                                      | (((x) >> 18) &=20
> 0x1))
>  #define SCU_AST2400_HW_STRAP_CLK_SOURCE_MASK       ((0x1 << 23) | (0x1=20
> << 18))
> -#define     AST2400_CLK_25M_IN                         (0x1 << 23)
> +#define SCU_HW_STRAP_CLK_25M_IN                    (0x1 << 23)
>  #define     AST2400_CLK_24M_IN                         0
>  #define     AST2400_CLK_48M_IN                         1
>  #define     AST2400_CLK_25M_IN_24M_USB_CKI             2
>  #define     AST2400_CLK_25M_IN_48M_USB_CKI             3
>=20=20
> +#define SCU_HW_STRAP_CLK_48M_IN                    (0x1 << 18)
>  #define SCU_HW_STRAP_2ND_BOOT_WDT                  (0x1 << 17)
>  #define SCU_HW_STRAP_SUPER_IO_CONFIG               (0x1 << 16)
>  #define SCU_HW_STRAP_VGA_CLASS_CODE                (0x1 << 15)
> @@ -160,8 +222,8 @@ extern bool is_supported_silicon_rev(uint32_t silicon=
_rev);
>  #define     AST2400_DIS_BOOT                           3
>=20=20
>  /*
> - * Hardware strapping register definition (for Aspeed AST2500 SoC and
> - * higher)
> + * SCU70  Hardware strapping register definition (for Aspeed AST2500
> + *        SoC and higher)
>   *
>   * 31     Enable SPI Flash Strap Auto Fetch Mode
>   * 30     Enable GPIO Strap Mode
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 59315010db9a..59333b50abdd 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -168,6 +168,27 @@ static uint32_t aspeed_scu_get_random(void)
>      return num;
>  }
>=20=20
> +static void aspeed_scu_set_apb_freq(AspeedSCUState *s)
> +{
> +    uint32_t apb_divider;
> +
> +    switch (s->silicon_rev) {
> +    case AST2400_A0_SILICON_REV:
> +    case AST2400_A1_SILICON_REV:
> +        apb_divider =3D 2;
> +        break;
> +    case AST2500_A0_SILICON_REV:
> +    case AST2500_A1_SILICON_REV:
> +        apb_divider =3D 4;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    s->apb_freq =3D s->hpll / (SCU_CLK_GET_PCLK_DIV(s->regs[CLK_SEL]) +=
=20
> 1)
> +        / apb_divider;
> +}
> +
>  static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned=20
> size)
>  {
>      AspeedSCUState *s =3D ASPEED_SCU(opaque);
> @@ -222,6 +243,10 @@ static void aspeed_scu_write(void *opaque, hwaddr=20
> offset, uint64_t data,
>      case PROT_KEY:
>          s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
>          return;
> +    case CLK_SEL:
> +        s->regs[reg] =3D data;
> +        aspeed_scu_set_apb_freq(s);
> +        break;
>=20=20
>      case FREQ_CNTR_EVAL:
>      case VGA_SCRATCH1 ... VGA_SCRATCH8:
> @@ -247,19 +272,93 @@ static const MemoryRegionOps aspeed_scu_ops =3D {
>      .valid.unaligned =3D false,
>  };
>=20=20
> +static uint32_t aspeed_scu_get_clkin(AspeedSCUState *s)
> +{
> +    if (s->hw_strap1 & SCU_HW_STRAP_CLK_25M_IN) {
> +        return 25000000;
> +    } else if (s->hw_strap1 & SCU_HW_STRAP_CLK_48M_IN) {
> +        return 48000000;
> +    } else {
> +        return 24000000;
> +    }
> +}
> +
> +/*
> + * Strapped frequencies for the AST2400 in MHz. They depend on the
> + * clkin frequency.
> + */
> +static const uint32_t hpll_ast2400_freqs[][4] =3D {
> +    { 384, 360, 336, 408 }, /* 24MHz or 48MHz */
> +    { 400, 375, 350, 425 }, /* 25MHz */
> +};
> +
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
> +    clk_25m_in =3D !!(s->hw_strap1 & SCU_HW_STRAP_CLK_25M_IN);
> +    freq_select =3D SCU_AST2400_HW_STRAP_GET_H_PLL_CLK(s->hw_strap1);
> +
> +    return hpll_ast2400_freqs[clk_25m_in][freq_select] * 1000000;
> +}
> +
> +static uint32_t aspeed_scu_calc_hpll_ast2500(AspeedSCUState *s)
> +{
> +    uint32_t hpll_reg   =3D s->regs[HPLL_PARAM];
> +    uint32_t multiplier =3D 1;
> +
> +    if (hpll_reg & SCU_H_PLL_OFF) {
> +        return 0;
> +    }
> +
> +    if (!(hpll_reg & SCU_H_PLL_BYPASS_EN)) {
> +        uint32_t p =3D (hpll_reg >> 13) & 0x3f;
> +        uint32_t m =3D (hpll_reg >> 5) & 0xff;
> +        uint32_t n =3D hpll_reg & 0x1f;
> +
> +        multiplier =3D ((m + 1) / (n + 1)) / (p + 1);
> +    }
> +
> +    return s->clkin * multiplier;
> +}
> +
>  static void aspeed_scu_reset(DeviceState *dev)
>  {
>      AspeedSCUState *s =3D ASPEED_SCU(dev);
>      const uint32_t *reset;
> +    uint32_t (*calc_hpll)(AspeedSCUState *s);
>=20=20
>      switch (s->silicon_rev) {
>      case AST2400_A0_SILICON_REV:
>      case AST2400_A1_SILICON_REV:
>          reset =3D ast2400_a0_resets;
> +        calc_hpll =3D aspeed_scu_calc_hpll_ast2400;
>          break;
>      case AST2500_A0_SILICON_REV:
>      case AST2500_A1_SILICON_REV:
>          reset =3D ast2500_a1_resets;
> +        calc_hpll =3D aspeed_scu_calc_hpll_ast2500;
>          break;
>      default:
>          g_assert_not_reached();
> @@ -270,6 +369,13 @@ static void aspeed_scu_reset(DeviceState *dev)
>      s->regs[HW_STRAP1] =3D s->hw_strap1;
>      s->regs[HW_STRAP2] =3D s->hw_strap2;
>      s->regs[PROT_KEY] =3D s->hw_prot_key;
> +
> +    /*
> +     * All registers are set. Now compute the frequencies of the main cl=
ocks
> +     */
> +    s->clkin =3D aspeed_scu_get_clkin(s);
> +    s->hpll =3D calc_hpll(s);
> +    aspeed_scu_set_apb_freq(s);
>  }
>=20=20
>  static uint32_t aspeed_silicon_revs[] =3D {
> --=20
> 2.13.6
>=20
