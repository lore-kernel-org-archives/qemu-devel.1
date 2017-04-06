Received: from eggs.gnu.org ([2001:4830:134:3::10]:60578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cw4hJ-0006hj-Tu
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cw4hF-0008F6-U0
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:31:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:37083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cw4hF-0008DP-Lq
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:31:21 -0400
Date: Thu, 6 Apr 2017 18:31:17 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170406103117.7elooodj2k5wrbnu@hz-desktop>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406094359.GB21261@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>, dan.j.williams@intel.com
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04/06/17 10:43 +0100, Stefan Hajnoczi wrote:
> On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
> > This patch series constructs the flush hint address structures for
> > nvdimm devices in QEMU.
> > 
> > It's of course not for 2.9. I send it out early in order to get
> > comments on one point I'm uncertain (see the detailed explanation
> > below). Thanks for any comments in advance!
> > Background
> > ---------------
> 
> Extra background:
> 
> Flush Hint Addresses are necessary because:
> 
> 1. Some hardware configurations may require them.  In other words, a
>    cache flush instruction is not enough to persist data.
> 
> 2. The host file system may need fsync(2) calls (e.g. to persist
>    metadata changes).
> 
> Without Flush Hint Addresses only some NVDIMM configurations actually
> guarantee data persistence.
> 
> > Flush hint address structure is a substructure of NFIT and specifies
> > one or more addresses, namely Flush Hint Addresses. Software can write
> > to any one of these flush hint addresses to cause any preceding writes
> > to the NVDIMM region to be flushed out of the intervening platform
> > buffers to the targeted NVDIMM. More details can be found in ACPI Spec
> > 6.1, Section 5.2.25.8 "Flush Hint Address Structure".
> 
> Do you have performance data?  I'm concerned that Flush Hint Address
> hardware interface is not virtualization-friendly.
>

I haven't tested how much vNVDIMM performance drops with this patch
series.

I tested the fsycn latency of a regular file on the bare metal by
writing 1 GB random data to a file (on ext4 fs on SSD) and then
performing fsync. The average latency of fsync in that case is 3 ms.
I currently don't have NVDIMM hardware, so I cannot get its latency
data. Anyway, as your comment below, the latency should be larger for
VM.

> In Linux drivers/nvdimm/region_devs.c:nvdimm_flush() does:
> 
>   wmb();
>   for (i = 0; i < nd_region->ndr_mappings; i++)
>       if (ndrd_get_flush_wpq(ndrd, i, 0))
>           writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
>   wmb();
> 
> That looks pretty lightweight - it's an MMIO write between write
> barriers.
> 
> This patch implements the MMIO write like this:
> 
>   void nvdimm_flush(NVDIMMDevice *nvdimm)
>   {
>       if (nvdimm->backend_fd != -1) {
>           /*
>            * If the backend store is a physical NVDIMM device, fsync()
>            * will trigger the flush via the flush hint on the host device.
>            */
>           fsync(nvdimm->backend_fd);
>       }
>   }
> 
> The MMIO store instruction turned into a synchronous fsync(2) system
> call plus vmexit/vmenter and QEMU userspace context switch:
> 
> 1. The vcpu blocks during the fsync(2) system call.  The MMIO write
>    instruction has an unexpected and huge latency.
> 
> 2. The vcpu thread holds the QEMU global mutex so all other threads
>    (including the monitor) are blocked during fsync(2).  Other vcpu
>    threads may block if they vmexit.
> 
> It is hard to implement this efficiently in QEMU.  This is why I said
> the hardware interface is not virtualization-friendly.  It's cheap on
> real hardware but expensive under virtualization.
>

I don't have the NVDIMM hardware, so I don't know the latency of
writing to host flush hint address. Dan, do you have any latency data
on the bare metal?

> We should think about the optimal way of implementing Flush Hint
> Addresses in QEMU.  But if there is no reasonable way to implement them
> then I think it's better *not* to implement them, just like the Block
> Window feature which is also not virtualization-friendly.  Users who
> want a block device can use virtio-blk.  I don't think NVDIMM Block
> Window can achieve better performance than virtio-blk under
> virtualization (although I'm happy to be proven wrong).
> 
> Some ideas for a faster implementation:
> 
> 1. Use memory_region_clear_global_locking() to avoid taking the QEMU
>    global mutex.  Little synchronization is necessary as long as the
>    NVDIMM device isn't hot unplugged (not yet supported anyway).
>

ACPI spec does not say it allows or disallows multiple writes to the
same flush hint address in parallel. If it can, I think we can remove
the global locking requirement for the MMIO memory region of the flush
hint address of vNVDIMM.

> 2. Can the host kernel provide a way to mmap Address Flush Hints from
>    the physical NVDIMM in cases where the configuration does not require
>    host kernel interception?  That way QEMU can map the physical
>    NVDIMM's Address Flush Hints directly into the guest.  The hypervisor
>    is bypassed and performance would be good.
>

It may work if the backend store of vNVDIMM is the physical NVDIMM
region and the latency of writing to host flush hint address is much
cheaper then performing fsync.

However, if the backend store is a regular file, then we still need to
use fsync.

> I'm not sure there is anything we can do to make the case where the host
> kernel wants an fsync(2) fast :(.
> 
> Benchmark results would be important for deciding how big the problem
> is.

Let me collect performance data w/ and w/o this patch series.

Thanks,
Haozhong
