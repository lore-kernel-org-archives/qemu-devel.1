Received: from eggs.gnu.org ([2001:4830:134:3::10]:36135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cmRvr-0001t8-9y
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 16:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cmRvo-00022B-50
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 16:18:39 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:53726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1cmRvn-00021k-P4
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 16:18:36 -0500
Date: Fri, 10 Mar 2017 13:18:25 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170310211825.GB16328@bombadil.infradead.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
	<20170310211037-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310211037-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liang.z.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Fri, Mar 10, 2017 at 09:10:53PM +0200, Michael S. Tsirkin wrote:
> > I completely agree with you that we should be able to pass a hugepage
> > as a single chunk.  Also we shouldn't assume that host and guest have
> > the same page size.  I think we can come up with a scheme that actually
> > lets us encode that into a 64-bit word, something like this:
> > 
> > bit 0 clear => bits 1-11 encode a page count, bits 12-63 encode a PFN, page size 4k.
> > bit 0 set, bit 1 clear => bits 2-12 encode a page count, bits 13-63 encode a PFN, page size 8k
> > bits 0+1 set, bit 2 clear => bits 3-13 for page count, bits 14-63 for PFN, page size 16k.
> > bits 0-2 set, bit 3 clear => bits 4-14 for page count, bits 15-63 for PFN, page size 32k
> > bits 0-3 set, bit 4 clear => bits 5-15 for page count, bits 16-63 for PFN, page size 64k
> 
> huge page sizes go up to gigabytes.

There was supposed to be a '...' there.  For a 16GB hugepage (largest
size I know of today), that'd be:

bits 0-21 set, 22 clear, 23-33 page count, 34-63 PFN, page size 16G
