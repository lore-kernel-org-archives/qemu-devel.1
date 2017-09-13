Received: from eggs.gnu.org ([2001:4830:134:3::10]:32786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ds7Pv-0005cq-CQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ds7Pp-0000A7-D3
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ds7Pp-00008W-4m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:09:17 -0400
Date: Wed, 13 Sep 2017 14:09:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170913130901.GC2096@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-23-dgilbert@redhat.com>
	<20170830055540.GD5920@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830055540.GD5920@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 22/32] vhost+postcopy: Add vhost waker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Aug 24, 2017 at 08:27:20PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Register a waker function in vhost-user code to be notified when
> > pages arrive or requests to previously mapped pages get requested.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/virtio/trace-events |  3 +++
> >  hw/virtio/vhost-user.c | 26 ++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index f7d4b831fe..adebf6dc6b 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -7,6 +7,9 @@ vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t
> >  vhost_user_postcopy_listen(void) ""
> >  vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
> >  vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
> > +vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
> > +vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
> > +vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
> >  
> >  # hw/virtio/virtio.c
> >  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 2897ff70b3..3bff33a1a6 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -847,6 +847,31 @@ static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
> >      return -1;
> >  }
> >  
> > +static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
> > +                                     uint64_t offset)
> > +{
> > +    struct vhost_dev *dev = pcfd->data;
> > +    struct vhost_user *u = dev->opaque;
> > +    int i;
> > +
> > +    trace_vhost_user_postcopy_waker(qemu_ram_get_idstr(rb), offset);
> > +    /* Translate the offset into an address in the clients address space */
> > +    for (i = 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
> > +        if (u->region_rb[i] == rb &&
> > +            offset >= u->region_rb_offset[i] &&
> > +            offset < (u->region_rb_offset[i] +
> > +                      dev->mem->regions[i].memory_size)) {
> 
> Just curious: checks against offset should only be for safety, right?
> Is there valid case that even rb is correct but the offset gets out of
> the range of that RAMBlock?

Yes, I think that case does exist.

'regions' are mapping regions as visible from the guest, but there may
be two regions that are mapped to the same RAMBlock.  In our world
the cleanest example of that is an x86 guest with 8GB of RAM; it
has a single pc.ram RAMBlock of 8GB in size, but that's mapped
in two chunks, a 3GB chunk at the bottom of physical address space
and a 5GB chunk that starts on the 4GB boundary - i.e. leaving
a 1GB hole.
In this structure that appears as two regions each with the same rb and
different offsets.

Dave

> > +            uint64_t client_addr = (offset - u->region_rb_offset[i]) +
> > +                                   u->postcopy_client_bases[i];
> > +            trace_vhost_user_postcopy_waker_found(client_addr);
> > +            return postcopy_wake_shared(pcfd, client_addr, rb);
> > +        }
> > +    }
> > +
> > +    trace_vhost_user_postcopy_waker_nomatch(qemu_ram_get_idstr(rb), offset);
> > +    return 0;
> > +}
> > +
> >  /*
> >   * Called at the start of an inbound postcopy on reception of the
> >   * 'advise' command.
> > @@ -892,6 +917,7 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
> >      u->postcopy_fd.fd = ufd;
> >      u->postcopy_fd.data = dev;
> >      u->postcopy_fd.handler = vhost_user_postcopy_fault_handler;
> > +    u->postcopy_fd.waker = vhost_user_postcopy_waker;
> >      u->postcopy_fd.idstr = "vhost-user"; /* Need to find unique name */
> >      postcopy_register_shared_ufd(&u->postcopy_fd);
> >      return 0;
> > -- 
> > 2.13.5
> > 
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
