Received: from eggs.gnu.org ([209.51.188.92]:38041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gmRMP-0003CC-8s
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gmRBS-0008OL-PA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:39:49 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:50454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zub@linux.fjfi.cvut.cz>)
	id 1gmRBP-0008J8-U3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:39:45 -0500
Date: Wed, 23 Jan 2019 23:39:32 +0100 (CET)
From: David Kozub <zub@linux.fjfi.cvut.cz>
In-Reply-To: <aeb7e3b4-b776-1ee3-d4a0-d39c3e44ac31@redhat.com>
Message-ID: <alpine.LRH.2.21.1901210003120.12076@linux.fjfi.cvut.cz>
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
	<e2e14237-32be-8e3d-242c-c19e98d04d60@redhat.com>
	<alpine.LRH.2.21.1901172312550.8075@linux.fjfi.cvut.cz>
	<aeb7e3b4-b776-1ee3-d4a0-d39c3e44ac31@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

On Thu, 17 Jan 2019, John Snow wrote:

> Admittedly I'm not too sure of how the ATA support in Linux works to
> know what the passthrough would actually look like, bit-wise. I know
> there's some SCSI abstraction layer that can drive ATA devices, but I'm
> not completely clear on the actual plumbing. How you want to attempt
> this might depend on what the linux ATA drivers look like and at which
> interface layer you could conceivably drive them. I don't know the
> answer to this.

Hi John,

I looked into how to send ATA commands in Linux from userspace. It seems 
to be a relatively obscure topic (it's not every day that one needs this, 
after all).

All googling points me to SG_IO ioctl. Searching for info on that IOCTL 
leads to some documentation.[1] But not only does that date to 2008, it 
also talks only about SCSI, so I was wondering where/how does ATA come 
into picture. Yet tools like hdparm and sedutil use SG_IO to send ATA 
commands.

I dived into Linux kernel sources. There are other relevant IOCTLs, like 
HDIO_DRIVE_CMD, but they seem quite constrained. SG_IO, at least when 
issued on a disk that uses the "sd" driver, reaches kernel's libata and 
libata is then able to unwrap the command and pass it on to an ATA disk. 
(I believe this is the abstraction layer you mention.)

Specifically, ata_scsi_queuecmd is invoked. It then calls either 
ata_scsi_translate or ata_scsi_simulate. The pass-through translation 
(from a SCSI cmd to ATA taskfile) is implemented in ata_scsi_pass_thru.[2]

I think SG_IO IOCTL allows one to send a single ATA command and the call 
blocks until the request is processed.

I don't know if there are other mechanisms how to pass ATA commands from 
userspace.

If anybody reading this has more ideas/info on this topic, please let me 
know.

[1] http://sg.danny.cz/sg/sg_io.html
[2] https://github.com/torvalds/linux/blob/30bac164aca750892b93eef350439a0562a68647/drivers/ata/libata-scsi.c#L3138

> I can give you maybe a brief overview of some of the obviously useful
> choke points in QEMU, though...
>
> the ATA support in QEMU comes in a few different levels:
>
> (1) IDE/ATA/PATA disks use a register set and PIO to directly read and
> write values to individual registers. You can see this interface in
> hw/ide.core.c for ide_ioport_write, ide_status_read, and ide_cmd_write.
> When the drive is in a PIO data loop, you can read or write data to a
> buffer by repeatedly writing to a certain register address, implemented
> with ide_data_[read|write][w|l].
>
>
> ide_exec_cmd serves as the "start processing" signal in QEMU, and uses
> the various registers manipulated in the above calls stored in `IDEState
> *s` to know which command to emulate. The arguments to ide_exec_cmd
> aren't sufficient instruction alone. ide_exec_cmd is triggered whenever
> the guest updates the command register.
>
> CDROM emulation actually does use SCSI packets. Generally the guest
> sends the 0xA0 PACKET command to the drive and then the drive waits for
> a SCSI CDB to arrive via PIO. When the packet has arrived in full,
> ide_atapi_cmd() processes it. However, there are a few places in this
> code where we dip into the ATA registers to formulate a reply, so the
> logical split isn't perfect.
>
> (2) PCI IDE utilizes additional BMDMA features outside of those core
> registers and are driven separately. It does not fully wrap the register
> interface present.
>
> (3) SATA devices begin using FIS packets. They're a message format that
> lets you send commands, update registers, read values, etc. They're the
> basic interface unit at this level. Both NCQ and traditional ATA
> commands are delivered using FIS Register Host-to-Device update packets.
> (The command, as always, is activated when the ATA device itself
> receives an update to its command register.)
>
> QEMU doesn't have a clean separation for ATA and SATA emulation, so the
> SATA device emulation actually happens at the interface layer in QEMU
> instead, as a hack. See hw/ide/ahci.c and look for this blurb:
>
> ```
>    /* Check for NCQ command */
>    if (is_ncq(cmd_fis[2])) {
> 	process_ncq_command(s, port, cmd_fis, slot);
>        return;
>    }
> ```
>
> This feels like maybe high level and useful enough to be able to
> intercept for passthrough purposes, but I'm not sure how to handle
> things like DMA routing or PIO access, which is still... technically
> allowed at this layer, and might be used by early bootup routines.
>
> A problem is that QEMU does not really disentangle the concept of a
> "SATA Device" and the "AHCI controller", so a lot of the FIS responses
> in QEMU go straight into the controller's buffer, and we'd have to split
> all of that out.
>
> (4) the AHCI controller manages sending and receiving the FIS packets.
> You fill a buffer with the FIS packet to send and manipulate AHCI PCI
> registers to send it off. FIS responses are buffered from the SATA
> drives informing the controller of the new register values.
>
> the AHCI command buffers include space for guests to pre-write their
> SCSI CDBs, and the controller handles sending both the outer ATA command
> and the inner ATAPI packet to the device.
>
> Again, in QEMU, we cheat a little and layers (3) and (4) are pretty well
> smooshed together. In general, the AHCI layer sends FIS packets back and
> forth from the SATA layer, which decomposes the FIS packets into
> constituent register updates, which are sent into layer (1) for
> processing. None of these layers are really truly strictly separated,
> unfortunately.

A naive question... which of these "details" (as in... was the command 
dispatched via PIO, or in a FIS packet) are needed for ATA pass-through? 
The only mechanism I'm currently aware of, in Linux, lets us pass a single 
command, synchronously, and it doesn't let us tune much more. This sounds 
like a horrible thing for performance, but this might in itself be OK for 
the fiddling/debugging scenarios I'm after. But even ignoring performance, 
is this sufficient? I.e. to extract - through whatever means - a sequence 
of ATA commands (no matter how they were delivered from the guest), then 
sequentially execute them, and then deliver them to the guest in the 
appripriate way (depending on how they were received)?

> Hope this helps even 1% instead of just being a useless info dump.

Thank you for this "executive summary". It helps me find the relevant code 
in QEMU and the terms to google for, as I don't know much about this.

Best regards,
David
