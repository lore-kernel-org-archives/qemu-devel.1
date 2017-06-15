Received: from eggs.gnu.org ([2001:4830:134:3::10]:42354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dLKyg-0008Kx-8D
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dLKyb-0004E9-C9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dLKyb-0004Cp-2Q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:57:41 -0400
Date: Thu, 15 Jun 2017 10:57:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170615025727.GC30118@pxdev.xzpeter.org>
References: <20170608061150.GA3628@pxdev.xzpeter.org>
	<20170608215918-mutt-send-email-mst@kernel.org>
	<20170609015847.GG3628@pxdev.xzpeter.org>
	<20170611130710-mutt-send-email-mst@kernel.org>
	<20170611121015.GA18542@umbus>
	<20170612023443.GA25059@pxdev.xzpeter.org>
	<20170612060450-mutt-send-email-mst@kernel.org>
	<20170612040458.GB25059@pxdev.xzpeter.org>
	<20170614213418-mutt-send-email-mst@kernel.org>
	<20170615023111.GB30118@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170615023111.GB30118@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Jun 15, 2017 at 10:31:11AM +0800, Peter Xu wrote:
> On Wed, Jun 14, 2017 at 09:34:52PM +0300, Michael S. Tsirkin wrote:
> > On Mon, Jun 12, 2017 at 12:04:58PM +0800, Peter Xu wrote:
> > > On Mon, Jun 12, 2017 at 06:07:04AM +0300, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 12, 2017 at 10:34:43AM +0800, Peter Xu wrote:
> > > > > On Sun, Jun 11, 2017 at 08:10:15PM +0800, David Gibson wrote:
> > > > > > On Sun, Jun 11, 2017 at 01:09:26PM +0300, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Jun 09, 2017 at 09:58:47AM +0800, Peter Xu wrote:
> > > > > > > > > > The problem is that when I was fixing the problem that vhost had with
> > > > > > > > > > PT (a764040, "exec: abstract address_space_do_translate()"), I did
> > > > > > > > > > broke the IOTLB translation a bit (it was using page masks). IMHO we
> > > > > > > > > > need to fix it first for correctness (patch 1/2).
> > > > > > > > > > 
> > > > > > > > > > For patch 3, if we can have Jason's patch to allow dynamic
> > > > > > > > > > iommu_platform switching, that'll be the best, then I can rewrite
> > > > > > > > > > patch 3 with the switching logic rather than caching anything. But
> > > > > > > > > > IMHO that can be separated from patch 1/2 if you like.
> > > > > > > > > > 
> > > > > > > > > > Or do you have better suggestion on how should we fix it?
> > > > > > > > > > 
> > > > > > > > > > Thanks,
> > > > > > > > > 
> > > > > > > > > Can we drop masks completely and replace with length? I think we
> > > > > > > > > should do that instead of trying to fix masks.
> > > > > > > > 
> > > > > > > > Do you mean to modify IOMMUTLBEntry.addr_mask into length?
> > > > > > > 
> > > > > > > I think it's better than alternatives.
> > > > > > > 
> > > > > > > > Again, I am not sure this is good... At least we need to get ack from
> > > > > > > > David since spapr should be the initial user of it, and possibly also
> > > > > > > > Alex since vfio should be assuming that (IIUC both in QEMU and kernel)
> > > > > > > > addr_mask is page masks rather than arbirary length.
> > > > > > > > 
> > > > > > > > (CC Alex)
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > 
> > > > > > > Callbacks that need powers of two can easily split up the range.
> > > > > > 
> > > > > > I think I missed part of the thread.  What's the original use case for
> > > > > > non-power-of-two IOTLB entries?  It certainly won't happen on Power.
> > > > > 
> > > > > Currently address_space_get_iotlb_entry() didn't really follow the
> > > > > rule, addr_mask can be arbitary length. This series tried to fix it,
> > > > > while Michael was questioning about whether we should really fix that
> > > > > at all.
> > > > > 
> > > > > Michael,
> > > > > 
> > > > > Even if for performance's sake, I should still think we should fix it.
> > > > > Let's consider a most simple worst case: we have a single page mapped
> > > > > with IOVA range (2M page):
> > > > > 
> > > > >  [0x0, 0x200000)
> > > > > 
> > > > > And if guest access IOVA using the following patern:
> > > > > 
> > > > >  0x1fffff, 0x1ffffe, 0x1ffffd, ...
> > > > > 
> > > > > Then now we'll get this:
> > > > > 
> > > > > - request 0x1fffff, cache miss, will get iotlb [0x1fffff, 0x200000)
> > > > > - request 0x1ffffe, cache miss, will get iotlb [0x1ffffe, 0x200000)
> > > > > - request 0x1ffffd, cache miss, will get iotlb [0x1ffffd, 0x200000)
> > > > > - ...
> > > > 
> > > > We pass an offset too, do we not? So callee can figure out
> > > > the region starts at 0x0 and avoid 2nd and 3rd misses.
> > > 
> > > Here when you say "offset", do you mean the offset in
> > > MemoryRegionSection?
> > > 
> > > In address_space_get_iotlb_entry() we have this:
> > > 
> > >     section = address_space_do_translate(as, addr, &xlat, &plen,
> > >                                          is_write, false);
> > > 
> > > One thing to mention is that, imho we cannot really assume the xlat is
> > > valid on the whole "section" range - the section can be a huge GPA
> > > range, while the xlat may only be valid on a single 4K page. The only
> > > safe region we can use here is (xlat, xlat+plen). Outside that, we
> > > should know nothing valid.
> 
> [1]
> 
> > > 
> > > Please correct me if I didn't really catch the point..
> > 
> > IIUC section is the translation result. If so all of it is valid,
> > not just one page.
> 
> It should be only one page (I think that depends on how we implemented
> the translation logic). Please check this (gdb session on current
> master):
> 
> (gdb) b address_space_get_iotlb_entry 
> Breakpoint 2 at 0x55555576803a: file /root/git/qemu/exec.c, line 512.
> ... (until break)
> (gdb) bt
> #0  0x000055555576803a in address_space_get_iotlb_entry (as=0x55555841bbb0, addr=4294959104, is_write=false) at /root/git/qemu/exec.c:512
> #1  0x00005555558322dd in vhost_device_iotlb_miss (dev=0x5555568b03a0, iova=4294959104, write=0) at /root/git/qemu/hw/virtio/vhost.c:982
> #2  0x0000555555834ad9 in vhost_backend_handle_iotlb_msg (dev=0x5555568b03a0, imsg=0x7fffffffd428) at /root/git/qemu/hw/virtio/vhost-backend.c:334
> #3  0x00005555558347be in vhost_kernel_iotlb_read (opaque=0x5555568b03a0) at /root/git/qemu/hw/virtio/vhost-backend.c:204
> #4  0x0000555555c7e7c3 in aio_dispatch_handlers (ctx=0x5555568091b0) at /root/git/qemu/util/aio-posix.c:399
> #5  0x0000555555c7e956 in aio_dispatch (ctx=0x5555568091b0) at /root/git/qemu/util/aio-posix.c:430
> #6  0x0000555555c7a722 in aio_ctx_dispatch (source=0x5555568091b0, callback=0x0, user_data=0x0) at /root/git/qemu/util/async.c:261
> #7  0x00007f98c62f3703 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> #8  0x0000555555c7d36c in glib_pollfds_poll () at /root/git/qemu/util/main-loop.c:213
> #9  0x0000555555c7d468 in os_host_main_loop_wait (timeout=29311167) at /root/git/qemu/util/main-loop.c:261
> #10 0x0000555555c7d521 in main_loop_wait (nonblocking=0) at /root/git/qemu/util/main-loop.c:517
> #11 0x00005555558fe234 in main_loop () at /root/git/qemu/vl.c:1918
> #12 0x0000555555905fe8 in main (argc=21, argv=0x7fffffffda48, envp=0x7fffffffdaf8) at /root/git/qemu/vl.c:4752
> (gdb) s
> 517         plen = (hwaddr)-1;
> (gdb)
> 520         section = address_space_do_translate(as, addr, &xlat, &plen,
> (gdb) n
> 524         if (section.mr == &io_mem_unassigned) {
> (gdb) p/x xlat
> $2 = 0x73900000
> (gdb) p/x addr
> $3 = 0xffffe000
> (gdb) p/x plen
> $4 = 0x1000
> (gdb) p section
> $5 = {mr = 0x5555569ad790, address_space = 0x5555562f9b40 <address_space_memory>, offset_within_region = 1048576, size = 0x0000000000000000000000007ff00000, 
>   offset_within_address_space = 1048576, readonly = false}
> 
> Here $2-$4 shows that we are translating IOVA 0xffffe000 into
> [0x73900000, 0x73901000) range, while we can see the section is having
> size as 0x7ff00000,

> which is ranged from [0x100000000, 0x17ff00000).
> That's the upper RAM that the guest has, corresponds to what we can
> see in "info mtree -f" (the guest contains 4G RAM, this is upper 2G):
> 
>   0000000100000000-000000017fffffff (prio 0, ram): pc.ram @0000000080000000

Hmm I made a mistake here... It should be the lower 2G mem (not
upper), which ranges from:

  0000000000100000-000000007fffffff (prio 0, ram): pc.ram @0000000000100000

Though the main point still stands below...

> 
> Obvious, we cannot assume we have a linear mapping on this whole
> range. So I don't think we can really use section info (though the
> section can be used to obtain some offset information, or address
> space the range belongs) to build up the IOTLB, but only the plen.
> Then, we need to fix current codes.
> 
> And this is exactly what I meant above at [1].  Hope this clarifies a
> bit on the issue.  Thanks,
> 
> > 
> > > > 
> > > > 
> > > > > We'll all cache miss along the way until we access 0x0. While if we
> > > > > are with page mask, we'll get:
> > > > > 
> > > > > - request 0x1fffff, cache miss, will get iotlb [0x0, 0x200000)
> > > > > - request 0x1ffffe, cache hit
> > > > > - request 0x1ffffd, cache hit
> > > > > - ...
> > > > > 
> > > > > We'll only miss at the first IO.
> > > > 
> > > > I think we should send as much info as we can.
> > > > There should be a way to find full region start and length.
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> 
> -- 
> Peter Xu
> 

-- 
Peter Xu
