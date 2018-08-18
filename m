Received: from eggs.gnu.org ([2001:4830:134:3::10]:39478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fr7jn-0003I4-5I
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fr7jk-0002gb-2p
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:22:19 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41345
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fr7jj-0002dQ-Rz
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:22:16 -0400
Received: from host86-159-123-112.range86-159.btcentralplus.com
	([86.159.123.112] helo=[192.168.1.65])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fr7jp-0005CR-GH
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 21:22:22 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <41d9b8ae-1db9-be8c-4b58-23ee6278ded7@ilande.co.uk>
Date: Sat, 18 Aug 2018 21:21:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] virtio ignores pci_address_space_*()?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi all,

As part of testing my OpenBIOS virtio-blk implementation, I've been
trying to use it under the 40p machine and have some questions related
to how address spaces are interpreted.

The 40p PCI address space is aliased onto the CPU physical address space
with an offset of 0x80000000 i.e.

   PCI address space 0x80001234 -> CPU address space 0x1234

For the LSI SCSI controller this just works: when configuring the DMA
descriptors I write the destination address to the LSI registers in PCI
address space i.e. 0x80001234. Internally this calls pci_dma_read() and
pci_dma_write() and the data gets transferred correctly to physical
address 0x1234.

When trying to configure a virtio device I'm not seeing the same
behaviour: firstly it seems that I need to write the CPU address 0x1234
to VIRTIO_PCI_QUEUE_PFN rather than the PCI address 0x80001234 as I
would expect.

Following this I've tried to configure the address in the virtio
descriptors with both the CPU address and PCI address and neither seems
to work in my tests here.

Looking through the virtio code I can't see any references to
pci_dma_read()/pci_dma_write() so I was wondering if someone can confirm
whether I should be using CPU or PCI addresses when programming virtio
registers and descriptors for machines such as 40p, and where I can find
the address space being used for virtio device reads/writes?


ATB,

Mark.
