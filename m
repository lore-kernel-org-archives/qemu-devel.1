Received: from eggs.gnu.org ([2001:4830:134:3::10]:55080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et6sb-0006gA-Rg
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et6sY-0000cb-Mz
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:19:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et6sY-0000cT-Gu
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:19:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34DAEEAE98
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 07:19:10 +0000 (UTC)
Date: Tue, 6 Mar 2018 15:19:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180306071901.GA17720@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-22-dgilbert@redhat.com>
	<20180302075513.GN27381@xz-mi> <20180305201643.GX3131@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305201643.GX3131@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 21/29] vhost+postcopy: Add vhost waker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Mon, Mar 05, 2018 at 08:16:44PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Fri, Feb 16, 2018 at 01:16:17PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Register a waker function in vhost-user code to be notified when
> > > pages arrive or requests to previously mapped pages get requested.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  hw/virtio/trace-events |  3 +++
> > >  hw/virtio/vhost-user.c | 30 ++++++++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > > 
> > > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > > index 3afd12cfea..fe5e0ff856 100644
> > > --- a/hw/virtio/trace-events
> > > +++ b/hw/virtio/trace-events
> > > @@ -13,6 +13,9 @@ vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t
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
> > > index 4589bfd92e..74807091a0 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -990,6 +990,35 @@ static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
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
> > > +
> > > +    if (!u) {
> > > +        return 0;
> > > +    }
> > > +    /* Translate the offset into an address in the clients address space */
> > > +    for (i = 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
> > > +        if (u->region_rb[i] == rb &&
> > > +            offset >= u->region_rb_offset[i] &&
> > > +            offset < (u->region_rb_offset[i] +
> > > +                      dev->mem->regions[i].memory_size)) {
> > > +            uint64_t client_addr = (offset - u->region_rb_offset[i]) +
> > > +                                   u->postcopy_client_bases[i];
> > > +            trace_vhost_user_postcopy_waker_found(client_addr);
> > > +            return postcopy_wake_shared(pcfd, client_addr, rb);
> > > +        }
> > > +    }
> > > +
> > > +    trace_vhost_user_postcopy_waker_nomatch(qemu_ram_get_idstr(rb), offset);
> > > +    return 0;
> > 
> > Can we really reach here?
> 
> Yes; note that all the waker's registered get called for all pages
> received
> so that:
>   a) A page not in shared memory, or not actually registered with a
> device, still calls the waker's and it's upto the waker to figure out
> whether it's interested for the device it belongs to.
> 
>   b) With two devices registered, they might each have registered
> different areas of shared memory, and thus it's upto the waker to figure
> out if it's interested in this specific page.

Indeed.

Again, if we note down faulted addresses for reach PostcopyFD, IMHO we
can even ignore this check, since if the copied page covers any of the
faulted addresses of the FD we'll definitely need to send the wake,
otherwise we don't need to.  But current patch is also okay to me now.

Thanks,

-- 
Peter Xu
