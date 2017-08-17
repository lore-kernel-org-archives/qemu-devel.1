Received: from eggs.gnu.org ([2001:4830:134:3::10]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diOch-0003X5-Se
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 13:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diOce-00033t-NN
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 13:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1diOce-00030S-E3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 13:30:20 -0400
Date: Thu, 17 Aug 2017 18:29:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170817172957.GC2523@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-17-dgilbert@redhat.com>
	<20170711033159.GE21344@pxdev.xzpeter.org>
	<20170714171554.GF2091@work-vm>
	<20170717025944.GR27284@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717025944.GR27284@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 16/29] vhost+postcopy: Stash RAMBlock and
 offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Jul 14, 2017 at 06:15:54PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Wed, Jun 28, 2017 at 08:00:34PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > 
> > > > Stash the RAMBlock and offset for later use looking up
> > > > addresses.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > >  hw/virtio/trace-events |  1 +
> > > >  hw/virtio/vhost-user.c | 11 +++++++++++
> > > >  2 files changed, 12 insertions(+)
> > > > 
> > > > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > > > index f7be340a45..1fd194363a 100644
> > > > --- a/hw/virtio/trace-events
> > > > +++ b/hw/virtio/trace-events
> > > > @@ -3,6 +3,7 @@
> > > >  # hw/virtio/vhost-user.c
> > > >  vhost_user_postcopy_listen(void) ""
> > > >  vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:%"PRIx64" for hva: %"PRIx64" reply %d region %d"
> > > > +vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:%"PRIx64" GPA:%"PRIx64" QVA/userspace:%"PRIx64" RB offset:%"PRIx64
> > > >  
> > > >  # hw/virtio/virtio.c
> > > >  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 6be3e7ff2d..3185af7a45 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -133,6 +133,11 @@ struct vhost_user {
> > > >      NotifierWithReturn postcopy_notifier;
> > > >      struct PostCopyFD  postcopy_fd;
> > > >      uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
> > > > +    RAMBlock          *region_rb[VHOST_MEMORY_MAX_NREGIONS];
> > > > +    /* The offset from the start of the RAMBlock to the start of the
> > > > +     * vhost region.
> > > > +     */
> > > > +    ram_addr_t         region_rb_offset[VHOST_MEMORY_MAX_NREGIONS];
> > > 
> > > Here the array size is VHOST_MEMORY_MAX_NREGIONS, while...
> > > 
> > > >  };
> > > >  
> > > >  static bool ioeventfd_enabled(void)
> > > > @@ -324,8 +329,14 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
> > > >          assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> > > >          mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> > > >                                       &offset);
> > > > +        u->region_rb_offset[i] = offset;
> > > > +        u->region_rb[i] = mr->ram_block;
> > > 
> > > ... can i>=VHOST_MEMORY_MAX_NREGIONS here? Or do we only need to note
> > > this down if fd > 0 below?  Thanks,
> > 
> > I don't *think* so - I mean:
> >     for (i = 0; i < dev->mem->nregions; ++i) {
> > 
> > so if that's the maximum number of regions and that's the number of
> > regions we should be safe???
> 
> That's my concern - looks like dev->mem->nregions can be bigger than
> that? At least I didn't really see a restriction on its size. The size
> is changed in following stack:
> 
>   vhost_region_add
>     vhost_set_memory
>       vhost_dev_assign_memory
> 
> And it's dynamic extended, without checks.
> 
> Indeed in the function vhost_user_set_mem_table() we have:
> 
>     int fds[VHOST_MEMORY_MAX_NREGIONS];
> 
> But we are safe iiuc because we also have assertions to protect:
> 
>     assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
>     fds[fd_num++] = fd;
> 
> Do we at least need that assert?

I think you're right that it can be validly larger than MAX_NREGIONS;
I think the idea is that the dev->mem->regions can be larger,
with the limit being only on the number that actually have fd's.

I'll rework the structure.

Dave

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
