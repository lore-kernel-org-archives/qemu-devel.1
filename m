Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ewgox-0001JQ-Tf
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ewgou-00053y-Mh
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:18:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ewgou-00053k-Gg
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:18:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D82E07C6CC
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 04:18:09 +0000 (UTC)
Date: Fri, 16 Mar 2018 12:18:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180316041800.GB2477@xz-mi>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-15-dgilbert@redhat.com>
	<20180312102059.GD11787@xz-mi> <20180312132320.GC3219@work-vm>
	<20180313082801.GF11787@xz-mi> <20180315094059.GA3060@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315094059.GA3060@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 14/29] libvhost-user+postcopy: Register
 new regions with the ufd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Thu, Mar 15, 2018 at 09:41:00AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Mon, Mar 12, 2018 at 01:23:21PM +0000, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > On Thu, Mar 08, 2018 at 07:57:56PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > 
> > > > > When new regions are sent to the client using SET_MEM_TABLE, register
> > > > > them with the userfaultfd.
> > > > > 
> > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > ---
> > > > >  contrib/libvhost-user/libvhost-user.c | 34 ++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 34 insertions(+)
> > > > > 
> > > > > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> > > > > index 4922b2c722..a18bc74a7c 100644
> > > > > --- a/contrib/libvhost-user/libvhost-user.c
> > > > > +++ b/contrib/libvhost-user/libvhost-user.c
> > > > > @@ -494,6 +494,40 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
> > > > >          close(vmsg->fds[i]);
> > > > >      }
> > > > >  
> > > > > +    /* TODO: Get address back to QEMU */
> > > > > +    for (i = 0; i < dev->nregions; i++) {
> > > > > +        VuDevRegion *dev_region = &dev->regions[i];
> > > > > +#ifdef UFFDIO_REGISTER
> > > > > +        /* We should already have an open ufd. Mark each memory
> > > > > +         * range as ufd.
> > > > > +         * Note: Do we need any madvises? Well it's not been accessed
> > > > > +         * yet, still probably need no THP to be safe, discard to be safe?
> > > > > +         */
> > > > > +        struct uffdio_register reg_struct;
> > > > > +        reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
> > > > > +        reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
> > > > 
> > > > Do we really care the page faults between offset zero to mmap_offset?
> > > 
> > > No, but if we saw them we'd think it meant something had gone wrong,
> > > so it's good to trap them.
> > 
> > I'm fine with that, especially since that's now only used in the test
> > codes.  However that's a still bit confusing to me, especially if
> > current QEMU won't really handle that page fault (and it seems that
> > should never happen).  Maybe at least a comment would help on
> > explaining why we need to explicitly extend the range to listen, just
> > like below code when we do the mapping, though with a different
> > reason.
> > 
> > > 
> > > > I'm thinking whether we should add that mmap_offset into range.start
> > > > instead of range.len.
> > > > 
> > > > Also, I see that in current vu_set_mem_table_exec():
> > > > 
> > > >         /* We don't use offset argument of mmap() since the
> > > >          * mapped address has to be page aligned, and we use huge
> > > >          * pages.  */
> > > >         mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
> > > >                          PROT_READ | PROT_WRITE, MAP_SHARED,
> > > >                          vmsg->fds[i], 0);
> > > > 
> > > > So adding the mmap_offset will help to make sure we'll use huge pages?
> > > > Could it?  Or say, how could we be sure that size+mmap_offset would be
> > > > page aligned?
> > > 
> > > If you look into the set_mem_table_exec (non-postcopy) you'll see that
> > > code and comment comes from the non-postcopy version; but it's something
> > > which as you say we could probably simplify now.
> > > 
> > > The problem used to be, before we did the merging as part of this series
> > > (0026 vhost Huge page align and merge), we could end up with mappings
> > > being passed from the qemu that were for small ranges of memory that
> > > weren't aligned to a huge page boundary and thus the mmap would fail.
> > > With the merging code that's no longer true, so it means we
> > > could simplify as you say;  although this way it's a smaller change from
> > > the existing code.
> > 
> > I was thinking what if the memory section was e.g. splitted as below:
> > 
> > - range A: [0x0,      0x10):     non-RAM range, size     0x10
> > - range B: [0x10,     0x1ffff0):     RAM range, size 0x1fffe0
> > - range C: [0x1ffff0, 0x200000): non-RAM range, size     0x10
> > 
> > Ranges A+B+C will cover a 2M page while vhost-user master should only
> > send range B to the client. Then even size+mmap_offset (which is
> > 0x1fffe0+0x10=0x1ffff0) shouldn't be aligned with the 2M boundary.
> > If previous mmap() can fail, would this fail too?
> 
> I think, 'vhost: Huge page align and merge' will round (B) to page
> boundaries so that the range sent to the slave will be aligned.

Ah I see what you meant.  Yes that seems to work, and yes the old code
won't hurt too even with some useless extra pages mapped.

-- 
Peter Xu
