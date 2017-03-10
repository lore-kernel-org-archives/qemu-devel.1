Received: from eggs.gnu.org ([2001:4830:134:3::10]:38346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmMwK-00047q-FC
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmMwF-00076h-KQ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:58:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cmMwF-00076J-Bt
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:58:43 -0500
Date: Fri, 10 Mar 2017 17:58:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170310175349-mutt-send-email-mst@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58C28FF8.5040403@intel.com>
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
Cc: Matthew Wilcox <willy@infradead.org>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liang.z.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Fri, Mar 10, 2017 at 07:37:28PM +0800, Wei Wang wrote:
> On 03/09/2017 10:14 PM, Matthew Wilcox wrote:
> > On Fri, Mar 03, 2017 at 01:40:28PM +0800, Wei Wang wrote:
> > > From: Liang Li <liang.z.li@intel.com>
> > > 1) allocating pages (6.5%)
> > > 2) sending PFNs to host (68.3%)
> > > 3) address translation (6.1%)
> > > 4) madvise (19%)
> > > 
> > > This patch optimizes step 2) by transfering pages to the host in
> > > chunks. A chunk consists of guest physically continuous pages, and
> > > it is offered to the host via a base PFN (i.e. the start PFN of
> > > those physically continuous pages) and the size (i.e. the total
> > > number of the pages). A normal chunk is formated as below:
> > > -----------------------------------------------
> > > |  Base (52 bit)               | Size (12 bit)|
> > > -----------------------------------------------
> > > For large size chunks, an extended chunk format is used:
> > > -----------------------------------------------
> > > |                 Base (64 bit)               |
> > > -----------------------------------------------
> > > -----------------------------------------------
> > > |                 Size (64 bit)               |
> > > -----------------------------------------------
> > What's the advantage to extended chunks?  IOW, why is the added complexity
> > of having two chunk formats worth it?  You already reduced the overhead by
> > a factor of 4096 with normal chunks ... how often are extended chunks used
> > and how much more efficient are they than having several normal chunks?
> > 
> 
> Right, chunk_ext may be rarely used, thanks. I will remove chunk_ext if
> there is no objection from others.
> 
> Best,
> Wei

I don't think we can drop this, this isn't an optimization.


One of the issues of current balloon is the 4k page size
assumption. For example if you free a huge page you
have to split it up and pass 4k chunks to host.
Quite often host can't free these 4k chunks at all (e.g.
when it's using huge tlb fs).
It's even sillier for architectures with base page size >4k.

So as long as we are changing things, let's not hard-code
the 12 shift thing everywhere.


Two things to consider:
- host should pass its base page size to guest
  this can be a separate patch and for now we can fall back on 12 bit if not there

- guest should pass full huge pages to host
  this should be done correctly to avoid breaking up huge pages
  I would say yes let's use a single format but drop the "normal chunk"
  and always use the extended one.
  Also, size is in units of 4k, right? Please document that low 12 bit
  are reserved, they will be handy as e.g. flags.
