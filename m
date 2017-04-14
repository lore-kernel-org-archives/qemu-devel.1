Received: from eggs.gnu.org ([2001:4830:134:3::10]:58707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyrQj-0005pd-Hv
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyrQf-00052W-J2
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cyrQf-00051q-DV
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:57:45 -0400
Date: Fri, 14 Apr 2017 05:57:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170414055106-mutt-send-email-mst@kernel.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<20170413204411.GJ784@bombadil.infradead.org>
	<20170414044515-mutt-send-email-mst@kernel.org>
	<58F033D0.7080101@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58F033D0.7080101@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Fri, Apr 14, 2017 at 10:28:32AM +0800, Wei Wang wrote:
> On 04/14/2017 09:50 AM, Michael S. Tsirkin wrote:
> > On Thu, Apr 13, 2017 at 01:44:11PM -0700, Matthew Wilcox wrote:
> > > On Thu, Apr 13, 2017 at 05:35:03PM +0800, Wei Wang wrote:
> > > > 2) transfer the guest unused pages to the host so that they
> > > > can be skipped to migrate in live migration.
> > > I don't understand this second bit.  You leave the pages on the free list,
> > > and tell the host they're free.  What's preventing somebody else from
> > > allocating them and using them for something?  Is the guest semi-frozen
> > > at this point with just enough of it running to ask the balloon driver
> > > to do things?
> > There's missing documentation here.
> > 
> > The way things actually work is host sends to guest
> > a request for unused pages and then write-protects all memory.
> > 
> > So guest isn't frozen but any changes will be detected by host.
> > 
> 
> Probably it's better to say " transfer the info about the guest unused pages
> to the host so that the host gets a chance to skip the transfer of the
> unused
> pages during live migration".
> 
> Best,
> Wei

IMHO this would not be helpful.
Most people don't know how does migration work, even if they did
this isn't tied to migration in any way.
It just makes people go "oh it's some virtualization mumbo jumbo".
We want people to be able to review and for that
interfaces need to be separate from the implementation.

IOW we must document what the interface promises not how it's used.


The promise is that pages have been unused at some time between when
host sent command and when guest completed it.  Host uses that by
tracking memory changes and then discarding changes made to pages
it gets from guest before it sent the command.

Say that and drop all mention of transfer, migration etc.

-- 
MST
