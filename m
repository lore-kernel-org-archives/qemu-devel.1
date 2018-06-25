Received: from eggs.gnu.org ([2001:4830:134:3::10]:54716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXKZs-0006hm-SR
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXKZs-0001NR-35
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:02:16 -0400
Message-Id: <1529906529.2292427.1419115928.6C7BD1D2@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
References: <20180612065716.10587-1-clg@kaod.org>
	<20180612065716.10587-2-clg@kaod.org>
In-Reply-To: <20180612065716.10587-2-clg@kaod.org>
Date: Mon, 25 Jun 2018 15:32:09 +0930
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] aspeed/smc: fix dummy
 cycles count when in dual IO mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>

On Tue, 12 Jun 2018, at 16:27, C=C3=A9dric Le Goater wrote:
> When configured in dual I/O mode, address and data are sent in dual
> mode, including the dummy byte cycles in between. Adapt the count to
> the IO setting.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  hw/ssi/aspeed_smc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 5059396bc623..fce126e6ee92 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -66,6 +66,8 @@
>=20=20
>  /* CEx Control Register */
>  #define R_CTRL0           (0x10 / 4)
> +#define   CTRL_IO_DUAL_DATA        (1 << 29)
> +#define   CTRL_IO_DUAL_ADDR_DATA   (1 << 28) /* Includes dummies */
>  #define   CTRL_CMD_SHIFT           16
>  #define   CTRL_CMD_MASK            0xff
>  #define   CTRL_DUMMY_HIGH_SHIFT    14
> @@ -492,8 +494,13 @@ static int aspeed_smc_flash_dummies(const=20
> AspeedSMCFlash *fl)
>      uint32_t r_ctrl0 =3D s->regs[s->r_ctrl0 + fl->id];
>      uint32_t dummy_high =3D (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
>      uint32_t dummy_low =3D (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
> +    uint32_t dummies =3D ((dummy_high << 2) | dummy_low) * 8;
>=20=20
> -    return ((dummy_high << 2) | dummy_low) * 8;
> +    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
> +        dummies /=3D 2;
> +    }
> +
> +    return dummies;
>  }
>=20=20
>  static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
> --=20
> 2.13.6
>=20
>=20
