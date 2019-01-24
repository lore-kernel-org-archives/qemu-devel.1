Received: from eggs.gnu.org ([209.51.188.92]:36480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gmcBe-00067l-Q7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gmcBd-0007o8-5v
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:24:42 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:39232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zub@linux.fjfi.cvut.cz>)
	id 1gmcBc-0007ky-7W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:24:41 -0500
Date: Thu, 24 Jan 2019 11:24:34 +0100 (CET)
From: David Kozub <zub@linux.fjfi.cvut.cz>
In-Reply-To: <0bf4c4ed-ba51-7723-66ea-43bb162691a8@redhat.com>
Message-ID: <alpine.LRH.2.21.1901241039400.4050@linux.fjfi.cvut.cz>
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
	<e2e14237-32be-8e3d-242c-c19e98d04d60@redhat.com>
	<alpine.LRH.2.21.1901172312550.8075@linux.fjfi.cvut.cz>
	<aeb7e3b4-b776-1ee3-d4a0-d39c3e44ac31@redhat.com>
	<alpine.LRH.2.21.1901210003120.12076@linux.fjfi.cvut.cz>
	<0bf4c4ed-ba51-7723-66ea-43bb162691a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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

On Wed, 23 Jan 2019, John Snow wrote:
> On 1/23/19 5:39 PM, David Kozub wrote:
>> On Thu, 17 Jan 2019, John Snow wrote:
>
>> I think SG_IO IOCTL allows one to send a single ATA command and the ca=
ll
>> blocks until the request is processed.
>>
>
> The problem(?) with this is that you don't get to choose the ATA
> command, exactly ... the way the SG_IO interface works for ATA is that
> you choose a SCSI command and the linux driver translates it into ATA
> for you, then issues that command.
>
> In this way, I don't think* you could do ATA passthrough exactly -- not
> in the sense that you can have an emulated ATA device passing through
> ATA commands to a real device.

libata seems to support SCSI / ATA Translation, including ATA PASS THROUG=
H=20
(12) and ATA PASS THROUGH (16). Is this not sufficient? (The=20
implementation can be seen in ata_scsi_pass_thru.)

> ...but you could create an emulated SCSI disk and then pass those SCSI
> commands to an ATA device -- achieving a *kind* of pass through, but I
> don't know if that's helpful to your project. If so, I'd start looking
> at the scsi disk sources instead of the ATA sources.

Perhaps. Or maybe fogetting about pass-through and really just=20
implementing OPAL in QEMU.

>> I don't know if there are other mechanisms how to pass ATA commands fr=
om
>> userspace.
>>
>> If anybody reading this has more ideas/info on this topic, please let =
me
>> know.
>>
>> [1] http://sg.danny.cz/sg/sg_io.html
>> [2]
>> https://github.com/torvalds/linux/blob/30bac164aca750892b93eef350439a0=
562a68647/drivers/ata/libata-scsi.c#L3138
>>
>>
>>> I can give you maybe a brief overview of some of the obviously useful
>>> choke points in QEMU, though...
>>>
>>> the ATA support in QEMU comes in a few different levels:
>>>
>>> (1) IDE/ATA/PATA disks use a register set and PIO to directly read an=
d
>>> write values to individual registers. You can see this interface in
>>> hw/ide.core.c for ide_ioport_write, ide_status_read, and ide_cmd_writ=
e.
>>> When the drive is in a PIO data loop, you can read or write data to a
>>> buffer by repeatedly writing to a certain register address, implement=
ed
>>> with ide_data_[read|write][w|l].
>>>
>>>
>>> ide_exec_cmd serves as the "start processing" signal in QEMU, and use=
s
>>> the various registers manipulated in the above calls stored in `IDESt=
ate
>>> *s` to know which command to emulate. The arguments to ide_exec_cmd
>>> aren't sufficient instruction alone. ide_exec_cmd is triggered whenev=
er
>>> the guest updates the command register.
>>>
>>> CDROM emulation actually does use SCSI packets. Generally the guest
>>> sends the 0xA0 PACKET command to the drive and then the drive waits f=
or
>>> a SCSI CDB to arrive via PIO. When the packet has arrived in full,
>>> ide_atapi_cmd() processes it. However, there are a few places in this
>>> code where we dip into the ATA registers to formulate a reply, so the
>>> logical split isn't perfect.
>>>
>>> (2) PCI IDE utilizes additional BMDMA features outside of those core
>>> registers and are driven separately. It does not fully wrap the regis=
ter
>>> interface present.
>>>
>>> (3) SATA devices begin using FIS packets. They're a message format th=
at
>>> lets you send commands, update registers, read values, etc. They're t=
he
>>> basic interface unit at this level. Both NCQ and traditional ATA
>>> commands are delivered using FIS Register Host-to-Device update packe=
ts.
>>> (The command, as always, is activated when the ATA device itself
>>> receives an update to its command register.)
>>>
>>> QEMU doesn't have a clean separation for ATA and SATA emulation, so t=
he
>>> SATA device emulation actually happens at the interface layer in QEMU
>>> instead, as a hack. See hw/ide/ahci.c and look for this blurb:
>>>
>>> ```
>>> =C2=A0=C2=A0 /* Check for NCQ command */
>>> =C2=A0=C2=A0 if (is_ncq(cmd_fis[2])) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0process_ncq_command(s, port, cmd_fis, slot);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0 }
>>> ```
>>>
>>> This feels like maybe high level and useful enough to be able to
>>> intercept for passthrough purposes, but I'm not sure how to handle
>>> things like DMA routing or PIO access, which is still... technically
>>> allowed at this layer, and might be used by early bootup routines.
>>>
>>> A problem is that QEMU does not really disentangle the concept of a
>>> "SATA Device" and the "AHCI controller", so a lot of the FIS response=
s
>>> in QEMU go straight into the controller's buffer, and we'd have to sp=
lit
>>> all of that out.
>>>
>>> (4) the AHCI controller manages sending and receiving the FIS packets=
.
>>> You fill a buffer with the FIS packet to send and manipulate AHCI PCI
>>> registers to send it off. FIS responses are buffered from the SATA
>>> drives informing the controller of the new register values.
>>>
>>> the AHCI command buffers include space for guests to pre-write their
>>> SCSI CDBs, and the controller handles sending both the outer ATA comm=
and
>>> and the inner ATAPI packet to the device.
>>>
>>> Again, in QEMU, we cheat a little and layers (3) and (4) are pretty w=
ell
>>> smooshed together. In general, the AHCI layer sends FIS packets back =
and
>>> forth from the SATA layer, which decomposes the FIS packets into
>>> constituent register updates, which are sent into layer (1) for
>>> processing. None of these layers are really truly strictly separated,
>>> unfortunately.
>>
>> A naive question... which of these "details" (as in... was the command
>> dispatched via PIO, or in a FIS packet) are needed for ATA pass-throug=
h?
>> The only mechanism I'm currently aware of, in Linux, lets us pass a
>> single command, synchronously, and it doesn't let us tune much more.
>> This sounds like a horrible thing for performance, but this might in
>> itself be OK for the fiddling/debugging scenarios I'm after. But even
>> ignoring performance, is this sufficient? I.e. to extract - through
>> whatever means - a sequence of ATA commands (no matter how they were
>> delivered from the guest), then sequentially execute them, and then
>> deliver them to the guest in the appripriate way (depending on how the=
y
>> were received)?
>>
>
> It depends at which level you want to intercept the command, because at
> each phase the way the command looks is different.
>
> At the PIO level, the command is actually a series of writes to device
> registers instead of looking like any kind of unified "command" that yo=
u
> could point to.

I really need to read up on this. But at some point with PIO, QEMU figure=
s=20
out what to do with the disk (i.e. what to read/write). So QEMU could=20
either create an ATA command for this, or maybe even end up doing ordinar=
y=20
read/write. But combining read/write via a block device with IOCTLs sound=
s=20
a bit dangerous.

>
> At the FIS level, it actually starts to resemble a coherent packet that
> can be issued to the device. FIS packets are kind of like the SATA
> analog to SCSI CDB packets.
>
> None of these are too useful for SG_IO, I think.
>
>>> Hope this helps even 1% instead of just being a useless info dump.
>>
>> Thank you for this "executive summary". It helps me find the relevant
>> code in QEMU and the terms to google for, as I don't know much about t=
his.
>>
>> Best regards,
>> David
