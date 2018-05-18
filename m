Received: from eggs.gnu.org ([2001:4830:134:3::10]:34048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYmV-0001Th-DS
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYmS-0001Dm-7Q
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:22:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJYmS-0001Dd-2f
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:22:20 -0400
Date: Fri, 18 May 2018 14:22:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180518062214.GH2569@xz-mi>
References: <20180517085927.24925-1-peterx@redhat.com>
	<20180517085927.24925-13-peterx@redhat.com>
	<20180518000522-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518000522-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 12/12] intel-iommu: new
 sync_shadow_page_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>

On Fri, May 18, 2018 at 12:06:14AM +0300, Michael S. Tsirkin wrote:
> On Thu, May 17, 2018 at 04:59:27PM +0800, Peter Xu wrote:
> > Firstly, introduce the sync_shadow_page_table() helper to resync the
> > whole shadow page table of an IOMMU address space.  Meanwhile, when we
> > receive domain invalidation or similar requests (for example, context
> > entry invalidations, global invalidations, ...), we should not really
> > run the replay logic, instead we can now use the new sync shadow page
> > table API to resync the whole shadow page table.
> > 
> > There will be two major differences:
> > 
> > 1. We don't unmap-all before walking the page table, we just sync.  The
> >    global unmap-all can create a very small window that the page table
> >    is invalid or incomplete
> 
> The implication is that with vfio, device might stop working
> without this change.

I guess it was working before.  However patch 9 changed the page
walking to be state-ful since we have IOVA tree now (it was not) so we
might encounter the scp DMA error after patch 9.  I still kept the
patches 9-12 to be separate since logically they are isolated.
However if you want maybe we can also squash 9-12 patches into one
single (but a bit huge) patch.

Thanks,

-- 
Peter Xu
