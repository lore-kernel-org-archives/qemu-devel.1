Received: from eggs.gnu.org ([2001:4830:134:3::10]:34973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAFe4-0005vt-4t
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAFdy-0006zA-8u
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:02:40 -0400
Date: Mon, 15 May 2017 15:02:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170515130221.GA4018@noname.redhat.com>
References: <1494842563-6534-1-git-send-email-pl@kamp.de>
	<20170515105032.GD23262@lemon.lan>
	<26b2441d-e80c-eeef-fba1-67b2529e9287@kamp.de>
	<20170515115318.GA7305@lemon.lan>
	<243331f2-3822-3c0e-b4a5-9f3de2302fe4@kamp.de>
	<20170515122802.GB7305@lemon.lan>
	<b850c6d3-c104-b171-0e7d-40ebf6780d6e@kamp.de>
	<20170515125202.GC7305@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515125202.GC7305@lemon.lan>
Subject: Re: [Qemu-devel] [RFC PATCH] qemu-io: add drain/undrain cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 15.05.2017 um 14:52 hat Fam Zheng geschrieben:
> On Mon, 05/15 14:32, Peter Lieven wrote:
> > Am 15.05.2017 um 14:28 schrieb Fam Zheng:
> > > On Mon, 05/15 13:58, Peter Lieven wrote:
> > > > Am 15.05.2017 um 13:53 schrieb Fam Zheng:
> > > > > On Mon, 05/15 13:26, Peter Lieven wrote:
> > > > > > Am 15.05.2017 um 12:50 schrieb Fam Zheng:
> > > > > > > On Mon, 05/15 12:02, Peter Lieven wrote:
> > > > > > > > Hi Block developers,
> > > > > > > > 
> > > > > > > > I would like to add a feature to Qemu to drain all traffic from a block so that
> > > > > > > > I can take external snaphosts without the risk to that in the middle of a write
> > > > > > > > operation. Its meant for cases where where QGA freeze/thaw is not available.
> > > > > > > > 
> > > > > > > > For me its enough to have this through qemu-io, but Kevin asked me to check
> > > > > > > > if its not worth to have a stable API for it and present it via QMP/HMP.
> > > > > > > > 
> > > > > > > > What are your thoughts?
> > > > > > > For debugging purpose or a "hacky" usage where you know what you are doing, it
> > > > > > > may be fine to have this. The only issue is it should be a separate flag, like
> > > > > > > BlockJob.user_paused.
> > > > > > How can I add, remove such a flag?
> > > > > Like bs->user_drained. Set it in "drain" command, then increment
> > > > > bs->quiesce_counter if toggled; vise versa.
> > > > Ah okay. You wouldn't use bdrv_drained_begin/end? Because in these functions
> > > > the counter is incremented already.
> > > You're right, calling bdrv_drained_begin() is better.
> > > 
> > > > 
> > > > 
> > > > > > > What happens from guest perspective? In the case of virtio, the request queue is
> > > > > > > not handled and -ETIMEDOUT may happen. With IDE, I/O commands are still handled,
> > > > > > > the command is not effective (or rather the implementation is not complete).
> > > > > > That it only works with virtio is fine. However, the thing it does not work correctly
> > > > > > apply then also to all other users of the drained_begin/end functions, right?
> > > > > > As for the timeout I only plan to drain the device for about 1 second.
> > > > > It didn't matter because for IDE, the invariant (staying quiesced as long as
> > > > > necessary) is already ensured by BQL.  Virtio is different because it supports
> > > > > ioeventfd and data plane.
> > > > Okay understood. So my use of bdrv_drained_begin/end is more an abuse of
> > > > these functions?
> > > Sort of. But it's not unreasonable to "extend" bdrv_drained_begin/end to cover
> > > IDE, I just haven't thought about "how".
> > > 
> > > > Do you have another idea how to achieve what I want? I was thinking of throttle
> > > > the I/O to zero. It would be enough to do this for writes, reading doesn't hurt in
> > > > my case.
> > > Maybe add a block filter on top of the drained node, drain it when doing so,
> > > then queue all further requests with a CoQueue until "undrain".  (It is then not
> > > quite to "drain" but to "halt" or "pause", though.)
> > 
> > To get the drain for free was why I was looking at this approach. If I read correctly
> > if I keep using bdrv_drained_begin/end its too hacky to implement it in QMP?
> 
> I think so.
> 
> > If yes, would support adding it to qemu-io?
> 
> I'm under the impression that you are looking to a real use case, I don't think
> I like the idea. Also, accessing the image from other processes while QEMU is
> using it is strongly discouraged, and there is the coming image locking
> mechanism to prevent this from happening.

Thinking a bit more about this, it looks to me as if what we really want
is inactivating the image. Should we add an option to the 'stop' command
(or introduce another command to be used on an already stopped VM) that
inactivates all/some images? And then 'cont' regains control over the
images, just like after migration.

Automatically stopping the VM while the snapshot is taken also makes it
work with IDE and prevents guests running into timeouts, which makes it
look much more like a proper solution to me.

But then, stop/cont would already achieve something very similar today
(as 'stop' calls bdrv_drain_all(); just the locking part wouldn't be
covered), so maybe there is a reason not to use it in your case, Peter?

Kevin
