Received: from eggs.gnu.org ([2001:4830:134:3::10]:58211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5q76-0001wb-97
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5q70-0004Y2-37
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:02:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f5q6z-0004Wl-T6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:02:50 -0400
Date: Tue, 10 Apr 2018 11:02:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180410100235.GC2559@work-vm>
References: <bb088a1ba2e344273db32402f7c9fae4@linux.vnet.ibm.com>
	<20180404080600.GA10540@xz-mi>
	<0a48a834f08d064eaa3eb4ef1b41235f@linux.vnet.ibm.com>
	<20180409185747.GL2449@work-vm>
	<20180410112255.7485f2a7@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410112255.7485f2a7@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <dgibson@redhat.com>
Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com

* David Gibson (dgibson@redhat.com) wrote:
> On Mon, 9 Apr 2018 19:57:47 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > > On 2018-04-04 13:36, Peter Xu wrote:  
> > > > On Wed, Apr 04, 2018 at 11:55:14AM +0530, Balamuruhan S wrote:
> [snip]
> > > > > > - postcopy: that'll let you start the destination VM even without
> > > > > >   transferring all the RAMs before hand  
> > > > > 
> > > > > I am seeing issue in postcopy migration between POWER8(16M) ->
> > > > > POWER9(1G)
> > > > > where the hugepage size is different. I am trying to enable it but
> > > > > host
> > > > > start
> > > > > address have to be aligned with 1G page size in
> > > > > ram_block_discard_range(),
> > > > > which I am debugging further to fix it.  
> > > > 
> > > > I thought the huge page size needs to be matched on both side
> > > > currently for postcopy but I'm not sure.  
> > > 
> > > you are right! it should be matched, but we need to support
> > > POWER8(16M) -> POWER9(1G)
> > >   
> > > > CC Dave (though I think Dave's still on PTO).  
> > 
> > There's two problems there:
> >   a) Postcopy with really big huge pages is a problem, because it takes
> >      a long time to send the whole 1G page over the network and the vCPU
> >      is paused during that time;  for example on a 10Gbps link, it takes
> >      about 1 second to send a 1G page, so that's a silly time to keep
> >      the vCPU paused.
> > 
> >   b) Mismatched pagesizes are a problem on postcopy; we require that the
> >      whole of a hostpage is sent continuously, so that it can be
> >      atomically placed in memory, the source knows to do this based on
> >      the page sizes that it sees.  There are some other cases as well 
> >      (e.g. discards have to be page aligned.)
> 
> I'm not entirely clear on what mismatched means here.  Mismatched
> between where and where?  I *think* the relevant thing is a mismatch
> between host backing page size on source and destination, but I'm not
> certain.

Right.  As I understand it, we make no requirements on (an x86) guest
as to what page sizes it uses given any particular host page sizes.

> > Both of the problems are theoretically fixable; but neither case is
> > easy.
> > (b) could be fixed by sending the hugepage size back to the source,
> > so that it knows to perform alignments on a larger boundary to it's
> > own RAM blocks.
> 
> Sounds feasible, but like something that will take some thought and
> time upstream.

Yes; it's not too bad.

> > (a) is a much much harder problem; one *idea* would be a major
> > reorganisation of the kernels hugepage + userfault code to somehow
> > allow them to temporarily present as normal pages rather than a
> > hugepage.
> 
> Yeah... for Power specifically, I think doing that would be really
> hard, verging on impossible, because of the way the MMU is
> virtualized.  Well.. it's probably not too bad for a native POWER9
> guest (using the radix MMU), but the issue here is for POWER8 compat
> guests which use the hash MMU.

My idea was to fill the pagetables for that hugepage using small page
entries but using the physical hugepages memory; so that once we're
done we'd flip it back to being a single hugepage entry.
(But my understanding is that doesn't fit at all into the way the kernel
hugepage code works).

> > Does P9 really not have a hugepage that's smaller than 1G?
> 
> It does (2M), but we can't use it in this situation.  As hinted above,
> POWER9 has two very different MMU modes, hash and radix.  In hash mode
> (which is similar to POWER8 and earlier CPUs) the hugepage sizes are
> 16M and 16G, in radix mode (more like x86) they are 2M and 1G.
> 
> POWER9 hosts always run in radix mode.  Or at least, we only support
> running them in radix mode.  We support both radix mode and hash mode
> guests, the latter including all POWER8 compat mode guests.
> 
> The next complication is because the way the hash virtualization works,
> any page used by the guest must be HPA-contiguous, not just
> GPA-contiguous.  Which means that any pagesize used by the guest must
> be smaller or equal than the host pagesizes used to back the guest.
> We (sort of) cope with that by only advertising the 16M pagesize to the
> guest if all guest RAM is backed by >= 16M pages.
> 
> But that advertisement only happens at guest boot.  So if we migrate a
> guest from POWER8, backed by 16M pages to POWER9 backed by 2M pages,
> the guest still thinks it can use 16M pages and jams up.  (I'm in the
> middle of upstream work to make the failure mode less horrible).
> 
> So, the only way to run a POWER8 compat mode guest with access to 16M
> pages on a POWER9 radix mode host is using 1G hugepages on the host
> side.

Ah ok;  I'm not seeing an easy answer here.
The only vague thing I can think of is if you gave P9 a fake 16M
hugepage mode, that did all HPA and mappings in 16M chunks (using 8 x 2M
page entries).

Dave

> -- 
> David Gibson <dgibson@redhat.com>
> Principal Software Engineer, Virtualization, Red Hat


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
