Received: from eggs.gnu.org ([2001:4830:134:3::10]:57928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT3oj-00024n-Sd
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT3og-0006Ip-Md
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:19:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT3og-0006Hb-HX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:19:54 -0400
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
	<20180613094727.11326-2-mark.cave-ayland@ilande.co.uk>
	<51d6368f-8a13-0daf-dcc2-78303af152ad@redhat.com>
	<2b146796-ade4-ec2c-34a9-6d6532d94175@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a2d3eca-95d0-c1ca-4769-7a06115cc2e5@redhat.com>
Date: Wed, 13 Jun 2018 13:19:45 +0200
MIME-Version: 1.0
In-Reply-To: <2b146796-ade4-ec2c-34a9-6d6532d94175@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, hpoussin@reactos.org, famz@redhat.com

On 13/06/2018 12:36, Mark Cave-Ayland wrote:
> Check out hw/dma/sparc32_dma.c for some ugly examples:
> espdma_memory_read()/espdma_memory_write() update the DMA address
> pointer register after each read/write, and
> ledma_memory_read()/ledma_memory_write() need to determine if the pcnet
> card has byte-swapping enabled: if so, then don't perform the required
> lance 16-bit swap and if not, do perform the 16-bit swap.

Heh, those are disgusting indeed. :)  So I guess it would have to stay,
only MIPS can use the pure MemoryRegion-based approach.

Regarding pcnet, is CSR_BSWP really a no-op on PCI cards?  If not, an
option could be to move that handling to pcnet.c - making the ledma swap
unconditional and removing the do_bswap argument.  The disadvantage is
that SPARC would swap twice, and you'd have to keep the callback because
of s->dmaregs[3], but maybe it's still worthwhile.

Thanks,

Paolo
