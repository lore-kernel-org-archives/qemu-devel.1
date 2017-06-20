Received: from eggs.gnu.org ([2001:4830:134:3::10]:54739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNOKK-0002P1-Uy
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNOKH-0007dh-UC
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dNOKH-0007cH-Lj
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:56:33 -0400
Date: Tue, 20 Jun 2017 21:56:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170620215552-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<20170620211445-mutt-send-email-mst@kernel.org>
	<f46768db-dcda-aa40-64b9-eb2929249db8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f46768db-dcda-aa40-64b9-eb2929249db8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, Nitesh Narayan Lal <nilal@redhat.com>

On Tue, Jun 20, 2017 at 08:54:29PM +0200, David Hildenbrand wrote:
> On 20.06.2017 20:17, Michael S. Tsirkin wrote:
> > On Tue, Jun 20, 2017 at 06:49:33PM +0200, David Hildenbrand wrote:
> >> On 20.06.2017 18:44, Rik van Riel wrote:
> >>> On Mon, 2017-06-12 at 07:10 -0700, Dave Hansen wrote:
> >>>
> >>>> The hypervisor is going to throw away the contents of these pages,
> >>>> right?  As soon as the spinlock is released, someone can allocate a
> >>>> page, and put good data in it.  What keeps the hypervisor from
> >>>> throwing
> >>>> away good data?
> >>>
> >>> That looks like it may be the wrong API, then?
> >>>
> >>> We already have hooks called arch_free_page and
> >>> arch_alloc_page in the VM, which are called when
> >>> pages are freed, and allocated, respectively.
> >>>
> >>> Nitesh Lal (on the CC list) is working on a way
> >>> to efficiently batch recently freed pages for
> >>> free page hinting to the hypervisor.
> >>>
> >>> If that is done efficiently enough (eg. with
> >>> MADV_FREE on the hypervisor side for lazy freeing,
> >>> and lazy later re-use of the pages), do we still
> >>> need the harder to use batch interface from this
> >>> patch?
> >>>
> >> David's opinion incoming:
> >>
> >> No, I think proper free page hinting would be the optimum solution, if
> >> done right. This would avoid the batch interface and even turn
> >> virtio-balloon in some sense useless.
> > 
> > I agree generally. But we have to balance that against the fact that
> > this was discussed since at least 2011 and no one built this solution
> > yet.
> 
> I totally agree, and I still think it will be hard to get a decent
> performance for free page hinting (let's call it challenging). But I
> heard of some interesting ideas. Surprise me.
> 
> Still, I would favor such an interface over a mm interface where people
> start asking the same question over and over again ("how can this even
> work"). Not only because it wasn't explained sufficiently enough, but
> also because this interface is so special for one use case and one
> scenario (concurrent dirty tracking in the host during migration).
> 
> IMHO even simply writing all-zeros to all free pages before starting
> migration (or even when freeing a page) would be a cleaner interface
> than this (because it atomically works with the entity the host cares
> about for migration). But yes, performance is horrible that's why I am
> not even suggesting it. Just saying that this mm interface is very very
> special and if we could find something better, I'd favor it.

As long as there's a single user, changing to a better interface
once it's found won't be hard at all :)

> -- 
> 
> Thanks,
> 
> David
