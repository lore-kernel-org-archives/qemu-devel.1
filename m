Received: from eggs.gnu.org ([209.51.188.92]:47915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gizIj-0000pW-Mf
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gizIh-0006x8-S2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:17:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gizIg-0006ug-9b
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:16:59 -0500
Date: Mon, 14 Jan 2019 05:16:55 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2011860338.64100587.1547461015822.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114095520.GC13316@quack2.suse.cz>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190110012617.GA4205@dastard>
	<20190110101757.GC15790@quack2.suse.cz>
	<1354249849.63357171.1547343519970.JavaMail.zimbra@redhat.com>
	<CAPcyv4hwcgTUpgNCefCGu4DvgkYBp5b=f+hJ+FC=s5APYKoycg@mail.gmail.com>
	<540171952.63371441.1547345866585.JavaMail.zimbra@redhat.com>
	<20190114095520.GC13316@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] kvm "virtio pmem" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Jason Wang <jasowang@redhat.com>, Dave Chinner <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, dave jiang <dave.jiang@intel.com>, darrick wong <darrick.wong@oracle.com>, vishal l verma <vishal.l.verma@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Theodore Ts'o <tytso@mit.edu>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>


> > > > > Right. Thinking about this I would be more concerned about the fact
> > > > > that
> > > > > guest can effectively pin amount of host's page cache upto size of
> > > > > the
> > > > > device/file passed to guest as PMEM, can't it Pankaj? Or is there
> > > > > some
> > > > > QEMU
> > > > > magic that avoids this?
> > > >
> > > > Yes, guest will pin these host page cache pages using 'get_user_pages'
> > > > by
> > > > elevating the page reference count. But these pages can be reclaimed by
> > > > host
> > > > at any time when there is memory pressure.
> > > 
> > > Wait, how can the guest pin the host pages? I would expect this to
> > > happen only when using vfio and device assignment. Otherwise, no the
> > > host can't reclaim a pinned page, that's the whole point of a pin to
> > > prevent the mm from reclaiming ownership.
> > 
> > yes. You are right I just used the pin word but it does not actually pin
> > pages
> > permanently. I had gone through the discussion on existing problems with
> > get_user_pages and DMA e.g [1] to understand Jan's POV. It does mention GUP
> > pin pages so I also used the word 'pin'. But guest does not permanently pin
> > these pages and these pages can be reclaimed by host.
> 
> OK, then I was just confused how virtio-pmem is going to work. Thanks for
> explanation! So can I imagine this as guest mmaping the host file and
> providing the mapped range as "NVDIMM pages" to the kernel inside the
> guest? Or is it more complex?

yes, that's correct. Host's Qemu process virtual address range is used as guest physical 
address and a direct mapping(EPT/NPT) is established. At guest side, this physical memory
range is plugged into guest system memory map and DAX mapping is setup using nvdimm calls.

Thanks,
Pankaj
