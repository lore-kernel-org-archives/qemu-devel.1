Received: from eggs.gnu.org ([2001:4830:134:3::10]:49594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds04W-0000HE-0H
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds04S-0000Pc-Qb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds04S-0000JR-HQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:18:44 -0400
Date: Wed, 13 Sep 2017 13:18:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170913051829.GC3617@pxdev.xzpeter.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-20-dgilbert@redhat.com>
	<20170830052802.GB5920@pxdev.xzpeter.org>
	<20170911115814.GC2150@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170911115814.GC2150@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 19/32] vhost+postcopy: Resolve client
 address
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

On Mon, Sep 11, 2017 at 12:58:15PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Aug 24, 2017 at 08:27:17PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Resolve fault addresses read off the clients UFD into RAMBlock
> > > and offset, and call back to the postcopy code to ask for the page.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  hw/virtio/trace-events |  3 +++
> > >  hw/virtio/vhost-user.c | 30 +++++++++++++++++++++++++++++-
> > >  2 files changed, 32 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > > index 5067dee19b..f7d4b831fe 100644
> > > --- a/hw/virtio/trace-events
> > > +++ b/hw/virtio/trace-events
> > > @@ -1,6 +1,9 @@
> > >  # See docs/devel/tracing.txt for syntax documentation.
> > >  
> > >  # hw/virtio/vhost-user.c
> > > +vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_address, int nregions) "%s: @0x%"PRIx64" nregions:%d"
> > > +vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
> > > +vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx64
> > >  vhost_user_postcopy_listen(void) ""
> > >  vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
> > >  vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index fbe2743298..2897ff70b3 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -816,7 +816,35 @@ out:
> > >  static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
> > >                                               void *ufd)
> > >  {
> > > -    return 0;
> > > +    struct vhost_dev *dev = pcfd->data;
> > > +    struct vhost_user *u = dev->opaque;
> > > +    struct uffd_msg *msg = ufd;
> > > +    uint64_t faultaddr = msg->arg.pagefault.address;
> > > +    RAMBlock *rb = NULL;
> > > +    uint64_t rb_offset;
> > > +    int i;
> > > +
> > > +    trace_vhost_user_postcopy_fault_handler(pcfd->idstr, faultaddr,
> > > +                                            dev->mem->nregions);
> > > +    for (i = 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
> > 
> > Should dev->mem->nregions always the same as u->region_rb_len?
> 
> u->region_rb_len only gets updated when vhost_user_set_mem_table is
> called, so I think there are short periods of time when they don't
> quite match.
> (We do have to take some more care than we are at the moment during
> updates, because this address resolution happens off the postcopy
> thread)

I see, so memory layout can change along the way...

But I still doubt whether this single MIN() can work.

Say, we have these arrays already:

- array A: dev->mem->regions[]
- array B: u->region_rb[]
- array C: u->postcopy_client_bases[]

These arrays should always be aligned with each other (index "i" of
array "A/B/C" will always describe the same memory region).  But since
we can change the memory layout dynamically during postcopy, then
array A can grow/shrink/change in following path:

  vhost_region_{add|delete}
    updates array A              (1)
  vhost_region_{add|delete}
    updates array A              (2)
  vhost_region_{add|delete}
    updates array A              (3)
  ...
  vhost_commit
    vhost_set_mem_table
      align arrays B/C with A    (4)

IMHO array A may not really match B/C during step (1)-(3), until step
(4) to re-align them?  And if they are not aligned with each other, I
guess a single MIN() won't help much? (Since the indexing below would
be problematic?)

(Hmm, can we just disallow memory change during postcopy for now?)

> 
> > > +        trace_vhost_user_postcopy_fault_handler_loop(i,
> > > +                u->postcopy_client_bases[i], dev->mem->regions[i].memory_size);
> > > +        if (faultaddr >= u->postcopy_client_bases[i]) {

Ah, wait...

postcopy_client_bases[] is now defined with static size
VHOST_MEMORY_MAX_NREGIONS.  Shouldn't it be dynamically allocated as
well with dev->mem->nregions, just like vhost_user.region_rb[]?

Maybe we want to leave the postcopy_client_bases[i] be zeros when
dev->mem->regions[i] it's not a vhost-user supported region (without
"fd")?

> > > +            /* Ofset of the fault address in the vhost region */
> > > +            uint64_t region_offset = faultaddr - u->postcopy_client_bases[i];
> > > +            if (region_offset <= dev->mem->regions[i].memory_size) {
> > 
> > Should be "<" rather than "<="?  Say:
> > 
> > Region 1: [0, 1M), size 1M
> > Region 2: [1M, 2M), size 1M
> > 
> > Looks like otherwise faultaddr=1M will fall into region 1, while it
> > should be region 2?
> 
> Fixed; thanks.
> 
> > 
> > > +                rb_offset = region_offset + u->region_rb_offset[i];
> > > +                trace_vhost_user_postcopy_fault_handler_found(i,
> > > +                        region_offset, rb_offset);
> > > +                rb = u->region_rb[i];
> > 
> > Nit: this "rb" might be avoided if only used once.
> 
> It's only a local, ok if it makes it a little more readable.
> 
> Dave
> 
> > > +                return postcopy_request_shared_page(pcfd, rb, faultaddr,
> > > +                                                    rb_offset);
> > > +            }
> > > +        }
> > > +    }
> > > +    error_report("%s: Failed to find region for fault %" PRIx64,
> > > +                 __func__, faultaddr);
> > > +    return -1;
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 2.13.5
> > > 
> > 
> > -- 
> > Peter Xu
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Peter Xu
