Received: from eggs.gnu.org ([2001:4830:134:3::10]:40120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cxpNp-0005f1-SF
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cxpNm-00024P-P0
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:34:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:60262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cxpNm-000245-Ar
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:34:30 -0400
Date: Tue, 11 Apr 2017 14:34:26 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170411063426.5fmxyuglhqk7qo3k@hz-desktop>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>

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

Some performance data below.

Host HW config:
  CPU: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz x 2 sockets w/ HT enabled
  MEM: 64 GB

  As I don't have NVDIMM hardware, so I use files in ext4 fs on a
  normal SATA SSD as the back storage of vNVDIMM.


Host SW config:
  Kernel: 4.10.1
  QEMU: commit ea2afcf with this patch series applied.


Guest config:
  For flush hint enabled case, the following QEMU options are used
    -enable-kvm -smp 4 -cpu host -machine pc,nvdimm \
    -m 4G,slots=4,maxmem=128G \
    -object memory-backend-file,id=mem1,share,mem-path=nvm-img,size=8G \
    -device nvdimm,id=nv1,memdev=mem1,reserved-size=4K,flush-hint \
    -hda GUEST_DISK_IMG -serial pty

  For flush hint disabled case, the following QEMU options are used
    -enable-kvm -smp 4 -cpu host -machine pc,nvdimm \
    -m 4G,slots=4,maxmem=128G \
    -object memory-backend-file,id=mem1,share,mem-path=nvm-img,size=8G \
    -device nvdimm,id=nv1,memdev=mem1 \
    -hda GUEST_DISK_IMG -serial pty

  nvm-img used above is created in ext4 fs on the host SSD by
    dd if=/dev/zero of=nvm-img bs=1G count=8

  Guest kernel: 4.11.0-rc4


Benchmark in guest:
  mkfs.ext4 /dev/pmem0
  mount -o dax /dev/pmem0 /mnt
  dd if=/dev/zero of=/mnt/data bs=1G count=7 # warm up EPT mapping
  rm /mnt/data                               #
  dd if=/dev/zero of=/mnt/data bs=1G count=7

  and record the write speed reported by the last 'dd' command.


Result:
  - Flush hint disabled
    Vary from 161 MB/s to 708 MB/s, depending on how many fs/device
    flush operations are performed on the host side during the guest
    'dd'.

  - Flush hint enabled
  
    Vary from 164 MB/s to 546 MB/s, depending on how long fsync() in
    QEMU takes. Usually, there is at least one fsync() during one 'dd'
    command that takes several seconds (the worst one takes 39 s).

    To be worse, during those long host-side fsync() operations, guest
    kernel complained stalls.


Some thoughts:

- If the non-NVDIMM hardware is used as the back store of vNVDIMM,
  QEMU may perform the host-side flush operations asynchronously with
  VM, which will not block VM too long but sacrifice the durability
  guarantee.

- If physical NVDIMM is used as the back store and ADR is supported on
  the host, QEMU can rely on ADR to guarantee the data durability and
  will not need to emulate flush hint for guest.

- If physical NVDIMM is used as the back store and ADR is not
  supported on the host, QEMU will still need to emulate flush hint
  for guest and need to use a fast approach other than fsync() to
  trigger writes to host flush hint.

  Could kernel expose an interface to allow the userland (i.e. QEMU in
  this case) to directly write to the flush hint of a NVDIMM region?


Haozhong

> 
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
> 2. Can the host kernel provide a way to mmap Address Flush Hints from
>    the physical NVDIMM in cases where the configuration does not require
>    host kernel interception?  That way QEMU can map the physical
>    NVDIMM's Address Flush Hints directly into the guest.  The hypervisor
>    is bypassed and performance would be good.
> 
> I'm not sure there is anything we can do to make the case where the host
> kernel wants an fsync(2) fast :(.
> 
> Benchmark results would be important for deciding how big the problem
> is.
