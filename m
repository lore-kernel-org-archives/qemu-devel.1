Received: from eggs.gnu.org ([2001:4830:134:3::10]:60483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esrTk-0006VC-Ix
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esrTe-0005MS-KX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:52:40 -0500
Date: Mon, 5 Mar 2018 14:52:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180305145215.GM3131@work-vm>
References: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
	<20180305114533.GI7910@stefanha-x1.localdomain>
	<0f1ec3c7-1157-e618-62f8-ffd5e08eb342@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1ec3c7-1157-e618-62f8-ffd5e08eb342@kamp.de>
Subject: Re: [Qemu-devel] block migration and MAX_IN_FLIGHT_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Peter Lieven (pl@kamp.de) wrote:
> Am 05.03.2018 um 12:45 schrieb Stefan Hajnoczi:
> > On Thu, Feb 22, 2018 at 12:13:50PM +0100, Peter Lieven wrote:
> >> I stumbled across the MAX_INFLIGHT_IO field that was introduced in 2015 and was curious what was the reason
> >> to choose 512MB as readahead? The question is that I found that the source VM gets very unresponsive I/O wise
> >> while the initial 512MB are read and furthermore seems to stay unreasponsive if we choose a high migration speed
> >> and have a fast storage on the destination VM.
> >>
> >> In our environment I modified this value to 16MB which seems to work much smoother. I wonder if we should make
> >> this a user configurable value or define a different rate limit for the block transfer in bulk stage at least?
> > I don't know if benchmarks were run when choosing the value.  From the
> > commit description it sounds like the main purpose was to limit the
> > amount of memory that can be consumed.
> >
> > 16 MB also fulfills that criteria :), but why is the source VM more
> > responsive with a lower value?
> >
> > Perhaps the issue is queue depth on the storage device - the block
> > migration code enqueues up to 512 MB worth of reads, and guest I/O has
> > to wait?
> 
> That is my guess. Especially if the destination storage is faster we basically alsways have
> 512 I/Os in flight on the source storage.
> 
> Does anyone mind if the reduce that value to 16MB or do we need a better mechanism?

We've got migration-parameters these days; you could connect it to one
of those fairly easily I think.
Try: grep -i 'cpu[-_]throttle[-_]initial'  for an example of one that's
already there.
Then you can set it to whatever you like.

Dave

> Peter
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
