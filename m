Received: from eggs.gnu.org ([2001:4830:134:3::10]:44865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cn1Uv-0003o5-16
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cn1Uq-0000Ws-2f
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:17:12 -0400
Received: from chuckie.co.uk ([82.165.15.123]:53800
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cn1Up-0000Wd-Ri
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:17:08 -0400
References: <90ac2aef-5fff-ada6-d847-cd3ce20b967a@ilande.co.uk>
	<20170312025259-mutt-send-email-mst@kernel.org>
	<20170312055033-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5f5a4f09-3da7-e200-cda2-85e1053bb9ee@ilande.co.uk>
Date: Sun, 12 Mar 2017 11:16:44 +0000
MIME-Version: 1.0
In-Reply-To: <20170312055033-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Incorrect memory region address with large 64-bit
 PCI BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 12/03/17 03:56, Michael S. Tsirkin wrote:

> After looking at it some more, I think the issue is merely with how info
> mtree presents information, which confuses instead of helping when
> overlap triggers. Specifically
>     000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
> 	...
>       000001fe04040000-000001fe04043fff (prio 1, i/o): virtio-pci
> 
> really means that virtio-pci is not visible at all, this
> happens because it starts at offset ffffffff04040000 which is
> outside the parent.
> 
> I think that the cleanest fix is probably to show 128 bit addresses,
> then user will see the real addresses:
> 
>     000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
> 	...
>       1000001fe04040000-1000001fe04043fff (prio 1, i/o): virtio-pci
> 	
> and now it's clear what is going on: virtio-pci is outside pci-mmio.
> 
> This would have pointed Mark in the right direction earlier.
> 
> Thoughts? Patch?

Presumably if someone tried to do this on real hardware, the BAR address
would lie outside of the pci-mmio region and effectively isn't mapped?

If this is the case I'd be happy with a simple qemu_log() showing the
full 64-bit address and region name explaining that it couldn't be
mapped underneath its parent because it was outside its parent region,
and skip the mapping.


ATB,

Mark.
