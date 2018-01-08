Received: from eggs.gnu.org ([2001:4830:134:3::10]:37450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfnM-0004kt-ST
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfnL-0007o2-AZ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:21:28 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180108154303.6522-4-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
	<20180108154303.6522-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 14:20:55 -0800
Message-ID: <CAKmqyKM010adN0rTP0GWzEg=SNWf4HH7h-zMQviVZCSWhadZNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 03/31] sdhci: add max-block-length
 capability (Spec v1)
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci-internal.h |  1 -
>  include/hw/sd/sdhci.h  |  1 +
>  hw/sd/sdhci.c          | 38 +++++++++++++-------------------------
>  3 files changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index 6944fcaf00..0561e6eaf7 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -188,7 +188,6 @@ FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
>  #define SDHC_CAN_DO_ADMA2              0x00080000
>  #define SDHC_CAN_DO_ADMA1              0x00100000
>  #define SDHC_64_BIT_BUS_SUPPORT        (1 << 28)
> -#define SDHC_CAPAB_BLOCKSIZE(x)        (((x) >> 16) & 0x3)
>  FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
>  FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
>  FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 266030dc8d..2703da1d5a 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -103,6 +103,7 @@ typedef struct SDHCIState {
>      bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int=
 */
>      uint8_t spec_version;
>      struct {
> +        uint16_t max_blk_len;
>          bool suspend;
>          bool high_speed;
>          bool sdma;
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index e7dbab2fdc..c78643fe54 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -46,9 +46,6 @@
>  #define SDHC_CAPAB_64BITBUS       0ul        /* 64-bit System Bus Suppor=
t */
>  #define SDHC_CAPAB_ADMA1          1ul        /* ADMA1 support */
>  #define SDHC_CAPAB_ADMA2          1ul        /* ADMA2 support */
> -/* Maximum host controller R/W buffers size
> - * Possible values: 512, 1024, 2048 bytes */
> -#define SDHC_CAPAB_MAXBLOCKLENGTH 512ul
>  /* Maximum clock frequency for SDclock in MHz
>   * value in range 10-63 MHz, 0 - not defined */
>  #define SDHC_CAPAB_BASECLKFREQ    52ul
> @@ -62,16 +59,6 @@
>  #error Capabilities features can have value 0 or 1 only!
>  #endif
>
> -#if SDHC_CAPAB_MAXBLOCKLENGTH =3D=3D 512
> -#define MAX_BLOCK_LENGTH 0ul
> -#elif SDHC_CAPAB_MAXBLOCKLENGTH =3D=3D 1024
> -#define MAX_BLOCK_LENGTH 1ul
> -#elif SDHC_CAPAB_MAXBLOCKLENGTH =3D=3D 2048
> -#define MAX_BLOCK_LENGTH 2ul
> -#else
> -#error Max host controller block size can have value 512, 1024 or 2048 o=
nly!
> -#endif
> -
>  #if (SDHC_CAPAB_BASECLKFREQ > 0 && SDHC_CAPAB_BASECLKFREQ < 10) || \
>      SDHC_CAPAB_BASECLKFREQ > 63
>  #error SDclock frequency can have value in range 0, 10-63 only!
> @@ -83,7 +70,7 @@
>
>  #define SDHC_CAPAB_REG_DEFAULT                                 \
>     ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_ADMA1 << 20) |   \
> -    (SDHC_CAPAB_ADMA2 << 19) | (MAX_BLOCK_LENGTH << 16) |      \
> +    (SDHC_CAPAB_ADMA2 << 19) |                                 \
>      (SDHC_CAPAB_BASECLKFREQ << 8) | (SDHC_CAPAB_TOUNIT << 7) | \
>      (SDHC_CAPAB_TOCLKFREQ))
>
> @@ -92,9 +79,17 @@
>  static void sdhci_init_capareg(SDHCIState *s, Error **errp)
>  {
>      uint64_t capareg =3D 0;
> +    uint32_t val;
>
>      switch (s->spec_version) {
>      case 1:
> +        val =3D ctz32(s->cap.max_blk_len >> 9);
> +        if (val >=3D 0b11) {
> +            error_setg(errp, "block size can be 512, 1024 or 2048 only")=
;
> +            return;
> +        }
> +        capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, MAXBLOCKLENGTH, val)=
;
> +
>          capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, HIGHSPEED, s->cap.hi=
gh_speed);
>          capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, SDMA, s->cap.sdma);
>          capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, SUSPRESUME, s->cap.s=
uspend);
> @@ -1175,17 +1170,7 @@ static const MemoryRegionOps sdhci_mmio_ops =3D {
>
>  static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
>  {
> -    switch (SDHC_CAPAB_BLOCKSIZE(s->capareg)) {
> -    case 0:
> -        return 512;
> -    case 1:
> -        return 1024;
> -    case 2:
> -        return 2048;
> -    default:
> -        hw_error("SDHC: unsupported value for maximum block size\n");
> -        return 0;
> -    }
> +    return 1 << (9 + FIELD_EX32(s->capareg, SDHC_CAPAB, MAXBLOCKLENGTH))=
;
>  }
>
>  static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
> @@ -1319,6 +1304,9 @@ const VMStateDescription sdhci_vmstate =3D {
>  static Property sdhci_properties[] =3D {
>      DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 2),
>
> +    /* Maximum host controller R/W buffers size
> +     * Possible values: 512, 1024, 2048 bytes */
> +    DEFINE_PROP_UINT16("max-block-length", SDHCIState, cap.max_blk_len, =
512),
>      /* DMA */
>      DEFINE_PROP_BOOL("sdma", SDHCIState, cap.sdma, true),
>      /* Suspend/resume support */
> --
> 2.15.1
>
>
