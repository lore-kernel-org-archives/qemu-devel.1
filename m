Received: from eggs.gnu.org ([2001:4830:134:3::10]:48151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnOga-0004fh-4S
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnOgV-00077U-9G
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cnOgV-00076c-37
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:02:43 -0400
Date: Mon, 13 Mar 2017 14:02:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170313140010-mutt-send-email-mst@kernel.org>
References: <90ac2aef-5fff-ada6-d847-cd3ce20b967a@ilande.co.uk>
	<20170312025259-mutt-send-email-mst@kernel.org>
	<20170312055033-mutt-send-email-mst@kernel.org>
	<5f5a4f09-3da7-e200-cda2-85e1053bb9ee@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5a4f09-3da7-e200-cda2-85e1053bb9ee@ilande.co.uk>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Sun, Mar 12, 2017 at 11:16:44AM +0000, Mark Cave-Ayland wrote:
> On 12/03/17 03:56, Michael S. Tsirkin wrote:
> 
> > After looking at it some more, I think the issue is merely with how info
> > mtree presents information, which confuses instead of helping when
> > overlap triggers. Specifically
> >     000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
> > 	...
> >       000001fe04040000-000001fe04043fff (prio 1, i/o): virtio-pci
> > 
> > really means that virtio-pci is not visible at all, this
> > happens because it starts at offset ffffffff04040000 which is
> > outside the parent.
> > 
> > I think that the cleanest fix is probably to show 128 bit addresses,
> > then user will see the real addresses:
> > 
> >     000001ff00000000-000001ffffffffff (prio 0, i/o): pci-mmio
> > 	...
> >       1000001fe04040000-1000001fe04043fff (prio 1, i/o): virtio-pci
> > 	
> > and now it's clear what is going on: virtio-pci is outside pci-mmio.
> > 
> > This would have pointed Mark in the right direction earlier.
> > 
> > Thoughts? Patch?
> 
> Presumably if someone tried to do this on real hardware, the BAR address
> would lie outside of the pci-mmio region and effectively isn't mapped?
> 
> If this is the case I'd be happy with a simple qemu_log() showing the
> full 64-bit address and region name explaining that it couldn't be
> mapped underneath its parent because it was outside its parent region,
> and skip the mapping.
> 
> 
> ATB,
> 
> Mark.

I think that's what happens anyway. The bug is merely the desplay in info mtree
which uses 64 bit math.

-- 
MST
