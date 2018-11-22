Received: from eggs.gnu.org ([2001:4830:134:3::10]:53801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gPmrG-00034U-F4
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gPmrA-0003FP-0p
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:09:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gPmr9-00036Z-6V
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:09:11 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so13296473ita.5
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 03:09:08 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120062109.eahirgygm4br3ov7@sirius.home.kraxel.org>
	<CAGxU2F64uK5oygQecZKOPpsyb--Pth9U00P_gghrtYDwQrSGtg@mail.gmail.com>
	<20181120112203.rzhhdl6hhsjf5twt@sirius.home.kraxel.org>
In-Reply-To: <20181120112203.rzhhdl6hhsjf5twt@sirius.home.kraxel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 22 Nov 2018 12:08:55 +0100
Message-ID: <CAGxU2F4LNN1UtVJFADxm1V4eBDQ8eGSoAjPXC=X8+zSR4yd9Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Kevin OConnor <kevin@koconnor.net>, Samuel Ortiz <sameo@linux.intel.com>, seabios@seabios.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Rob Bradford <robert.bradford@intel.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stephend@silicom-usa.com, stefanb@linux.ibm.com

Hi,
I continued to investigate how to reduce the boot time with SeaBIOS
and QEMU when it used with linuxboot_dma.bin (-kernel parameter).
I reached ~12ms with a SeaBIOS configuration (attached) where I
disabled debug output, all Hardware support (except SMM & MTRRs) and I
applied a small patch to disable VGA setup and console (attached).

Samuel, I put also the total time to userspace (linux_start_user)
adding a probe in the kernel_init() and when I disabled the VGA in the
SeaBIOS I noticed also a speed up in the kernel boot phase.

Another approach that I tried, obtaining similar results, is to
recognize the linuxboot_dma.bin at runtime, then skip
device_hardware_setup(), enable_vga_console(), and vgarom_setup(). In
this case, I used the default configuration without disabling
anything.

Gerd, Kevin do you think these approaches can be acceptable in SeaBIOS?

Thanks,
Stefano

Booting times with several configurations:
 - SeaBIOS default config + Stephen's TPM patch
   qemu_init_end: 40.342836
   fw_start: 40.528355 (+0.185519)
   fw_do_boot: 108.679648 (+68.151293)
   linux_start_boot: 110.961394 (+2.281746)
   linux_start_user: 647.981995 (+537.020601)
- SeaBIOS config (CONFIG_DEBUG_LEVEL=0) + Stephen's TPM patch
   qemu_init_end: 44.533900
   fw_start: 44.763200 (+0.229300)
   fw_do_boot: 98.881728 (+54.118528)
   linux_start_boot: 100.925424 (+2.043696)
   linux_start_user: 638.000481 (+537.075057)
- SeaBIOS config (CONFIG_DEBUG_LEVEL=0, disable all HW support except
SMM & MTRRs) + Stephen's TPM patch
   qemu_init_end: 42.705257
   fw_start: 42.915464 (+0.210207)
   fw_do_boot: 91.982749 (+49.067285)
   linux_start_boot: 93.970654 (+1.987905)
   linux_start_user: 632.916320 (+538.945666)
- SeaBIOS config (CONFIG_DEBUG_LEVEL=0, disable all HW support except
SMM & MTRRs, CONFIG_DISABLE_VGA=y) + Stephen's TPM patch
   qemu_init_end: 42.968648
   fw_start: 43.154598 (+0.185950)
   fw_do_boot: 55.808438 (+12.653840)
   linux_start_boot: 57.170154 (+1.361716)
   linux_start_user: 529.189856 (+472.019702)


Disable VGA patch:
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 22 Nov 2018 10:55:23 +0100
Subject: [PATCH] qemu: Add CONFIG_DISABLE_VGA to disable VGA setup and console

Allow users to disable VGA setup and console. Useful to speed
up the boot with QEMU when -kernel parameter is used. Linux
kernel will also initialize the VGA during the boot phase.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 src/Kconfig      | 7 +++++++
 src/bootsplash.c | 2 ++
 src/optionroms.c | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/Kconfig b/src/Kconfig
index daf8222..b1f0ce6 100644
--- a/src/Kconfig
+++ b/src/Kconfig
@@ -364,6 +364,13 @@ menu "Hardware support"
         help
             Support for using the CPU timestamp counter as an internal
             timing source.
+    config DISABLE_VGA
+        depends on QEMU
+        bool "Disable VGA setup"
+        default n
+        help
+            Skip VGA setup and console (useful to speed up the boot with QEMU
+            when -kernel parameter is used).
 endmenu

 menu "BIOS interfaces"
diff --git a/src/bootsplash.c b/src/bootsplash.c
index 165c98d..dde3314 100644
--- a/src/bootsplash.c
+++ b/src/bootsplash.c
@@ -39,6 +39,8 @@ call16_int10(struct bregs *br)
 void
 enable_vga_console(void)
 {
+    if (CONFIG_DISABLE_VGA)
+        return;
     dprintf(1, "Turning on vga text mode console\n");
     struct bregs br;

diff --git a/src/optionroms.c b/src/optionroms.c
index fc992f6..a3b5a16 100644
--- a/src/optionroms.c
+++ b/src/optionroms.c
@@ -428,7 +428,7 @@ vgarom_setup(void)
 {
     int have_vga = 0;

-    if (! CONFIG_OPTIONROMS)
+    if (!CONFIG_OPTIONROMS || CONFIG_DISABLE_VGA)
         return;

     dprintf(1, "Scan for VGA option rom\n");
--
2.19.1


SeaBIOS final configuration:
#
# Automatically generated file; DO NOT EDIT.
# SeaBIOS Configuration
#

#
# General Features
#
# CONFIG_COREBOOT is not set
CONFIG_QEMU=y
# CONFIG_CSM is not set
CONFIG_QEMU_HARDWARE=y
CONFIG_XEN=y
CONFIG_THREADS=y
CONFIG_RELOCATE_INIT=y
CONFIG_BOOTMENU=y
CONFIG_BOOTSPLASH=y
CONFIG_BOOTORDER=y
CONFIG_ENTRY_EXTRASTACK=y
CONFIG_MALLOC_UPPERMEMORY=y
CONFIG_ROM_SIZE=0

#
# Hardware support
#
# CONFIG_ATA is not set
# CONFIG_AHCI is not set
# CONFIG_SDCARD is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_VIRTIO_SCSI is not set
# CONFIG_PVSCSI is not set
# CONFIG_ESP_SCSI is not set
# CONFIG_LSI_SCSI is not set
# CONFIG_MEGASAS is not set
# CONFIG_MPT_SCSI is not set
# CONFIG_FLASH_FLOPPY is not set
# CONFIG_NVME is not set
# CONFIG_PS2PORT is not set
# CONFIG_USB is not set
# CONFIG_SERIAL is not set
# CONFIG_SERCON is not set
# CONFIG_LPT is not set
# CONFIG_HARDWARE_IRQ is not set
CONFIG_USE_SMM=y
CONFIG_CALL32_SMM=y
CONFIG_MTRR_INIT=y
# CONFIG_PMTIMER is not set
# CONFIG_TSC_TIMER is not set
CONFIG_DISABLE_VGA=y

#
# BIOS interfaces
#
CONFIG_DRIVES=y
CONFIG_CDROM_BOOT=y
CONFIG_CDROM_EMU=y
CONFIG_PCIBIOS=y
CONFIG_APMBIOS=y
CONFIG_PNPBIOS=y
CONFIG_OPTIONROMS=y
CONFIG_PMM=y
CONFIG_BOOT=y
CONFIG_KEYBOARD=y
CONFIG_KBD_CALL_INT15_4F=y
CONFIG_MOUSE=y
CONFIG_S3_RESUME=y
CONFIG_VGAHOOKS=y
# CONFIG_DISABLE_A20 is not set
# CONFIG_WRITABLE_UPPERMEMORY is not set
CONFIG_TCGBIOS=y

#
# BIOS Tables
#
CONFIG_PIRTABLE=y
CONFIG_MPTABLE=y
CONFIG_SMBIOS=y
CONFIG_ACPI=y
CONFIG_ACPI_DSDT=y
CONFIG_FW_ROMFILE_LOAD=y

#
# VGA ROM
#
CONFIG_NO_VGABIOS=y
# CONFIG_VGA_STANDARD_VGA is not set
# CONFIG_VGA_CIRRUS is not set
# CONFIG_VGA_BOCHS is not set
# CONFIG_VGA_GEODEGX2 is not set
# CONFIG_VGA_GEODELX is not set
# CONFIG_DISPLAY_BOCHS is not set
# CONFIG_VGA_RAMFB is not set
# CONFIG_BUILD_VGABIOS is not set
CONFIG_VGA_EXTRA_STACK_SIZE=512

#
# Debugging
#
CONFIG_DEBUG_LEVEL=0

On Tue, Nov 20, 2018 at 12:22 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Background:  The drivers in seabios work on both virtual and physical
> > > hardware (you can run seabios as coreboot payload on physical hardware).
> > > There are quite a few places where are delays and timeouts which are
> > > required to work properly on physical hardware.  But typically virtual
> > > hardware is alot faster.  There is -- for example -- no time needed to
> > > establish a sata link.  Link detection in ahci is instant on qemu.
> >
> > I'll investigate also other timeouts.
>
> I'd focus on legacy lpc/isa hardware here.  PCI-ish hardware which has
> such timeouts (sata, usb, ...) typically isn't present in the virtual
> machine if you care about performance.  Or, in other words, the best way
> to handle the sata link detection delay is to use "qemu -M q35,sata=off".
>
> cheers,
>   Gerd
>


--
Stefano Garzarella
Red Hat
