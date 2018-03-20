Received: from eggs.gnu.org ([2001:4830:134:3::10]:52741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7tT-0004Sg-49
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7tP-0002cv-UY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:24:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7tP-0002cW-O5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:24:55 -0400
Date: Tue, 20 Mar 2018 05:24:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320051840-mutt-send-email-mst@kernel.org>
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
	<1521197309-13544-5-git-send-email-wei.w.wang@intel.com>
	<20180316165319-mutt-send-email-mst@kernel.org>
	<5AAE4124.5010602@intel.com>
	<20180319062023-mutt-send-email-mst@kernel.org>
	<5AAF7C72.5070403@intel.com>
	<20180320004900-mutt-send-email-mst@kernel.org>
	<5AB06EE9.1030306@intel.com>
	<20180320045134-mutt-send-email-mst@kernel.org>
	<5AB07D7F.90205@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AB07D7F.90205@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v5 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Tue, Mar 20, 2018 at 11:18:23AM +0800, Wei Wang wrote:
> On 03/20/2018 10:59 AM, Michael S. Tsirkin wrote:
> > On Tue, Mar 20, 2018 at 10:16:09AM +0800, Wei Wang wrote:
> > > On 03/20/2018 06:55 AM, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 19, 2018 at 05:01:38PM +0800, Wei Wang wrote:
> > > > > On 03/19/2018 12:24 PM, Michael S. Tsirkin wrote:
> > > > > > On Sun, Mar 18, 2018 at 06:36:20PM +0800, Wei Wang wrote:
> > > > > > > On 03/16/2018 11:16 PM, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Mar 16, 2018 at 06:48:28PM +0800, Wei Wang wrote:
> > > > > > OTOH it seems that if thread stops nothing will wake it up
> > > > > > whem vm is restarted. Such bahaviour change across vmstop/vmstart
> > > > > > is unexpected.
> > > > > > I do not understand why we want to increment the counter
> > > > > > on vm stop though. It does make sense to stop the thread
> > > > > > but why not resume where we left off when vm is resumed?
> > > > > > 
> > > > > I'm not sure which counter we incremented. But it would be clear if we have
> > > > > a high level view of how it works (it is symmetric actually). Basically, we
> > > > > start the optimization when each round starts and stop it at the end of each
> > > > > round (i.e. before we do the bitmap sync), as shown below:
> > > > > 
> > > > > 1) 1st Round starts --> free_page_start
> > > > > 2) 1st Round in progress..
> > > > > 3) 1st Round ends  --> free_page_stop
> > > > > 4) 2nd Round starts --> free_page_start
> > > > > 5) 2nd Round in progress..
> > > > > 6) 2nd Round ends --> free_page_stop
> > > > > ......
> > > > > 
> > > > > For example, in 2), the VM is stopped. virtio_balloon_poll_free_page_hints
> > > > > finds the vq is empty (i.e. elem == NULL) and the runstate is stopped, the
> > > > > optimization thread exits immediately. That is, this optimization thread is
> > > > > gone forever (the optimization we can do for this round is done). We won't
> > > > > know when would the VM be woken up:
> > > > > A) If the VM is woken up very soon when the migration thread is still in
> > > > > progress of 2), then in 4) a new optimization thread (not the same one for
> > > > > the first round) will be created and start the optimization for the 2nd
> > > > > round as usual (If you have questions about 3) in this case, that
> > > > > free_page_stop will do nothing than just return, since the optimization
> > > > > thread has exited) ;
> > > > > B) If the VM is woken up after the whole migration has ended, there is still
> > > > > no point in resuming the optimization.
> > > > > 
> > > > > I think this would be the simple design for the first release of this
> > > > > optimization. There are possibilities to improve case A) above by continuing
> > > > > optimization for the 1st Round as it is still in progress, but I think
> > > > > adding that complexity for this rare case wouldn't be worthwhile (at least
> > > > > for now). What would you think?
> > > > > 
> > > > > 
> > > > > Best,
> > > > > Wei
> > > > In my opinion this just makes the patch very messy.
> > > > 
> > > > E.g. attempts to attach a debugger to the guest will call vmstop and
> > > > then behaviour changes. This is a receipe for heisenbugs which are then
> > > > extremely painful to debug.
> > > > 
> > > > It is not really hard to make things symmetrical:
> > > > e.g. if you stop on vmstop then you should start on vmstart, etc.
> > > > And stopping thread should not involve a bunch of state
> > > > changes, just stop it and that's it.
> > > > 
> > > "stop it" - do you mean to
> > > 1) make the thread exit (i.e.make virtio_balloon_poll_free_page_hints exit
> > > the while loop and return NULL); or
> > > 2) keep the thread staying in the while loop but yield running (e.g.
> > > sleep(1) or block on a mutex)? (or please let me know if you suggested a
> > > different implementation about stopping the thread)
> > I would say it makes more sense to make it block on something.
> > 
> > BTW I still think you are engaging in premature optimization here.
> > What you are doing here is a "data plane for balloon".
> > I would make the feature work first by processing this in a BH.
> > Creating threads immediately opens up questions of isolation,
> > cgroups etc.
> > 
> 
> Could you please share more about how creating threads affects isolation and
> cgroup?

When threads are coming and going, they are hard to control.

Consider the rich API libvirt exposes for controlling the io threads:

https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation


> and how does BH solve it? Thanks.
> Best,
> Wei

It's late at night so I don't remember whether it's the emulator
or the io thread that runs the BH, but the point is it's
already controlled by libvirt.

-- 
MST
