Received: from eggs.gnu.org ([209.51.188.92]:48685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1giVOb-0000n1-Hb
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 21:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1giVLT-0003Yd-P4
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 21:17:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1giVLS-0003Y9-0h
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 21:17:51 -0500
Date: Sat, 12 Jan 2019 21:17:46 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <540171952.63371441.1547345866585.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4hwcgTUpgNCefCGu4DvgkYBp5b=f+hJ+FC=s5APYKoycg@mail.gmail.com>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190110012617.GA4205@dastard>
	<20190110101757.GC15790@quack2.suse.cz>
	<1354249849.63357171.1547343519970.JavaMail.zimbra@redhat.com>
	<CAPcyv4hwcgTUpgNCefCGu4DvgkYBp5b=f+hJ+FC=s5APYKoycg@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Jason Wang <jasowang@redhat.com>, Dave Chinner <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, dave jiang <dave.jiang@intel.com>, darrick wong <darrick.wong@oracle.com>, vishal l verma <vishal.l.verma@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Theodore Ts'o <tytso@mit.edu>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>


> >
> >
> >
> > >
> > > On Thu 10-01-19 12:26:17, Dave Chinner wrote:
> > > > On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
> > > > >  This patch series has implementation for "virtio pmem".
> > > > >  "virtio pmem" is fake persistent memory(nvdimm) in guest
> > > > >  which allows to bypass the guest page cache. This also
> > > > >  implements a VIRTIO based asynchronous flush mechanism.
> > > >
> > > > Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
> > > > like a good idea, but.....
> > > >
> > > > This means the guest VM can now run timing attacks to observe host
> > > > side page cache residency, and depending on the implementation I'm
> > > > guessing that the guest will be able to control host side page
> > > > cache eviction, too (e.g. via discard or hole punch operations).
> > > >
> > > > Which means this functionality looks to me like a new vector for
> > > > information leakage into and out of the guest VM via guest
> > > > controlled host page cache manipulation.
> > > >
> > > > https://arxiv.org/pdf/1901.01161
> > > >
> > > > I might be wrong, but if I'm not we're going to have to be very
> > > > careful about how guest VMs can access and manipulate host side
> > > > resources like the page cache.....
> > >
> > > Right. Thinking about this I would be more concerned about the fact that
> > > guest can effectively pin amount of host's page cache upto size of the
> > > device/file passed to guest as PMEM, can't it Pankaj? Or is there some
> > > QEMU
> > > magic that avoids this?
> >
> > Yes, guest will pin these host page cache pages using 'get_user_pages' by
> > elevating the page reference count. But these pages can be reclaimed by
> > host
> > at any time when there is memory pressure.
> 
> Wait, how can the guest pin the host pages? I would expect this to
> happen only when using vfio and device assignment. Otherwise, no the
> host can't reclaim a pinned page, that's the whole point of a pin to
> prevent the mm from reclaiming ownership.

yes. You are right I just used the pin word but it does not actually pin pages 
permanently. I had gone through the discussion on existing problems with 
get_user_pages and DMA e.g [1] to understand Jan's POV. It does mention GUP 
pin pages so I also used the word 'pin'. But guest does not permanently pin 
these pages and these pages can be reclaimed by host.

> 
> > KVM does not permanently pin pages. vfio does that but we are not using
> > it here.
> 
> Right, so I'm confused by your pin assertion above.

Sorry! for the confusion. 

[1] https://lwn.net/Articles/753027/

Thanks,
Pankaj
