Received: from eggs.gnu.org ([209.51.188.92]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gj9uG-0000na-Tc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gj9uE-0005HQ-F0
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:36:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1gj9u9-00059j-1r
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:36:23 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so590126otl.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190110012617.GA4205@dastard>
	<1326478078.61913951.1547192704870.JavaMail.zimbra@redhat.com>
	<20190113232902.GD4205@dastard>
	<20190113233820.GX6310@bombadil.infradead.org>
	<942065073.64011540.1547450140670.JavaMail.zimbra@redhat.com>
	<20190114212501.GG4205@dastard>
In-Reply-To: <20190114212501.GG4205@dastard>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 14 Jan 2019 13:35:57 -0800
Message-ID: <CAPcyv4jtPcLV-s0sKNHwwk0ug7GLBV6699dpm1h3r2xSo879dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] kvm "virtio pmem" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Chinner <david@fromorbit.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Matthew Wilcox <willy@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Linux ACPI <linux-acpi@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@surriel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ross Zwisler <zwisler@kernel.org>, vishal l verma <vishal.l.verma@intel.com>, dave jiang <dave.jiang@intel.com>, David Hildenbrand <david@redhat.com>, jmoyer <jmoyer@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, lcapitulino@redhat.com, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Theodore Ts'o <tytso@mit.edu>, adilger kernel <adilger.kernel@dilger.ca>, darrick wong <darrick.wong@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, Jan 14, 2019 at 1:25 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jan 14, 2019 at 02:15:40AM -0500, Pankaj Gupta wrote:
> >
> > > > Until you have images (and hence host page cache) shared between
> > > > multiple guests. People will want to do this, because it means they
> > > > only need a single set of pages in host memory for executable
> > > > binaries rather than a set of pages per guest. Then you have
> > > > multiple guests being able to detect residency of the same set of
> > > > pages. If the guests can then, in any way, control eviction of the
> > > > pages from the host cache, then we have a guest-to-guest information
> > > > leak channel.
> > >
> > > I don't think we should ever be considering something that would allow a
> > > guest to evict page's from the host's pagecache [1].  The guest should
> > > be able to kick its own references to the host's pagecache out of its
> > > own pagecache, but not be able to influence whether the host or another
> > > guest has a read-only mapping cached.
> > >
> > > [1] Unless the guest is allowed to modify the host's file; obviously
> > > truncation, holepunching, etc are going to evict pages from the host's
> > > page cache.
> >
> > This is so correct. Guest does not not evict host page cache pages directly.
>
> They don't right now.
>
> But someone is going to end up asking for discard to work so that
> the guest can free unused space in the underlying spares image (i.e.
> make use of fstrim or mount -o discard) because they have workloads
> that have bursts of space usage and they need to trim the image
> files afterwards to keep their overall space usage under control.
>
> And then....

...we reject / push back on that patch citing the above concern.

> > In case of virtio-pmem & DAX, guest clears guest page cache exceptional entries.
> > Its solely decision of host to take action on the host page cache pages.
> >
> > In case of virtio-pmem, guest does not modify host file directly i.e don't
> > perform hole punch & truncation operation directly on host file.
>
> ... this will no longer be true, and the nuclear landmine in this
> driver interface will have been armed....

I agree with the need to be careful when / if explicit cache control
is added, but that's not the case today.
