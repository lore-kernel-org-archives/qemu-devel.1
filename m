Received: from eggs.gnu.org ([2001:4830:134:3::10]:45489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D0L-0002uj-7A
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D0K-0004Sv-5q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:05 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5D0J-0004SE-UU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:04 -0400
Received: by mail-wm0-x244.google.com with SMTP id m72so16568017wmc.0
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:45:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019151249.13663-2-clg@kaod.org>
References: <20171019151249.13663-1-clg@kaod.org>
	<20171019151249.13663-2-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 16:44:42 +0100
Message-ID: <CAFEAcA-6gXF9skgYRTke5-0Ds_SLceAgX-Dz6WyyuiYJSz7afw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/8] aspeed: use a ROM memory region to
 catch invalid writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 October 2017 at 16:12, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Some legacy firmwares access unimplemented addresses on the Aspeed SoC
> (old U-Boot code using variables in the bss when it shouldn't do).
> Let's use a ROM memory region to catch the invalid writes and support
> new boards without using the 'ignore_memory_transaction_failures'
> flag.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  Changes since v4 :
>
>  - use a ROM memory region

Probably worth mentioning in the commit message that this
is a migration compatibility break for these boards.

>  hw/arm/aspeed.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ab895ad490af..d88a8b5120b6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -166,6 +166,23 @@ static void aspeed_board_init_flashes(AspeedSMCState=
 *s, const char *flashtype,
>      }
>  }
>
> +/*
> + * This is to track invalid writes done in the ROM by some legacy
> + * firmwares
> + */
> +static void boot_rom_write(void *opaque, hwaddr offset, uint64_t value,
> +                           unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
> +                  __func__, offset, value, size);
> +}
> +
> +static const MemoryRegionOps boot_rom_ops =3D {
> +    .write =3D boot_rom_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
>  static void aspeed_board_init(MachineState *machine,
>                                const AspeedBoardConfig *cfg)
>  {
> @@ -216,8 +233,9 @@ static void aspeed_board_init(MachineState *machine,
>           * SoC and 128MB for the AST2500 SoC, which is twice as big as
>           * needed by the flash modules of the Aspeed machines.
>           */
> -        memory_region_init_rom_nomigrate(boot_rom, OBJECT(bmc), "aspeed.=
boot_rom",
> -                               fl->size, &error_abort);
> +        memory_region_init_rom_device(boot_rom, OBJECT(bmc), &boot_rom_o=
ps,
> +                                      NULL, "aspeed.boot_rom", fl->size,
> +                                      &error_abort);
>          memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
>                                      boot_rom);
>          write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
> --

Don't you want to create the ROM device even if there happens
not to be any contents specified by the user? The thing is still
there in the SoC even if it's empty...

thanks
-- PMM
