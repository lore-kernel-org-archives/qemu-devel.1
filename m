Received: from eggs.gnu.org ([2001:4830:134:3::10]:59186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJrf-0006t3-W1
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJrZ-0005CH-QQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:07:07 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqJrZ-0005Bh-8X
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:07:01 -0400
Received: by mail-oi0-x242.google.com with SMTP id b16-v6so8571503oic.9
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:07:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180811090836.4024-4-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-4-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 16:06:39 +0100
Message-ID: <CAFEAcA-vtLpt-ScYpYPFqtQAnECuVqCW-DhKqVgoh6mAG=KfQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] arm: Add chip variant property to
 nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 11 August 2018 at 10:08, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> =
wrote:
> Nordic Semiconductor nRF51 SOCs are available
> in different "variants" which differ in available memory.
> This patchs adds a "variant" attribute to the SOC
> so that the user can choose between different variants and
> thus memory sizes.
>
> See product specification http://infocenter.nordicsemi.com/pdf/nRF51822_P=
S_v3.1.pdf
> section 10.6
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/microbit.c          |  4 ++--
>  hw/arm/nrf51_soc.c         | 40 +++++++++++++++++++++++++++-----------
>  include/hw/arm/nrf51_soc.h | 15 +++++++++++---
>  3 files changed, 43 insertions(+), 16 deletions(-)
>
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> index 8f3c446f52..d6776dea0a 100644
> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -27,11 +27,11 @@ static void microbit_init(MachineState *machine)
>      object_property_add_child(OBJECT(machine), "nrf51", soc, &error_fata=
l);
>      object_property_set_link(soc, OBJECT(system_memory),
>                               "memory", &error_abort);
> +    qdev_prop_set_uint32(DEVICE(soc), "variant", NRF51_VARIANT_AA);
>
>      object_property_set_bool(soc, true, "realized", &error_abort);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> -            NRF51_SOC(soc)->flash_size);
> +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x0=
0);

Hmm. Using 0x00 here doesn't seem ideal.

>  }
>
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 441d05e1ef..85bce2c1e0 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -32,15 +32,21 @@
>  #define FLASH_BASE      0x00000000
>  #define SRAM_BASE       0x20000000
>
> -/* The size and base is for the NRF51822 part. If other parts
> - * are supported in the future, add a sub-class of NRF51SoC for
> - * the specific variants */
> -#define NRF51822_FLASH_SIZE     (256 * 1024)
> -#define NRF51822_SRAM_SIZE      (16 * 1024)
> +#define PAGE_SIZE       1024

Page size isn't really an obvious concept for M profile.

You might find the KiB macro in qemu/units.h useful ?

>
>  /* IRQ lines can be derived from peripheral base addresses */
>  #define BASE_TO_IRQ(base) (((base) >> 12) & 0x1F)
>
> +/* RAM and CODE size in number of pages for different NRF51Variants vari=
ants */
> +struct {
> +  hwaddr ram_size;
> +  hwaddr flash_size;
> +} NRF51VariantAttributes[] =3D {
> +        [NRF51_VARIANT_AA] =3D {.ram_size =3D 16, .flash_size =3D 256 },
> +        [NRF51_VARIANT_AB] =3D {.ram_size =3D 16, .flash_size =3D 128 },
> +        [NRF51_VARIANT_AC] =3D {.ram_size =3D 32, .flash_size =3D 256 },
> +};
> +
>  static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>  {
>      NRF51State *s =3D NRF51_SOC(dev_soc);
> @@ -51,13 +57,21 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
>          return;
>      }
>
> +    if (!(s->part_variant > NRF51_VARIANT_INVALID
> +            && s->part_variant < NRF51_VARIANT_MAX)) {
> +        error_setg(errp, "VARIANT not set or invalid");
> +        return;
> +    }
> +
>      object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "me=
mory",
>              &err);
>      object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
>
>      memory_region_add_subregion_overlap(&s->container, 0, s->board_memor=
y, -1);
>
> -    memory_region_init_ram(&s->flash, OBJECT(s), "nrf51.flash", s->flash=
_size,
> +    /* FLASH */
> +    memory_region_init_ram(&s->flash, NULL, "nrf51_soc.flash",
> +            NRF51VariantAttributes[s->part_variant].flash_size * PAGE_SI=
ZE,
>              &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -66,7 +80,9 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Err=
or **errp)
>      memory_region_set_readonly(&s->flash, true);
>      memory_region_add_subregion(&s->container, FLASH_BASE, &s->flash);
>
> -    memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &=
err);
> +    /* SRAM */
> +    memory_region_init_ram(&s->sram, NULL, "nrf51_soc.sram",
> +            NRF51VariantAttributes[s->part_variant].ram_size * PAGE_SIZE=
, &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
> @@ -85,17 +101,19 @@ static void nrf51_soc_init(Object *obj)
>      memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX=
);
>
>      object_initialize(&s->cpu, sizeof(s->cpu), TYPE_ARMV7M);
> -    object_property_add_child(OBJECT(s), "armv6m", OBJECT(&s->cpu), &err=
or_abort);
> +    object_property_add_child(OBJECT(s), "armv6m", OBJECT(&s->cpu),
> +                              &error_abort);
>      qdev_set_parent_bus(DEVICE(&s->cpu), sysbus_get_default());
> -    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type", ARM_CPU_TYPE_NAME(=
"cortex-m0"));
> +    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
> +                         ARM_CPU_TYPE_NAME("cortex-m0"));

Why have these lines been changed? (Rule of thumb: don't include code
reformatting or style cleanups in the same patch as substantive changes.)

thanks
-- PMM
