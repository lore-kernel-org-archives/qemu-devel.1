Received: from eggs.gnu.org ([209.51.188.92]:36808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1Z39-0002lS-PN
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1Z38-000865-Ew
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:05:43 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h1Z36-0007yn-HX
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:05:41 -0500
Received: by mail-pg1-x541.google.com with SMTP id e17so8771488pgd.2
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 08:05:29 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Wed, 6 Mar 2019 19:01:52 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201903061901.52932.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balaton@eik.bme.hu, qemu-devel@nongnu.org

> This could be some missing or buggy emulation. Maybe if you can get some debug logs from kernel that could tell what it's doing. Usually at least -d unimp,guest_errors options are recommended for debugging but if nothing is printed then it's harder to find out what's causing the hang.

This was kernel dying in ata subsystem:

[    1.340000] io scheduler noop registered
[    1.340000] io scheduler deadline registered
[    1.340000] io scheduler cfq registered (default)
[    1.352000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.388000] console [ttyS0] disabled
[    1.424000] serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.432000] console [ttyS0] enabled
[    1.432000] console [ttyS0] enabled
[    1.432000] bootconsole [early0] disabled
[    1.432000] bootconsole [early0] disabled
[    1.472000] scsi0 : pata_via
[    1.476000] scsi1 : pata_via
[    1.480000] ata1: PATA max UDMA/100 cmd 0x4450 ctl 0x4460 bmdma 0x4440
[    1.484000] ata2: PATA max UDMA/100 cmd 0x4458 ctl 0x4464 bmdma 0x4448
[    1.524000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.524000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.532000] mousedev: PS/2 mouse device common for all mice
[    1.552000] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    1.552000] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram
[    1.556000] ledtrig-cpu: registered to indicate activity on CPUs
[    1.556000] TCP: cubic registered
[    1.560000] NET: Registered protocol family 10
[    1.588000] mip6: Mobile IPv6
[    1.588000] NET: Registered protocol family 17
[    1.588000] mpls_gso: MPLS GSO support
[    1.596000] registered taskstats version 1
[    1.612000] rtc_cmos rtc_cmos: setting system clock to 2019-03-06 15:48:12 UTC (1551887292)
[    1.684000] input: AT Raw Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.724000] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    1.724000] ata1.00: 204800 sectors, multi 16: LBA48
[    1.728000] ata1.00: limited to UDMA/33 due to 40-wire cable
[    1.736000] ata1.00: configured for UDMA/33
[    1.796000] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    1.820000] sd 0:0:0:0: [sda] 204800 512-byte logical blocks: (104 MB/100 MiB)
[    1.832000] sd 0:0:0:0: [sda] Write Protect is off
[    1.836000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.864000] Data bus error, epc == ffffffff804157d8, ra == ffffffff804f7ddc
[    1.864000] Oops[#1]:

for 

mips64el-softmmu/qemu-system-mips64el -M fulong2e  -kernel /dev/shm/boot/vmlinux-3.16.0-4-loongson-2e -hda /dev/shm/LONGSOON_disk  -cdrom /dev/shm/debian-8.0.0-mipsel-xfce-CD-1.iso -nographic -d unimp,guest_errors -append "console=ttyS0" > VMLINUX_3.16.log 2>&1

and without ata disk but with just CD it moved into 'normal' panic (no root device)

[    1.480000] console [ttyS0] enabled
[    1.480000] console [ttyS0] enabled
[    1.484000] bootconsole [early0] disabled
[    1.484000] bootconsole [early0] disabled
[    1.524000] scsi0 : pata_via
[    1.528000] scsi1 : pata_via
[    1.532000] ata1: PATA max UDMA/100 cmd 0x4450 ctl 0x4460 bmdma 0x4440
[    1.536000] ata2: PATA max UDMA/100 cmd 0x4458 ctl 0x4464 bmdma 0x4448
[    1.580000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.584000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.596000] mousedev: PS/2 mouse device common for all mice
[    1.616000] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    1.616000] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram
[    1.620000] ledtrig-cpu: registered to indicate activity on CPUs
[    1.624000] TCP: cubic registered
[    1.624000] NET: Registered protocol family 10
[    1.648000] mip6: Mobile IPv6
[    1.652000] NET: Registered protocol family 17
[    1.652000] mpls_gso: MPLS GSO support
[    1.656000] registered taskstats version 1
[    1.688000] rtc_cmos rtc_cmos: setting system clock to 2019-03-06 15:50:38 UTC (1551887438)
[    1.752000] input: AT Raw Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.912000] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.916000] ata2.00: limited to UDMA/33 due to 40-wire cable
[    1.924000] ata2.00: configured for UDMA/33
[    2.604000] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
[    6.928000] ata2.00: qc timeout (cmd 0xa0)
[    6.928000] ata2.00: TEST_UNIT_READY failed (err_mask=0x4)
[    7.088000] ata2.00: configured for UDMA/33
[   12.092000] ata2.00: qc timeout (cmd 0xa0)
[   12.096000] ata2.00: TEST_UNIT_READY failed (err_mask=0x4)
[   12.096000] ata2.00: limiting speed to UDMA/33:PIO3
[   12.252000] ata2.00: configured for UDMA/33
[   17.252000] ata2.00: qc timeout (cmd 0xa0)
[   17.252000] ata2.00: TEST_UNIT_READY failed (err_mask=0x4)
[   17.256000] ata2.00: disabled
[   17.260000] ata2: soft resetting link
[   17.420000] ata2: EH complete
[   17.428000] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
[   17.428000] Please append a correct "root=" boot option; here are the available partitions:
[   17.432000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[   17.432000] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

vmlinux-2e also boots (if I redirect output to serial console), but not very verbose :/

Scaning....
=========================================================
=========================================================
not find usb drivers...

mips64el-softmmu/qemu-system-mips64el -M fulong2e  -kernel /dev/shm/vmlinux-2e  -cdrom /dev/shm/debian-8.0.0-mipsel-xfce-CD-1.iso -nographic -d unimp,guest_errors -append "console=ttyS0"

Hm. Note I skipped adding ati-vga device in those tests, because Debian 3.16 kernel was panicing in radeon code too.
