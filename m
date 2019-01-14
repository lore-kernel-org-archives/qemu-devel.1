Received: from eggs.gnu.org ([209.51.188.92]:57569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1giswY-0006hE-CI
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 22:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1giswW-0004v6-Ss
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 22:29:42 -0500
MIME-Version: 1.0
References: <20190111125759.31577-1-clg@kaod.org>
In-Reply-To: <20190111125759.31577-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 14 Jan 2019 14:29:27 +1100
Message-ID: <CACPK8Xdp8hCYCqWrVQeRuK819-EmNCuWJwF1jGSJfy5RzMUsXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ftgmac100: implement the new MDIO
 interface on Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Jason Wang <jasowang@redhat.com>

On Fri, 11 Jan 2019 at 23:58, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The PHY behind the MAC of an Aspeed SoC can be controlled using two
> different MDC/MDIO interfaces. The same registers PHYCR (MAC60) and
> PHYDATA (MAC64) are involved but they have a different layout.
>
> BIT31 of the Feature Register (MAC40) controls which MDC/MDIO
> interface is active.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/net/ftgmac100.c | 80 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 12 deletions(-)

> @@ -269,9 +281,9 @@ static void phy_reset(FTGMAC100State *s)
>      s->phy_int =3D 0;
>  }
>
> -static uint32_t do_phy_read(FTGMAC100State *s, int reg)
> +static uint16_t do_phy_read(FTGMAC100State *s, uint8_t reg)
>  {
> -    uint32_t val;
> +    uint16_t val;

Unrelated?

> @@ -336,7 +348,7 @@ static uint32_t do_phy_read(FTGMAC100State *s, int re=
g)
>                         MII_BMCR_FD | MII_BMCR_CTST)
>  #define MII_ANAR_MASK 0x2d7f
>
> -static void do_phy_write(FTGMAC100State *s, int reg, uint32_t val)
> +static void do_phy_write(FTGMAC100State *s, uint8_t reg, uint16_t val)

Also unrelated?

> @@ -711,14 +771,11 @@ static void ftgmac100_write(void *opaque, hwaddr ad=
dr,
>          break;
>
>      case FTGMAC100_PHYCR:  /* PHY Device control */
> -        reg =3D FTGMAC100_PHYCR_REG(value);
>          s->phycr =3D value;
> -        if (value & FTGMAC100_PHYCR_MIIWR) {
> -            do_phy_write(s, reg, s->phydata & 0xffff);
> -            s->phycr &=3D ~FTGMAC100_PHYCR_MIIWR;
> +        if (s->revr & FTGMAC100_REVR_NEW_MDIO_INTERFACE) {
> +            do_phy_new_ctl(s);
>          } else {
> -            s->phydata =3D do_phy_read(s, reg) << 16;
> -            s->phycr &=3D ~FTGMAC100_PHYCR_MIIRD;
> +            do_phy_ctl(s);

I assume the guest code programs the correct phy mode so this will
work fine. This change appears to keep the existing default of the old
mode.

Did you give this a go with both -kernel and a u-boot mtd image?

Looks good to me. If you feel like splitting out the unrelated changes
do that, but I'm not fussed either way.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
