Received: from eggs.gnu.org ([2001:4830:134:3::10]:48154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBwrL-0001mq-JX
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBwrG-00046I-MG
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:27:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBwrG-000462-HY
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:27:50 -0400
Date: Fri, 27 Apr 2018 14:27:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180427062744.GZ9036@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-8-peterx@redhat.com>
	<df734575-d387-eec6-fd8a-ad66d31da95d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df734575-d387-eec6-fd8a-ad66d31da95d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] util: implement simple interval tree
 logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Fri, Apr 27, 2018 at 01:53:35PM +0800, Jason Wang wrote:

[...]

> > +    /* Merge right adjacent range */
> > +    overlap = it_tree_find_value(tree, end + 1);
> > +    if (overlap) {
> > +        range->end = overlap->end;
> > +        g_tree_remove(gtree, overlap);
> > +    }
> > +
> > +    /* Key and value are sharing the same range data */
> > +    it_tree_insert_internal(gtree, range);
> 
> A small optimization here is to delay the allocation until you're sure
> there's not overlapping.

Yes I can.

[...]

> > +int it_tree_remove(ITTree *tree, ITValue start, ITValue end)
> > +{
> > +    ITRange range = { .start = start, .end = end }, *overlap, and;
> > +    GTree *gtree;
> > +
> > +    g_assert(tree);
> > +
> > +    gtree = tree->tree;
> > +    while ((overlap = g_tree_lookup(gtree, &range))) {
> > +        if (it_range_equal(overlap, &range)) {
> > +            /* Exactly what we want to remove; done */
> > +            g_tree_remove(gtree, overlap);
> > +            break;
> > +        } else if (it_range_cover(overlap, &range)) {
> > +            /* Split existing range into two; done */
> > +            it_tree_remove_subset(gtree, overlap, &range);
> > +            break;
> > +        } else if (it_range_cover(&range, overlap)) {
> > +            /* Drop this range and continue */
> > +            g_tree_remove(gtree, overlap);
> > +        } else {
> > +            /*
> > +             * The range to remove has intersection with existing
> > +             * ranges.  Remove part of the range and continue
> > +             */
> > +            it_range_and(&and, overlap, &range);
> > +            g_assert(and.start <= and.end);
> > +            it_tree_remove_subset(gtree, overlap, &and);
> > +        }
> > +    }
> > +
> 
> Looks like what we need here is just calculate the intersection part the
> remove it.

Yes.  Will fix that.  Thanks,

-- 
Peter Xu
