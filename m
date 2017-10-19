Received: from eggs.gnu.org ([2001:4830:134:3::10]:60415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e58fR-0004P1-CT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e58fN-0002mc-AQ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:07:13 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:46600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e58fN-0002m0-3y
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:07:09 -0400
Received: by mail-wm0-x244.google.com with SMTP id m72so15273843wmc.1
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 04:07:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019100410.26239-2-clg@kaod.org>
References: <20171019100410.26239-1-clg@kaod.org>
	<20171019100410.26239-2-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 12:06:47 +0100
Message-ID: <CAFEAcA_xM93zxp-QqwXd+Fxj9LE6sPn+9zWbiL4tK1GZOqKNYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/8] aspeed: introduce a dummy ROM
 device to catch invalid writes
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

On 19 October 2017 at 11:04, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Some legacy firmwares access unimplemented addresses on the Aspeed SoC
> (old U-Boot code using variables in the bss when it shouldn't do).
> Let's add a dummy ROM device to catch the invalid writes and support
> new board without using the 'ignore_memory_transaction_failures' flags.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ab895ad490af..e44733153819 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -166,6 +166,19 @@ static void aspeed_board_init_flashes(AspeedSMCState=
 *s, const char *flashtype,
>      }
>  }
>
> +static void boot_rom_rw_flash_write(void *opaque, hwaddr offset, uint64_=
t value,
> +                              unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
> +                  __func__, offset, value, size);
> +}
> +
> +static const MemoryRegionOps boot_rom_rw_flash_ops =3D {
> +    .write =3D boot_rom_rw_flash_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
>  static void aspeed_board_init(MachineState *machine,
>                                const AspeedBoardConfig *cfg)
>  {
> @@ -209,6 +222,7 @@ static void aspeed_board_init(MachineState *machine,
>      if (drive0) {
>          AspeedSMCFlash *fl =3D &bmc->soc.fmc.flashes[0];
>          MemoryRegion *boot_rom =3D g_new(MemoryRegion, 1);
> +        MemoryRegion *boot_rom_rw =3D  g_new(MemoryRegion, 1);
>
>          /*
>           * create a ROM region using the default mapping window size of
> @@ -221,6 +235,16 @@ static void aspeed_board_init(MachineState *machine,
>          memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
>                                      boot_rom);
>          write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
> +
> +        /*
> +         * Create a fake ROM region to track invalid writes done by
> +         * some legacy firmwares
> +         */
> +        memory_region_init_rom_device(boot_rom_rw, NULL, &boot_rom_rw_fl=
ash_ops,
> +                                      NULL, "aspeed.boot_rom_rw", fl->si=
ze,
> +                                      &error_abort);
> +        memory_region_add_subregion_overlap(get_system_memory(), FIRMWAR=
E_ADDR,
> +                                            boot_rom_rw, 0);
>      }

You're already (in some conditions) adding a memory region at this
address -- you can see it just above. I think you probably want
to be always creating this region in the same way, whether you
need to do a write_boot_rom() to it or not, rather than creating
two things at the same address.

I think that currently memory_region_init_rom() regions will
MEMTX_DECODE_ERROR on attempts to write to them -- that's really
a bug, which we might be able to fix, but for now you can do
this with the init_rom_device() and a comment about why we
can't just use memory_region_init_rom().

thanks
-- PMM
