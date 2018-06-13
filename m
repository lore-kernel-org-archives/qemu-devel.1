Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT39M-0006o7-62
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT39J-0000Fs-25
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:37:12 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60153
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fT39I-0000ET-RC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:37:08 -0400
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
	<20180613094727.11326-2-mark.cave-ayland@ilande.co.uk>
	<51d6368f-8a13-0daf-dcc2-78303af152ad@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <2b146796-ade4-ec2c-34a9-6d6532d94175@ilande.co.uk>
Date: Wed, 13 Jun 2018 11:36:52 +0100
MIME-Version: 1.0
In-Reply-To: <51d6368f-8a13-0daf-dcc2-78303af152ad@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/mips/jazz: create ESP device
 directly via qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, hpoussin@reactos.org, famz@redhat.com

On 13/06/18 11:06, Paolo Bonzini wrote:

> On 13/06/2018 11:47, Mark Cave-Ayland wrote:
>> +    dev = qdev_create(NULL, TYPE_ESP);
>> +    sysbus_esp = ESP_STATE(dev);
>> +    esp = &sysbus_esp->esp;
>> +    esp->dma_memory_read = rc4030_dma_read;
>> +    esp->dma_memory_write = rc4030_dma_write;
>> +    esp->dma_opaque = dmas[0];
> 
> Poking at the functions here is a bit ugly, and it's the last user of
> rc4030_dma_{read,write}.  It would be nicer if ESP could get a memory
> region like it's done a bit above for the NIC.  I guess it's not a big
> deal, but perhaps there could be a TODO comment.

Okay - I'll wait for Hervé to confirm it passes his tests and then see 
if wants a respin with a TODO added (or can add it himself).

> I'm mostly mentioning this because Hervé is copied and because SPARC DMA
> has the same issue of using function pointers instead of an IOMMU memory
> region...

Ahhh this is a fun one :)

As part of the SPARC32 cleanups for the last release there is now a 
proper sun4m IOMMU implementation, but from memory the big issue was 
that the DMA functions need access to the device state to affect the 
transfer.

Check out hw/dma/sparc32_dma.c for some ugly examples: 
espdma_memory_read()/espdma_memory_write() update the DMA address 
pointer register after each read/write, and 
ledma_memory_read()/ledma_memory_write() need to determine if the pcnet 
card has byte-swapping enabled: if so, then don't perform the required 
lance 16-bit swap and if not, do perform the 16-bit swap.

So yes, it's fairly ugly but I can't think of good solution involving 
just IOMMU memory regions.


ATB,

Mark.
