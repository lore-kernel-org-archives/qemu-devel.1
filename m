Received: from eggs.gnu.org ([2001:4830:134:3::10]:60927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmMc1-0007j0-T9
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmMby-0006S3-OJ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:37:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cmMby-0006RK-G4
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:37:46 -0500
Date: Fri, 10 Mar 2017 17:37:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170310173602-mutt-send-email-mst@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170308054813-mutt-send-email-mst@kernel.org>
	<58C279B7.2060106@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58C279B7.2060106@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v7 kernel 3/5]
 virtio-balloon: implementation of VIRTIO_BALLOON_F_CHUNK_TRANSFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Liang Li <liang.z.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Fri, Mar 10, 2017 at 06:02:31PM +0800, Wei Wang wrote:
> On 03/08/2017 12:01 PM, Michael S. Tsirkin wrote:
> > On Fri, Mar 03, 2017 at 01:40:28PM +0800, Wei Wang wrote:
> > > From: Liang Li <liang.z.li@intel.com>
> > > 
> > > The implementation of the current virtio-balloon is not very
> > > efficient, because the pages are transferred to the host one by one.
> > > Here is the breakdown of the time in percentage spent on each
> > > step of the balloon inflating process (inflating 7GB of an 8GB
> > > idle guest).
> > > 
> > > 1) allocating pages (6.5%)
> > > 2) sending PFNs to host (68.3%)
> > > 3) address translation (6.1%)
> > > 4) madvise (19%)
> > > 
> > > It takes about 4126ms for the inflating process to complete.
> > > The above profiling shows that the bottlenecks are stage 2)
> > > and stage 4).
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
> > > 
> > > By doing so, step 4) can also be optimized by doing address
> > > translation and madvise() in chunks rather than page by page.
> > > 
> > > This optimization requires the negotation of a new feature bit,
> > > VIRTIO_BALLOON_F_CHUNK_TRANSFER.
> > > 
> > > With this new feature, the above ballooning process takes ~590ms
> > > resulting in an improvement of ~85%.
> > > 
> > > TODO: optimize stage 1) by allocating/freeing a chunk of pages
> > > instead of a single page each time.
> > > 
> > > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > Cc: Amit Shah <amit.shah@redhat.com>
> > > Cc: Dave Hansen <dave.hansen@intel.com>
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Liang Li <liliang324@gmail.com>
> > > Cc: Wei Wang <wei.w.wang@intel.com>
> > Does this pass sparse? I see some endian-ness issues here.
> 
> "pass sparse"- what does that mean?
> I didn't see any complaints from "make" on my machine.


Run with make C=1 (or C=2 to check all source).

Generally there's a ton of useful info you will find
if you run make help.

-- 
MST
