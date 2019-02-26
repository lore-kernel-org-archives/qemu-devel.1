Received: from eggs.gnu.org ([209.51.188.92]:52148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyZ35-000629-Rw
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyZ33-0000dR-Ua
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:29:15 -0500
Date: Tue, 26 Feb 2019 10:28:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190226092858.GB4598@linux.fritz.box>
References: <d1ee3263-17df-f488-7603-3ed6924f178a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ee3263-17df-f488-7603-3ed6924f178a@virtuozzo.com>
Subject: Re: [Qemu-devel] mirror questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Am 26.02.2019 um 09:48 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi!
> 
> A question about s->cow_bitmap, introduced in far b812f6719c
>      "mirror: perform COW if the cluster size is bigger than the granularity"
> 
> cow_bitmap is just a bitmap which tracks, what clusters of target are allocated, to
> prevent COW in target, if target backing is not ready yet. And it is done by just
> aligning request to be larget and cover unaligned border clusters.
> 
> so, questions:
> 
> 1. Is it correct that we align only on COPY operation in
> mirror_co_read? Misaligned write_zero can also lead to COW, I think?
> Discard seems safe in this way, is it?

It looks a bit odd at least.

There is a bdrv_round_to_clusters() call in mirror_iteration() before
MIRROR_METHOD_ZERO is set. I think this might avoid the COW. However,
how is rounding up the range even correct for write_zeroes and discard?
Can't we destroy data in adjacent sectors this way?

Might be worth writing some test cases and trying to reproduce a bug.

> 2. I don't see, how is it handled, if we align operation so that offset is decreases,
> then it may intersect with previous mirror operation request, which may be not yet finished?

You mean the mirror_cow_align() in mirror_co_read()?

I think it's safe as long as the bitmap granularity is such that
rounding can never affect another bit. This seems to be the case with
default granularity and 64k cluster size in the target image.

If we can't rely on this, it might indeed be unsafe. Another thing worth
trying to reproduce.

Kevin
