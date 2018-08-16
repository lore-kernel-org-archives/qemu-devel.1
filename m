Received: from eggs.gnu.org ([2001:4830:134:3::10]:45996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHha-0000ai-7C
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHhY-0002zN-5Q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:48:34 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHhX-0002yz-TZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:48:32 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so7747637oie.7
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:48:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-7-joel@jms.id.au>
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-7-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:48:10 +0100
Message-ID: <CAFEAcA8eUOzyHgF6YEBo80xQLzdnaVeZMYRiPPJWFBNv7dhZTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] aspeed: add a max_ram_size property to
 the memory controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 August 2018 at 08:57, Joel Stanley <joel@jms.id.au> wrote:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>
> This will be used to construct a memory region beyond the RAM region
> to let firmwares scan the address space with load/store to guess how
> much RAM the SoC has.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/arm/aspeed.c               | 31 +++++++++++++++++++++++++++++++
>  hw/arm/aspeed_soc.c           |  2 ++
>  hw/misc/aspeed_sdmc.c         |  3 +++
>  include/hw/misc/aspeed_sdmc.h |  1 +
>  4 files changed, 37 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index bb9d33848d3f..e078269266bc 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -31,6 +31,7 @@ static struct arm_boot_info aspeed_board_binfo =3D {
>  typedef struct AspeedBoardState {
>      AspeedSoCState soc;
>      MemoryRegion ram;
> +    MemoryRegion max_ram;
>  } AspeedBoardState;
>
>  typedef struct AspeedBoardConfig {
> @@ -127,6 +128,27 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>      },
>  };
>
> +/*
> + * The max ram region is for firmwares that scan the address space
> + * with load/store to guess how much RAM the SoC has.
> + */
> +static uint64_t max_ram_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void max_ram_write(void *opaque, hwaddr offset, uint64_t value,
> +                           unsigned size)
> +{
> +    /* Disacard writes */
> +}
> +
> +static const MemoryRegionOps max_ram_ops =3D {
> +    .read =3D max_ram_read,
> +    .write =3D max_ram_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
>  #define FIRMWARE_ADDR 0x0
>
>  static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_siz=
e,
> @@ -187,6 +209,7 @@ static void aspeed_board_init(MachineState *machine,
>      AspeedBoardState *bmc;
>      AspeedSoCClass *sc;
>      DriveInfo *drive0 =3D drive_get(IF_MTD, 0, 0);
> +    ram_addr_t max_ram_size;
>
>      bmc =3D g_new0(AspeedBoardState, 1);
>      object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
> @@ -226,6 +249,14 @@ static void aspeed_board_init(MachineState *machine,
>      object_property_add_const_link(OBJECT(&bmc->soc), "ram", OBJECT(&bmc=
->ram),
>                                     &error_abort);
>
> +    max_ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "max-ra=
m-size",
> +                                            &error_abort);
> +    memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
> +                          "max_ram", max_ram_size  - ram_size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                sc->info->sdram_base + ram_size,
> +                                &bmc->max_ram);

I'm surprised that you need the IO ops, ie that it doesn't work
just to define an empty container region with memory_region_init().

thanks
-- PMM
