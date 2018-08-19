Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1frHWf-0001it-Df
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 02:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1frHWb-00039N-7t
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 02:49:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42189
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1frHWb-00039H-1P
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 02:49:21 -0400
Received: from host86-159-123-112.range86-159.btcentralplus.com
	([86.159.123.112] helo=[192.168.1.65])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1frHWm-0007El-5W
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 07:49:33 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <41d9b8ae-1db9-be8c-4b58-23ee6278ded7@ilande.co.uk>
Message-ID: <0e22587c-651c-3e5b-579b-8181a7ec1722@ilande.co.uk>
Date: Sun, 19 Aug 2018 07:49:09 +0100
MIME-Version: 1.0
In-Reply-To: <41d9b8ae-1db9-be8c-4b58-23ee6278ded7@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio ignores pci_address_space_*()?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

On 18/08/18 21:21, Mark Cave-Ayland wrote:

> Hi all,
> 
> As part of testing my OpenBIOS virtio-blk implementation, I've been
> trying to use it under the 40p machine and have some questions related
> to how address spaces are interpreted.
> 
> The 40p PCI address space is aliased onto the CPU physical address space
> with an offset of 0x80000000 i.e.
> 
>    PCI address space 0x80001234 -> CPU address space 0x1234
> 
> For the LSI SCSI controller this just works: when configuring the DMA
> descriptors I write the destination address to the LSI registers in PCI
> address space i.e. 0x80001234. Internally this calls pci_dma_read() and
> pci_dma_write() and the data gets transferred correctly to physical
> address 0x1234.
> 
> When trying to configure a virtio device I'm not seeing the same
> behaviour: firstly it seems that I need to write the CPU address 0x1234
> to VIRTIO_PCI_QUEUE_PFN rather than the PCI address 0x80001234 as I
> would expect.
> 
> Following this I've tried to configure the address in the virtio
> descriptors with both the CPU address and PCI address and neither seems
> to work in my tests here.
> 
> Looking through the virtio code I can't see any references to
> pci_dma_read()/pci_dma_write() so I was wondering if someone can confirm
> whether I should be using CPU or PCI addresses when programming virtio
> registers and descriptors for machines such as 40p, and where I can find
> the address space being used for virtio device reads/writes?

So after quite a lot more searching I think I've finally found the answer:

- Enable VIRTIO_F_IOMMU_PLATFORM feature bit via iommu_platform property
to enable use of iovas in the descriptor rings

- Write the physical address to VIRTIO_PCI_QUEUE_PFN

Does this sound right?


ATB,

Mark.
