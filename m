Received: from eggs.gnu.org ([2001:4830:134:3::10]:37541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cxrMs-0003sQ-Vj
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cxrMo-0000Qh-36
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:41:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:46230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cxrMn-0000PJ-Oe
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:41:38 -0400
Date: Tue, 11 Apr 2017 16:41:33 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170411084133.wroqrhn5eczesqam@hz-desktop>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
	<30db934f-d27e-1d15-6257-84224283dea9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30db934f-d27e-1d15-6257-84224283dea9@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] nvdimm: enable flush hint address
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On 04/06/17 20:02 +0800, Xiao Guangrong wrote:
> 
> 
> On 04/06/2017 05:43 PM, Stefan Hajnoczi wrote:
> > On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
> > > This patch series constructs the flush hint address structures for
> > > nvdimm devices in QEMU.
> > > 
> > > It's of course not for 2.9. I send it out early in order to get
> > > comments on one point I'm uncertain (see the detailed explanation
> > > below). Thanks for any comments in advance!
> > > Background
> > > ---------------
> > 
> > Extra background:
> > 
> > Flush Hint Addresses are necessary because:
> > 
> > 1. Some hardware configurations may require them.  In other words, a
> >    cache flush instruction is not enough to persist data.
> > 
> > 2. The host file system may need fsync(2) calls (e.g. to persist
> >    metadata changes).
> > 
> > Without Flush Hint Addresses only some NVDIMM configurations actually
> > guarantee data persistence.
> > 
> > > Flush hint address structure is a substructure of NFIT and specifies
> > > one or more addresses, namely Flush Hint Addresses. Software can write
> > > to any one of these flush hint addresses to cause any preceding writes
> > > to the NVDIMM region to be flushed out of the intervening platform
> > > buffers to the targeted NVDIMM. More details can be found in ACPI Spec
> > > 6.1, Section 5.2.25.8 "Flush Hint Address Structure".
> > 
> > Do you have performance data?  I'm concerned that Flush Hint Address
> > hardware interface is not virtualization-friendly.
> > 
> > In Linux drivers/nvdimm/region_devs.c:nvdimm_flush() does:
> > 
> >   wmb();
> >   for (i = 0; i < nd_region->ndr_mappings; i++)
> >       if (ndrd_get_flush_wpq(ndrd, i, 0))
> >           writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
> >   wmb();
> > 
> > That looks pretty lightweight - it's an MMIO write between write
> > barriers.
> > 
> > This patch implements the MMIO write like this:
> > 
> >   void nvdimm_flush(NVDIMMDevice *nvdimm)
> >   {
> >       if (nvdimm->backend_fd != -1) {
> >           /*
> >            * If the backend store is a physical NVDIMM device, fsync()
> >            * will trigger the flush via the flush hint on the host device.
> >            */
> >           fsync(nvdimm->backend_fd);
> >       }
> >   }
> > 
> > The MMIO store instruction turned into a synchronous fsync(2) system
> > call plus vmexit/vmenter and QEMU userspace context switch:
> > 
> > 1. The vcpu blocks during the fsync(2) system call.  The MMIO write
> >    instruction has an unexpected and huge latency.
> > 
> > 2. The vcpu thread holds the QEMU global mutex so all other threads
> >    (including the monitor) are blocked during fsync(2).  Other vcpu
> >    threads may block if they vmexit.
> > 
> > It is hard to implement this efficiently in QEMU.  This is why I said
> > the hardware interface is not virtualization-friendly.  It's cheap on
> > real hardware but expensive under virtualization.
> > 
> > We should think about the optimal way of implementing Flush Hint
> > Addresses in QEMU.  But if there is no reasonable way to implement them
> > then I think it's better *not* to implement them, just like the Block
> > Window feature which is also not virtualization-friendly.  Users who
> > want a block device can use virtio-blk.  I don't think NVDIMM Block
> > Window can achieve better performance than virtio-blk under
> > virtualization (although I'm happy to be proven wrong).
> > 
> > Some ideas for a faster implementation:
> > 
> > 1. Use memory_region_clear_global_locking() to avoid taking the QEMU
> >    global mutex.  Little synchronization is necessary as long as the
> >    NVDIMM device isn't hot unplugged (not yet supported anyway).
> > 
> > 2. Can the host kernel provide a way to mmap Address Flush Hints from
> >    the physical NVDIMM in cases where the configuration does not require
> >    host kernel interception?  That way QEMU can map the physical
> >    NVDIMM's Address Flush Hints directly into the guest.  The hypervisor
> >    is bypassed and performance would be good.
> > 
> > I'm not sure there is anything we can do to make the case where the host
> > kernel wants an fsync(2) fast :(.
> 
> Good point.
> 
> We can assume flush-CPU-cache-to-make-persistence is always
> available on Intel's hardware so that flush-hint-table is not
> needed if the vNVDIMM is based on a real Intel's NVDIMM device.
>

We can let users of qemu (e.g. libvirt) detect whether the backend
device supports ADR, and pass 'flush-hint' option to qemu only if ADR
is not supported.

> If the vNVDIMM device is based on the regular file, i think
> fsync is the bottleneck rather than this mmio-virtualization. :(
> 

Yes, fsync() on the regular file is the bottleneck. We may either

1/ perform the host-side flush in an asynchronous way which will not
   block vcpu too long,

or

2/ not provide strong durability guarantee for non-NVDIMM backend and
   not emulate flush-hint for guest at all. (I know 1/ does not
   provide strong durability guarantee either).

Haozhong
