Received: from eggs.gnu.org ([2001:4830:134:3::10]:50285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TLP-0002GK-9s
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TLG-00030W-B2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:11:15 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:54899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0TLG-0002zZ-0b
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:11:06 -0400
Received: by mail-wm0-x230.google.com with SMTP id i124so8174520wmf.3
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:11:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-9-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-9-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 15:10:44 +0100
Message-ID: <CAFEAcA_5Yt4a3gE8pHAdE9RnY-SZoucMkt8CParasA1YQxKUfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/17] imx_fec: Add support for multiple Tx
 DMA rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> More recent version of the IP block support more than one Tx DMA ring,
> so add the code implementing that feature.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

I'm surprised this doesn't mean "we have a property on the device
to indicate what IP version it is, which the boards set". Or are
all our current boards mismodelling their ethernet devices with the
wrong number of TX rings ?

> ---
>  hw/net/imx_fec.c         | 97 +++++++++++++++++++++++++++++++++++++++---------
>  include/hw/net/imx_fec.h | 23 +++++++++++-
>  2 files changed, 101 insertions(+), 19 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index bd62d7a75f..6045ffe673 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -196,6 +196,17 @@ static const char *imx_eth_reg_name(IMXFECState *s, uint32_t index)
>      }
>  }
>
> +static const VMStateDescription vmstate_imx_eth_tx_ring = {
> +    .name = "fec-tx-ring",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(descriptor, IMXFECTxRing),
> +        VMSTATE_UINT32(tdsr, IMXFECTxRing),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_imx_eth = {
>      .name = TYPE_IMX_FEC,
>      .version_id = 2,
> @@ -203,8 +214,10 @@ static const VMStateDescription vmstate_imx_eth = {
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, IMXFECState, ENET_MAX),
>          VMSTATE_UINT32(rx_descriptor, IMXFECState),
> -        VMSTATE_UINT32(tx_descriptor, IMXFECState),
> -
> +        VMSTATE_STRUCT_ARRAY(tx_ring, IMXFECState,
> +                             ENET_TX_RING_NUM,
> +                             1, vmstate_imx_eth_tx_ring,
> +                             IMXFECTxRing),
>          VMSTATE_UINT32(phy_status, IMXFECState),
>          VMSTATE_UINT32(phy_control, IMXFECState),
>          VMSTATE_UINT32(phy_advertise, IMXFECState),

This breaks migration compatibility, so you need to figure out
how you want to handle that. The simple solution is to increment
the version_id and minimum_version_id fields in vmstate_imx_eth;
that will mean migration from an old QEMU to a new one doesn't
work but it fails in a clean way. The complex way is to put the
new state into a migration subsection with a .needed function
to determine whether to use it or not. For imx I think we can
get away with the simple solution.

> @@ -407,7 +420,7 @@ static void imx_fec_do_tx(IMXFECState *s)
>      int frame_size = 0, descnt = 0;
>      uint8_t frame[ENET_MAX_FRAME_SIZE];
>      uint8_t *ptr = frame;
> -    uint32_t addr = s->tx_descriptor;
> +    uint32_t addr = s->tx_ring[0].descriptor;
>
>      while (descnt++ < IMX_MAX_DESC) {
>          IMXFECBufDesc bd;
> @@ -448,17 +461,38 @@ static void imx_fec_do_tx(IMXFECState *s)
>          }
>      }
>
> -    s->tx_descriptor = addr;
> +    s->tx_ring[0].descriptor = addr;
>
>      imx_eth_update(s);
>  }
>
> -static void imx_enet_do_tx(IMXFECState *s)
> +static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
>  {
>      int frame_size = 0, descnt = 0;
>      uint8_t frame[ENET_MAX_FRAME_SIZE];
>      uint8_t *ptr = frame;
> -    uint32_t addr = s->tx_descriptor;
> +    IMXFECTxRing *ring;
> +    uint32_t addr;
> +
> +    switch (index) {
> +    case ENET_TDAR:
> +        ring = &s->tx_ring[0];
> +        break;
> +    case ENET_TDAR1:
> +        ring = &s->tx_ring[1];
> +        break;
> +    case ENET_TDAR2:
> +        ring = &s->tx_ring[2];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bogus value for index %x\n",
> +                      __func__, index);
> +        abort();
> +        break;
> +    }
> +
> +    addr = ring->descriptor;
>
>      while (descnt++ < IMX_MAX_DESC) {
>          IMXENETBufDesc bd;
> @@ -502,32 +536,32 @@ static void imx_enet_do_tx(IMXFECState *s)
>              ptr = frame;
>              frame_size = 0;
>              if (bd.option & ENET_BD_TX_INT) {
> -                s->regs[ENET_EIR] |= ENET_INT_TXF;
> +                s->regs[ENET_EIR] |= ring->int_txf;
>              }
>          }
>          if (bd.option & ENET_BD_TX_INT) {
> -            s->regs[ENET_EIR] |= ENET_INT_TXB;
> +            s->regs[ENET_EIR] |= ring->int_txb;
>          }
>          bd.flags &= ~ENET_BD_R;
>          /* Write back the modified descriptor.  */
>          imx_enet_write_bd(&bd, addr);
>          /* Advance to the next descriptor.  */
>          if ((bd.flags & ENET_BD_W) != 0) {
> -            addr = s->regs[ENET_TDSR];
> +            addr = s->regs[ring->tdsr];
>          } else {
>              addr += sizeof(bd);
>          }
>      }
>
> -    s->tx_descriptor = addr;
> +    ring->descriptor = addr;
>
>      imx_eth_update(s);
>  }
>
> -static void imx_eth_do_tx(IMXFECState *s)
> +static void imx_eth_do_tx(IMXFECState *s, uint32_t index)
>  {
>      if (!s->is_fec && (s->regs[ENET_ECR] & ENET_ECR_EN1588)) {
> -        imx_enet_do_tx(s);
> +        imx_enet_do_tx(s, index);
>      } else {
>          imx_fec_do_tx(s);
>      }
> @@ -586,7 +620,22 @@ static void imx_eth_reset(DeviceState *d)
>      }
>
>      s->rx_descriptor = 0;
> -    s->tx_descriptor = 0;
> +
> +    s->tx_ring[0].tdsr = ENET_TDSR;
> +    s->tx_ring[1].tdsr = ENET_TDSR1;
> +    s->tx_ring[2].tdsr = ENET_TDSR2;
> +
> +    s->tx_ring[0].int_txf = ENET_INT_TXF;
> +    s->tx_ring[1].int_txf = ENET_INT_TXF1;
> +    s->tx_ring[2].int_txf = ENET_INT_TXF2;
> +
> +    s->tx_ring[0].int_txb = ENET_INT_TXB;
> +    s->tx_ring[1].int_txb = ENET_INT_TXB1;
> +    s->tx_ring[2].int_txb = ENET_INT_TXB2;
> +
> +    s->tx_ring[0].descriptor = 0;
> +    s->tx_ring[1].descriptor = 0;
> +    s->tx_ring[2].descriptor = 0;
>
>      /* We also reset the PHY */
>      phy_reset(s);
> @@ -814,10 +863,12 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>              s->regs[index] = 0;
>          }
>          break;
> +    case ENET_TDAR1:    /* FALLTHROUGH */
> +    case ENET_TDAR2:    /* FALLTHROUGH */
>      case ENET_TDAR:
>          if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
>              s->regs[index] = ENET_TDAR_TDAR;
> -            imx_eth_do_tx(s);
> +            imx_eth_do_tx(s, index);
>          }
>          s->regs[index] = 0;
>          break;
> @@ -829,8 +880,12 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>          if ((s->regs[index] & ENET_ECR_ETHEREN) == 0) {
>              s->regs[ENET_RDAR] = 0;
>              s->rx_descriptor = s->regs[ENET_RDSR];
> -            s->regs[ENET_TDAR] = 0;
> -            s->tx_descriptor = s->regs[ENET_TDSR];
> +            s->regs[ENET_TDAR]  = 0;
> +            s->regs[ENET_TDAR1] = 0;
> +            s->regs[ENET_TDAR2] = 0;
> +            s->tx_ring[0].descriptor = s->regs[ENET_TDSR];
> +            s->tx_ring[1].descriptor = s->regs[ENET_TDSR1];
> +            s->tx_ring[2].descriptor = s->regs[ENET_TDSR2];
>          }
>          break;
>      case ENET_MMFR:
> @@ -908,7 +963,15 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>          } else {
>              s->regs[index] = value & ~7;
>          }
> -        s->tx_descriptor = s->regs[index];
> +        s->tx_ring[0].descriptor = s->regs[index];
> +        break;
> +    case ENET_TDSR1:
> +        s->regs[index] = value & ~7;
> +        s->tx_ring[1].descriptor = s->regs[index];
> +        break;
> +    case ENET_TDSR2:
> +        s->regs[index] = value & ~7;
> +        s->tx_ring[2].descriptor = s->regs[index];
>          break;
>      case ENET_MRBR:
>          s->regs[index] = value & 0x00003ff0;
> diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
> index 20a6aa98b4..40bd29771f 100644
> --- a/include/hw/net/imx_fec.h
> +++ b/include/hw/net/imx_fec.h
> @@ -52,6 +52,8 @@
>  #define ENET_TFWR              81
>  #define ENET_FRBR              83
>  #define ENET_FRSR              84
> +#define ENET_TDSR1             89
> +#define ENET_TDSR2             92
>  #define ENET_RDSR              96
>  #define ENET_TDSR              97
>  #define ENET_MRBR              98
> @@ -66,6 +68,8 @@
>  #define ENET_FTRL              108
>  #define ENET_TACC              112
>  #define ENET_RACC              113
> +#define ENET_TDAR1             121
> +#define ENET_TDAR2             123
>  #define ENET_MIIGSK_CFGR       192
>  #define ENET_MIIGSK_ENR        194
>  #define ENET_ATCR              256
> @@ -106,13 +110,18 @@
>  #define ENET_INT_WAKEUP        (1 << 17)
>  #define ENET_INT_TS_AVAIL      (1 << 16)
>  #define ENET_INT_TS_TIMER      (1 << 15)
> +#define ENET_INT_TXF2          (1 <<  7)
> +#define ENET_INT_TXB2          (1 <<  6)
> +#define ENET_INT_TXF1          (1 <<  3)
> +#define ENET_INT_TXB1          (1 <<  2)
>
>  #define ENET_INT_MAC           (ENET_INT_HB | ENET_INT_BABR | ENET_INT_BABT | \
>                                  ENET_INT_GRA | ENET_INT_TXF | ENET_INT_TXB | \
>                                  ENET_INT_RXF | ENET_INT_RXB | ENET_INT_MII | \
>                                  ENET_INT_EBERR | ENET_INT_LC | ENET_INT_RL | \
>                                  ENET_INT_UN | ENET_INT_PLR | ENET_INT_WAKEUP | \
> -                                ENET_INT_TS_AVAIL)
> +                                ENET_INT_TS_AVAIL | ENET_INT_TXF1 | ENET_INT_TXB1 |\
> +                                ENET_INT_TXF2 | ENET_INT_TXB2)
>
>  /* RDAR */
>  #define ENET_RDAR_RDAR         (1 << 24)
> @@ -233,6 +242,15 @@ typedef struct {
>
>  #define ENET_BD_BDU            (1 << 31)
>
> +#define ENET_TX_RING_NUM       3
> +
> +typedef struct IMXFECTxRing {
> +    uint32_t descriptor;
> +    uint32_t tdsr;
> +    uint32_t int_txf;
> +    uint32_t int_txb;

Why aren't the int_txf and int_txb fields in the migration state?
What are they for? It looks from the code like they're just constants
indicating the tx interrupt bits to use for this tx ring, in which
case they'd be better implemented using a utility function which
returns the tx bit when given a ring number, I think.

> +} IMXFECTxRing;
> +
>  typedef struct IMXFECState {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -245,7 +263,8 @@ typedef struct IMXFECState {
>
>      uint32_t regs[ENET_MAX];
>      uint32_t rx_descriptor;
> -    uint32_t tx_descriptor;
> +
> +    IMXFECTxRing tx_ring[ENET_TX_RING_NUM];
>
>      uint32_t phy_status;
>      uint32_t phy_control;
> --
> 2.13.5


thanks
-- PMM
