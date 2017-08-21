Received: from eggs.gnu.org ([2001:4830:134:3::10]:46385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1djg2X-0006OX-P1
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1djg2S-0004QS-Ru
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:18:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:47158 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1djg2S-0004PQ-JM
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:18:16 -0400
Date: Mon, 21 Aug 2017 08:18:12 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170821061812.GB13724@dhcp22.suse.cz>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
	<20170818201946-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818201946-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v14 4/5] mm: support reporting free page
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Fri 18-08-17 20:23:05, Michael S. Tsirkin wrote:
> On Thu, Aug 17, 2017 at 11:26:55AM +0800, Wei Wang wrote:
[...]
> > +void walk_free_mem_block(void *opaque1,
> > +			 unsigned int min_order,
> > +			 void (*visit)(void *opaque2,
> 
> You can just avoid opaque2 completely I think, then opaque1 can
> be renamed opaque.
> 
> > +				       unsigned long pfn,
> > +				       unsigned long nr_pages))
> > +{
> > +	struct zone *zone;
> > +	struct page *page;
> > +	struct list_head *list;
> > +	unsigned int order;
> > +	enum migratetype mt;
> > +	unsigned long pfn, flags;
> > +
> > +	for_each_populated_zone(zone) {
> > +		for (order = MAX_ORDER - 1;
> > +		     order < MAX_ORDER && order >= min_order; order--) {
> > +			for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> > +				spin_lock_irqsave(&zone->lock, flags);
> > +				list = &zone->free_area[order].free_list[mt];
> > +				list_for_each_entry(page, list, lru) {
> > +					pfn = page_to_pfn(page);
> > +					visit(opaque1, pfn, 1 << order);
> 
> My only concern here is inability of callback to
> 1. break out of list
> 2. remove page from the list

As I've said before this has to be a read only API. You cannot simply
fiddle with the page allocator internals under its feet.

> So I would make the callback bool, and I would use
> list_for_each_entry_safe.

If a bool would tell to break out of the loop then I agree. This sounds
useful.
-- 
Michal Hocko
SUSE Labs
