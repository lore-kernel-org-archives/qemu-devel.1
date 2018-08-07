Received: from eggs.gnu.org ([2001:4830:134:3::10]:34695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmzDL-00083j-62
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmzDG-0003zX-Ve
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:27:43 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:38279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fmzDG-0003yN-OS
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:27:38 -0400
Received: from player695.ha.ovh.net (unknown [10.109.143.225])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id EAB69E18A6
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 12:27:36 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-5-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6fd6639f-9399-ffea-9924-9ccf85efd6ec@kaod.org>
Date: Tue, 7 Aug 2018 12:27:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-5-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] aspeed_sdmc: Init status alwlays idle
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
> The ast2500 SDRAM training routine busy waits on the 'init cycle busy
> state' bit in DDR PHY Control/Status register #1 (MCR60).
>=20
> This ensures the bit always reads zero, and allows training to
> complete with upstream u-boot on the ast2500-evb.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

One comment below, no need to resend for that.

> ---
>  hw/misc/aspeed_sdmc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 9ece545c4ffa..522e01ef8c0d 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -23,6 +23,10 @@
>  /* Configuration Register */
>  #define R_CONF            (0x04 / 4)
> =20
> +/* Control/Status Register #1 (ast2500) */
> +#define R_STATUS1         (0x60 / 4)
> +#define   PHY_BUSY_STATE      BIT(0)
> +
>  /*
>   * Configuration register Ox4 (for Aspeed AST2400 SOC)
>   *
> @@ -137,6 +141,17 @@ static void aspeed_sdmc_write(void *opaque, hwaddr=
 addr, uint64_t data,
>              g_assert_not_reached();
>          }
>      }
> +    if (s->silicon_rev =3D=3D AST2500_A0_SILICON_REV ||
> +            s->silicon_rev =3D=3D AST2500_A1_SILICON_REV) {

Maybe use the ASPEED_IS_AST2500() ?=20

It would be nice to have a set of macros we could use in the different
models testing the SoC silicon revision. How about :

#define ASPEED_AST2400 0x2
#define ASPEED_AST2500 0x4
#define ASPEED_AST2600 0x6

#define ASPEED_REVISION_MAJOR(si_rev)     (((si_rev) >> 24) & 0xff)

#define ASPEED_IS_AST2400(si_rev)  (ASPEED_REVISION_MAJOR(si_rev) =3D=3D =
ASPEED_AST2400)
#define ASPEED_IS_AST2500(si_rev)  (ASPEED_REVISION_MAJOR(si_rev) =3D=3D =
ASPEED_AST2500)
#define ASPEED_IS_AST2600(si_rev)  (ASPEED_REVISION_MAJOR(si_rev) =3D=3D =
ASPEED_AST2600)


Thanks,

C.


> +        switch (addr) {
> +        case R_STATUS1:
> +            /* Will never return 'busy' */
> +            data &=3D ~PHY_BUSY_STATE;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> =20
>      s->regs[addr] =3D data;
>  }
>=20
