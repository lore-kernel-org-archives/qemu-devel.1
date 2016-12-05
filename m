Received: from eggs.gnu.org ([2001:4830:134:3::10]:60907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cDutv-0003yZ-7E
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cDutq-0000TL-4W
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:09:55 -0500
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-25-git-send-email-clg@kaod.org>
	<4e2db842-7ff6-d7e7-c96c-26ce9c563c83@gmail.com>
	<f28b693f-dade-b338-cc86-b5e85f8b1675@kaod.org>
	<CABc_YGCweFyD8+tZf32_AM6YYYcFWtZS3ejb2A_cUMi0LCsZ0A@mail.gmail.com>
	<7eeb3879-309e-0117-2f44-51100005d475@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <683c71e8-52db-d240-ecdd-9f083e2a409b@gmail.com>
Date: Mon, 5 Dec 2016 16:09:34 +0100
MIME-Version: 1.0
In-Reply-To: <7eeb3879-309e-0117-2f44-51100005d475@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>



W dniu 05.12.2016 o 15:53, Cédric Le Goater pisze:
> On 12/05/2016 10:57 AM, Marcin Krzemiński wrote:
>> 2016-12-05 10:36 GMT+01:00 Cédric Le Goater <clg@kaod.org <mailto:clg@kaod.org>>:
>>
>>      Hello Marcin,
>>
>>      On 12/04/2016 06:00 PM, mar.krzeminski wrote:
>>      > Hi Cedric,
>>      >
>>      > it looks like good idea for now to handle boot from flash.
>>      > As I understand you are trying to omit bootrom code in Qemu model?
>>
>>      I suppose you mean handling a romd memory region under the m25p80
>>      object ?
>>
>> It could be that I mess up everything because my understanding how the real HW
>> work and boot is wrong. Please correct my assumptions:
>> 1. You are setting boot source to spi-nor (jumper, resistor whatever)
>> 2. There is a small bootrom in SoC (not u-boot) that set eg. reset vector, configure SMC
>> and start execude code from flash.
>> 3. Memory mapped flash content is at address 0x1c000000.
> No. The memory flash content CS0 is mapped at 0x0 and starts
> with U-Boot directly, there is no preliminary loader.
>
> U-Boot is not merged in mainline yet. We are "slowly" building a
> tree for upstream :
>   
> 	https://github.com/openbmc/u-boot/
> 	https://github.com/legoater/u-boot/
Thanks, I will look at those source in that case and the get back.

Thanks,
Marcin
>
>
>>      > This could lead you to some hacks in device models (eg SMC).
>>
>>      I haven't had to, yet.
>>
>>      > W dniu 29.11.2016 o 16:44, Cédric Le Goater pisze:
>>      >> Fill a ROM region with the flash content to support U-Boot. This is a
>>      >> little hacky but until we can boot from a MMIO region, it seems
>>      >> difficult to do anything else.
>>      >>
>>      >> Signed-off-by: Cédric Le Goater <clg@kaod.org <mailto:clg@kaod.org>>
>>      >> Reviewed-by: Joel Stanley <joel@jms.id.au <mailto:joel@jms.id.au>>
>>      >> Reviewed-by: Andrew Jeffery <andrew@aj.id.au <mailto:andrew@aj.id.au>>
>>      >> ---
>>      >>  hw/arm/aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>      >>  1 file changed, 41 insertions(+)
>>      >>
>>      >> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>      >> index 40c13838fb2d..a92c2f1c362b 100644
>>      >> --- a/hw/arm/aspeed.c
>>      >> +++ b/hw/arm/aspeed.c
>>      >> @@ -20,6 +20,8 @@
>>      >>  #include "qemu/log.h"
>>      >>  #include "sysemu/block-backend.h"
>>      >>  #include "sysemu/blockdev.h"
>>      >> +#include "hw/loader.h"
>>      >> +#include "qemu/error-report.h"
>>      >>
>>      >>  static struct arm_boot_info aspeed_board_binfo = {
>>      >>      .board_id = -1, /* device-tree-only board */
>>      >> @@ -104,6 +106,28 @@ static const AspeedBoardConfig aspeed_boards[] = {
>>      >>      },
>>      >>  };
>>      >>
>>      >> +#define FIRMWARE_ADDR 0x0
>>      >> +
>>      >> +static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
>>      >> +                           Error **errp)
>>      >> +{
>>      >> +    BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
>>      >> +    uint8_t *storage;
>>      >> +
>>      >> +    if (rom_size > blk_getlength(blk)) {
>>      >> +        rom_size = blk_getlength(blk);
>>      >> +    }
>>      > I was not able to attach smaller file as m25p80 storage.
>>
>>      yes that's most probably because m25p80_realize() does :
>>
>>             if (blk_pread(s->blk, 0, s->storage, s->size) != s->size) {
>>                  error_setg(errp, "failed to read the initial flash content");
>>                  return;
>>              }
>>
>>      my bad. May be, we could relax a bit the test and allow smaller block
>>      backends ?
>>
>>   
>> I think not, if you have fs on flash (eg. UBI) and smaller image fs will not mount,
>> or in worse case you can issue writes outside the file.
>>
>>
>>
>>      >> +
>>      >> +    storage = g_new0(uint8_t, rom_size);
>>      >> +    if (blk_pread(blk, 0, storage, rom_size) < 0) {
>>      >> +        error_setg(errp, "failed to read the initial flash content");
>>      >> +        return;
>>      >> +    }
>>      >> +
>>      >> +    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
>>      >> +    g_free(storage);
>>      >> +}
>>      >> +
>>      >>  static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>>      >>                                        Error **errp)
>>      >>  {
>>      >> @@ -135,6 +159,7 @@ static void aspeed_board_init(MachineState *machine,
>>      >>  {
>>      >>      AspeedBoardState *bmc;
>>      >>      AspeedSoCClass *sc;
>>      >> +    DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
>>      >>
>>      >>      bmc = g_new0(AspeedBoardState, 1);
>>      >>      object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
>>      >> @@ -168,6 +193,22 @@ static void aspeed_board_init(MachineState *machine,
>>      >>      aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
>>      >>      aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_abort);
>>      >>
>>      >> +    /* Install first FMC flash content as a boot rom. */
>>      >> +    if (drive0) {
>>      >> +        AspeedSMCFlash *fl = &bmc->soc.fmc.flashes[0];
>>      >> +        MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
>>      >> +
>>      >> +        /*
>>      >> +         * create a ROM region using the default mapping window size of
>>      >> +         * the flash module.
>>      >> +         */
>>      >> +        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
>>      >> +                               fl->size, &error_abort);
>>      >> +        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
>>      >> +                                    boot_rom);
>>      >> +        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
>>      >
>>      > Is it possible that fl->size will be bigger than segment size?
>>      >
>>      > I think max_size here should be segment size in smc.
>>
>>      I am not sure what you mean by "segment" ?
>>
>>      fl->size holds the default mapping window size on the AHB bus of the
>>      flash chip CS0. The size can be changed by the guest using the segment
>>      address registers but for CS0 this should be "autoconfigured" by HW.
>>
>>
>> This is exactly what i meant, I was thinking that fl->size is the size of the whole flash,
>> not the size of memory mapped part.
>>
>>
>>      Here, we are just using the default from the specs but we could go a
>>      little further in the model and setup the mapping window size of CS0
>>      using the block backend size, and set up the segment registers accordingly.
>>      There are some checks to be done. It might be a little complex.
>>
>>
>> I do not think there is a reason for doing that yet :)
> ok. I need to think about the API between the different objects, SCU and SMC,
> to configure the hw strapping.
>
> Thanks,
>
> C.
>
>> Thanks,
>> Marcin
>>
>>
>>      Thanks,
>>
>>      C.
>>
>>
>>      > Thanks,
>>      > Marcin
>>      >> +    }
>>      >> +
>>      >>      aspeed_board_binfo.kernel_filename = machine->kernel_filename;
>>      >>      aspeed_board_binfo.initrd_filename = machine->initrd_filename;
>>      >>      aspeed_board_binfo.kernel_cmdline = machine->kernel_cmdline;
>>      >
>>
>>
>
