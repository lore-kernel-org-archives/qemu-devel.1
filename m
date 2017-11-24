Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1eIDHC-0000Lz-P3
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1eIDH8-0006VW-ID
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:40:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1eIDH8-0006Rx-8z
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:40:10 -0500
Date: Fri, 24 Nov 2017 07:40:07 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
In-Reply-To: <654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<86754966-281f-c3ed-938c-f009440de563@gmail.com>
	<CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>


Hello,

Thank you all for all the useful suggestions.
I want to summarize the discussions so far in the
thread. Please see below:

> >>
> >>> We can go with the "best" interface for what
> >>> could be a relatively slow flush (fsync on a
> >>> file on ssd/disk on the host), which requires
> >>> that the flushing task wait on completion
> >>> asynchronously.
> >>
> >>
> >> I'd like to clarify the interface of "wait on completion
> >> asynchronously" and KVM async page fault a bit more.
> >>
> >> Current design of async-page-fault only works on RAM rather
> >> than MMIO, i.e, if the page fault caused by accessing the
> >> device memory of a emulated device, it needs to go to
> >> userspace (QEMU) which emulates the operation in vCPU's
> >> thread.
> >>
> >> As i mentioned before the memory region used for vNVDIMM
> >> flush interface should be MMIO and consider its support
> >> on other hypervisors, so we do better push this async
> >> mechanism into the flush interface design itself rather
> >> than depends on kvm async-page-fault.
> > 
> > I would expect this interface to be virtio-ring based to queue flush
> > requests asynchronously to the host.
> 
> Could we reuse the virtio-blk device, only with a different device id?

As per previous discussions, there were suggestions on main two parts of the project:

1] Expose vNVDIMM memory range to KVM guest.

   - Add flag in ACPI NFIT table for this new memory type. Do we need NVDIMM spec 
     changes for this? 

   - Guest should be able to add this memory in system memory map. Name of the added memory in
     '/proc/iomem' should be different(shared memory?) than persistent memory as it 
     does not satisfy exact definition of persistent memory (requires an explicit flush).

   - Guest should not allow 'device-dax' and other fancy features which are not 
     virtualization friendly.

2] Flushing interface to persist guest changes.

   - As per suggestion by ChristophH (CCed), we explored options other then virtio like MMIO etc.
     Looks like most of these options are not use-case friendly. As we want to do fsync on a
     file on ssd/disk on the host and we cannot make guest vCPU's wait for that time. 

   - Though adding new driver(virtio-pmem) looks like repeated work and not needed so we can 
     go with the existing pmem driver and add flush specific to this new memory type.

   - Suggestion by Paolo & Stefan(previously) to use virtio-blk makes sense if just 
     want a flush vehicle to send guest commands to host and get reply after asynchronous
     execution. There was previous discussion [1] with Rik & Dan on this.

    [1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg08373.html 

Is my understanding correct here?

Thanks,
Pankaj  
 
