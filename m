Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1diYUt-00029L-9V
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 00:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1diYUo-00009W-Bw
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 00:02:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1diYUo-00007K-2H
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 00:02:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F913488
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 04:02:51 +0000 (UTC)
Date: Fri, 18 Aug 2017 12:02:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170818040245.GD2294@pxdev.xzpeter.org>
References: <1502949374-3061-1-git-send-email-peterx@redhat.com>
	<55204f73-46d3-0f8e-195f-15a9247819d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55204f73-46d3-0f8e-195f-15a9247819d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] intel_iommu: fix missing BQL in
 pt fast path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Thu, Aug 17, 2017 at 11:40:48AM +0200, Paolo Bonzini wrote:
> On 17/08/2017 07:56, Peter Xu wrote:
> > In vtd_switch_address_space() we did the memory region switch, however
> > it's possible that the caller of it has not taken the BQL at all. Make
> > sure we have it.
> > 
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Jason Wang <jasowang@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > Paolo: I noticed this qemu_mutex_iothread_locked() function, which might
> > simplify the fix, so I decided to use it. Using bottom half should be ok
> > as well, but after a second thought it can be complicated: consider the
> > case when guest firstly triggered the pt fast path then quickly
> > re-enables the IOMMU region before the bottom half being executed. Then
> > looks like we need special care on the sync of bottom half task as well.
> 
> No, we don't, because the bottom half (as you correctly do below) would
> only have to cover vtd_switch_address_space.  So the worst that can
> happen is that on of the two calls to vtd_switch_address_space does nothing.

Ah, yes, the state is shared... :)

> 
> The patch below is okay.  However, vtd_switch_address_space is
> expensive, which is why I suggested the bottom half.

But still, shall we just do it this way? It looks cleaner.

For the slowness (as I mentioned below), one thing to mention is that,
this fast path should even not be used when PT is enabled.  When
"iommu=pt" is set, the IOMMU regions are off start from the very
beginning.  In other words, this patch should only affect a very
corner use case, and to make sure that use case is safe, though it
brings the first IO of that use case slower.

How do you think?

Thanks,

> 
> Paolo
> 
> > That's over-complicated I guess (if with that, I'd prefer to remove the
> > pt fast path since it's even not really the default path when pt is
> > used...). Please let me know if you don't think so.
> > ---
> >  hw/i386/intel_iommu.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index a7bf87a..3a5bb0b 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -957,6 +957,8 @@ static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
> >  static bool vtd_switch_address_space(VTDAddressSpace *as)
> >  {
> >      bool use_iommu;
> > +    /* Whether we need to take the BQL on our own */
> > +    bool take_bql = !qemu_mutex_iothread_locked();
> >  
> >      assert(as);
> >  
> > @@ -967,6 +969,15 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
> >                                     VTD_PCI_FUNC(as->devfn),
> >                                     use_iommu);
> >  
> > +    /*
> > +     * It's possible that we reach here without BQL, e.g., when called
> > +     * from vtd_pt_enable_fast_path(). However the memory APIs need
> > +     * it. We'd better make sure we have had it already, or, take it.
> > +     */
> > +    if (take_bql) {
> > +        qemu_mutex_lock_iothread();
> > +    }
> > +
> >      /* Turn off first then on the other */
> >      if (use_iommu) {
> >          memory_region_set_enabled(&as->sys_alias, false);
> > @@ -976,6 +987,10 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
> >          memory_region_set_enabled(&as->sys_alias, true);
> >      }
> >  
> > +    if (take_bql) {
> > +        qemu_mutex_unlock_iothread();
> > +    }
> > +
> >      return use_iommu;
> >  }
> >  
> > 
> 

-- 
Peter Xu
