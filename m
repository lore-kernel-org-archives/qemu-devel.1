Received: from eggs.gnu.org ([2001:4830:134:3::10]:51567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtnBW-0004LT-IC
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtnBT-0006vG-FM
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dtnBT-0006sz-77
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:57:23 -0400
Date: Mon, 18 Sep 2017 11:57:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170918035709.GY3617@pxdev.xzpeter.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-23-dgilbert@redhat.com>
	<20170830055540.GD5920@pxdev.xzpeter.org>
	<20170913130901.GC2096@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913130901.GC2096@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 22/32] vhost+postcopy: Add vhost waker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

On Wed, Sep 13, 2017 at 02:09:02PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Aug 24, 2017 at 08:27:20PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Register a waker function in vhost-user code to be notified when
> > > pages arrive or requests to previously mapped pages get requested.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  hw/virtio/trace-events |  3 +++
> > >  hw/virtio/vhost-user.c | 26 ++++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> > > 
> > > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > > index f7d4b831fe..adebf6dc6b 100644
> > > --- a/hw/virtio/trace-events
> > > +++ b/hw/virtio/trace-events
> > > @@ -7,6 +7,9 @@ vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t
> > >  vhost_user_postcopy_listen(void) ""
> > >  vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
> > >  vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
> > > +vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
> > > +vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
> > > +vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
> > >  
> > >  # hw/virtio/virtio.c
> > >  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 2897ff70b3..3bff33a1a6 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -847,6 +847,31 @@ static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
> > >      return -1;
> > >  }
> > >  
> > > +static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
> > > +                                     uint64_t offset)
> > > +{
> > > +    struct vhost_dev *dev = pcfd->data;
> > > +    struct vhost_user *u = dev->opaque;
> > > +    int i;
> > > +
> > > +    trace_vhost_user_postcopy_waker(qemu_ram_get_idstr(rb), offset);
> > > +    /* Translate the offset into an address in the clients address space */
> > > +    for (i = 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
> > > +        if (u->region_rb[i] == rb &&
> > > +            offset >= u->region_rb_offset[i] &&
> > > +            offset < (u->region_rb_offset[i] +
> > > +                      dev->mem->regions[i].memory_size)) {
> > 
> > Just curious: checks against offset should only be for safety, right?
> > Is there valid case that even rb is correct but the offset gets out of
> > the range of that RAMBlock?
> 
> Yes, I think that case does exist.
> 
> 'regions' are mapping regions as visible from the guest, but there may
> be two regions that are mapped to the same RAMBlock.  In our world
> the cleanest example of that is an x86 guest with 8GB of RAM; it
> has a single pc.ram RAMBlock of 8GB in size, but that's mapped
> in two chunks, a 3GB chunk at the bottom of physical address space
> and a 5GB chunk that starts on the 4GB boundary - i.e. leaving
> a 1GB hole.
> In this structure that appears as two regions each with the same rb and
> different offsets.

Yeah I missed that.  Thanks!

-- 
Peter Xu
