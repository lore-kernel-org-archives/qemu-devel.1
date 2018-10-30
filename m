Received: from eggs.gnu.org ([2001:4830:134:3::10]:54077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHaJi-00086k-35
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 16:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHaJh-0007DJ-5X
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 16:08:46 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-7-mark.cave-ayland@ilande.co.uk>
	<d86f51e6-0f5d-e78a-3aba-cad233e83efa@reactos.org>
	<02f4cde5-e82b-ed63-5e02-ff83d591f05d@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <af7fa5d2-7da4-0827-9e7c-e210ca78b82f@vivier.eu>
Date: Tue, 30 Oct 2018 21:08:05 +0100
MIME-Version: 1.0
In-Reply-To: <02f4cde5-e82b-ed63-5e02-ff83d591f05d@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 06/11] esp: add pseudo-DMA as used by
 Macintosh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net

On 30/10/2018 11:09, Mark Cave-Ayland wrote:
> On 30/10/2018 06:47, Hervé Poussineau wrote:
> 
>> Le 29/10/2018 à 14:39, Mark Cave-Ayland a écrit :
>>> From: Laurent Vivier <laurent@vivier.eu>
>>>
>>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>   hw/scsi/esp.c         | 292 +++++++++++++++++++++++++++++++++++++++++++++-----
>>>   include/hw/scsi/esp.h |   7 ++
>>>   2 files changed, 270 insertions(+), 29 deletions(-)
>>>
>>
>> [...]
>>
>>>   @@ -409,6 +564,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
>>>               s->ti_size--;
>>>               s->rregs[ESP_FIFO] = s->ti_buf[s->ti_rptr++];
>>>           }
>>> +        esp_raise_irq(s);
>>>           if (s->ti_rptr == s->ti_wptr) {
>>>               s->ti_rptr = 0;
>>>               s->ti_wptr = 0;
>>
>> You're now raising irq (not drq) when reading registers. In my opinion, this deserves
>> its own patch with an explanation.

This line must be removed.

> Oooh good spot. Laurent, can you explain a bit more as to how the pseudo-DMA is wired
> up for ESP?
> 

There is no DMA in Quadra 800, so the CPU reads/writes the data from the
PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and copies them
to/from the memory.

There is a nice assembly loop in the kernel to do that, see
linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().

The start of the transfer is triggered by the DREQ interrupt (see linux
mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to start the
transfer after a SCSI command has been sent (in Quadra 800 it goes
through the VIA2, the via2-irq line and the vIFR register)

The Macintosh hardware includes hardware handshaking to prevent the CPU
from reading invalid data or writing data faster than the peripheral
device can accept it.

This is the "blind mode", and from the doc:
"Approximate maximum SCSI transfer rates within a blocks are 1.4 MB per
second for blind transfers in the Macintosh II"

Some references can be found in:
  Apple Macintosh Family Hardware Reference, ISBN 0-201-19255-1
  Guide to the Macintosh Family Hardware, ISBN-0-201-52405-8

Thanks,
Laurent
