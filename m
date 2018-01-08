Received: from eggs.gnu.org ([2001:4830:134:3::10]:53005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfNR-0004bo-FZ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfNQ-0006Qz-EG
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:54:41 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180108154303.6522-18-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
	<20180108154303.6522-18-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:54:08 -0800
Message-ID: <CAKmqyKPG=0jN_xGR50fefcndj36_YNAwCRchBH1pxOtcODG7pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 17/31] sdhci: rename the hostctl1
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jan 8, 2018 at 7:42 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> As per the Spec v3.00
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sdhci.h |  2 +-
>  hw/sd/sdhci.c         | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index c0098fc920..ecd192ee47 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -65,7 +65,7 @@ typedef struct SDHCIState {
>      /* Buffer Data Port Register - virtual access point to R and W buffe=
rs */
>      uint32_t prnsts;       /* Present State Register */
>      /* 0x28 */
> -    uint8_t  hostctl;      /* Host Control Register */
> +    uint8_t  hostctl1;     /* Host Control Register */
>      uint8_t  pwrcon;       /* Power control Register */
>      uint8_t  blkgap;       /* Block Gap Control Register */
>      uint8_t  wakcon;       /* WakeUp Control Register */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 3f5e0760f6..d7e247cb48 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -600,7 +600,7 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
>      uint32_t adma1 =3D 0;
>      uint64_t adma2 =3D 0;
>      hwaddr entry_addr =3D (hwaddr)s->admasysaddr;
> -    switch (SDHC_DMA_TYPE(s->hostctl)) {
> +    switch (SDHC_DMA_TYPE(s->hostctl1)) {
>      case SDHC_CTRL_ADMA2_32:
>          dma_memory_read(&s->dma_as, entry_addr, (uint8_t *)&adma2,
>                          sizeof(adma2));
> @@ -789,7 +789,7 @@ static void sdhci_data_transfer(void *opaque)
>      SDHCIState *s =3D (SDHCIState *)opaque;
>
>      if (s->trnmod & SDHC_TRNS_DMA) {
> -        switch (SDHC_DMA_TYPE(s->hostctl)) {
> +        switch (SDHC_DMA_TYPE(s->hostctl1)) {
>          case SDHC_CTRL_SDMA:
>              if ((s->blkcnt =3D=3D 1) || !(s->trnmod & SDHC_TRNS_MULTI)) =
{
>                  sdhci_sdma_transfer_single_block(s);
> @@ -898,7 +898,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offse=
t, unsigned size)
>          ret =3D s->prnsts;
>          break;
>      case SDHC_HOSTCTL:
> -        ret =3D s->hostctl | (s->pwrcon << 8) | (s->blkgap << 16) |
> +        ret =3D s->hostctl1 | (s->pwrcon << 8) | (s->blkgap << 16) |
>                (s->wakcon << 24);
>          break;
>      case SDHC_CLKCON:
> @@ -1016,7 +1016,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
>          MASKED_WRITE(s->sdmasysad, mask, value);
>          /* Writing to last byte of sdmasysad might trigger transfer */
>          if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->b=
lkcnt &&
> -                s->blksize && SDHC_DMA_TYPE(s->hostctl) =3D=3D SDHC_CTRL=
_SDMA) {
> +                s->blksize && SDHC_DMA_TYPE(s->hostctl1) =3D=3D SDHC_CTR=
L_SDMA) {
>              if (s->trnmod & SDHC_TRNS_MULTI) {
>                  sdhci_sdma_transfer_multi_blocks(s);
>              } else {
> @@ -1068,14 +1068,14 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t=
 val, unsigned size)
>          if (!(mask & 0xFF0000)) {
>              sdhci_blkgap_write(s, value >> 16);
>          }
> -        MASKED_WRITE(s->hostctl, mask, value);
> +        MASKED_WRITE(s->hostctl1, mask, value);
>          MASKED_WRITE(s->pwrcon, mask >> 8, value >> 8);
>          MASKED_WRITE(s->wakcon, mask >> 24, value >> 24);
>          if (!(s->prnsts & SDHC_CARD_PRESENT) || ((s->pwrcon >> 1) & 0x7)=
 < 5 ||
>                  !(s->capareg & (1 << (31 - ((s->pwrcon >> 1) & 0x7))))) =
{
>              s->pwrcon &=3D ~SDHC_POWER_ON;
>          }
> -        qemu_set_irq(s->access_led, s->hostctl & 1);
> +        qemu_set_irq(s->access_led, s->hostctl1 & 1);
>          break;
>      case SDHC_CLKCON:
>          if (!(mask & 0xFF000000)) {
> @@ -1284,7 +1284,7 @@ const VMStateDescription sdhci_vmstate =3D {
>          VMSTATE_UINT16(cmdreg, SDHCIState),
>          VMSTATE_UINT32_ARRAY(rspreg, SDHCIState, 4),
>          VMSTATE_UINT32(prnsts, SDHCIState),
> -        VMSTATE_UINT8(hostctl, SDHCIState),
> +        VMSTATE_UINT8(hostctl1, SDHCIState),
>          VMSTATE_UINT8(pwrcon, SDHCIState),
>          VMSTATE_UINT8(blkgap, SDHCIState),
>          VMSTATE_UINT8(wakcon, SDHCIState),
> --
> 2.15.1
>
>
