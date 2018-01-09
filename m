Received: from eggs.gnu.org ([2001:4830:134:3::10]:59814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYqZW-00020h-Lg
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYqZV-0002i9-F3
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:51:54 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYqZV-0002gY-8J
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:51:53 -0500
Received: by mail-ot0-x241.google.com with SMTP id 5so2878212oth.8
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 01:51:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109020054.32553-10-f4bug@amsat.org>
References: <20180109020054.32553-1-f4bug@amsat.org>
	<20180109020054.32553-10-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 09:51:32 +0000
Message-ID: <CAFEAcA-v8ZgCLmd2NB=6P2r-ZwsozsDsuFDuAC7DrJxp=ADRCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 9/9] hw/arm/xlnx-zynqmp: use Linux
 FDT names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 9 January 2018 at 02:00, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/xlnx-zynqmp.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 325642058b..fdcd6801b6 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -24,6 +24,7 @@
>  #include "exec/address-spaces.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
> +#include "hw/sysbus-fdt.h"
>
>  #define GIC_NUM_SPI_INTR 160
>
> @@ -138,6 +139,7 @@ static void xlnx_zynqmp_init(Object *obj)
>      XlnxZynqMPState *s =3D XLNX_ZYNQMP(obj);
>      int i;
>      int num_apus =3D MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    const char *type_name;
>
>      for (i =3D 0; i < num_apus; i++) {
>          object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
> @@ -150,12 +152,14 @@ static void xlnx_zynqmp_init(Object *obj)
>      qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
>
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
> -        object_initialize(&s->gem[i], sizeof(s->gem[i]), TYPE_CADENCE_GE=
M);
> +        type_name =3D type_resolve_fdt_alias("cdns,zynqmp-gem");
> +        object_initialize(&s->gem[i], sizeof(s->gem[i]), type_name);
>          qdev_set_parent_bus(DEVICE(&s->gem[i]), sysbus_get_default());
>      }

I'm having difficulty seeing the benefits of this series. We spend
patches 1-8 adding code to devices to add alias names to them,
and this means that in patch 9 we can replace a single
object_initialize() with ... two lines of code including
a runtime lookup of an alias name. Can you explain why this
is better than what we have currently?

thanks
-- PMM
