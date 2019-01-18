Received: from eggs.gnu.org ([209.51.188.92]:47471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkHav-0005Iy-DJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 19:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkHau-00054I-1L
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 19:01:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gkHat-0004yK-Ng
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 19:01:07 -0500
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
	<e2e14237-32be-8e3d-242c-c19e98d04d60@redhat.com>
	<alpine.LRH.2.21.1901172312550.8075@linux.fjfi.cvut.cz>
From: John Snow <jsnow@redhat.com>
Message-ID: <aeb7e3b4-b776-1ee3-d4a0-d39c3e44ac31@redhat.com>
Date: Thu, 17 Jan 2019 19:01:02 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1901172312550.8075@linux.fjfi.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Kozub <zub@linux.fjfi.cvut.cz>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com



On 1/17/19 6:04 PM, David Kozub wrote:
> On Wed, 16 Jan 2019, John Snow wrote:
> 
>> I can answer some questions about the ATA layer, but I'm not well read
>> on OPAL or the interrelationship between the two.
>>
>> We don't have an ATA-style passthrough in QEMU right now and nobody has
>> ever asked! Would you mind elaborating for me what kind of setup you're
>> looking to accomplish and maybe I can give you some better hints?
>>
>> --js
> 
> Hi John,
> 
> I'm thinking about adding OPAL support into grub. And I thought being
> able to do the development with qemu would make the development much
> easier.
> 
> While I read the OPAL spec, I can't say I understand it. But as far as I
> know, the relationship between OPAL and ATA is not too complicated. The
> OPAL spec itself is written in interface-agnostic way. It just defines
> there should be two interface commands ("Trusted Commands"), described
> as "IF-SEND" and "IF-RECV". (See [1], 1.4.1 Global Terminology and 2.3.1
> Host <-> TPer Communication Infrastructure) and the OPAL spec
> essentially defines the paylods for these.
> 
> The actual definition of what "Trused Commands" are for ATA comes from
> "TCG Storage Interface Interactions Specification (SIIS)"[3],
> specifically "4.2 Mapping of IF-SEND and IF-RECV". (Well, it's not that
> simple, as there are other things like error handling.)
> 
> Of course, OPAL affects other commands, like reads and writes, based on
> the OPAL state (see [1], 5.7 Locking Template).
> 
> Furthermore, there is the "shadow MBR" feature, which, when enabled (and
> not marked as done), makes the disk present a different content at the
> beginning. (This is typically used to store a program that can be
> booted, asks for password, unlocks the disk, sets the "mbr done" flag to
> hide the shadow MBR and reboots to the real OS. - see e.g. 5.7.2.5.3
> Done in [1].)
> 
> Here are the specs relevant for OPAL v2:
> [1]
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf
> 
> [2]
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_SSC_v2.01_rev1.00.pdf
> 
> [3]
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_v1.08_r1.00.pdf
> 
> 
> Implementing the spec (for what an "OPAL" disk need to support, I think
> [2] is the important document) seems like a big task.
> 
> So I'm thinking ATA passthrough might be a more attainable goal. This
> way I could use a real OPAL drive w/o needing a spare controller for PCI
> passthrough. And with some more fiddling, I could even connect this to
> userspace (I was thinking of ATA over Ethernet). This could be useful
> for other development/fiddling scenarios too.
> 
> But I don't know much about ATA. Would it be sufficient to just do an
> SG_IO IOCTL on the target block device for each ide_exec_cmd? How do
> things like NCQ fit into this?
> 
> Best regards,
> David

Admittedly I'm not too sure of how the ATA support in Linux works to
know what the passthrough would actually look like, bit-wise. I know
there's some SCSI abstraction layer that can drive ATA devices, but I'm
not completely clear on the actual plumbing. How you want to attempt
this might depend on what the linux ATA drivers look like and at which
interface layer you could conceivably drive them. I don't know the
answer to this.

I can give you maybe a brief overview of some of the obviously useful
choke points in QEMU, though...

the ATA support in QEMU comes in a few different levels:

(1) IDE/ATA/PATA disks use a register set and PIO to directly read and
write values to individual registers. You can see this interface in
hw/ide.core.c for ide_ioport_write, ide_status_read, and ide_cmd_write.
When the drive is in a PIO data loop, you can read or write data to a
buffer by repeatedly writing to a certain register address, implemented
with ide_data_[read|write][w|l].


ide_exec_cmd serves as the "start processing" signal in QEMU, and uses
the various registers manipulated in the above calls stored in `IDEState
*s` to know which command to emulate. The arguments to ide_exec_cmd
aren't sufficient instruction alone. ide_exec_cmd is triggered whenever
the guest updates the command register.

CDROM emulation actually does use SCSI packets. Generally the guest
sends the 0xA0 PACKET command to the drive and then the drive waits for
a SCSI CDB to arrive via PIO. When the packet has arrived in full,
ide_atapi_cmd() processes it. However, there are a few places in this
code where we dip into the ATA registers to formulate a reply, so the
logical split isn't perfect.

(2) PCI IDE utilizes additional BMDMA features outside of those core
registers and are driven separately. It does not fully wrap the register
interface present.

(3) SATA devices begin using FIS packets. They're a message format that
lets you send commands, update registers, read values, etc. They're the
basic interface unit at this level. Both NCQ and traditional ATA
commands are delivered using FIS Register Host-to-Device update packets.
(The command, as always, is activated when the ATA device itself
receives an update to its command register.)

QEMU doesn't have a clean separation for ATA and SATA emulation, so the
SATA device emulation actually happens at the interface layer in QEMU
instead, as a hack. See hw/ide/ahci.c and look for this blurb:

```
    /* Check for NCQ command */
    if (is_ncq(cmd_fis[2])) {
	process_ncq_command(s, port, cmd_fis, slot);
        return;
    }
```

This feels like maybe high level and useful enough to be able to
intercept for passthrough purposes, but I'm not sure how to handle
things like DMA routing or PIO access, which is still... technically
allowed at this layer, and might be used by early bootup routines.

A problem is that QEMU does not really disentangle the concept of a
"SATA Device" and the "AHCI controller", so a lot of the FIS responses
in QEMU go straight into the controller's buffer, and we'd have to split
all of that out.

(4) the AHCI controller manages sending and receiving the FIS packets.
You fill a buffer with the FIS packet to send and manipulate AHCI PCI
registers to send it off. FIS responses are buffered from the SATA
drives informing the controller of the new register values.

the AHCI command buffers include space for guests to pre-write their
SCSI CDBs, and the controller handles sending both the outer ATA command
and the inner ATAPI packet to the device.

Again, in QEMU, we cheat a little and layers (3) and (4) are pretty well
smooshed together. In general, the AHCI layer sends FIS packets back and
forth from the SATA layer, which decomposes the FIS packets into
constituent register updates, which are sent into layer (1) for
processing. None of these layers are really truly strictly separated,
unfortunately.




...I'd have to read up a bit on what interfaces Linux offers where we
might be able to do an ATA passthrough and I can make better
recommendations on where to take the surgeon's scalpel.

Hope this helps even 1% instead of just being a useless info dump.

--js
