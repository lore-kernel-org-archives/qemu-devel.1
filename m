Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Ch-0008MT-0i
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Cf-0002Sw-MD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:38:07 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:38220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ee7Cf-0002RD-9S
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:38:05 -0500
Received: by mail-lf0-x244.google.com with SMTP id g72so2663171lfg.5
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 14:38:05 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123030630.26613-4-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
	<20180123030630.26613-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:37:33 -0800
Message-ID: <CAKmqyKMQSOma074pnDQTWuyS=mx-1C_KFRoQCd0WvNQw_zY=KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 03/14] sdhci: implement the Host Control
 2 register (tuning sequence)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>

On Mon, Jan 22, 2018 at 7:06 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  from qemu/xilinx tag xilinx-v2015.2]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci-internal.h | 10 ++++++++++
>  include/hw/sd/sdhci.h  |  1 +
>  hw/sd/sdhci.c          | 22 +++++++++++++++++++---
>  3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index 9111f6856a..e7cbea297f 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -184,6 +184,16 @@ FIELD(SDHC_ACMD12ERRSTS, TIMEOUT_ERR,  1, 1);
>  FIELD(SDHC_ACMD12ERRSTS, CRC_ERR,      2, 1);
>  FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
>
> +/* Host Control Register 2 (since v3) */
> +#define SDHC_HOSTCTL2                  0x3E
> +FIELD(SDHC_HOSTCTL2, UHS_MODE_SEL,     0, 3);
> +FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS-I only */
> +FIELD(SDHC_HOSTCTL2, DRIVER_STRENGTH,  4, 2); /* UHS-I only */
> +FIELD(SDHC_HOSTCTL2, EXECUTE_TUNING,   6, 1); /* UHS-I only */
> +FIELD(SDHC_HOSTCTL2, SAMPLING_CLKSEL,  7, 1); /* UHS-I only */
> +FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
> +FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
> +
>  /* HWInit Capabilities Register 0x05E80080 */
>  #define SDHC_CAPAB                     0x40
>  FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 5af9e0dc5a..0fff941a98 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -71,6 +71,7 @@ typedef struct SDHCIState {
>      uint16_t norintsigen;  /* Normal Interrupt Signal Enable Register */
>      uint16_t errintsigen;  /* Error Interrupt Signal Enable Register */
>      uint16_t acmd12errsts; /* Auto CMD12 error status register */
> +    uint16_t hostctl2;     /* Host Control 2 */
>      uint64_t admasysaddr;  /* ADMA System Address Register */
>
>      /* Read-only registers */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 013c35e585..b7e69fbc22 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -408,14 +408,29 @@ static void sdhci_end_transfer(SDHCIState *s)
>  static void sdhci_read_block_from_card(SDHCIState *s)
>  {
>      int index =3D 0;
> +    uint8_t data;
> +    const uint16_t blk_size =3D s->blksize & BLOCK_SIZE_MASK;
>
>      if ((s->trnmod & SDHC_TRNS_MULTI) &&
>              (s->trnmod & SDHC_TRNS_BLK_CNT_EN) && (s->blkcnt =3D=3D 0)) =
{
>          return;
>      }
>
> -    for (index =3D 0; index < (s->blksize & BLOCK_SIZE_MASK); index++) {
> -        s->fifo_buffer[index] =3D sdbus_read_data(&s->sdbus);
> +    for (index =3D 0; index < blk_size; index++) {
> +        data =3D sdbus_read_data(&s->sdbus);
> +        if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
> +            /* Device is not in tunning */
> +            s->fifo_buffer[index] =3D data;
> +        }
> +    }
> +
> +    if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
> +        /* Device is in tunning */
> +        s->hostctl2 &=3D ~R_SDHC_HOSTCTL2_EXECUTE_TUNING_MASK;
> +        s->hostctl2 |=3D R_SDHC_HOSTCTL2_SAMPLING_CLKSEL_MASK;
> +        s->prnsts &=3D ~(SDHC_DAT_LINE_ACTIVE | SDHC_DOING_READ |
> +                       SDHC_DATA_INHIBIT);
> +        goto read_done;
>      }
>
>      /* New data now available for READ through Buffer Port Register */
> @@ -440,6 +455,7 @@ static void sdhci_read_block_from_card(SDHCIState *s)
>          }
>      }
>
> +read_done:
>      sdhci_update_irq(s);
>  }
>
> @@ -1005,7 +1021,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr off=
set, unsigned size)
>          ret =3D s->norintsigen | (s->errintsigen << 16);
>          break;
>      case SDHC_ACMD12ERRSTS:
> -        ret =3D s->acmd12errsts;
> +        ret =3D s->acmd12errsts | (s->hostctl2 << 16);
>          break;
>      case SDHC_CAPAB:
>          ret =3D (uint32_t)s->capareg;
> --
> 2.15.1
>
>
