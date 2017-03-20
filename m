Received: from eggs.gnu.org ([2001:4830:134:3::10]:39017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cpzSi-0000nN-CI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cpzSd-0001S0-FX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cpzSd-0001RX-9X
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:07 -0400
Date: Mon, 20 Mar 2017 17:43:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170320174101-mutt-send-email-mst@kernel.org>
References: <20170317215725.GJ996@jhogan-linux.le.imgtec.org>
	<6b3ec98b-55e2-ecc8-d962-dc9d13866319@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3ec98b-55e2-ecc8-d962-dc9d13866319@redhat.com>
Subject: Re: [Qemu-devel] [BUG] virtio-net linux driver fails to probe on
 MIPS Malta since 'hw/virtio-pci: fix virtio behaviour'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org

On Mon, Mar 20, 2017 at 05:21:22PM +0200, Marcel Apfelbaum wrote:
> On 03/17/2017 11:57 PM, James Hogan wrote:
> > Hi,
> > 
> > I've bisected the following failure of the virtio_net linux v4.10 driver
> > to probe in QEMU v2.9.0-rc1 emulating a MIPS Malta machine:
> > 
> > virtio_net virtio0: virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
> > virtio_net: probe of virtio0 failed with error -22
> > 
> > To QEMU commit 9a4c0e220d8a ("hw/virtio-pci: fix virtio behaviour").
> > 
> > It appears that adding ",disable-modern=on,disable-legacy=off" to the
> > virtio-net -device makes it work again.
> > 
> > I presume this should really just work out of the box. Any ideas why it
> > isn't?
> > 
> 
> Hi,
> 
> 
> This is strange. This commit changes virtio devices from legacy to virtio "transitional".
> (your command line changes it to legacy)
> Linux 4.10 supports virtio modern/transitional (as far as I know) and on QEMU side
> there is nothing new.
> 
> Michael, do you have any idea?
> 
> Thanks,
> Marcel

My guess would be firmware mishandling 64 bit BARs - we saw such
a case on sparc previously. As a result you are probably reading
all zeroes from features register or something like that.
Marcel, could you send a patch making the bar 32 bit?
If that helps we know what the issue is.

> > Cheers
> > James
> > 
