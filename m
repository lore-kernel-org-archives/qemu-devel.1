Received: from eggs.gnu.org ([2001:4830:134:3::10]:38047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0RDJ-0001Ib-E3
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0RDI-0005Nv-AF
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:22:29 -0400
Date: Tue, 18 Apr 2017 13:22:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170418112215.GC9236@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
	<d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
	<e00ab029-cf9f-5aca-9786-581915dd5189@openvz.org>
	<20170413094454.GB5095@noname.redhat.com>
	<1cc754f6-6718-edbc-96ef-ab0e0e10fd56@openvz.org>
	<d34a20e9-8cb7-3b83-e96f-4631f91045cd@redhat.com>
	<6727667f-5422-13d7-be70-b8515f3ff589@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6727667f-5422-13d7-be70-b8515f3ff589@openvz.org>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 14.04.2017 um 06:17 hat Denis V. Lunev geschrieben:
> [skipped...]
> 
> > Hi Denis,
> >
> > I've read this entire thread now and I really like Berto's summary which
> > I think is one of the best recaps of existing qcow2 problems and this
> > discussion so far.
> >
> > I understand your opinion that we should focus on compatible changes
> > before incompatible ones, and I also understand that you are very
> > concerned about physical fragmentation for reducing long-term IO.
> >
> > What I don't understand is why you think that subclusters will increase
> > fragmentation. If we admit that fragmentation is a problem now, surely
> > increasing cluster sizes to 1 or 2 MB will only help to *reduce*
> > physical fragmentation, right?
> >
> > Subclusters as far as I am understanding them will not actually allow
> > subclusters to be located at virtually disparate locations, we will
> > continue to allocate clusters as normal -- we'll just keep track of
> > which portions of the cluster we've written to to help us optimize COW*.
> >
> > So if we have a 1MB cluster with 64k subclusters as a hypothetical, if
> > we write just the first subcluster, we'll have a map like:
> >
> > X---------------
> >
> > Whatever actually happens to exist in this space, whether it be a hole
> > we punched via fallocate or literal zeroes, this space is known to the
> > filesystem to be contiguous.
> >
> > If we write to the last subcluster, we'll get:
> >
> > X--------------X
> >
> > And again, maybe the dashes are a fallocate hole, maybe they're zeroes.
> > but the last subcluster is located virtually exactly 15 subclusters
> > behind the first, they're not physically contiguous. We've saved the
> > space between them. Future out-of-order writes won't contribute to any
> > fragmentation, at least at this level.
> >
> > You might be able to reduce COW from 5 IOPs to 3 IOPs, but if we tune
> > the subclusters right, we'll have *zero*, won't we?
> >
> > As far as I can tell, this lets us do a lot of good things all at once:
> >
> > (1) We get some COW optimizations (for reasons Berto and Kevin have
> > detailed)
> Yes. We are fine with COW. Let us assume that we will have issued read
> entire cluster command after the COW, in the situation
> 
> X--------------X
> 
> with a backing store. This is possible even with 1-2 Mb cluster size.
> I have seen 4-5 Mb requests from the guest in the real life. In this
> case we will have 3 IOP:
>     read left X area, read backing, read right X.
> This is the real drawback of the approach, if sub-cluster size is really
> small enough, which should be the case for optimal COW. Thus we
> will have random IO in the host instead of sequential one in guest.
> Thus we have optimized COW at the cost of long term reads. This
> is what I am worrying about as we can have a lot of such reads before
> any further data change.

So just to avoid misunderstandings about what you're comparing here:
You get these 3 iops for 2 MB clusters with 64k subclusters, whereas you
would get only a single operation for 2 MB clusters without subclusters.
Today's 64k clusters without subclusters behave no better than the
2M/64k version, but that's not what you're comparing.

Yes, you are correct about this observation. But it is a tradeoff that
you're intentionally making when using backing files. In the extreme,
there is an alternative that performs so much better: Instead of using a
backing file, use 'qemu-img convert' to copy (and defragment) the whole
image upfront. No COW whatsoever, no fragmentation, fast reads. The
downside is that it takes a while to copy the whole image upfront, and
it also costs quite a bit of disk space.

So once we acknowledge that we're dealing with a tradeoff here, it
becomes obvious that neither the extreme setup for performance (copy the
whole image upfront) nor the extreme setup for sparseness (COW on a
sector level) are the right default for the average case, nor is
optimising one-sidedly a good idea. It is good if we can provide
solutions for extreme cases, but by default we need to cater for the
average case, which cares both about reasonable performance and disk
usage.

Kevin
