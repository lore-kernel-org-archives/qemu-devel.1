Received: from eggs.gnu.org ([2001:4830:134:3::10]:57058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cw67z-0006iT-K3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cw67v-0000sT-Mk
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:03:03 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cw67v-0000s7-EE
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:02:59 -0400
Received: by mail-pg0-x241.google.com with SMTP id 79so8055432pgf.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 05:02:59 -0700 (PDT)
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <30db934f-d27e-1d15-6257-84224283dea9@gmail.com>
Date: Thu, 6 Apr 2017 20:02:51 +0800
MIME-Version: 1.0
In-Reply-To: <20170406094359.GB21261@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Stefan Hajnoczi <stefanha@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>



On 04/06/2017 05:43 PM, Stefan Hajnoczi wrote:
> On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
>> This patch series constructs the flush hint address structures for
>> nvdimm devices in QEMU.
>>
>> It's of course not for 2.9. I send it out early in order to get
>> comments on one point I'm uncertain (see the detailed explanation
>> below). Thanks for any comments in advance!
>> Background
>> ---------------
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
>> Flush hint address structure is a substructure of NFIT and specifies
>> one or more addresses, namely Flush Hint Addresses. Software can write
>> to any one of these flush hint addresses to cause any preceding writes
>> to the NVDIMM region to be flushed out of the intervening platform
>> buffers to the targeted NVDIMM. More details can be found in ACPI Spec
>> 6.1, Section 5.2.25.8 "Flush Hint Address Structure".
>
> Do you have performance data?  I'm concerned that Flush Hint Address
> hardware interface is not virtualization-friendly.
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

Good point.

We can assume flush-CPU-cache-to-make-persistence is always
available on Intel's hardware so that flush-hint-table is not
needed if the vNVDIMM is based on a real Intel's NVDIMM device.

If the vNVDIMM device is based on the regular file, i think
fsync is the bottleneck rather than this mmio-virtualization. :(
