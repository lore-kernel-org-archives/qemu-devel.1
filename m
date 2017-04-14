Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cz27k-0008CG-CQ
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 10:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cz27g-0001Lm-E5
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 10:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cz27g-0001Ky-7j
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 10:22:52 -0400
Date: Fri, 14 Apr 2017 17:22:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170414171452-mutt-send-email-mst@kernel.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<20170413204411.GJ784@bombadil.infradead.org>
	<20170414044515-mutt-send-email-mst@kernel.org>
	<20170414094740.GN784@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414094740.GN784@bombadil.infradead.org>
Subject: Re: [Qemu-devel] [PATCH v9 0/5] Extend virtio-balloon for fast
 (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Fri, Apr 14, 2017 at 02:47:40AM -0700, Matthew Wilcox wrote:
> On Fri, Apr 14, 2017 at 04:50:48AM +0300, Michael S. Tsirkin wrote:
> > On Thu, Apr 13, 2017 at 01:44:11PM -0700, Matthew Wilcox wrote:
> > > On Thu, Apr 13, 2017 at 05:35:03PM +0800, Wei Wang wrote:
> > > > 2) transfer the guest unused pages to the host so that they
> > > > can be skipped to migrate in live migration.
> > > 
> > > I don't understand this second bit.  You leave the pages on the free list,
> > > and tell the host they're free.  What's preventing somebody else from
> > > allocating them and using them for something?  Is the guest semi-frozen
> > > at this point with just enough of it running to ask the balloon driver
> > > to do things?
> > 
> > There's missing documentation here.
> > 
> > The way things actually work is host sends to guest
> > a request for unused pages and then write-protects all memory.
> 
> ... hopefully you mean "write protects all memory, then sends a request
> for unused pages", otherwise there's a race condition.

Exactly.

> And I see the utility of this, but does this functionality belong in
> the balloon driver?

We have historically put all kind of memory-related functionality in the
balloon device. Consider for example memory statistics - seems related
conceptually. See patches 1-2: the new mechanism for reporting lists of
pages seems to be benefitial for both which seems to indicate using the
balloon for this is a good idea.

> It seems like it's something you might want even if you don't have the
> balloon driver loaded.  Or something you might not want if you do have
> the balloon driver loaded.

Most of balloon functionality is kind of loosely coupled.  Yes we could
split it up but I'm not sure what would this buy us. What do you have
in mind?

-- 
MST
