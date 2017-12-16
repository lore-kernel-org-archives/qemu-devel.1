Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eQ05H-0002rM-Sr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 19:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eQ05G-0008WF-PH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 19:12:07 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171214020025.4004-5-f4bug@amsat.org>
References: <20171214020025.4004-1-f4bug@amsat.org>
	<20171214020025.4004-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 15 Dec 2017 16:11:32 -0800
Message-ID: <CAKmqyKMcPagPWoe4kJB3deccHxxzcBpoyM13+PMO-mxTuj0mEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/8] sdhci: fix CAPAB/MAXCURR registers,
 both are 64bit and read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 6:00 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> running qtests:
>
>   $ make check-qtest-arm
>     GTESTER check-qtest-arm
>   SDHC rd_4b @0x44 not implemented
>   SDHC wr_4b @0x40 <- 0x89abcdef not implemented
>   SDHC wr_4b @0x44 <- 0x01234567 not implemented
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sdhci.h |  4 ++--
>  hw/sd/sdhci.c         | 25 ++++++++++++++++++++-----
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index f8e91ce903..d5093fe3fd 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -75,8 +75,8 @@ typedef struct SDHCIState {
>      uint16_t acmd12errsts; /* Auto CMD12 error status register */
>      uint64_t admasysaddr;  /* ADMA System Address Register */
>
> -    uint32_t capareg;      /* Capabilities Register */
> -    uint32_t maxcurr;      /* Maximum Current Capabilities Register */
> +    uint64_t capareg;      /* Capabilities Register */
> +    uint64_t maxcurr;      /* Maximum Current Capabilities Register */
>      uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
>      uint32_t buf_maxsz;
>      uint16_t data_count;   /* current element in FIFO buffer */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index d6145342fb..4d269c7ac4 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -99,7 +99,7 @@
>
>  static void sdhci_init_capareg(SDHCIState *s, Error **errp)
>  {
> -    if (s->capareg =3D=3D UINT32_MAX) {
> +    if (s->capareg =3D=3D UINT64_MAX) {
>          s->capareg =3D SDHC_CAPAB_REG_DEFAULT;
>      }
>  }
> @@ -893,10 +893,16 @@ static uint64_t sdhci_read(void *opaque, hwaddr off=
set, unsigned size)
>          ret =3D s->acmd12errsts;
>          break;
>      case SDHC_CAPAREG:
> -        ret =3D s->capareg;
> +        ret =3D (uint32_t)s->capareg;
> +        break;
> +    case SDHC_CAPAREG + 4:
> +        ret =3D (uint32_t)(s->capareg >> 32);
>          break;
>      case SDHC_MAXCURR:
> -        ret =3D s->maxcurr;
> +        ret =3D (uint32_t)s->maxcurr;
> +        break;
> +    case SDHC_MAXCURR + 4:
> +        ret =3D (uint32_t)(s->maxcurr >> 32);
>          break;
>      case SDHC_ADMAERR:
>          ret =3D  s->admaerr;
> @@ -1117,6 +1123,15 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>          }
>          sdhci_update_irq(s);
>          break;
> +
> +    case SDHC_CAPAREG:
> +    case SDHC_CAPAREG + 4:
> +    case SDHC_MAXCURR:
> +    case SDHC_MAXCURR + 4:
> +        qemu_log_mask(LOG_GUEST_ERROR, "SDHC wr_%ub @0x%02" HWADDR_PRIx
> +                      " <- 0x%08x read-only\n", size, offset, value >> s=
hift);
> +        break;
> +
>      default:
>          qemu_log_mask(LOG_UNIMP, "SDHC wr_%ub @0x%02" HWADDR_PRIx " <- 0=
x%08x "
>                        "not implemented\n", size, offset, value >> shift)=
;
> @@ -1266,8 +1281,8 @@ const VMStateDescription sdhci_vmstate =3D {
>  static Property sdhci_properties[] =3D {
>      DEFINE_PROP_UINT8("sd-spec-version", SDHCIState,
>                        capabilities.spec_version, SD_HOST_SPECv2_VERS),
> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg, UINT32_MAX),
> -    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
> +    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, UINT64_MAX),
> +    DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
>      DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
>                       false),
>      DEFINE_PROP_LINK("dma-memory", SDHCIState, dma_mr,
> --
> 2.15.1
>
>
