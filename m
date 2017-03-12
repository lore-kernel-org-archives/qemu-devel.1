Received: from eggs.gnu.org ([2001:4830:134:3::10]:43192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmujz-0005Ak-39
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 23:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmujv-0007Wp-3O
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 23:04:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cmuju-0007WJ-Tm
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 23:04:15 -0500
Date: Sun, 12 Mar 2017 06:04:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170312055658-mutt-send-email-mst@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
	<58C3E6A3.1000000@intel.com>
	<20170311140946.GA1860@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F73919E524@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73919E524@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 kernel 3/5] virtio-balloon:
 implementation of VIRTIO_BALLOON_F_CHUNK_TRANSFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Sun, Mar 12, 2017 at 01:59:54AM +0000, Wang, Wei W wrote:
> On 03/11/2017 10:10 PM, Matthew Wilcox wrote:
> > On Sat, Mar 11, 2017 at 07:59:31PM +0800, Wei Wang wrote:
> > > I'm thinking what if the guest needs to transfer these much physically
> > > continuous memory to host: 1GB+2MB+64KB+32KB+16KB+4KB.
> > > Is it going to use Six 64-bit chunks? Would it be simpler if we just
> > > use the 128-bit chunk format (we can drop the previous normal 64-bit
> > > format)?
> > 
> > Is that a likely thing for the guest to need to do though?  Freeing a 1GB page is
> > much more liikely, IMO.
> 
> Yes, I think it's very possible. The host can ask for any number of pages (e.g. 1.5GB) that the guest can afford.  Also, the ballooned 1.5G memory is not guaranteed to be continuous in any pattern like 1GB+512MB. That's why we need to use a bitmap to draw the whole picture first, and then seek for continuous bits to chunk.
> 
> Best,
> Wei

While I like the clever format that Matthew came up with, I'm also
inclined to say let's keep things simple.
the simplest thing seems to be to use the ext format all the time.
Except let's reserve the low 12 bits in both address and size,
since they are already 0, we might be able to use them for flags down the road.

-- 
MST
