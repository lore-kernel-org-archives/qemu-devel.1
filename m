Received: from eggs.gnu.org ([2001:4830:134:3::10]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT5UG-0003Br-1t
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT5UC-0001hQ-Pu
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:06:56 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60416
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fT5UC-0001eC-Ib
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:06:52 -0400
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
	<20180613094727.11326-2-mark.cave-ayland@ilande.co.uk>
	<51d6368f-8a13-0daf-dcc2-78303af152ad@redhat.com>
	<2b146796-ade4-ec2c-34a9-6d6532d94175@ilande.co.uk>
	<4a2d3eca-95d0-c1ca-4769-7a06115cc2e5@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6515c082-3904-e077-144d-d1f3f9fd7ee1@ilande.co.uk>
Date: Wed, 13 Jun 2018 14:06:44 +0100
MIME-Version: 1.0
In-Reply-To: <4a2d3eca-95d0-c1ca-4769-7a06115cc2e5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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

On 13/06/18 12:19, Paolo Bonzini wrote:

> On 13/06/2018 12:36, Mark Cave-Ayland wrote:
>> Check out hw/dma/sparc32_dma.c for some ugly examples:
>> espdma_memory_read()/espdma_memory_write() update the DMA address
>> pointer register after each read/write, and
>> ledma_memory_read()/ledma_memory_write() need to determine if the pcnet
>> card has byte-swapping enabled: if so, then don't perform the required
>> lance 16-bit swap and if not, do perform the 16-bit swap.
> 
> Heh, those are disgusting indeed. :)  So I guess it would have to stay,
> only MIPS can use the pure MemoryRegion-based approach.

The only option I can think of is inserting an AddressSpace between the 
esp/ledma device and the IOMMU AddressSpace which intercepts the DMA 
request (addr, len, direction).

I can then grab a reference to the device from the MemoryRegion opaque, 
perform the magic, and then manually invoke address_space_rw() on iommu_as.

Is there a hook somewhere in the memory API that could allow me to do this?

> Regarding pcnet, is CSR_BSWP really a no-op on PCI cards?  If not, an
> option could be to move that handling to pcnet.c - making the ledma swap
> unconditional and removing the do_bswap argument.  The disadvantage is
> that SPARC would swap twice, and you'd have to keep the callback because
> of s->dmaregs[3], but maybe it's still worthwhile.

Hmmm good question. If we can intercept the request above, that would be 
my preferred option as something tells it me it might be useful for 
other similar situations.


ATB,

Mark.
