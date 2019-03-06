Received: from eggs.gnu.org ([209.51.188.92]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1a1Y-0003b4-Le
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1a1X-0007ot-Lr
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:08:08 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:12256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1a1X-0007mZ-BS
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:08:07 -0500
Date: Wed, 6 Mar 2019 18:08:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903061901.52932.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903061751270.91150@zero.eik.bme.hu>
References: <201903061901.52932.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, 6 Mar 2019, Andrew Randrianasulu wrote:
> This was kernel dying in ata subsystem:
>
> [    1.724000] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
> [    1.724000] ata1.00: 204800 sectors, multi 16: LBA48
> [    1.728000] ata1.00: limited to UDMA/33 due to 40-wire cable
> [    1.736000] ata1.00: configured for UDMA/33
> [    1.796000] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> [    1.820000] sd 0:0:0:0: [sda] 204800 512-byte logical blocks: (104 MB/100 MiB)
> [    1.832000] sd 0:0:0:0: [sda] Write Protect is off
> [    1.836000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.864000] Data bus error, epc == ffffffff804157d8, ra == ffffffff804f7ddc
> [    1.864000] Oops[#1]:

Not sure what is this.

> mips64el-softmmu/qemu-system-mips64el -M fulong2e  -kernel /dev/shm/boot/vmlinux-3.16.0-4-loongson-2e -hda /dev/shm/LONGSOON_disk  -cdrom /dev/shm/debian-8.0.0-mipsel-xfce-CD-1.iso -nographic -d unimp,guest_errors -append "console=ttyS0" > VMLINUX_3.16.log 2>&1
>
> and without ata disk but with just CD it moved into 'normal' panic (no root device)
>
> [    1.912000] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    1.916000] ata2.00: limited to UDMA/33 due to 40-wire cable
> [    1.924000] ata2.00: configured for UDMA/33
> [    2.604000] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
> [    6.928000] ata2.00: qc timeout (cmd 0xa0)
> [    6.928000] ata2.00: TEST_UNIT_READY failed (err_mask=0x4)
> [    7.088000] ata2.00: configured for UDMA/33
> [   12.092000] ata2.00: qc timeout (cmd 0xa0)
> [   12.096000] ata2.00: TEST_UNIT_READY failed (err_mask=0x4)
> [   12.096000] ata2.00: limiting speed to UDMA/33:PIO3
> [   12.252000] ata2.00: configured for UDMA/33
> [   17.252000] ata2.00: qc timeout (cmd 0xa0)
> [   17.252000] ata2.00: TEST_UNIT_READY failed (err_mask=0x4)
> [   17.256000] ata2.00: disabled
> [   17.260000] ata2: soft resetting link
> [   17.420000] ata2: EH complete
> [   17.428000] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6

As I've said I've also seen problems with DMA with via-ide and this also 
looks like a problem with DMA so it could be a problem with the device 
model. Previously this only modelled the legacy ide mode which did not 
work well with PMON, Linux nor what I'm trying to use it for so I've 
changed it to emulate native mode but could be it's not complete and still 
missing something for DMA to work. Unfortunately I don't know QEMU that 
much to tell what may be needed and had no time to try to debug it yet.

My guess (which could be all wrong) is that maybe a PCI window is needed 
for DMA to work otherwise PCI device won't be able to write data to memory 
which would need mapping some memory region somewhere but I'm not sure how 
to do that. Maybe you could try enabling ide and bmdma related traces (or 
debug defines in these devices if any) to get more detailed output on 
what's happening. Then it's a matter of looking up docs and knowing how it 
should work and find what's different but that may not be easy for someone 
who don't know much about this like me.

> mips64el-softmmu/qemu-system-mips64el -M fulong2e  -kernel /dev/shm/vmlinux-2e  -cdrom /dev/shm/debian-8.0.0-mipsel-xfce-CD-1.iso -nographic -d unimp,guest_errors -append "console=ttyS0"
>
> Hm. Note I skipped adding ati-vga device in those tests, because Debian 3.16 kernel was panicing in radeon code too.

The RV100 emulation in ati-vga is even less tested than the default 
rage128p so it's possible that the Linux radeon driver does not like it 
yet. I think Gerd Hoffmann has found and debugged a problem with it trying 
to get values from vgabios which we don't have that can cause a panic. He 
had some patches to fix that but it's in his own tree only yet. Hopefully 
the ati-vga can be merged soon and then we can include a better vgabios 
that works better with the Linux driver. Maybe you should wait for that 
before trying it more to avoid chasing already known problems.

Regards,
BALATON Zoltan
