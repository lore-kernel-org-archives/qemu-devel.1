Received: from eggs.gnu.org ([2001:4830:134:3::10]:44969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9ji-0002xX-6P
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9jh-0004GV-5E
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:55:26 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eX9jg-0004Fy-Ur
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:55:25 -0500
Received: by mail-wr0-x242.google.com with SMTP id f8so2248644wre.4
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:55:24 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103180805.18140-13-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
	<20180103180805.18140-13-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 4 Jan 2018 09:54:53 -0800
Message-ID: <CAKmqyKMioFgDW+3TscAq6_usdLTgpsMOn0qS11z+Njtr7tGN+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 12/17] sdhci: use FIELD_DP32() macro for
 the WRITE_PROTECT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 10:08 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci-internal.h | 6 ++++--
>  hw/sd/sdhci.c          | 8 ++------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index e941bc2386..df240ea046 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -24,6 +24,8 @@
>  #ifndef SDHCI_INTERNAL_H
>  #define SDHCI_INTERNAL_H
>
> +#include "hw/registerfields.h"
> +
>  /* R/W SDMA System Address register 0x0 */
>  #define SDHC_SYSAD                     0x00
>
> @@ -77,8 +79,8 @@
>  #define SDHC_SPACE_AVAILABLE           0x00000400
>  #define SDHC_DATA_AVAILABLE            0x00000800
>  #define SDHC_CARD_PRESENT              0x00010000
> -#define SDHC_CARD_DETECT               0x00040000
> -#define SDHC_WRITE_PROTECT             0x00080000
> +FIELD(SDHC_PRNSTS, CARD_DETECT,        18, 1);
> +FIELD(SDHC_PRNSTS, WRITE_PROTECT,      19, 1);
>  #define TRANSFERRING_DATA(x)           \
>      ((x) & (SDHC_DOING_READ | SDHC_DOING_WRITE))
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index ede51d7e45..2c8dc66e7a 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -159,12 +159,8 @@ static void sdhci_set_readonly(DeviceState *dev, boo=
l level)
>  {
>      SDHCIState *s =3D (SDHCIState *)dev;
>
> -    if (level) {
> -        s->prnsts &=3D ~SDHC_WRITE_PROTECT;
> -    } else {
> -        /* Write enabled */
> -        s->prnsts |=3D SDHC_WRITE_PROTECT;
> -    }
> +    /* Write enabled */
> +    s->prnsts =3D FIELD_DP32(s->prnsts, SDHC_PRNSTS, WRITE_PROTECT, leve=
l);
>  }
>
>  static void sdhci_reset(SDHCIState *s)
> --
> 2.15.1
>
>
