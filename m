Received: from eggs.gnu.org ([2001:4830:134:3::10]:48180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnon-0001UO-PS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnom-0003pD-F8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:33:53 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170922171323.10348-4-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
	<20170922171323.10348-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Feb 2018 14:33:17 -0800
Message-ID: <CAKmqyKMnvTe5xQ8vTH28voRh+K5jxjcPJ1X8MBSKX--HUhxA2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/7] hw/mdio: Generalize phy
 initialization routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Sep 22, 2017 at 10:13 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> From: Grant Likely <grant.likely@arm.com>
>
> There really isn't anything tdk-specific about tdk_init() other than the
> phy id registers. The function should instead be generalized for any
> phy, at least as far as the ID registers are concerned. For the most
> part the read/write behaviour should be very similar across PHYs.
>
> This patch renames tdk_{read,write,init}() to mdio_phy_*() so it can be
> used for any PHY.
>
> More work definitely needs to be done here to make it easy to override
> the default behaviour for specific PHYs, but this at least is a
> reasonable start.
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: just rebased]
> ---
>  include/hw/net/mdio.h   |  2 +-
>  hw/net/etraxfs_eth.c    |  2 +-
>  hw/net/mdio.c           | 14 +++++++-------
>  hw/net/xilinx_axienet.c |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
> index 7ffa4389b9..b3b4f497c0 100644
> --- a/include/hw/net/mdio.h
> +++ b/include/hw/net/mdio.h
> @@ -86,7 +86,7 @@ struct qemu_mdio {
>      struct qemu_phy *devs[32];
>  };
>
> -void tdk_init(struct qemu_phy *phy);
> +void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2);
>  void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy,
>                   unsigned int addr);
>  uint16_t mdio_read_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req)=
;
> diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
> index f8d8f8441d..4c5415771f 100644
> --- a/hw/net/etraxfs_eth.c
> +++ b/hw/net/etraxfs_eth.c
> @@ -333,7 +333,7 @@ static int fs_eth_init(SysBusDevice *sbd)
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>
>
> -    tdk_init(&s->phy);
> +    mdio_phy_init(&s->phy, 0x0300, 0xe400);
>      mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
>      return 0;
>  }
> diff --git a/hw/net/mdio.c b/hw/net/mdio.c
> index 3d70d99077..33bfbb4623 100644
> --- a/hw/net/mdio.c
> +++ b/hw/net/mdio.c
> @@ -43,7 +43,7 @@
>   * linux driver (PHYID and Diagnostics reg).
>   * TODO: Add friendly names for the register nums.
>   */
> -static unsigned int tdk_read(struct qemu_phy *phy, unsigned int req)
> +static unsigned int mdio_phy_read(struct qemu_phy *phy, unsigned int req=
)
>  {
>      int regnum;
>      unsigned r =3D 0;
> @@ -107,7 +107,7 @@ static unsigned int tdk_read(struct qemu_phy *phy, un=
signed int req)
>      return r;
>  }
>
> -static void tdk_write(struct qemu_phy *phy, unsigned int req, unsigned i=
nt data)
> +static void mdio_phy_write(struct qemu_phy *phy, unsigned int req, unsig=
ned int data)
>  {
>      int regnum;
>
> @@ -120,18 +120,18 @@ static void tdk_write(struct qemu_phy *phy, unsigne=
d int req, unsigned int data)
>      }
>  }
>
> -void tdk_init(struct qemu_phy *phy)
> +void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2)
>  {
>      phy->regs[PHY_CTRL] =3D 0x3100;
>      /* PHY Id. */
> -    phy->regs[PHY_ID1] =3D 0x0300;
> -    phy->regs[PHY_ID2] =3D 0xe400;
> +    phy->regs[PHY_ID1] =3D id1;
> +    phy->regs[PHY_ID2] =3D id2;

These should be set by QEMU properties instead of values to the init() func=
tion.

Alistair

>      /* Autonegotiation advertisement reg. */
>      phy->regs[PHY_AUTONEG_ADV] =3D 0x01e1;
>      phy->link =3D 1;
>
> -    phy->read =3D tdk_read;
> -    phy->write =3D tdk_write;
> +    phy->read =3D mdio_phy_read;
> +    phy->write =3D mdio_phy_write;
>  }
>
>  void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned i=
nt addr)
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 1e859fdaae..408cd6e675 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -791,7 +791,7 @@ static void xilinx_enet_realize(DeviceState *dev, Err=
or **errp)
>                            object_get_typename(OBJECT(dev)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>
> -    tdk_init(&s->TEMAC.phy);
> +    mdio_phy_init(&s->TEMAC.phy, 0x0300, 0xe400);
>      mdio_attach(&s->TEMAC.mdio_bus, &s->TEMAC.phy, s->c_phyaddr);
>
>      s->TEMAC.parent =3D s;
> --
> 2.14.1
>
>
