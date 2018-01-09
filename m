Received: from eggs.gnu.org ([2001:4830:134:3::10]:57741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYlDw-0004Yi-Qi
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 23:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYlDt-00028E-Kw
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 23:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eYlDt-00027T-8I
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 23:09:13 -0500
Date: Tue, 9 Jan 2018 06:09:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180109060704-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
	<20171222014258-mutt-send-email-mst@kernel.org>
	<CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
	<20180108200725-mutt-send-email-mst@kernel.org>
	<20180109011010.GI2131@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109011010.GI2131@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Tue, Jan 09, 2018 at 12:10:10PM +1100, David Gibson wrote:
> On Mon, Jan 08, 2018 at 08:10:23PM +0200, Michael S. Tsirkin wrote:
> > On Mon, Jan 08, 2018 at 09:14:41AM +0000, Peter Maydell wrote:
> > > On 21 December 2017 at 23:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >> you also need to drop "hw/pci: remove obsolete PCIDevice->init()"
> > > >> (applied in your tree as 18951fce55d5aa58cd1629b4cb704ee51bab4420)
> > > >> else the not-yet-QOM'ified NVME won't work anymore.
> > > >
> > > > Done that too, thanks a lot
> > > 
> > > Hi. I'm afraid this pullreq (merge of 880b1ff) has new runtime
> > > errors from the clang sanitizer:
> > > 
> > > /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
> > > runtime error: member access within misaligned address 0x55b4ffee8246
> > > for type 'struct ip_header', which requires 4 byte alignment
> > > 0x55b4ffee8246: note: pointer points here
> > >  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> > > ff ff 00 00 00 00 00 00  00 00
> > >              ^
> > > /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
> > > runtime error: load of misaligned address 0x55b4ffee8246 for type
> > > 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
> > > 0x55b4ffee8246: note: pointer points here
> > >  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> > > ff ff 00 00 00 00 00 00  00 00
> > >              ^
> > > /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:208:65:
> > > runtime error: member access within misaligned address 0x55b4ffee8246
> > > for type 'struct ip_header', which requires 4 byte alignment
> > > 0x55b4ffee8246: note: pointer points here
> > >  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> > > ff ff 00 00 00 00 00 00  00 00
> > >              ^
> > > /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
> > > runtime error: member access within misaligned address 0x55b4ffee8246
> > > for type 'struct ip_header', which requires 4 byte alignment
> > > 0x55b4ffee8246: note: pointer points here
> > >  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> > > ff ff 00 00 00 00 00 00  00 00
> > >              ^
> > > /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
> > > runtime error: load of misaligned address 0x55b4ffee8246 for type
> > > 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
> > > 0x55b4ffee8246: note: pointer points here
> > >  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> > > ff ff 00 00 00 00 00 00  00 00
> > >              ^
> > > 
> > > Sorry for the late report, I didn't quite have time
> > > to process the pull before Christmas holidays.
> > > 
> > > thanks
> > > -- PMM
> > 
> > So I bisected and the reason is this commit:
> > 
> > commit 18b20bb43a2f37f0c8ae23a3e9b3d9a4a05b6bd4
> > Author: David Gibson <david@gibson.dropbear.id.au>
> > Date:   Tue Dec 19 15:45:22 2017 +1100
> > 
> >     tests/pxe-test: Add some extra tests
> >     
> >     Previously virtio-net was only tested for ppc64 in "slow" mode.  That
> >     doesn't make much sense since virtio-net is used much more often in
> >     practice than the spapr-vlan device which was tested always.  So, move
> >     virtio-net to always be tested on ppc64.
> >     
> >     We had no tests at all for the q35 machine, which doesn't seem wise
> >     given its increasing prominence.  Add a couple of tests for it,
> >     including testing the newer e1000e adapter.
> >     
> >     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >     Reviewed-by: Thomas Huth <thuth@redhat.com>
> >     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > :040000 040000 5a982bfea24b9ac3c651b84425a39b3c85f4871e 771af3fdfb2778c6d6ed6b1098d1e79c181d6fb0 M      tests
> > 
> > Pls either fix or drop e1000e test
> 
> Feel free to drop this patch for now.  I'll debug and repost it when I
> have a chance.
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

It's just a test, it exposes the bug but does not introduce it so
I think it's ok to keep it. My point is e1000e appears to have some
issues.

-- 
MST
