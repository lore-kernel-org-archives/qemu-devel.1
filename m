Received: from eggs.gnu.org ([2001:4830:134:3::10]:46325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1clyq4-000891-LH
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1clyq1-0002wv-FM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:14:44 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:47981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1clyq1-0002tJ-5B
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:14:41 -0500
Date: Thu, 9 Mar 2017 06:14:11 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170309141411.GZ16328@bombadil.infradead.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liang.z.li@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Fri, Mar 03, 2017 at 01:40:28PM +0800, Wei Wang wrote:
> From: Liang Li <liang.z.li@intel.com>
> 1) allocating pages (6.5%)
> 2) sending PFNs to host (68.3%)
> 3) address translation (6.1%)
> 4) madvise (19%)
> 
> This patch optimizes step 2) by transfering pages to the host in
> chunks. A chunk consists of guest physically continuous pages, and
> it is offered to the host via a base PFN (i.e. the start PFN of
> those physically continuous pages) and the size (i.e. the total
> number of the pages). A normal chunk is formated as below:
> -----------------------------------------------
> |  Base (52 bit)               | Size (12 bit)|
> -----------------------------------------------
> For large size chunks, an extended chunk format is used:
> -----------------------------------------------
> |                 Base (64 bit)               |
> -----------------------------------------------
> -----------------------------------------------
> |                 Size (64 bit)               |
> -----------------------------------------------

What's the advantage to extended chunks?  IOW, why is the added complexity
of having two chunk formats worth it?  You already reduced the overhead by
a factor of 4096 with normal chunks ... how often are extended chunks used
and how much more efficient are they than having several normal chunks?
