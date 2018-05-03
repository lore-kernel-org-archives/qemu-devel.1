Received: from eggs.gnu.org ([2001:4830:134:3::10]:49953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fE5j3-0003oy-8U
	for qemu-devel@nongnu.org; Thu, 03 May 2018 00:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fE5iz-000061-Sn
	for qemu-devel@nongnu.org; Thu, 03 May 2018 00:20:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fE5iz-00005Z-Mf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 00:20:09 -0400
Date: Wed, 2 May 2018 22:20:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180502222000.611ddfe4@w520.home>
In-Reply-To: <20180503033635.GF8239@xz-mi>
References: <20180501162901.28940.1075.stgit@gimli.home>
	<20180501164332.28940.40383.stgit@gimli.home>
	<20180503033635.GF8239@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] vfio/quirks: ioeventfd quirk
 acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, eric.auger@redhat.com

On Thu, 3 May 2018 11:36:35 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Tue, May 01, 2018 at 10:43:32AM -0600, Alex Williamson wrote:
> 
> [...]
> 
> > @@ -743,6 +843,60 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
> >                            addr + mirror->offset, data, size);
> >          trace_vfio_quirk_nvidia_bar0_msi_ack(vdev->vbasedev.name);
> >      }
> > +
> > +    /*
> > +     * Automatically add an ioeventfd to handle any repeated write with the
> > +     * same data and size above the standard PCI config space header.  This is
> > +     * primarily expected to accelerate the MSI-ACK behavior, such as noted
> > +     * above.  Current hardware/drivers should trigger an ioeventfd at config
> > +     * offset 0x704 (region offset 0x88704), with data 0x0, size 4.
> > +     *
> > +     * The criteria of 10 successive hits is arbitrary but reliably adds the
> > +     * MSI-ACK region.  Note that as some writes are bypassed via the ioeventfd,
> > +     * the remaining ones have a greater chance of being seen successively.
> > +     * To avoid the pathological case of burning up all of QEMU's open file
> > +     * handles, arbitrarily limit this algorithm from adding no more than 10
> > +     * ioeventfds, print an error if we would have added an 11th, and then
> > +     * stop counting.
> > +     */
> > +    if (!vdev->no_kvm_ioeventfd &&
> > +        addr > PCI_STD_HEADER_SIZEOF && last->added < MAX_DYN_IOEVENTFD + 1) {
> > +        if (addr != last->addr || data != last->data || size != last->size) {
> > +            last->addr = addr;
> > +            last->data = data;
> > +            last->size = size;
> > +            last->hits = 1;
> > +        } else if (++last->hits >= HITS_FOR_IOEVENTFD) {
> > +            if (last->added < MAX_DYN_IOEVENTFD) {
> > +                VFIOIOEventFD *ioeventfd;
> > +                ioeventfd = vfio_ioeventfd_init(vdev, mirror->mem, addr, size,
> > +                                        data, &vdev->bars[mirror->bar].region,
> > +                                        mirror->offset + addr, true);
> > +                if (ioeventfd) {
> > +                    VFIOQuirk *quirk;
> > +
> > +                    QLIST_FOREACH(quirk,
> > +                                  &vdev->bars[mirror->bar].quirks, next) {  
> 
> I'm not sure whether the quirks list can be a long one, otherwise not
> sure whether we can just cache the quirk pointer inside the mirror to
> avoid the loop.

The list here only has two entries, but it does seem simple enough to
add a VFIOQuirk* to LastData which we set when it's allocated to avoid
this loop.  I'll test and post and update tomorrow.
 
> > +                        if (quirk->data == mirror) {
> > +                            QLIST_INSERT_HEAD(&quirk->ioeventfds,
> > +                                              ioeventfd, next);
> > +                            break;
> > +                        }
> > +                    }  
> 
> [...]
> 
> > +typedef struct VFIOIOEventFD {
> > +    QLIST_ENTRY(VFIOIOEventFD) next;
> > +    MemoryRegion *mr;
> > +    hwaddr addr;
> > +    unsigned size;
> > +    uint64_t data;
> > +    EventNotifier e;
> > +    VFIORegion *region;
> > +    hwaddr region_addr;
> > +    bool match_data;  
> 
> Would it possible in the future that match_data will be false?
> Otherwise I'm not sure whether we can even omit this field.

I don't see how we could, and you're right, it's pretty useless.  I'll
drop it in the next version.  Thanks!

Alex
