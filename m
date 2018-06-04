Received: from eggs.gnu.org ([2001:4830:134:3::10]:33255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPu95-0007ML-Qe
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPu94-0000OB-Ov
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:23:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180603000827.30872-5-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Jun 2018 11:23:19 -0700
Message-ID: <CAKmqyKP3HtfP1_S7WynXM7UB_A_+ynBO3RsNoZEmJBH1Yb9Mcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/8] sdcard: Set Spec v2.00 as default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sat, Jun 2, 2018 at 5:08 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/sd/sd.h |  1 +
>  hw/sd/sd.c         | 13 +++++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 49f22b0b89..7c6ad3c8f1 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -56,6 +56,7 @@
>
>  enum SDPhySpecificationVersion {
>      SD_PHY_SPECv1_10_VERS     =3D 1,
> +    SD_PHY_SPECv2_00_VERS     =3D 2,
>  };
>
>  typedef enum {
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5ddd211114..81f178b36e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -311,8 +311,12 @@ static void sd_ocr_powerup(void *opaque)
>
>  static void sd_set_scr(SDState *sd)
>  {
> -    sd->scr[0] =3D (0 << 4)       /* SCR structure version 1.0 */
> -                 | 1;           /* Spec Version 1.10 */
> +    sd->scr[0] =3D 0 << 4;        /* SCR structure version 1.0 */
> +    if (sd->spec_version =3D=3D SD_PHY_SPECv1_10_VERS) {
> +        sd->scr[0] |=3D 1;        /* Spec Version 1.10 */
> +    } else {
> +        sd->scr[0] |=3D 2;        /* Spec Version 2.00 */
> +    }
>      sd->scr[1] =3D (2 << 4)       /* SDSC Card (Security Version 1.01) *=
/
>                   | 0b0101;      /* 1-bit or 4-bit width bus modes */
>      sd->scr[2] =3D 0x00;          /* Extended Security is not supported.=
 */
> @@ -2060,7 +2064,8 @@ static void sd_realize(DeviceState *dev, Error **er=
rp)
>      sd->proto_name =3D sd->spi ? "SPI" : "SD";
>
>      switch (sd->spec_version) {
> -    case SD_PHY_SPECv1_10_VERS:
> +    case SD_PHY_SPECv1_10_VERS
> +     ... SD_PHY_SPECv2_00_VERS:
>          break;
>      default:
>          error_setg(errp, "Invalid SD card Spec version: %u", sd->spec_ve=
rsion);
> @@ -2084,7 +2089,7 @@ static void sd_realize(DeviceState *dev, Error **er=
rp)
>
>  static Property sd_properties[] =3D {
>      DEFINE_PROP_UINT8("spec_version", SDState,
> -                      spec_version, SD_PHY_SPECv1_10_VERS),
> +                      spec_version, SD_PHY_SPECv2_00_VERS),
>      DEFINE_PROP_DRIVE("drive", SDState, blk),
>      /* We do not model the chip select pin, so allow the board to select
>       * whether card should be in SSI or MMC/SD mode.  It is also up to t=
he
> --
> 2.17.1
>
>
