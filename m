Received: from eggs.gnu.org ([2001:4830:134:3::10]:37573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtssu-0007Cy-9D
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtsso-00050o-Cb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:02:36 -0400
Date: Mon, 18 Sep 2017 11:02:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918100226.GD31063@stefanha-x1.localdomain>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170914154221.GD7370@stefanha-x1.localdomain>
	<ff9cac4f-5dba-666c-fc0d-8c1e3f23e6c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9cac4f-5dba-666c-fc0d-8c1e3f23e6c9@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/18] block/mirror: Add
 active-sync mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Sat, Sep 16, 2017 at 04:02:45PM +0200, Max Reitz wrote:
> On 2017-09-14 17:42, Stefan Hajnoczi wrote:
> > On Wed, Sep 13, 2017 at 08:18:52PM +0200, Max Reitz wrote:
> >> There may be a couple of things to do on top of this series:
> >> - Allow switching between active and passive mode at runtime: This
> >>   should not be too difficult to implement, the main question is how to
> >>   expose it to the user.
> >>   (I seem to recall we wanted some form of block-job-set-option
> >>   command...?)
> >>
> >> - Implement an asynchronous active mode: May be detrimental when it
> >>   comes to convergence, but it might be nice to have anyway.  May or may
> >>   not be complicated to implement.
> > 
> > Ideally the user doesn't have to know about async vs sync.  It's an
> > implementation detail.
> > 
> > Async makes sense during the bulk copy phase (e.g. sync=full) because
> > guest read/write latencies are mostly unaffected.  Once the entire
> > device has been copied there are probably still dirty blocks left
> > because the guest touched them while the mirror job was running.  At
> > that point it definitely makes sense to switch to synchronous mirroring
> > in order to converge.
> 
> Makes sense, but I'm not sure whether it really is just an
> implementation detail.  If you're in the bulk copy phase in active/async
> mode and you have enough write requests with the target being slow
> enough, I suspect you might still not get convergence then (because the
> writes to the target yield for a long time while ever more write
> requests pile up) -- so then you'd just shift the dirty tracking from
> the bitmap to a list of requests in progress.
> 
> And I think we do want the bulk copy phase to guarantee convergence,
> too, usually (when active/foreground/synchronous mode is selected).  If
> we don't, then that's a policy decision and would be up to libvirt, as I
> see it.

This is a good point.  Bulk copy should converge too.

Can we measure the target write rate and guest write rate?  A heuristic
can choose between async vs sync based on the write rates.

For example, if the guest write rate has been larger than the target
write rate for the past 10 seconds during the bulk phase, switch to
synchronous mirroring.

Stefan
