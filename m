Received: from eggs.gnu.org ([2001:4830:134:3::10]:39932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ36y-00076w-EA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ36s-0007M9-Kq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:15:16 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180108154303.6522-11-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
	<20180108154303.6522-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 9 Jan 2018 15:14:38 -0800
Message-ID: <CAKmqyKOb7S1ff9uwQ8eYHxgvZRYMPCNr3wbgy-m5FZumHj3cSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 10/31] sdhci: add a Designware/Samsung
 host controller
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
> ---
>  hw/sd/dw-mshc.c     | 64 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/sd/Makefile.objs |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 hw/sd/dw-mshc.c
>
> diff --git a/hw/sd/dw-mshc.c b/hw/sd/dw-mshc.c
> new file mode 100644
> index 0000000000..c2869cd569
> --- /dev/null
> +++ b/hw/sd/dw-mshc.c
> @@ -0,0 +1,64 @@
> +/*
> + * Synopsys Designware Mobile Storage Host Controller emulation
> + * (and Samsung Exynos specific extensions)
> + *
> + * Copyright (C) 2018 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "hw/sd/sdhci.h"
> +#include "qapi/error.h"
> +
> +/* Compatible with:
> + * - SD Host Controller Specification Version 2.0
> + * - SDIO Specification Version 2.0
> + * - MMC Specification Version 4.3
> + *
> + * - SDMA
> + * - ADMA
> + */
> +static void exynos4210_dw_mshc_realize(DeviceState *dev, Error **errp)
> +{
> +    SDHCICommonClass *cc =3D SYSBUS_SDHCI_COMMON_GET_CLASS(dev);
> +    Object *obj =3D OBJECT(dev);
> +    Error *local_err =3D NULL;
> +
> +    object_property_set_uint(obj, 2, "sd-spec-version", &local_err);
> +    object_property_set_bool(obj, true, "suspend", &local_err);
> +    object_property_set_bool(obj, true, "1v8", &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    cc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
> +static void exynos4210_dw_mshc_class_init(ObjectClass *klass, void *data=
)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    SDHCICommonClass *cc =3D SYSBUS_SDHCI_COMMON_CLASS(klass);
> +
> +    cc->parent_realize =3D dc->realize;

This need an explanation, why are we doing this weird realise logic?

Alistair

> +    dc->realize =3D exynos4210_dw_mshc_realize;
> +}
> +
> +static const TypeInfo exynos4210_dw_mshc_info =3D {
> +    .name =3D "samsung,exynos4210-dw-mshc",
> +    .parent =3D TYPE_SYSBUS_SDHCI,
> +    .class_init =3D exynos4210_dw_mshc_class_init,
> +};
> +
> +static void dw_mshc_sdhc_register_types(void)
> +{
> +    type_register_static(&exynos4210_dw_mshc_info);
> +}
> +
> +type_init(dw_mshc_sdhc_register_types)
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index 0fe2501017..fd866d7f94 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -3,6 +3,7 @@ common-obj-$(CONFIG_SD) +=3D core.o
>
>  # SD/MMC host adapters
>  common-obj-$(CONFIG_PL181) +=3D pl181.o
> +common-obj-$(CONFIG_EXYNOS4) +=3D dw-mshc.o
>  common-obj-$(CONFIG_SSI_SD) +=3D ssi-sd.o
>  common-obj-$(CONFIG_SDHCI) +=3D sdhci.o
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
> --
> 2.15.1
>
>
