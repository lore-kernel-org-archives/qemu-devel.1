Received: from eggs.gnu.org ([2001:4830:134:3::10]:41911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtkvI-0001MU-V6
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 21:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtkvF-0007Nj-7T
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 21:32:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1505494753-10837-1-git-send-email-sundeep.lkml@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c141996-c4ed-7156-d960-58ae2d9c4d1e@amsat.org>
Date: Sun, 17 Sep 2017 22:32:15 -0300
MIME-Version: 1.0
In-Reply-To: <1505494753-10837-1-git-send-email-sundeep.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel v9 PATCH 0/5] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, crosthwaite.peter@gmail.com, alistair23@gmail.com

Hi Sundeep,

On 09/15/2017 01:59 PM, Subbaraya Sundeep wrote:
> Hi Qemu-devel,
> 
> I am trying to add Smartfusion2 SoC.
> SoC is from Microsemi and System on Module(SOM)
> board is from Emcraft systems. Smartfusion2 has hardened
> Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
> At the moment only system timer, sysreg and SPI
> controller are modelled.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

When a review tag is sent to the series cover, this means it can be 
added to all the patches from the series.

> 
> Testing:
> ./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio \
> -kernel u-boot.bin -display none -drive file=spi.bin,if=mtd,format=raw
> 
> Binaries u-boot.bin and spi.bin are at:
> https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git
> 
> U-boot is from Emcraft with modified
>      - SPI driver not to use PDMA.
>      - ugly hack to pass dtb to kernel in r1.
> @
> https://github.com/Subbaraya-Sundeep/emcraft-uboot-sf2.git
> 
> Linux is 4.5 linux with Smartfusion2 SoC dts and clocksource
> driver added by myself @
> https://github.com/Subbaraya-Sundeep/linux.git
> 
> v9:

However if you made significant changes to v9, please drop the R-b that 
were left on v8 to make sure people re-review those changes. Functional 
changes directly reset Tested-by tags.

$ git backport-diff -r master..msf2_v9 -u msf2_v8
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, 
respectively

001/5:[----] [--] 'msf2: Add Smartfusion2 System timer'
002/5:[0047] [FC] 'msf2: Microsemi Smartfusion2 System Register block'
003/5:[----] [--] 'msf2: Add Smartfusion2 SPI controller'
004/5:[0018] [FC] 'msf2: Add Smartfusion2 SoC'
005/5:[0001] [FC] 'msf2: Add Emcraft's Smartfusion2 SOM kit'

> 	used trace instead of DB_PRINT in msf2-sysreg.c
> 	used LOG_UNIMP for non guest errors in msf2-sysreg.c
> 	added unimplemented devices in msf2-soc.c
> 	removed .alias suffix in alias memory region name for eNVM

you also removed "mc->ignore_memory_transaction_failures" use.

> 
> v8:
> 	memory_region_init_ram to memory_region_init_rom in soc
> 	%s/emcraft_sf2_init/emcraft_sf2_s2s010_init/g in som
> 	Added mc->ignore_memory_transaction_failures = true in som
> 		as per latest commit.
> 	Code simplifications as suggested by Alistair in sysreg and ssi.

FYI, testing outputs:

- U-Boot

CPU  : SmartFusion2 SoC (Cortex-M3 Hard IP)
Freqs: CORTEX-M3=142MHz,PCLK0=71MHz,PCLK1=71MHz
Board: M2S-FG484-SOM Rev 1A, www.emcraft.com
apb_config: unimplemented device write (size 4, value 0x0, offset 0x10)
apb_config: unimplemented device write (size 4, value 0x118, offset 0x84)
apb_config: unimplemented device write (size 4, value 0xc1, offset 0x18)
apb_config: unimplemented device write (size 4, value 0x99f, offset 0x1c)
apb_config: unimplemented device write (size 4, value 0x3333, offset 0x24)
apb_config: unimplemented device write (size 4, value 0xffff, offset 0x28)
apb_config: unimplemented device write (size 4, value 0x3300, offset 0x78)
apb_config: unimplemented device write (size 4, value 0x7777, offset 0x2c)
apb_config: unimplemented device write (size 4, value 0xfff, offset 0x30)
apb_config: unimplemented device write (size 4, value 0x580, offset 0x8)
apb_config: unimplemented device write (size 4, value 0x110, offset 0xc)
apb_config: unimplemented device write (size 4, value 0x1c00, offset 0x38)
apb_config: unimplemented device write (size 4, value 0x8, offset 0x3c)
apb_config: unimplemented device write (size 4, value 0xd23, offset 0x6c)
apb_config: unimplemented device write (size 4, value 0x240, offset 0x50)
apb_config: unimplemented device write (size 4, value 0x2, offset 0x5c)
apb_config: unimplemented device write (size 4, value 0x126, offset 0x60)
apb_config: unimplemented device write (size 4, value 0x3, offset 0xbc)
apb_config: unimplemented device write (size 4, value 0x23, offset 0x54)
apb_config: unimplemented device write (size 4, value 0x33, offset 0x40)
apb_config: unimplemented device write (size 4, value 0x20, offset 0x44)
apb_config: unimplemented device write (size 4, value 0x33, offset 0x80)
apb_config: unimplemented device write (size 4, value 0x8, offset 0x7c)
apb_config: unimplemented device write (size 4, value 0x4000, offset 0x9c)
apb_config: unimplemented device write (size 4, value 0x0, offset 0xb4)
apb_config: unimplemented device write (size 4, value 0x107, offset 0x64)
apb_config: unimplemented device write (size 4, value 0x104, offset 0x58)
apb_config: unimplemented device write (size 4, value 0x11, offset 0x68)
apb_config: unimplemented device write (size 4, value 0x80f8, offset 0xa0)
apb_config: unimplemented device write (size 4, value 0x7, offset 0xa4)
apb_config: unimplemented device write (size 4, value 0x80f8, offset 0xa8)
apb_config: unimplemented device write (size 4, value 0x7, offset 0xac)
apb_config: unimplemented device write (size 4, value 0x200, offset 0xb0)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x21c)
apb_config: unimplemented device write (size 4, value 0x80, offset 0x224)
apb_config: unimplemented device write (size 4, value 0xf, offset 0x230)
apb_config: unimplemented device write (size 4, value 0xb, offset 0x248)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x25c)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x260)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x264)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x268)
apb_config: unimplemented device write (size 4, value 0x1, offset 0x280)
apb_config: unimplemented device write (size 4, value 0x40, offset 0x298)
apb_config: unimplemented device write (size 4, value 0x401, offset 0x29c)
apb_config: unimplemented device write (size 4, value 0x4010, offset 0x2a0)
apb_config: unimplemented device write (size 4, value 0x40, offset 0x2d8)
apb_config: unimplemented device write (size 4, value 0x401, offset 0x2dc)
apb_config: unimplemented device write (size 4, value 0x4010, offset 0x2e0)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x2fc)
apb_config: unimplemented device write (size 4, value 0x3, offset 0x304)
apb_config: unimplemented device write (size 4, value 0x1, offset 0x308)
apb_config: unimplemented device write (size 4, value 0x1, offset 0x30c)
apb_config: unimplemented device write (size 4, value 0x9, offset 0x314)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x238)
apb_config: unimplemented device write (size 4, value 0x0, offset 0x23c)
apb_config: unimplemented device write (size 4, value 0x1, offset 0x31c)
apb_config: unimplemented device write (size 4, value 0x1, offset 0x0)
DRAM:  64 MB
pdma: unimplemented device write (size 4, value 0x1a0, offset 0x20)
pdma: unimplemented device read (size 4, offset 0x20)
pdma: unimplemented device write (size 4, value 0x3c000, offset 0x20)
pdma: unimplemented device read (size 4, offset 0x20)
pdma: unimplemented device write (size 4, value 0x2000001, offset 0x20)
pdma: unimplemented device write (size 4, value 0x1a0, offset 0x40)
pdma: unimplemented device read (size 4, offset 0x40)
pdma: unimplemented device write (size 4, value 0x3c000, offset 0x40)
pdma: unimplemented device read (size 4, offset 0x40)
pdma: unimplemented device write (size 4, value 0x2800003, offset 0x40)
pdma: unimplemented device write (size 4, value 0x20, offset 0x20)
pdma: unimplemented device write (size 4, value 0x20, offset 0x40)
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   M2S_MAC
Hit any key to stop autoboot:  0
pdma: unimplemented device write (size 4, value 0x1a0, offset 0x20)
pdma: unimplemented device read (size 4, offset 0x20)
pdma: unimplemented device write (size 4, value 0x3c000, offset 0x20)
pdma: unimplemented device read (size 4, offset 0x20)
pdma: unimplemented device write (size 4, value 0x2000001, offset 0x20)
pdma: unimplemented device write (size 4, value 0x1a0, offset 0x40)
pdma: unimplemented device read (size 4, offset 0x40)
pdma: unimplemented device write (size 4, value 0x3c000, offset 0x40)
pdma: unimplemented device read (size 4, offset 0x40)
pdma: unimplemented device write (size 4, value 0x2800003, offset 0x40)
pdma: unimplemented device write (size 4, value 0x20, offset 0x20)
pdma: unimplemented device write (size 4, value 0x20, offset 0x40)
16384 KiB S25FL128P_64K at 0:0 is now current device
pdma: unimplemented device write (size 4, value 0x1a0, offset 0x20)
pdma: unimplemented device read (size 4, offset 0x20)
pdma: unimplemented device write (size 4, value 0x3c000, offset 0x20)
pdma: unimplemented device read (size 4, offset 0x20)
pdma: unimplemented device write (size 4, value 0x2000001, offset 0x20)
pdma: unimplemented device write (size 4, value 0x1a0, offset 0x40)
pdma: unimplemented device read (size 4, offset 0x40)
pdma: unimplemented device write (size 4, value 0x3c000, offset 0x40)
pdma: unimplemented device read (size 4, offset 0x40)
pdma: unimplemented device write (size 4, value 0x2800003, offset 0x40)
pdma: unimplemented device write (size 4, value 0x20, offset 0x20)
pdma: unimplemented device write (size 4, value 0x20, offset 0x40)

- tftpboot

M2S-FG484-SOM> tftpboot
emac: unimplemented device write (size 4, value 0x7, offset 0x20)
emac: unimplemented device read (size 4, offset 0x0)
emac: unimplemented device write (size 4, value 0x80000000, offset 0x0)
emac: unimplemented device read (size 4, offset 0x0)
emac: unimplemented device write (size 4, value 0x0, offset 0x0)
emac: unimplemented device read (size 4, offset 0x0)
emac: unimplemented device write (size 4, value 0x0, offset 0x0)
emac: unimplemented device read (size 4, offset 0x0)
emac: unimplemented device write (size 4, value 0x0, offset 0x0)
emac: unimplemented device read (size 4, offset 0x0)
emac: unimplemented device write (size 4, value 0x0, offset 0x0)
emac: unimplemented device read (size 4, offset 0x0)
emac: unimplemented device write (size 4, value 0x0, offset 0x0)
emac: unimplemented device read (size 4, offset 0x38)
emac: unimplemented device write (size 4, value 0x0, offset 0x38)
emac: unimplemented device read (size 4, offset 0x48)
emac: unimplemented device write (size 4, value 0x0, offset 0x48)
emac: unimplemented device write (size 4, value 0x0, offset 0x0)
emac: unimplemented device read (size 4, offset 0x4)
emac: unimplemented device write (size 4, value 0x0, offset 0x4)
emac: unimplemented device read (size 4, offset 0x4)
emac: unimplemented device write (size 4, value 0x105, offset 0x4)
emac: unimplemented device write (size 4, value 0x600, offset 0x10)
emac: unimplemented device write (size 4, value 0xc0b13c83, offset 0x40)
emac: unimplemented device write (size 4, value 0x83830000, offset 0x44)
emac: unimplemented device write (size 4, value 0x200032e4, offset 0x190)
emac: unimplemented device write (size 4, value 0x1, offset 0x18c)
emac: unimplemented device read (size 4, offset 0x48)
emac: unimplemented device write (size 4, value 0x1f, offset 0x48)
emac: unimplemented device read (size 4, offset 0x48)
emac: unimplemented device write (size 4, value 0x0, offset 0x48)
emac: unimplemented device write (size 4, value 0xff00, offset 0x48)
emac: unimplemented device read (size 4, offset 0x48)
[...]
emac: unimplemented device read (size 4, offset 0x48)
m2s_eth_init: FIFO initialization timeout
*** m2s_mac_dump_regs FIFO init:
emac: unimplemented device read (size 4, offset 0x180)
emac: unimplemented device read (size 4, offset 0x184)
emac: unimplemented device read (size 4, offset 0x188)
  DMA TX CTRL=00000000;DESC=00000000;STAT=00000000
emac: unimplemented device read (size 4, offset 0x18c)
emac: unimplemented device read (size 4, offset 0x190)
emac: unimplemented device read (size 4, offset 0x194)
  DMA RX CTRL=00000000;DESC=00000000;STAT=00000000
emac: unimplemented device read (size 4, offset 0x19c)
emac: unimplemented device read (size 4, offset 0x198)
  DMA IRQ 00000000/00000000
emac: unimplemented device read (size 4, offset 0x0)
emac: unimplemented device read (size 4, offset 0x4)
emac: unimplemented device read (size 4, offset 0x8)
emac: unimplemented device read (size 4, offset 0xc)
emac: unimplemented device read (size 4, offset 0x10)
  CFG1=00000000;CFG2=00000000;IFG=00000000;HD=00000000;MFL=00000000
emac: unimplemented device read (size 4, offset 0x38)
emac: unimplemented device read (size 4, offset 0x3c)
emac: unimplemented device read (size 4, offset 0x40)
emac: unimplemented device read (size 4, offset 0x44)
  IFCTRL=00000000;IFSTAT=00000000;ADR1=00000000;ADR2=00000000
  FIFO CFG emac: unimplemented device read (size 4, offset 0x48)
00000000/emac: unimplemented device read (size 4, offset 0x4c)
00000000/emac: unimplemented device read (size 4, offset 0x50)
00000000/emac: unimplemented device read (size 4, offset 0x54)
00000000/emac: unimplemented device read (size 4, offset 0x58)
00000000/emac: unimplemented device read (size 4, offset 0x5c)
00000000/
  FIFO ACC emac: unimplemented device read (size 4, offset 0x60)
00000000/emac: unimplemented device read (size 4, offset 0x64)
00000000/emac: unimplemented device read (size 4, offset 0x68)
00000000/emac: unimplemented device read (size 4, offset 0x6c)
00000000/emac: unimplemented device read (size 4, offset 0x70)
00000000/emac: unimplemented device read (size 4, offset 0x74)
00000000/emac: unimplemented device read (size 4, offset 0x78)
00000000/emac: unimplemented device read (size 4, offset 0x7c)
00000000/
M2S-FG484-SOM>

- erase

M2S-FG484-SOM> sf erase 0 0x1000
Taking exception 4 [Data Abort]
...with CFSR.PRECISERR and BFAR 0x10
... as 3
UNHANDLED EXCEPTION: HARD FAULT
   R0	= 00848cea  R1	= 00000000
   R2	= 00022ab0  R3	= 00000000
   R12	= 00000004  LR	= 00000a27
   PC	= 0000d418  PSR	= 01000000

Good work :)

Regards,

Phil.
