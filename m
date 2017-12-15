Received: from eggs.gnu.org ([2001:4830:134:3::10]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePzpV-0000LG-QX
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 18:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePzpV-0007dk-1d
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 18:55:49 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171214020025.4004-2-f4bug@amsat.org>
References: <20171214020025.4004-1-f4bug@amsat.org>
	<20171214020025.4004-2-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 15 Dec 2017 15:55:13 -0800
Message-ID: <CAKmqyKMW-v+29fqk-Bn3cuC40ctr0RTv5kLhLg+XW-UXiJZS9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] sdhci: add a "sd-spec-version" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 6:00 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> default to SDHCI v2
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
> I am not sure which real VENDOR is HCVER=3D0x24, we probably don't care.
>
>  hw/sd/sdhci-internal.h |  4 ++--
>  include/hw/sd/sdhci.h  | 10 ++++++++++
>  hw/sd/sdhci.c          |  5 ++++-
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index e941bc2386..7e4a9d79d1 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -210,9 +210,9 @@
>  /* Slot interrupt status */
>  #define SDHC_SLOT_INT_STATUS            0xFC
>
> -/* HWInit Host Controller Version Register 0x0401 */
> +/* HWInit Host Controller Version Register */
>  #define SDHC_HCVER                      0xFE
> -#define SD_HOST_SPECv2_VERS             0x2401
> +#define SDHC_HCVER_VENDOR               0x24
>
>  #define SDHC_REGISTERS_MAP_SIZE         0x100
>  #define SDHC_INSERTION_DELAY            (NANOSECONDS_PER_SECOND)
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 579e0ea644..f8e91ce903 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -88,6 +88,9 @@ typedef struct SDHCIState {
>      /* Force Event Auto CMD12 Error Interrupt Reg - write only */
>      /* Force Event Error Interrupt Register- write only */
>      /* RO Host Controller Version Register always reads as 0x2401 */
> +    struct {
> +        uint8_t spec_version;
> +    } capabilities;
>  } SDHCIState;
>
>  #define TYPE_PCI_SDHCI "sdhci-pci"
> @@ -97,4 +100,11 @@ typedef struct SDHCIState {
>  #define SYSBUS_SDHCI(obj)                               \
>       OBJECT_CHECK(SDHCIState, (obj), TYPE_SYSBUS_SDHCI)
>
> +/* Host Controller Specification Version */
> +enum sdhci_spec_version {
> +    SD_HOST_SPECv1_VERS     =3D 0x00,
> +    SD_HOST_SPECv2_VERS     =3D 0x01,
> +    SD_HOST_SPECv3_VERS     =3D 0x02
> +};
> +
>  #endif /* SDHCI_H */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index d8188fdc2a..d6145342fb 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -908,7 +908,8 @@ static uint64_t sdhci_read(void *opaque, hwaddr offse=
t, unsigned size)
>          ret =3D (uint32_t)(s->admasysaddr >> 32);
>          break;
>      case SDHC_SLOT_INT_STATUS:
> -        ret =3D (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
> +        ret =3D (SDHC_HCVER_VENDOR << 24) | (s->capabilities.spec_versio=
n << 16);
> +        ret |=3D sdhci_slotint(s);
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
> @@ -1263,6 +1264,8 @@ const VMStateDescription sdhci_vmstate =3D {
>  /* Capabilities registers provide information on supported features of t=
his
>   * specific host controller implementation */
>  static Property sdhci_properties[] =3D {
> +    DEFINE_PROP_UINT8("sd-spec-version", SDHCIState,
> +                      capabilities.spec_version, SD_HOST_SPECv2_VERS),
>      DEFINE_PROP_UINT32("capareg", SDHCIState, capareg, UINT32_MAX),
>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>      DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
> --
> 2.15.1
>
>
