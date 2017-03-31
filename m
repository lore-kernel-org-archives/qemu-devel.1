Received: from eggs.gnu.org ([2001:4830:134:3::10]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctzNP-0007QA-A4
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctzNK-0002BE-7v
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:26:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctzNK-0002Ai-05
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:26:10 -0400
Date: Fri, 31 Mar 2017 19:25:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170331192321-mutt-send-email-mst@kernel.org>
References: <1489648127-37282-1-git-send-email-wei.w.wang@intel.com>
	<1489648127-37282-4-git-send-email-wei.w.wang@intel.com>
	<20170316142842.69770813b98df70277431b1e@linux-foundation.org>
	<58CB8865.5030707@intel.com>
	<20170329204418-mutt-send-email-mst@kernel.org>
	<58DE26FC.7090403@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58DE26FC.7090403@intel.com>
Subject: Re: [Qemu-devel] [PATCH kernel v8 3/4] mm: add inerface to offer
 info about unused pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Fri, Mar 31, 2017 at 05:53:00PM +0800, Wei Wang wrote:
> On 03/30/2017 01:48 AM, Michael S. Tsirkin wrote:
> > On Fri, Mar 17, 2017 at 02:55:33PM +0800, Wei Wang wrote:
> > > On 03/17/2017 05:28 AM, Andrew Morton wrote:
> > > > On Thu, 16 Mar 2017 15:08:46 +0800 Wei Wang <wei.w.wang@intel.com> wrote:
> > > > 
> > > > > From: Liang Li <liang.z.li@intel.com>
> > > > > 
> > > > > This patch adds a function to provides a snapshot of the present system
> > > > > unused pages. An important usage of this function is to provide the
> > > > > unsused pages to the Live migration thread, which skips the transfer of
> > > > > thoses unused pages. Newly used pages can be re-tracked by the dirty
> > > > > page logging mechanisms.
> > > > I don't think this will be useful for anything other than
> > > > virtio-balloon.  I guess it would be better to keep this code in the
> > > > virtio-balloon driver if possible, even though that's rather a layering
> > > > violation :( What would have to be done to make that possible?  Perhaps
> > > > we can put some *small* helpers into page_alloc.c to prevent things
> > > > from becoming too ugly.
> > > The patch description was too narrowed and may have caused some
> > > confusion, sorry about that. This function is aimed to be generic. I
> > > agree with the description suggested by Michael.
> > > 
> > > Since the main body of the function is related to operating on the
> > > free_list. I think it is better to have them located here.
> > > Small helpers may be less efficient and thereby causing some
> > > performance loss as well.
> > > I think one improvement we can make is to remove the "chunk format"
> > > related things from this function. The function can generally offer the
> > > base pfn to the caller's recording buffer. Then it will be the caller's
> > > responsibility to format the pfn if they need.
> > Sounds good at a high level, but we'd have to see the implementation
> > to judge it properly.
> > 
> > > > > --- a/mm/page_alloc.c
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -4498,6 +4498,120 @@ void show_free_areas(unsigned int filter)
> > > > >    	show_swap_cache_info();
> > > > >    }
> > > > > +static int __record_unused_pages(struct zone *zone, int order,
> > > > > +				 __le64 *buf, unsigned int size,
> > > > > +				 unsigned int *offset, bool part_fill)
> > > > > +{
> > > > > +	unsigned long pfn, flags;
> > > > > +	int t, ret = 0;
> > > > > +	struct list_head *curr;
> > > > > +	__le64 *chunk;
> > > > > +
> > > > > +	if (zone_is_empty(zone))
> > > > > +		return 0;
> > > > > +
> > > > > +	spin_lock_irqsave(&zone->lock, flags);
> > > > > +
> > > > > +	if (*offset + zone->free_area[order].nr_free > size && !part_fill) {
> > > > > +		ret = -ENOSPC;
> > > > > +		goto out;
> > > > > +	}
> > > > > +	for (t = 0; t < MIGRATE_TYPES; t++) {
> > > > > +		list_for_each(curr, &zone->free_area[order].free_list[t]) {
> > > > > +			pfn = page_to_pfn(list_entry(curr, struct page, lru));
> > > > > +			chunk = buf + *offset;
> > > > > +			if (*offset + 2 > size) {
> > > > > +				ret = -ENOSPC;
> > > > > +				goto out;
> > > > > +			}
> > > > > +			/* Align to the chunk format used in virtio-balloon */
> > > > > +			*chunk = cpu_to_le64(pfn << 12);
> > > > > +			*(chunk + 1) = cpu_to_le64((1 << order) << 12);
> > > > > +			*offset += 2;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +out:
> > > > > +	spin_unlock_irqrestore(&zone->lock, flags);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > This looks like it could disable interrupts for a long time.  Too long?
> > > What do you think if we give "budgets" to the above function?
> > > For example, budget=1000, and there are 2000 nodes on the list.
> > > record() returns with "incomplete" status in the first round, along with the
> > > status info, "*continue_node".
> > > 
> > > *continue_node: pointer to the starting node of the leftover. If
> > > *continue_node
> > > has been used at the time of the second call (i.e. continue_node->next ==
> > > NULL),
> > > which implies that the previous 1000 nodes have been used, then the record()
> > > function can simply start from the head of the list.
> > > 
> > > It is up to the caller whether it needs to continue the second round
> > > when getting "incomplete".
> > It might be cleaner to add APIs to
> > 	- start iteration
> > 	- do one step
> > 	- end iteration
> > 
> > caller can then iterate without too many issues
> > 
> 
> OK. I will re-implement it with this simple one - get only one node(page
> block) from the list in each call, and check if the time would increase a
> lot in comparison to v8.
> 
> Best,
> Wei

Might work though this isn't what was suggested - just an iterator based
approach that allows user to drop the lock periodically.

-- 
MST
