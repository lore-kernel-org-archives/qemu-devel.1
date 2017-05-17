Received: from eggs.gnu.org ([2001:4830:134:3::10]:41829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dAvQT-0006sF-Fv
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dAvQR-00053v-4l
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:39:25 -0400
MIME-Version: 1.0
In-Reply-To: <d403f33f-647e-a142-4265-7d856d8be6aa@amsat.org>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<d403f33f-647e-a142-4265-7d856d8be6aa@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Wed, 17 May 2017 15:09:21 +0530
Message-ID: <CALHRZur8Uh0JCnOoY-_mUU_fyzbUgxbmWKtfOoB-GTYR5UcEnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v5 PATCH 0/5] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,

On Wed, May 17, 2017 at 9:57 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Sundeep,
>
> This patchset is way cleaner!
> I had a fast look and I like it, I'll try to make some time soon to revie=
w
> details and test it.


Thank you

>


> Is your work interested on U-Boot or more focused in Linux kernel?
>

I am interested more in kernel. I had to look into u-boot for first time
for Qemu only.
I worked only on FPGAs(load kernel with debugger) till now so never got a
chance to look into u-boot.

>
> If you compile QEMU with libfdt support you can use the -dtb option to
> pass the blob to the kernel directly, bypassing the bootloader.
>
> Yeah for armv7m I could not find any thing like that in tree.


> If you need a bootloader you may give a look at coreboot which supports
> dts well, see how Vladimir Serbinenko used Linux's dt to boot a QEMU
> Versatile Express board:
> https://mail.coreboot.org/pipermail/coreboot-gerrit/2016-
> February/040899.html
>
> Cool. I will look into it.

Thanks,
Sundeep


> Regards,
>
> Phil.
>
>
> On 05/16/2017 12:38 PM, Subbaraya Sundeep wrote:
>
>> Hi Qemu-devel,
>>
>> I am trying to add Smartfusion2 SoC.
>> SoC is from Microsemi and System on Module(SOM)
>> board is from Emcraft systems. Smartfusion2 has hardened
>> Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
>> At the moment only system timer, sysreg and SPI
>> controller are modelled.
>>
>> Testing:
>> ./arm-softmmu/qemu-system-arm -M smartfusion2-som -serial mon:stdio \
>> -kernel u-boot.bin -display none -drive file=3Dspi.bin,if=3Dmtd,format=
=3Draw
>>
>> Binaries u-boot.bin and spi.bin are at:
>> https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git
>>
>> U-boot is from Emcraft with modified
>>     - SPI driver not to use PDMA.
>>     - ugly hack to pass dtb to kernel in r1.
>> @
>> https://github.com/Subbaraya-Sundeep/emcraft-uboot-sf2.git
>>
>> Linux is 4.5 linux with Smartfusion2 SoC dts and clocksource
>> driver added by myself @
>> https://github.com/Subbaraya-Sundeep/linux.git
>>
>> v5
>>     As per Philippe comments:
>>         Added abort in Sysreg if guest tries to remap memory
>>         other than default mapping.
>>         Use of CONFIG_MSF2 in Makefile for soc.c
>>         Fixed incorrect logic in timer model.
>>         Renamed msf2-timer.c -> mss-timer.c
>>                 msf2-spi.c -> mss-spi.c also type names
>>         Renamed function msf2_init->emcraft_sf2_init in msf2-som.c
>>         Added part-name,eNVM-size,eSRAM-size,pclk0 and pclk1
>>             properties to soc.
>>         Pass soc part-name,memory size and clock rate properties from so=
m.
>> v4:
>>     Fixed build failure by using PRIx macros.
>> v3:
>>     Added SoC file and board file as per Alistair comments.
>> v2:
>>     Added SPI controller so that u-boot loads kernel from spi flash.
>> v1:
>>     Initial patch set with timer and sysreg
>>
>> Thanks,
>> Sundeep
>>
>> Subbaraya Sundeep (5):
>>   msf2: Add Smartfusion2 System timer
>>   msf2: Microsemi Smartfusion2 System Register block.
>>   msf2: Add Smartfusion2 SPI controller
>>   msf2: Add Smartfusion2 SoC.
>>   msf2: Add Emcraft's Smartfusion2 SOM kit.
>>
>>  default-configs/arm-softmmu.mak |   1 +
>>  hw/arm/Makefile.objs            |   2 +
>>  hw/arm/msf2-soc.c               | 201 +++++++++++++++++++++
>>  hw/arm/msf2-som.c               |  89 ++++++++++
>>  hw/misc/Makefile.objs           |   1 +
>>  hw/misc/msf2-sysreg.c           | 161 +++++++++++++++++
>>  hw/ssi/Makefile.objs            |   1 +
>>  hw/ssi/mss-spi.c                | 378 ++++++++++++++++++++++++++++++
>> ++++++++++
>>  hw/timer/Makefile.objs          |   1 +
>>  hw/timer/mss-timer.c            | 249 ++++++++++++++++++++++++++
>>  include/hw/arm/msf2-soc.h       |  69 ++++++++
>>  include/hw/misc/msf2-sysreg.h   |  80 +++++++++
>>  include/hw/ssi/mss-spi.h        | 104 +++++++++++
>>  include/hw/timer/mss-timer.h    |  80 +++++++++
>>  14 files changed, 1417 insertions(+)
>>  create mode 100644 hw/arm/msf2-soc.c
>>  create mode 100644 hw/arm/msf2-som.c
>>  create mode 100644 hw/misc/msf2-sysreg.c
>>  create mode 100644 hw/ssi/mss-spi.c
>>  create mode 100644 hw/timer/mss-timer.c
>>  create mode 100644 include/hw/arm/msf2-soc.h
>>  create mode 100644 include/hw/misc/msf2-sysreg.h
>>  create mode 100644 include/hw/ssi/mss-spi.h
>>  create mode 100644 include/hw/timer/mss-timer.h
>>
>>
