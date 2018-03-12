Received: from eggs.gnu.org ([2001:4830:134:3::10]:50913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evNQT-0000MC-Bc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evNQN-00069a-Hy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:23:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evNQN-000680-CY
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:23:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BE1BBD9E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 13:23:33 +0000 (UTC)
Date: Mon, 12 Mar 2018 13:23:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312132320.GC3219@work-vm>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-15-dgilbert@redhat.com>
	<20180312102059.GD11787@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312102059.GD11787@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, aarcange@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Mar 08, 2018 at 07:57:56PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > When new regions are sent to the client using SET_MEM_TABLE, register
> > them with the userfaultfd.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> > index 4922b2c722..a18bc74a7c 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -494,6 +494,40 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
> >          close(vmsg->fds[i]);
> >      }
> >  
> > +    /* TODO: Get address back to QEMU */
> > +    for (i = 0; i < dev->nregions; i++) {
> > +        VuDevRegion *dev_region = &dev->regions[i];
> > +#ifdef UFFDIO_REGISTER
> > +        /* We should already have an open ufd. Mark each memory
> > +         * range as ufd.
> > +         * Note: Do we need any madvises? Well it's not been accessed
> > +         * yet, still probably need no THP to be safe, discard to be safe?
> > +         */
> > +        struct uffdio_register reg_struct;
> > +        reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
> > +        reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
> 
> Do we really care the page faults between offset zero to mmap_offset?

No, but if we saw them we'd think it meant something had gone wrong,
so it's good to trap them.

> I'm thinking whether we should add that mmap_offset into range.start
> instead of range.len.
> 
> Also, I see that in current vu_set_mem_table_exec():
> 
>         /* We don't use offset argument of mmap() since the
>          * mapped address has to be page aligned, and we use huge
>          * pages.  */
>         mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
>                          PROT_READ | PROT_WRITE, MAP_SHARED,
>                          vmsg->fds[i], 0);
> 
> So adding the mmap_offset will help to make sure we'll use huge pages?
> Could it?  Or say, how could we be sure that size+mmap_offset would be
> page aligned?

If you look into the set_mem_table_exec (non-postcopy) you'll see that
code and comment comes from the non-postcopy version; but it's something
which as you say we could probably simplify now.

The problem used to be, before we did the merging as part of this series
(0026 vhost Huge page align and merge), we could end up with mappings
being passed from the qemu that were for small ranges of memory that
weren't aligned to a huge page boundary and thus the mmap would fail.
With the merging code that's no longer true, so it means we
could simplify as you say;  although this way it's a smaller change from
the existing code.

Dave

> Thanks,
> 
> > +        reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
> > +
> > +        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
> > +            vu_panic(dev, "%s: Failed to userfault region %d "
> > +                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
> > +                     __func__, i,
> > +                     dev_region->mmap_addr,
> > +                     dev_region->size, dev_region->mmap_offset,
> > +                     dev->postcopy_ufd, strerror(errno));
> > +            return false;
> > +        }
> > +        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> > +            vu_panic(dev, "%s Region (%d) doesn't support COPY",
> > +                     __func__, i);
> > +            return false;
> > +        }
> > +        DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
> > +                __func__, i, reg_struct.range.start, reg_struct.range.len);
> > +        /* TODO: Stash 'zero' support flags somewhere */
> > +#endif
> > +    }
> > +
> >      return false;
> >  }
> >  
> > -- 
> > 2.14.3
> > 
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
