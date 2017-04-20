Received: from eggs.gnu.org ([2001:4830:134:3::10]:36008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1d1I51-0007OH-Vb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1d1I50-000398-Bf
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:49:28 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:35571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1d1I50-00037Y-1U
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:49:26 -0400
Received: by mail-oi0-x232.google.com with SMTP id j201so65338024oih.2
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 12:49:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hmQRTn-KdUVYQjgb16cnprJ9yep+STFd1id4zEgL1rCg@mail.gmail.com>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
	<30db934f-d27e-1d15-6257-84224283dea9@gmail.com>
	<20170411084133.wroqrhn5eczesqam@hz-desktop>
	<CAPcyv4hmQRTn-KdUVYQjgb16cnprJ9yep+STFd1id4zEgL1rCg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 20 Apr 2017 12:49:21 -0700
Message-ID: <CAPcyv4hV2-ZW8SMCRtD0P_86KgR3DHOvNe+6T5SY2u7wXg3gEg@mail.gmail.com>
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan J Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>

On Tue, Apr 11, 2017 at 7:56 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> [ adding Christoph ]
>
> On Tue, Apr 11, 2017 at 1:41 AM, Haozhong Zhang
> <haozhong.zhang@intel.com> wrote:
>> On 04/06/17 20:02 +0800, Xiao Guangrong wrote:
>>>
>>>
>>> On 04/06/2017 05:43 PM, Stefan Hajnoczi wrote:
>>> > On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
>>> > > This patch series constructs the flush hint address structures for
>>> > > nvdimm devices in QEMU.
>>> > >
>>> > > It's of course not for 2.9. I send it out early in order to get
>>> > > comments on one point I'm uncertain (see the detailed explanation
>>> > > below). Thanks for any comments in advance!
>>> > > Background
>>> > > ---------------
>>> >
>>> > Extra background:
>>> >
>>> > Flush Hint Addresses are necessary because:
>>> >
>>> > 1. Some hardware configurations may require them.  In other words, a
>>> >    cache flush instruction is not enough to persist data.
>>> >
>>> > 2. The host file system may need fsync(2) calls (e.g. to persist
>>> >    metadata changes).
>>> >
>>> > Without Flush Hint Addresses only some NVDIMM configurations actually
>>> > guarantee data persistence.
>>> >
>>> > > Flush hint address structure is a substructure of NFIT and specifies
>>> > > one or more addresses, namely Flush Hint Addresses. Software can write
>>> > > to any one of these flush hint addresses to cause any preceding writes
>>> > > to the NVDIMM region to be flushed out of the intervening platform
>>> > > buffers to the targeted NVDIMM. More details can be found in ACPI Spec
>>> > > 6.1, Section 5.2.25.8 "Flush Hint Address Structure".
>>> >
>>> > Do you have performance data?  I'm concerned that Flush Hint Address
>>> > hardware interface is not virtualization-friendly.
>>> >
>>> > In Linux drivers/nvdimm/region_devs.c:nvdimm_flush() does:
>>> >
>>> >   wmb();
>>> >   for (i = 0; i < nd_region->ndr_mappings; i++)
>>> >       if (ndrd_get_flush_wpq(ndrd, i, 0))
>>> >           writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
>>> >   wmb();
>>> >
>>> > That looks pretty lightweight - it's an MMIO write between write
>>> > barriers.
>>> >
>>> > This patch implements the MMIO write like this:
>>> >
>>> >   void nvdimm_flush(NVDIMMDevice *nvdimm)
>>> >   {
>>> >       if (nvdimm->backend_fd != -1) {
>>> >           /*
>>> >            * If the backend store is a physical NVDIMM device, fsync()
>>> >            * will trigger the flush via the flush hint on the host device.
>>> >            */
>>> >           fsync(nvdimm->backend_fd);
>>> >       }
>>> >   }
>>> >
>>> > The MMIO store instruction turned into a synchronous fsync(2) system
>>> > call plus vmexit/vmenter and QEMU userspace context switch:
>>> >
>>> > 1. The vcpu blocks during the fsync(2) system call.  The MMIO write
>>> >    instruction has an unexpected and huge latency.
>>> >
>>> > 2. The vcpu thread holds the QEMU global mutex so all other threads
>>> >    (including the monitor) are blocked during fsync(2).  Other vcpu
>>> >    threads may block if they vmexit.
>>> >
>>> > It is hard to implement this efficiently in QEMU.  This is why I said
>>> > the hardware interface is not virtualization-friendly.  It's cheap on
>>> > real hardware but expensive under virtualization.
>>> >
>>> > We should think about the optimal way of implementing Flush Hint
>>> > Addresses in QEMU.  But if there is no reasonable way to implement them
>>> > then I think it's better *not* to implement them, just like the Block
>>> > Window feature which is also not virtualization-friendly.  Users who
>>> > want a block device can use virtio-blk.  I don't think NVDIMM Block
>>> > Window can achieve better performance than virtio-blk under
>>> > virtualization (although I'm happy to be proven wrong).
>>> >
>>> > Some ideas for a faster implementation:
>>> >
>>> > 1. Use memory_region_clear_global_locking() to avoid taking the QEMU
>>> >    global mutex.  Little synchronization is necessary as long as the
>>> >    NVDIMM device isn't hot unplugged (not yet supported anyway).
>>> >
>>> > 2. Can the host kernel provide a way to mmap Address Flush Hints from
>>> >    the physical NVDIMM in cases where the configuration does not require
>>> >    host kernel interception?  That way QEMU can map the physical
>>> >    NVDIMM's Address Flush Hints directly into the guest.  The hypervisor
>>> >    is bypassed and performance would be good.
>>> >
>>> > I'm not sure there is anything we can do to make the case where the host
>>> > kernel wants an fsync(2) fast :(.
>>>
>>> Good point.
>>>
>>> We can assume flush-CPU-cache-to-make-persistence is always
>>> available on Intel's hardware so that flush-hint-table is not
>>> needed if the vNVDIMM is based on a real Intel's NVDIMM device.
>>>
>>
>> We can let users of qemu (e.g. libvirt) detect whether the backend
>> device supports ADR, and pass 'flush-hint' option to qemu only if ADR
>> is not supported.
>>
>
> There currently is no ACPI mechanism to detect the presence of ADR.
> Also, you still need the flush for fs metadata management.
>
>>> If the vNVDIMM device is based on the regular file, i think
>>> fsync is the bottleneck rather than this mmio-virtualization. :(
>>>
>>
>> Yes, fsync() on the regular file is the bottleneck. We may either
>>
>> 1/ perform the host-side flush in an asynchronous way which will not
>>    block vcpu too long,
>>
>> or
>>
>> 2/ not provide strong durability guarantee for non-NVDIMM backend and
>>    not emulate flush-hint for guest at all. (I know 1/ does not
>>    provide strong durability guarantee either).
>
> or
>
> 3/ Use device-dax as a stop-gap until we can get an efficient fsync()
> overhead reduction (or bypass) mechanism built and accepted for
> filesystem-dax.

I didn't realize we have a bigger problem with host filesystem-fsync
and that WPQ exits will not save us. Applications that use device-dax
in the guest may never trigger a WPQ flush, because userspace flushing
with device-dax is expected to be safe. WPQ flush was never meant to
be a persistency mechanism the way it is proposed here, it's only
meant to minimize the fallout from potential ADR failure. My apologies
for insinuating that it was viable.

So, until we solve this userspace flushing problem virtualization must
not pass through any file except a device-dax instance for any
production workload.

Also these performance overheads seem prohibitive. We really want to
take whatever fsync minimization / bypass mechanism we come up with on
the host into a fast para-virtualized interface for the guest. Guests
need to be able to avoid hypervisor and host syscall overhead in the
fast path.
