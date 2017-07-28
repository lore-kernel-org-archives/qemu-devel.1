Received: from eggs.gnu.org ([2001:4830:134:3::10]:44551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbENT-0004Tm-QD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbENR-0004vV-40
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dbENQ-0004uO-RZ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:09:01 -0400
Date: Sat, 29 Jul 2017 02:08:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170729020231-mutt-send-email-mst@kernel.org>
References: <20170712160129-mutt-send-email-mst@kernel.org>
	<5966241C.9060503@intel.com>
	<20170712163746-mutt-send-email-mst@kernel.org>
	<5967246B.9030804@intel.com>
	<20170713210819-mutt-send-email-mst@kernel.org>
	<59686EEB.8080805@intel.com>
	<20170723044036-mutt-send-email-mst@kernel.org>
	<59781119.8010200@intel.com>
	<20170726155856-mutt-send-email-mst@kernel.org>
	<597954E3.2070801@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597954E3.2070801@intel.com>
Subject: Re: [Qemu-devel] [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Thu, Jul 27, 2017 at 10:50:11AM +0800, Wei Wang wrote:
> > > > OK I thought this over. While we might need these new APIs in
> > > > the future, I think that at the moment, there's a way to implement
> > > > this feature that is significantly simpler. Just add each s/g
> > > > as a separate input buffer.
> > > 
> > > Should it be an output buffer?
> > Hypervisor overwrites these pages with zeroes. Therefore it is
> > writeable by device: DMA_FROM_DEVICE.
> 
> Why would the hypervisor need to zero the buffer?

The page is supplied to hypervisor and can lose the value that
is there.  That is the definition of writeable by device.

> I think it may only
> need to read out the info(base,size).

And then do what?

> I think it should be like this:
> the cmd hdr buffer: input, because the hypervisor would write it to
> send a cmd to the guest
> the payload buffer: output, for the hypervisor to read the info

These should be split.

We have:

1. request that hypervisor sends to guest, includes ID: input
2. synchronisation header with ID sent by guest: output
3. list of pages: input

2 and 3 must be on the same VQ. 1 can come on any VQ - reusing stats VQ
might make sense.


> > > I think output means from the
> > > driver to device (i.e. DMA_TO_DEVICE).
> > This part is correct I believe.
> > 
> > > > This needs zero new APIs.
> > > > 
> > > > I know that follow-up patches need to add a header in front
> > > > so you might be thinking: how am I going to add this
> > > > header? The answer is quite simple - add it as a separate
> > > > out header.
> > > > 
> > > > Host will be able to distinguish between header and pages
> > > > by looking at the direction, and - should we want to add
> > > > IN data to header - additionally size (<4K => header).
> > > 
> > > I think this works fine when the cmdq is only used for
> > > reporting the unused pages.
> > > It would be an issue
> > > if there are other usages (e.g. report memory statistics)
> > > interleaving. I think one solution would be to lock the cmdq until
> > > a cmd usage is done ((e.g. all the unused pages are reported) ) -
> > > in this case, the periodically updated guest memory statistics
> > > may be delayed for a while occasionally when live migration starts.
> > > Would this be acceptable? If not, probably we can have the cmdq
> > > for one usage only.
> > > 
> > > 
> > > Best,
> > > Wei
> > OK I see, I think the issue is that reporting free pages
> > was structured like stats. Let's split it -
> > send pages on e.g. free_vq, get commands on vq shared with
> > stats.
> > 
> 
> Would it be better to have the "report free page" command to be sent
> through the free_vq? In this case,we will have
> stats_vq: for the stats usage, which is already there
> free_vq: for reporting free pages.
> 
> Best,
> Wei

See above. I would get requests on stats vq but report
free pages separately on free vq.

> 
> 
> 
> 
