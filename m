Received: from eggs.gnu.org ([2001:4830:134:3::10]:55955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmyht-0004r7-3j
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmyhp-0007rI-QH
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:55:13 -0400
Received: from 4.mo7.mail-out.ovh.net ([178.32.122.254]:58181)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fmyhp-0007qh-IR
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:55:09 -0400
Received: from player730.ha.ovh.net (unknown [10.109.146.50])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id C4CBEC34C9
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 11:55:07 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-3-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4d731cd6-7b48-664b-47ad-18998b7152c5@kaod.org>
Date: Tue, 7 Aug 2018 11:55:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-3-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] aspeed_sdmc: Fix saved values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/07/2018 09:57 AM, Joel Stanley wrote:
> This fixes the intended protection of read-only values in the
> configuration register. They were being always set to zero by mistake.

yes :/

> The read-only fields depend on the configured memory size of the system=
,
> so they cannot be fixed at compile time. The most straight forward
> option was to store them in the state structure.

We could also use an array of init values for registers, like SCU does, b=
ut
this is fine for now. =20

> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/misc/aspeed_sdmc.c         | 27 ++++++++-------------------
>  include/hw/misc/aspeed_sdmc.h |  1 +
>  2 files changed, 9 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 0df008e52a18..24fd4aee2d82 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -126,10 +126,12 @@ static void aspeed_sdmc_write(void *opaque, hwadd=
r addr, uint64_t data,
>          case AST2400_A0_SILICON_REV:
>          case AST2400_A1_SILICON_REV:
>              data &=3D ~ASPEED_SDMC_READONLY_MASK;
> +            data |=3D s->fixed_conf;
>              break;
>          case AST2500_A0_SILICON_REV:
>          case AST2500_A1_SILICON_REV:
>              data &=3D ~ASPEED_SDMC_AST2500_READONLY_MASK;
> +            data |=3D s->fixed_conf;
>              break;
>          default:
>              g_assert_not_reached();
> @@ -198,25 +200,7 @@ static void aspeed_sdmc_reset(DeviceState *dev)
>      memset(s->regs, 0, sizeof(s->regs));
> =20
>      /* Set ram size bit and defaults values */
> -    switch (s->silicon_rev) {
> -    case AST2400_A0_SILICON_REV:
> -    case AST2400_A1_SILICON_REV:
> -        s->regs[R_CONF] |=3D
> -            ASPEED_SDMC_VGA_COMPAT |
> -            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
> -        break;
> -
> -    case AST2500_A0_SILICON_REV:
> -    case AST2500_A1_SILICON_REV:
> -        s->regs[R_CONF] |=3D
> -            ASPEED_SDMC_HW_VERSION(1) |
> -            ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
> -            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
> -        break;
> -
> -    default:
> -        g_assert_not_reached();
> -    }
> +    s->regs[R_CONF] =3D s->fixed_conf;
>  }
> =20
>  static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
> @@ -234,10 +218,15 @@ static void aspeed_sdmc_realize(DeviceState *dev,=
 Error **errp)
>      case AST2400_A0_SILICON_REV:
>      case AST2400_A1_SILICON_REV:
>          s->ram_bits =3D ast2400_rambits(s);
> +        s->fixed_conf =3D ASPEED_SDMC_VGA_COMPAT |
> +            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
>          break;
>      case AST2500_A0_SILICON_REV:
>      case AST2500_A1_SILICON_REV:
>          s->ram_bits =3D ast2500_rambits(s);
> +        s->fixed_conf =3D ASPEED_SDMC_HW_VERSION(1) |
> +            ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
> +            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
>          break;
>      default:
>          g_assert_not_reached();
> diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdm=
c.h
> index 682f0f5d56dc..e079c66a7d73 100644
> --- a/include/hw/misc/aspeed_sdmc.h
> +++ b/include/hw/misc/aspeed_sdmc.h
> @@ -27,6 +27,7 @@ typedef struct AspeedSDMCState {
>      uint32_t silicon_rev;
>      uint32_t ram_bits;
>      uint64_t ram_size;
> +    uint32_t fixed_conf;
> =20
>  } AspeedSDMCState;
> =20
>=20
