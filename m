Received: from eggs.gnu.org ([2001:4830:134:3::10]:47119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fzSrf-0007NI-VA
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fzSrZ-0000D7-L9
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 16:32:55 -0400
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
	<20180908090820.15591-4-mark.cave-ayland@ilande.co.uk>
	<20180910034837.GD2890@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <39035d04-e556-5d06-61ed-7cac87d9522f@ilande.co.uk>
Date: Mon, 10 Sep 2018 21:32:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180910034837.GD2890@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] 40p: add fixed IRQ routing for LSI
 SCSI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, hpoussin@reactos.org, qemu-devel@nongnu.org

On 10/09/18 04:48, David Gibson wrote:

> On Sat, Sep 08, 2018 at 10:08:20AM +0100, Mark Cave-Ayland wrote:
>> Whilst the PReP specification describes how all PCI IRQs are routed via IRQ
>> 15 on the interrupt controller, the real 40p machine has routing quirk in
>> that the LSI SCSI device is routed to IRQ 13.
>>
>> This is implemented using a little hack: the existing IRQ routing code uses
>> (irq_num + (pci_dev->devfn >> 3)) & 1 to give the PCI interrupt pin, where
>> the "& 1" ensures that the only pins A and B (0 and 1) will ever be used.
>>
>> Rather than fix the mask to "& 3" we leave the existing routing above as-is
>> and then force the LSI SCSI device to use pin C (2). This enables us to
>> route pin 2 permanantly to IRQ 13 since the LSI SCSI device will be its
>> only user.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> I don't think this is really the right approach.
> 
> As noted in an earlier mail, it's really common for on-board devices
> on pre-express PCI boards to have their LSIs wired specially, rather
> than via the PCI irq pins which are used for "slotted" devices.
> 
> I think we should explicitly model it like that: wiring the SCSI
> device's irq directly to system IRQ 13, rather than wiring it via a
> PCI LSI pin.
> 
> Wiring the SCSI to an otherwise unused pin, then routing that
> specially to the system irq is confusing.  It also might be incorrect
> if we tried to add a "slotted" device that actually used PINC (rare,
> I'll grant you).

Okay. I was hoping to get away with not altering the LSI SCSI device
itself, but after some experimentation I managed to come up with a
solution that is not too invasive and certainly more readable than this
attempt. Let me tidy up and post a v3.


ATB,

Mark.
