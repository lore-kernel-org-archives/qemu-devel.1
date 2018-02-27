Received: from eggs.gnu.org ([2001:4830:134:3::10]:49872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnwA-0004Nf-HR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnw8-0007Wi-Su
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:41:30 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eqnw8-0007VP-GO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:41:28 -0500
Received: by mail-lf0-x244.google.com with SMTP id 70so661706lfw.2
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:41:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170922171323.10348-6-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
	<20170922171323.10348-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Feb 2018 14:40:56 -0800
Message-ID: <CAKmqyKNifbjEXP6Yy5Aqg_t6Lq-EZQ1SSNoGm5phrYYqEzGmaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/7] hw/mdio: Refactor bitbanging state
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Sep 22, 2017 at 10:13 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> From: Grant Likely <grant.likely@arm.com>
>
> The MDIO state machine has a moderate amount of duplicate code in the
> state processing that can be consolidated. This patch does so and
> reorganizes it a bit so that far less code is required. Most of the
> states simply stream a fixed number of bits in as a single integer and
> can be handled by a common processing function that checks for
> completion of the state and returns the streamed in value.
>
> Changes include:
> - Move clock state change tracking into core code
> - Use a common shift register for clocking data in and out
> - Create separate mdc & mdio accessor functions
>   - will be replaced with GPIO connection in a follow-on patch
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: just rebased]

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/net/mdio.h |  41 ++++++++-------
>  hw/net/etraxfs_eth.c  |  11 ++--
>  hw/net/mdio.c         | 140 ++++++++++++++++++++++----------------------=
------
>  3 files changed, 87 insertions(+), 105 deletions(-)
>
> diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
> index ed1879a728..7fca19784e 100644
> --- a/include/hw/net/mdio.h
> +++ b/include/hw/net/mdio.h
> @@ -52,37 +52,33 @@
>  #define PHY_ADVERTISE_100FULL   0x0100  /* Try for 100mbps full-duplex *=
/
>
>  struct qemu_phy {
> -    uint32_t regs[NUM_PHY_REGS];
> +    uint16_t regs[NUM_PHY_REGS];
>      const uint16_t *regs_readonly_mask; /* 0=3Dwritable, 1=3Dread-only *=
/
>
> -    int link;
> +    bool link;
>
> -    unsigned int (*read)(struct qemu_phy *phy, unsigned int req);
> -    void (*write)(struct qemu_phy *phy, unsigned int req, unsigned int d=
ata);
> +    uint16_t (*read)(struct qemu_phy *phy, unsigned int req);
> +    void (*write)(struct qemu_phy *phy, unsigned int req, uint16_t data)=
;
>  };
>
>  struct qemu_mdio {
> -    /* bus. */
> -    int mdc;
> -    int mdio;
> -
> -    /* decoder.  */
> +    /* bitbanging state machine */
> +    bool mdc;
> +    bool mdio;
>      enum {
>          PREAMBLE,
> -        SOF,
>          OPC,
>          ADDR,
>          REQ,
>          TURNAROUND,
>          DATA
>      } state;
> -    unsigned int drive;
>
> -    unsigned int cnt;
> -    unsigned int addr;
> -    unsigned int opc;
> -    unsigned int req;
> -    unsigned int data;
> +    uint16_t cnt; /* Bit count for current state */
> +    uint16_t addr; /* PHY Address; retrieved during ADDR state */
> +    uint16_t opc; /* Operation; 2:read */
> +    uint16_t req; /* Register address */
> +    uint32_t shiftreg; /* shift register; bits in to or out from PHY */
>
>      struct qemu_phy *devs[32];
>  };
> @@ -91,7 +87,16 @@ void mdio_phy_init(struct qemu_phy *phy, uint16_t id1,=
 uint16_t id2);
>  void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy,
>                   unsigned int addr);
>  uint16_t mdio_read_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req)=
;
> -void mdio_write_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req, ui=
nt16_t data);
> -void mdio_cycle(struct qemu_mdio *bus);
> +void mdio_write_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req,
> +                    uint16_t data);
> +void mdio_bitbang_set_clk(struct qemu_mdio *bus, bool mdc);
> +static inline void mdio_bitbang_set_data(struct qemu_mdio *bus, bool mdi=
o)
> +{
> +    bus->mdio =3D mdio;
> +}
> +static inline bool mdio_bitbang_get_data(struct qemu_mdio *bus)
> +{
> +    return bus->mdio;
> +}
>
>  #endif
> diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
> index 4c5415771f..1b518ea16e 100644
> --- a/hw/net/etraxfs_eth.c
> +++ b/hw/net/etraxfs_eth.c
> @@ -119,7 +119,7 @@ eth_read(void *opaque, hwaddr addr, unsigned int size=
)
>
>      switch (addr) {
>      case R_STAT:
> -        r =3D eth->mdio_bus.mdio & 1;
> +        r =3D mdio_bitbang_get_data(&eth->mdio_bus);
>          break;
>      default:
>          r =3D eth->regs[addr];
> @@ -177,13 +177,10 @@ eth_write(void *opaque, hwaddr addr,
>      case RW_MGM_CTRL:
>          /* Attach an MDIO/PHY abstraction.  */
>          if (value & 2) {
> -            eth->mdio_bus.mdio =3D value & 1;
> +            mdio_bitbang_set_data(&eth->mdio_bus, value & 1);
>          }
> -        if (eth->mdio_bus.mdc !=3D (value & 4)) {
> -            mdio_cycle(&eth->mdio_bus);
> -            eth_validate_duplex(eth);
> -        }
> -        eth->mdio_bus.mdc =3D !!(value & 4);
> +        mdio_bitbang_set_clk(&eth->mdio_bus, value & 4);
> +        eth_validate_duplex(eth);
>          eth->regs[addr] =3D value;
>          break;
>
> diff --git a/hw/net/mdio.c b/hw/net/mdio.c
> index 89a6a3a590..96e10fada0 100644
> --- a/hw/net/mdio.c
> +++ b/hw/net/mdio.c
> @@ -43,7 +43,7 @@
>   * linux driver (PHYID and Diagnostics reg).
>   * TODO: Add friendly names for the register nums.
>   */
> -static unsigned int mdio_phy_read(struct qemu_phy *phy, unsigned int req=
)
> +static uint16_t mdio_phy_read(struct qemu_phy *phy, unsigned int req)
>  {
>      int regnum;
>      unsigned r =3D 0;
> @@ -107,7 +107,8 @@ static unsigned int mdio_phy_read(struct qemu_phy *ph=
y, unsigned int req)
>      return r;
>  }
>
> -static void mdio_phy_write(struct qemu_phy *phy, unsigned int req, unsig=
ned int data)
> +static void mdio_phy_write(struct qemu_phy *phy, unsigned int req,
> +                           uint16_t data)
>  {
>      int regnum =3D req & 0x1f;
>      uint16_t mask =3D phy->regs_readonly_mask[regnum];
> @@ -136,13 +137,14 @@ void mdio_phy_init(struct qemu_phy *phy, uint16_t i=
d1, uint16_t id2)
>      /* Autonegotiation advertisement reg. */
>      phy->regs[PHY_AUTONEG_ADV] =3D 0x01e1;
>      phy->regs_readonly_mask =3D default_readonly_mask;
> -    phy->link =3D 1;
> +    phy->link =3D true;
>
>      phy->read =3D mdio_phy_read;
>      phy->write =3D mdio_phy_write;
>  }
>
> -void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned i=
nt addr)
> +void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy,
> +                 unsigned int addr)
>  {
>      bus->devs[addr & 0x1f] =3D phy;
>  }
> @@ -169,99 +171,77 @@ void mdio_write_req(struct qemu_mdio *bus, uint8_t =
addr, uint8_t req,
>      }
>  }
>
> -void mdio_cycle(struct qemu_mdio *bus)
> +/**
> + * mdio_bitbang_update() - internal function to check how many clocks ha=
ve
> + * passed and move to the next state if necessary. Returns TRUE on state=
 change.
> + */
> +static bool mdio_bitbang_update(struct qemu_mdio *bus, int num_bits, int=
 next,
> +                                uint16_t *reg)
>  {
> +    if (bus->cnt < num_bits) {
> +        return false;
> +    }
> +    if (reg) {
> +        *reg =3D bus->shiftreg;
> +    }
> +    bus->state =3D next;
> +    bus->cnt =3D 0;
> +    bus->shiftreg =3D 0;
> +    return true;
> +}
> +
> +/**
> + * mdio_bitbang_set_clk() - set value of mdc signal and update state
> + */
> +void mdio_bitbang_set_clk(struct qemu_mdio *bus, bool mdc)
> +{
> +    uint16_t tmp;
> +
> +    if (mdc =3D=3D bus->mdc) {
> +        return; /* Clock state hasn't changed; do nothing */
> +    }
> +
> +    bus->mdc =3D mdc;
> +    if (bus->mdc) {
> +        /* Falling (inactive) clock edge */
> +        if ((bus->state =3D=3D DATA) && (bus->opc =3D=3D 2)) {
> +            bus->mdio =3D !!(bus->shiftreg & 0x8000);
> +        }
> +        return;
> +    }
> +
> +    /* Rising clock Edge */
> +    bus->shiftreg =3D (bus->shiftreg << 1) | bus->mdio;
>      bus->cnt++;
> -
>      D(printf("mdc=3D%d mdio=3D%d state=3D%d cnt=3D%d drv=3D%d\n",
> -             bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive));
> +             bus->mdc, bus->mdio, bus->state, bus->cnt));
>      switch (bus->state) {
>      case PREAMBLE:
> -        if (bus->mdc) {
> -            if (bus->cnt >=3D (32 * 2) && !bus->mdio) {
> -                bus->cnt =3D 0;
> -                bus->state =3D SOF;
> -                bus->data =3D 0;
> -            }
> -        }
> -        break;
> -    case SOF:
> -        if (bus->mdc) {
> -            if (bus->mdio !=3D 1) {
> -                printf("WARNING: no SOF\n");
> -            }
> -            if (bus->cnt =3D=3D 1 * 2) {
> -                bus->cnt =3D 0;
> -                bus->opc =3D 0;
> -                bus->state =3D OPC;
> -            }
> +        /* MDIO must be 30 clocks high, 1 low, and 1 high to get out of
> +           preamble */
> +        if (bus->shiftreg =3D=3D 0xfffffffd) {
> +            mdio_bitbang_update(bus, 0, OPC, NULL);
>          }
>          break;
>      case OPC:
> -        if (bus->mdc) {
> -            bus->opc <<=3D 1;
> -            bus->opc |=3D bus->mdio & 1;
> -            if (bus->cnt =3D=3D 2 * 2) {
> -                bus->cnt =3D 0;
> -                bus->addr =3D 0;
> -                bus->state =3D ADDR;
> -            }
> -        }
> +        mdio_bitbang_update(bus, 2, ADDR, &bus->opc);
>          break;
>      case ADDR:
> -        if (bus->mdc) {
> -            bus->addr <<=3D 1;
> -            bus->addr |=3D bus->mdio & 1;
> -
> -            if (bus->cnt =3D=3D 5 * 2) {
> -                bus->cnt =3D 0;
> -                bus->req =3D 0;
> -                bus->state =3D REQ;
> -            }
> -        }
> +        mdio_bitbang_update(bus, 5, REQ, &bus->addr);
>          break;
>      case REQ:
> -        if (bus->mdc) {
> -            bus->req <<=3D 1;
> -            bus->req |=3D bus->mdio & 1;
> -            if (bus->cnt =3D=3D 5 * 2) {
> -                bus->cnt =3D 0;
> -                bus->state =3D TURNAROUND;
> -            }
> -        }
> +        mdio_bitbang_update(bus, 5, TURNAROUND, &bus->req);
>          break;
>      case TURNAROUND:
> -        if (bus->mdc && bus->cnt =3D=3D 2 * 2) {
> -            bus->mdio =3D 0;
> -            bus->cnt =3D 0;
> -
> -            if (bus->opc =3D=3D 2) {
> -                bus->drive =3D 1;
> -                bus->data =3D mdio_read_req(bus, bus->addr, bus->req);
> -                bus->mdio =3D bus->data & 1;
> -            }
> -            bus->state =3D DATA;
> +        /* If beginning of DATA READ cycle, then read PHY into shift reg=
ister */
> +        if (mdio_bitbang_update(bus, 2, DATA, NULL) && (bus->opc =3D=3D =
2)) {
> +            bus->shiftreg =3D mdio_read_req(bus, bus->addr, bus->req);
>          }
>          break;
>      case DATA:
> -        if (!bus->mdc) {
> -            if (bus->drive) {
> -                bus->mdio =3D !!(bus->data & (1 << 15));
> -                bus->data <<=3D 1;
> -            }
> -        } else {
> -            if (!bus->drive) {
> -                bus->data <<=3D 1;
> -                bus->data |=3D bus->mdio;
> -            }
> -            if (bus->cnt =3D=3D 16 * 2) {
> -                bus->cnt =3D 0;
> -                bus->state =3D PREAMBLE;
> -                if (!bus->drive) {
> -                    mdio_write_req(bus, bus->addr, bus->req, bus->data);
> -                }
> -                bus->drive =3D 0;
> -            }
> +        /* If end of DATA WRITE cycle, then write shift register to PHY =
*/
> +        if (mdio_bitbang_update(bus, 16, PREAMBLE, &tmp) && (bus->opc =
=3D=3D 1)) {
> +            mdio_write_req(bus, bus->addr, bus->req, tmp);
>          }
>          break;
>      default:
> --
> 2.14.1
>
>
