Received: from eggs.gnu.org ([2001:4830:134:3::10]:51013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1cw8SE-0001oE-KG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1cw8SD-0005WU-8r
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:32:06 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1cw8SD-0005W6-2U
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:32:05 -0400
Received: by mail-oi0-x22e.google.com with SMTP id f193so53272777oib.2
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:32:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170406094359.GB21261@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 6 Apr 2017 07:32:01 -0700
Message-ID: <CAPcyv4jYHN7gaofVUFDqubf-ZyrQttw7aPO=f2iGbXpMeJGXbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Apr 6, 2017 at 2:43 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
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

A few thoughts:

* You don't need to call fsync in the case that the host file is a
/dev/daxX.Y device. Since there is no intervening filesystem.

* While the host implementation is fast it still is not meant to be
called very frequently. We could also look to make a paravirtualized
way for it complete asynchronously if the guest just wants to post a
flush request and get notified of a completion at a later time.

* We're still actively looking for ways to make it safe and efficient
to minimize sync overhead if an mmap write did not dirty filesystem
data, so hopefully we can make that fsync call overhead smaller over
time.

* I don't think we can just skip implementing support for this flush.
Yes it's virtualization unfriendly, but it completely defeats the
persistence of persistent memory if the host filesystem is free to
throw away writes that the guest expects to find after a surprise
power loss.
