Received: from eggs.gnu.org ([209.51.188.92]:54650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1TkF-0000p2-BO
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1TkD-0000an-Sz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:25:51 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:36065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h1TkC-0000VI-5Z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:25:49 -0500
Received: by mail-pf1-x42a.google.com with SMTP id n22so8249698pfa.3
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 02:25:41 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Wed, 6 Mar 2019 13:21:58 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201903061321.58890.randrianasulu@gmail.com>
Subject: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, balaton@eik.bme.hu

Hello, all.

I was compiling those pmons for last two days, and I happy to say most of m=
y hackery was
unnecessary.

Just unpack pmon_1c.tar.gz and toolchain-pmon.tar.bz2
compile tools in pmon/tools (just make), create  directory /opt/pmon2000/to=
ols, install tools,
be sure /opt/pmon2000/tools/bin in your $PATH, put compiler in /usr/local/c=
omp, put build.sh=20
script from unpacked toolchain tree into pmon.zloader dir, reset tree (git =
checkout -b label)=20
to some known or desired commit

few of them I tested:

9048810a267835e8efb0496fd99884bd500c43a0

17471780223332a7016959bcb9784ba249bd8660

dd26466da98371470af957993a600719466305f9

for last one you probably want to revert "move highmemcpy highset into lib.=
",
because it was breaking zloader.2edev compilation for me.

Now, most of my hacks were unnecessary, you can just use this Bonito file
in Targets/Bonito2edev/conf/:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# $Id: Bonito,v 1.1.1.1 2006/09/14 01:59:09 root Exp $ # #      GENERIC con=
figuration for Galileo EV64240 # #  This file is supposed to be included by=
 target file after #  endian has been defined.
#
machine         Bonito2edev        mips    # CPU Architecture, Platform
config          pmon

#
#  Define target endian
#
makeoptions     ENDIAN=3DEL               # Little endian version.


#include "conf/GENERIC_ALL"

#
# System Name and Target Name
#
option          SYSTYPE=3D"\"Bonito\""
option          TARGETNAME=3D"\"Bonito\""

#
# Platform options
#
option          BONITOEL
option      DEVBD2E
option          MIPS
option          INET

select          mod_flash_amd           # AMD flash device programming
select          mod_flash_intel         # intel flash device programming
select          mod_flash_sst           # intel flash device programming
select          mod_debugger            # Debugging module
select          mod_symbols             # Symbol table handling
select          mod_s3load              # Srecord loading
#select         mod_fastload            # LSI Fastload
select          mod_elfload             # ELF loading

#
# Command selection. Selects pmon commands
#
select          cmd_newmt
select          cmd_setup
select          mod_display
select          cmd_about               # Display info about PMON
select          cmd_boot                # Boot wrapper
select          cmd_mycmd
select          cmd_xmodem
select          ramfiles
select          cmd_newmt
select          cmd_cache               # Cache enabling
#select         cmd_call                # Call a function command
select          cmd_date                # Time of day command
select          cmd_env                 # Full blown environment command set
select          cmd_flash               # Flash programming cmds
select          cmd_hist                # Command history
select          cmd_ifaddr              # Interface address command
select          cmd_l                   # Disassemble
select          cmd_mem                 # Memory manipulation commands
select          cmd_more                # More paginator
select          cmd_mt                  # Simple memory test command
select          cmd_misc                # Reboot & Flush etc.
#select         cmd_stty                # TTY setings command
select          cmd_tr                  # Host port-through command
select          cmd_devls               # Device list
select          cmd_set                 # As cmd_env but not req. cmd_hist
select          cmd_testdisk
select          cmd_test
select          pmon_zmodem_rz
#
select          cmd_shell               # Shell commands, vers, help, eval
#
#
# Platform options
#
select          mod_uart_ns16550        # Standard UART driver
#option         CONS_BAUD=3DB9600
option          CONS_BAUD=3DB115200
select          ext2
select          fatfs
#select         mod_x86emu              # X86 emulation for VGA
option  MY40IO
#select         mod_x86emu_int10
select          mod_vgacon
select          mod_framebuffer
option          X640x480
option          CONFIG_VIDEO_16BPP
option          NOPCINAMES              # Save some space for x86emu
#option         FASTBOOT
select      vt82c686        #via686a/b code

#
# Functional options.
#
option          NOSNOOP                 # Caches are no-snooping

#
# HAVE options. What tgt level provide
#
option          HAVE_TOD                # Time-Of-Day clock
option          HAVE_NVENV              #  Platform has non-volatile env mem
option          HAVE_LOGO               # Output splash logo
option          USE_SUPERIO_UART
#option         USE_LEGACY_RTC
#option         GODSONEV2A
#option         LINUX_PC
#option         LONGMENG
option          RADEON7000
#option         DEBUG_EMU_VGA
option          AUTOLOAD
#option         CONFIG_PCI0_LARGE_MEM
#option         CONFIG_PCI0_HUGE_MEM
#option         CONFIG_PCI0_GAINT_MEM
option          CONFIG_CACHE_64K_4WAY
option      NVRAM_IN_FLASH

#
#  Now the Machine specification
#
mainbus0        at root
localbus0       at mainbus0
#fd0         at mainbus0
pcibr*          at mainbus0
#pcibr1         at mainbus0
pci*            at pcibr?
#ppb*           at pci? dev ? function ?        # PCI-PCI bridges
#pci*           at ppb? bus ?

#### USB
#uhci*          at pci? dev ? function ?

#### SCSI support
#siop*          at pci? dev ? function ?        # Symbios/NCR 53c...
#scsibus*       at siop?
#sd*            at scsibus? target ? lun ?
#cd*            at scsibus? target ? lun ?

#### Networking Devices
#gt0            at localbus? base 4
#gt1            at localbus? base 5
#gt2            at localbus? base 6
# fxp normally only used for debugging (enable/disable both)
fxp*            at pci? dev ? function ?        # Intel 82559 Device
inphy*          at mii? phy ?                   # Intel 82555 PHYs
rtl*        at pci? dev ? function ?
uhci*            at pci? dev ? function ?
#ohci0           at pci? dev ? function ?
usb*             at usbbus ?
#ohci1           at pci? dev ? function ?

select      mod_usb
select          mod_usb_storage
select      mod_usb_uhci
#select                 mod_usb_ohci
select      mod_usb_kbd


#### IDE controllers
pciide*         at pci ? dev ? function ? flags 0x0000
atp*           at pci? dev ? function ?  #sata atp8620
sata*       at atp?
#### IDE hard drives
wd*             at pciide? channel ? drive ? flags 0x0000

#### Pseudo devices
pseudo-device   loop    1       # network loopback

ide_cd*         at pciide? channel ? drive ? flags 0x0001
select          iso9660
option IDECD
#option HAVE_NB_SERIAL
option USE_ENVMAC
#option LOOKLIKE_PC
#select cmd_lwdhcp
#select cmd_bootp
option WDC_NORESET
option FOR_GXEMUL
select fatfs
option FLOATINGPT
select gzip
option VIA686B_POWERFIXUP
option INPUT_FROM_BOTH
option OUTPUT_TO_BOTH
option PCI_IDSEL_VIA686B=3D17

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In other words, just DISABLE both x86_emu and x86_emu_int10h, enable frameb=
uffer,=20
set 640x480 resolution and 16 bpp bit depth.

After this, you can make it
cd zloader.2edev
LANG=3DC ./build.sh
(otherwise in can put localized date in pmon, it will be shown wrong).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#!/bin/bash
export MKDEP=3Dmakedepend
export PATH=3D/usr/local/comp/mips-elf/gcc-2.95.3/bin/:$PATH
make cfg            #=B8=FC=D0=C2=C5=E4=D6=C3
make tgt=3Dram
mv gzram pmon_ram.bin
make tgt=3Drom    #=B2=FA=C9=FA=C9=D5=D6=C6=CE=C4=BC=FE gzrom.bin
mv gzrom.bin  pmon.bin
mkdir -d /var/lib/tftpboot
cp pmon.bin pmon_ram.bin /var/lib/tftpboot
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

note, my mkdir doesn't understand 'd' option, but script finishes anyway.
watch for errors, especially if you enabled some more options.

Newer pmon source fails to compile for me due to some mtd changes.

After this , I run resulted pmon like this=20
(using Zoltan's patch for ati-vga device on top of current qemu):

mips64el-softmmu/qemu-system-mips64el -M fulong2e  -cpu Loongson-2E -m 1G  =
=2Dbios /dev/shm/pmon-my/pmon/zloader.2edev/pmon.bin -device ati-vga,model=
=3Drv100 -hda /dev/shm/LONGSOON_disk  -cdrom /dev/shm/debian-8.0.0-mipsel-x=
fce-CD-1.iso -display sdl,gl=3Don

it can see both disk and CD, but sadly I was unable to find any working ker=
nel?!

vmlinux-2e just hangs early, and vmlinux-3.16.0-4-loongson-2e extracted fro=
m debian pkg
hangs a litle latter in boot process. Tried without -m option, and with 2F =
CPU.=20
I mean even with just -kernel, no bios involved.

Also, while I was able to compile-in uhci support, adding usb-kbd device fr=
eezes pmon. And newly-added=20
EHCI support apparently limited to only some CPUs/boards :/ At least I was =
unable to compile pmon in=20
this config and with mod_usb_ehci.

Oh, and sadly my little "disable bitblit" patch was still needed:

diff --git a/fb/cfb_console.c b/fb/cfb_console.c
index 6663ef7..f29c43f 100644
=2D-- a/fb/cfb_console.c
+++ b/fb/cfb_console.c
@@ -113,7 +113,7 @@ CONFIG_VIDEO_HW_CURSOR:          - Uses the hardware cu=
rsor capability of the
 #define CONFIG_VIDEO_LOGO
 #define        CONFIG_VIDEO_BMP_LOGO
 //#define DEBUG_CFG_CONSOLE
=2D#define VIDEO_HW_BITBLT
+//#define VIDEO_HW_BITBLT
 #elif defined(SMI712)
 #define CONFIG_VIDEO_SW_CURSOR
 //#define CONFIG_VIDEO_LOGO

otherwise pmon was not scrolling help text or any messages up.
