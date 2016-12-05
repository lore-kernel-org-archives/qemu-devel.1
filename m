Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cDue5-0008BP-Up
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cDue2-00012r-Pv
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:53:33 -0500
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:44970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cDue2-00012Z-FZ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:53:30 -0500
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C69ED51E5A
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 15:53:27 +0100 (CET)
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-25-git-send-email-clg@kaod.org>
	<4e2db842-7ff6-d7e7-c96c-26ce9c563c83@gmail.com>
	<f28b693f-dade-b338-cc86-b5e85f8b1675@kaod.org>
	<CABc_YGCweFyD8+tZf32_AM6YYYcFWtZS3ejb2A_cUMi0LCsZ0A@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7eeb3879-309e-0117-2f44-51100005d475@kaod.org>
Date: Mon, 5 Dec 2016 15:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <CABc_YGCweFyD8+tZf32_AM6YYYcFWtZS3ejb2A_cUMi0LCsZ0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 24/30] aspeed: use first SPI flash
 as a boot ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marcin_Krzemi=c5=84ski?= <mar.krzeminski@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12/05/2016 10:57 AM, Marcin Krzemi=C5=84ski wrote:
>=20
> 2016-12-05 10:36 GMT+01:00 C=C3=A9dric Le Goater <clg@kaod.org <mailto:=
clg@kaod.org>>:
>=20
>     Hello Marcin,
>=20
>     On 12/04/2016 06:00 PM, mar.krzeminski wrote:
>     > Hi Cedric,
>     >
>     > it looks like good idea for now to handle boot from flash.
>     > As I understand you are trying to omit bootrom code in Qemu model=
?
>=20
>     I suppose you mean handling a romd memory region under the m25p80
>     object ?
>=20
> It could be that I mess up everything because my understanding how the =
real HW
> work and boot is wrong. Please correct my assumptions:
> 1. You are setting boot source to spi-nor (jumper, resistor whatever)
> 2. There is a small bootrom in SoC (not u-boot) that set eg. reset vect=
or, configure SMC
> and start execude code from flash.
> 3. Memory mapped flash content is at address 0x1c000000.

No. The memory flash content CS0 is mapped at 0x0 and starts=20
with U-Boot directly, there is no preliminary loader.

U-Boot is not merged in mainline yet. We are "slowly" building a
tree for upstream :=20
=20
	https://github.com/openbmc/u-boot/
	https://github.com/legoater/u-boot/


>     > This could lead you to some hacks in device models (eg SMC).
>=20
>     I haven't had to, yet.
>=20
>     > W dniu 29.11.2016 o 16:44, C=C3=A9dric Le Goater pisze:
>     >> Fill a ROM region with the flash content to support U-Boot. This=
 is a
>     >> little hacky but until we can boot from a MMIO region, it seems
>     >> difficult to do anything else.
>     >>
>     >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org <mailto:clg@k=
aod.org>>
>     >> Reviewed-by: Joel Stanley <joel@jms.id.au <mailto:joel@jms.id.au=
>>
>     >> Reviewed-by: Andrew Jeffery <andrew@aj.id.au <mailto:andrew@aj.i=
d.au>>
>     >> ---
>     >>  hw/arm/aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++++
>     >>  1 file changed, 41 insertions(+)
>     >>
>     >> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>     >> index 40c13838fb2d..a92c2f1c362b 100644
>     >> --- a/hw/arm/aspeed.c
>     >> +++ b/hw/arm/aspeed.c
>     >> @@ -20,6 +20,8 @@
>     >>  #include "qemu/log.h"
>     >>  #include "sysemu/block-backend.h"
>     >>  #include "sysemu/blockdev.h"
>     >> +#include "hw/loader.h"
>     >> +#include "qemu/error-report.h"
>     >>
>     >>  static struct arm_boot_info aspeed_board_binfo =3D {
>     >>      .board_id =3D -1, /* device-tree-only board */
>     >> @@ -104,6 +106,28 @@ static const AspeedBoardConfig aspeed_board=
s[] =3D {
>     >>      },
>     >>  };
>     >>
>     >> +#define FIRMWARE_ADDR 0x0
>     >> +
>     >> +static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_=
t rom_size,
>     >> +                           Error **errp)
>     >> +{
>     >> +    BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
>     >> +    uint8_t *storage;
>     >> +
>     >> +    if (rom_size > blk_getlength(blk)) {
>     >> +        rom_size =3D blk_getlength(blk);
>     >> +    }
>     > I was not able to attach smaller file as m25p80 storage.
>=20
>     yes that's most probably because m25p80_realize() does :
>=20
>            if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) =
{
>                 error_setg(errp, "failed to read the initial flash cont=
ent");
>                 return;
>             }
>=20
>     my bad. May be, we could relax a bit the test and allow smaller blo=
ck
>     backends ?
>=20
> =20
> I think not, if you have fs on flash (eg. UBI) and smaller image fs wil=
l not mount,
> or in worse case you can issue writes outside the file.=20
>=20
>=20
>=20
>     >> +
>     >> +    storage =3D g_new0(uint8_t, rom_size);
>     >> +    if (blk_pread(blk, 0, storage, rom_size) < 0) {
>     >> +        error_setg(errp, "failed to read the initial flash cont=
ent");
>     >> +        return;
>     >> +    }
>     >> +
>     >> +    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, ad=
dr);
>     >> +    g_free(storage);
>     >> +}
>     >> +
>     >>  static void aspeed_board_init_flashes(AspeedSMCState *s, const =
char *flashtype,
>     >>                                        Error **errp)
>     >>  {
>     >> @@ -135,6 +159,7 @@ static void aspeed_board_init(MachineState *=
machine,
>     >>  {
>     >>      AspeedBoardState *bmc;
>     >>      AspeedSoCClass *sc;
>     >> +    DriveInfo *drive0 =3D drive_get(IF_MTD, 0, 0);
>     >>
>     >>      bmc =3D g_new0(AspeedBoardState, 1);
>     >>      object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_n=
ame);
>     >> @@ -168,6 +193,22 @@ static void aspeed_board_init(MachineState =
*machine,
>     >>      aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &e=
rror_abort);
>     >>      aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model,=
 &error_abort);
>     >>
>     >> +    /* Install first FMC flash content as a boot rom. */
>     >> +    if (drive0) {
>     >> +        AspeedSMCFlash *fl =3D &bmc->soc.fmc.flashes[0];
>     >> +        MemoryRegion *boot_rom =3D g_new(MemoryRegion, 1);
>     >> +
>     >> +        /*
>     >> +         * create a ROM region using the default mapping window=
 size of
>     >> +         * the flash module.
>     >> +         */
>     >> +        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.b=
oot_rom",
>     >> +                               fl->size, &error_abort);
>     >> +        memory_region_add_subregion(get_system_memory(), FIRMWA=
RE_ADDR,
>     >> +                                    boot_rom);
>     >> +        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_=
abort);
>     >
>     > Is it possible that fl->size will be bigger than segment size?
>     >
>     > I think max_size here should be segment size in smc.
>=20
>     I am not sure what you mean by "segment" ?
>=20
>     fl->size holds the default mapping window size on the AHB bus of th=
e
>     flash chip CS0. The size can be changed by the guest using the segm=
ent
>     address registers but for CS0 this should be "autoconfigured" by HW=
.
>=20
>=20
> This is exactly what i meant, I was thinking that fl->size is the size =
of the whole flash,
> not the size of memory mapped part.
>=20
>=20
>     Here, we are just using the default from the specs but we could go =
a
>     little further in the model and setup the mapping window size of CS=
0
>     using the block backend size, and set up the segment registers acco=
rdingly.
>     There are some checks to be done. It might be a little complex.
>=20
>=20
> I do not think there is a reason for doing that yet :)

ok. I need to think about the API between the different objects, SCU and =
SMC,
to configure the hw strapping.

Thanks,

C.=20

> Thanks,
> Marcin
>=20
>=20
>     Thanks,
>=20
>     C.
>=20
>=20
>     > Thanks,
>     > Marcin
>     >> +    }
>     >> +
>     >>      aspeed_board_binfo.kernel_filename =3D machine->kernel_file=
name;
>     >>      aspeed_board_binfo.initrd_filename =3D machine->initrd_file=
name;
>     >>      aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdli=
ne;
>     >
>=20
>=20
