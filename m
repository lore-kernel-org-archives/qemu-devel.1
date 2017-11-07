Received: from eggs.gnu.org ([2001:4830:134:3::10]:47836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1eC1wt-00085u-8M
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1eC1wp-0000AZ-0K
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:21:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1eC1wo-00009l-PB
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:21:38 -0500
Date: Tue, 7 Nov 2017 06:21:36 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1412426579.28360924.1510053696238.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4jdJwUQTy7O7Ar82J+gAi54ycCTa=HSfXY5Ogwqi+oC-Q@mail.gmail.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<CAPcyv4jR_LdbsX-rAsHC7++C6d-WYC084uWXzr+08PSYwoXFMw@mail.gmail.com>
	<ca6aaa77-cca0-441e-be49-73133d8581cf@gmail.com>
	<CAPcyv4gKzvd39WbnKjbs3Bn9+o1tt=vz90CYMFu0DF5PsfHUig@mail.gmail.com>
	<86754966-281f-c3ed-938c-f009440de563@gmail.com>
	<CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
	<1228466331.27752565.1509955040884.JavaMail.zimbra@redhat.com>
	<CAPcyv4jdJwUQTy7O7Ar82J+gAi54ycCTa=HSfXY5Ogwqi+oC-Q@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Jan Kara <jack@suse.cz>, kvm-devel <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>, Ross Zwisler <ross.zwisler@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Christoph Hellwig <hch@infradead.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, ross zwisler <ross.zwisler@linux.intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Amit Shah <amit@kernel.org>, Aams@amazon.com


> >
> >
> >> [..]
> >> >> Yes, the GUID will specifically identify this range as "Virtio Shared
> >> >> Memory" (or whatever name survives after a bikeshed debate). The
> >> >> libnvdimm core then needs to grow a new region type that mostly
> >> >> behaves the same as a "pmem" region, but drivers/nvdimm/pmem.c grows a
> >> >> new flush interface to perform the host communication. Device-dax
> >> >> would be disallowed from attaching to this region type, or we could
> >> >> grow a new device-dax type that does not allow the raw device to be
> >> >> mapped, but allows a filesystem mounted on top to manage the flush
> >> >> interface.
> >> >
> >> >
> >> > I am afraid it is not a good idea that a single SPA is used for multiple
> >> > purposes. For the region used as "pmem" is directly mapped to the VM so
> >> > that guest can freely access it without host's assistance, however, for
> >> > the region used as "host communication" is not mapped to VM, so that
> >> > it causes VM-exit and host gets the chance to do specific operations,
> >> > e.g, flush cache. So we'd better distinctly define these two regions to
> >> > avoid the unnecessary complexity in hypervisor.
> >>
> >> Good point, I was assuming that the mmio flush interface would be
> >> discovered separately from the NFIT-defined memory range. Perhaps via
> >> PCI in the guest? This piece of the proposal  needs a bit more
> >> thought...
> >
> > Also, in earlier discussions we agreed for entire device flush whenever
> > guest
> > performs a fsync on DAX file. If we do a MMIO call for this, guest CPU
> > would be
> > trapped for the duration device flush is completed.
> >
> > Instead, if we do perform an asynchronous flush guest CPU's can be utilized
> > by
> > some other tasks till flush completes?
> 
> Yes, the interface for the guest to trigger and wait for flush
> requests should be asynchronous, just like a storage "flush-cache"
> command.

One idea got while discussing this with Rik & Amit during KVM forum is to use something 
similar to Hyperv Key-value pair for sharing command between guest <=> host. Don't think 
such thing exists yet for KVM? Or how we can utilize existing features in KVM to achieve this?
